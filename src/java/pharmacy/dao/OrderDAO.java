package pharmacy.dao;

import pharmacy.model.Order;
import pharmacy.model.OrderItem;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<Order> getOrdersByPharmacy(int pharmacyId) {
        List<Order> orders = new ArrayList<>();
        // Query orders with patient join if available
        String sql = "SELECT * FROM orders WHERE pharmacy_id = ? ORDER BY order_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, pharmacyId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrder(rs, con));
                }
            }
        } catch (Exception e) {
            System.err.println("Error getting orders by pharmacy: " + e.getMessage());
        }
        return orders;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapOrder(rs, con);
                }
            }
        } catch (Exception e) {
            System.err.println("Error getting order by id: " + e.getMessage());
        }
        return null;
    }

    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, m.medicine_name "
                + "FROM order_items oi "
                + "LEFT JOIN medicines m ON oi.medicine_id = m.medicine_id "
                + "WHERE oi.order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setOrderItemId(rs.getInt("order_item_id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setMedicineId(rs.getInt("medicine_id"));
                    item.setQuantity(rs.getInt("quantity"));

                    double priceVal = 0.0;
                    try {
                        priceVal = rs.getDouble("unit_price");
                    } catch (SQLException e) {
                        try { priceVal = rs.getDouble("price"); } catch (SQLException ignore) {}
                    }
                    item.setPrice(priceVal);

                    String medName = rs.getString("medicine_name");
                    item.setMedicineName(medName != null ? medName : "Medicine #" + item.getMedicineId());
                    items.add(item);
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching order items: " + e.getMessage());
        }
        return items;
    }

    /**
     * Atomically updates order status, ensuring valid status progression
     * and deducting stock when transitioned to ACCEPTED.
     */
    public boolean updateOrderStatus(int orderId, String newStatus) {
        if (newStatus == null) return false;
        newStatus = newStatus.trim().toUpperCase();

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            String statusCol = getStatusColumn(con);
            String stockCol = getStockColumn(con);

            // Fetch current order status
            String checkSql = "SELECT " + statusCol + " FROM orders WHERE order_id = ?";
            String currentStatus = null;

            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setInt(1, orderId);
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        currentStatus = rs.getString(statusCol);
                    } else {
                        con.rollback();
                        return false;
                    }
                }
            }

            if (!isValidStatusTransition(currentStatus, newStatus)) {
                System.err.println("Invalid status transition: " + currentStatus + " -> " + newStatus);
                con.rollback();
                return false;
            }

            // If transitioning to ACCEPTED for the first time, check and deduct stock
            if ("ACCEPTED".equalsIgnoreCase(newStatus) && !"ACCEPTED".equalsIgnoreCase(currentStatus)) {
                String itemSql = "SELECT medicine_id, quantity FROM order_items WHERE order_id = ?";
                try (PreparedStatement itemPs = con.prepareStatement(itemSql)) {
                    itemPs.setInt(1, orderId);
                    try (ResultSet itemRs = itemPs.executeQuery()) {
                        while (itemRs.next()) {
                            int medicineId = itemRs.getInt("medicine_id");
                            int quantity = itemRs.getInt("quantity");

                            // Check current stock
                            String stockSql = "SELECT " + stockCol + " FROM medicines WHERE medicine_id = ?";
                            int currentStock = 0;
                            try (PreparedStatement stockPs = con.prepareStatement(stockSql)) {
                                stockPs.setInt(1, medicineId);
                                try (ResultSet stockRs = stockPs.executeQuery()) {
                                    if (stockRs.next()) {
                                        currentStock = stockRs.getInt(stockCol);
                                    } else {
                                        con.rollback();
                                        return false;
                                    }
                                }
                            }

                            if (currentStock < quantity) {
                                System.err.println("Insufficient stock for medicine ID " + medicineId + ": available=" + currentStock + ", required=" + quantity);
                                con.rollback();
                                return false;
                            }

                            // Deduct stock
                            String updateStockSql = "UPDATE medicines SET " + stockCol + " = " + stockCol + " - ? WHERE medicine_id = ?";
                            try (PreparedStatement updateStockPs = con.prepareStatement(updateStockSql)) {
                                updateStockPs.setInt(1, quantity);
                                updateStockPs.setInt(2, medicineId);
                                updateStockPs.executeUpdate();
                            }
                        }
                    }
                }
            }

            // Update order status
            String updateOrderSql = "UPDATE orders SET " + statusCol + " = ? WHERE order_id = ?";
            try (PreparedStatement updatePs = con.prepareStatement(updateOrderSql)) {
                updatePs.setString(1, newStatus);
                updatePs.setInt(2, orderId);
                int updatedRows = updatePs.executeUpdate();
                if (updatedRows == 0) {
                    con.rollback();
                    return false;
                }
            }

            con.commit();
            return true;
        } catch (Exception e) {
            System.err.println("Error updating order status: " + e.getMessage());
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    private boolean isValidStatusTransition(String currentStatus, String newStatus) {
        if (currentStatus == null || newStatus == null) return false;
        currentStatus = currentStatus.toUpperCase();
        newStatus = newStatus.toUpperCase();

        if (currentStatus.equals(newStatus)) return true;

        switch (currentStatus) {
            case "PENDING":
                return "ACCEPTED".equals(newStatus) || "CANCELLED".equals(newStatus);
            case "ACCEPTED":
                return "PROCESSING".equals(newStatus) || "CANCELLED".equals(newStatus);
            case "PROCESSING":
                return "SHIPPED".equals(newStatus) || "CANCELLED".equals(newStatus);
            case "SHIPPED":
                return "DELIVERED".equals(newStatus);
            case "DELIVERED":
            case "CANCELLED":
                return false;
            default:
                return true;
        }
    }

    private Order mapOrder(ResultSet rs, Connection con) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setPatientId(rs.getString("patient_id"));
        order.setPharmacyId(rs.getInt("pharmacy_id"));
        order.setTotalAmount(rs.getDouble("total_amount"));

        // Support address vs delivery_address
        String addr = null;
        try { addr = rs.getString("address"); } catch (SQLException ignore) {}
        if (addr == null) {
            try { addr = rs.getString("delivery_address"); } catch (SQLException ignore) {}
        }
        order.setAddress(addr != null ? addr : "N/A");

        // Support status vs order_status
        String st = null;
        try { st = rs.getString("status"); } catch (SQLException ignore) {}
        if (st == null) {
            try { st = rs.getString("order_status"); } catch (SQLException ignore) {}
        }
        order.setStatus(st != null ? st : "PENDING");

        try {
            order.setOrderDate(rs.getDate("order_date"));
        } catch (SQLException ignore) {}

        // Fetch patient name if possible
        if (order.getPatientId() != null && !order.getPatientId().isEmpty() && con != null) {
            try {
                String pSql = "SELECT name FROM patients WHERE patient_id = ?";
                try (PreparedStatement pPs = con.prepareStatement(pSql)) {
                    pPs.setString(1, order.getPatientId());
                    try (ResultSet pRs = pPs.executeQuery()) {
                        if (pRs.next()) {
                            order.setPatientName(pRs.getString("name"));
                        }
                    }
                }
            } catch (Exception ignore) {}
        }
        if (order.getPatientName() == null || order.getPatientName().isEmpty()) {
            order.setPatientName("Patient #" + (order.getPatientId() != null ? order.getPatientId() : ""));
        }

        return order;
    }

    private String getStatusColumn(Connection con) {
        try {
            java.sql.DatabaseMetaData meta = con.getMetaData();
            try (ResultSet rs = meta.getColumns(null, null, "orders", "order_status")) {
                if (rs.next()) return "order_status";
            }
        } catch (Exception ignore) {}
        return "status";
    }

    private String getStockColumn(Connection con) {
        try {
            java.sql.DatabaseMetaData meta = con.getMetaData();
            try (ResultSet rs = meta.getColumns(null, null, "medicines", "stock_quantity")) {
                if (rs.next()) return "stock_quantity";
            }
        } catch (Exception ignore) {}
        return "stock";
    }
}
