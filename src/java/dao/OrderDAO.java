package dao;

import model.OrderItem;
import model.Order;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<Order> getOrdersByPharmacy(int pharmacyId) {

        List<Order> orders = new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "WHERE pharmacy_id = ? " +
                "ORDER BY order_date DESC";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, pharmacyId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setPatientId(rs.getInt("patient_id"));
                order.setPharmacyId(rs.getInt("pharmacy_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setAddress(rs.getString("address"));
                order.setStatus(rs.getString("status"));
                order.setOrderDate(rs.getDate("order_date"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }


    public boolean updateOrderStatus(int orderId, String status) {

        Connection con = null;

        try {

            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Get current order status
            String checkOrderSql =
                    "SELECT status FROM orders WHERE order_id = ?";

            String currentStatus = null;

            try (PreparedStatement ps =
                         con.prepareStatement(checkOrderSql)) {

                ps.setInt(1, orderId);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    currentStatus = rs.getString("status");
                } else {
                    con.rollback();
                    return false;
                }
            }


            // Check whether status transition is valid
            if (!isValidStatusTransition(currentStatus, status)) {

                con.rollback();
                return false;
            }


            /*
             * Deduct stock only when the order is
             * accepted for the first time.
             */
            if ("ACCEPTED".equalsIgnoreCase(status)
                    && !"ACCEPTED".equalsIgnoreCase(currentStatus)) {

                String itemSql =
                        "SELECT medicine_id, quantity " +
                        "FROM order_items " +
                        "WHERE order_id = ?";

                try (PreparedStatement ps =
                             con.prepareStatement(itemSql)) {

                    ps.setInt(1, orderId);

                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {

                        int medicineId =
                                rs.getInt("medicine_id");

                        int quantity =
                                rs.getInt("quantity");


                        // Check stock
                        String stockSql =
                                "SELECT stock FROM medicines " +
                                "WHERE medicine_id = ?";

                        int stock;

                        try (PreparedStatement stockPs =
                                     con.prepareStatement(stockSql)) {

                            stockPs.setInt(1, medicineId);

                            ResultSet stockRs =
                                    stockPs.executeQuery();

                            if (!stockRs.next()) {

                                con.rollback();
                                return false;
                            }

                            stock = stockRs.getInt("stock");
                        }


                        // Not enough stock
                        if (stock < quantity) {

                            con.rollback();
                            return false;
                        }


                        // Deduct stock
                        String updateStockSql =
                                "UPDATE medicines " +
                                "SET stock = stock - ? " +
                                "WHERE medicine_id = ?";

                        try (PreparedStatement stockPs =
                                     con.prepareStatement(updateStockSql)) {

                            stockPs.setInt(1, quantity);
                            stockPs.setInt(2, medicineId);

                            stockPs.executeUpdate();
                        }
                    }
                }
            }


            // Update order status
            String updateOrderSql =
                    "UPDATE orders SET status = ? " +
                    "WHERE order_id = ?";

            try (PreparedStatement ps =
                         con.prepareStatement(updateOrderSql)) {

                ps.setString(1, status);
                ps.setInt(2, orderId);

                int result = ps.executeUpdate();

                if (result == 0) {

                    con.rollback();
                    return false;
                }
            }


            // Save all changes
            con.commit();

            return true;


        } catch (Exception e) {

            e.printStackTrace();

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception rollbackException) {

                rollbackException.printStackTrace();
            }

            return false;


        } finally {

            try {

                if (con != null) {

                    con.setAutoCommit(true);
                    con.close();
                }

            } catch (Exception closeException) {

                closeException.printStackTrace();
            }
        }
    }


    // Checks whether an order can move to the requested status
    private boolean isValidStatusTransition(
            String currentStatus,
            String newStatus) {

        if (currentStatus == null || newStatus == null) {
            return false;
        }

        currentStatus =
                currentStatus.toUpperCase();

        newStatus =
                newStatus.toUpperCase();


        // Same status is allowed
        if (currentStatus.equals(newStatus)) {
            return true;
        }


        switch (currentStatus) {

            case "PENDING":
                return newStatus.equals("ACCEPTED");

            case "ACCEPTED":
                return newStatus.equals("PROCESSING");

            case "PROCESSING":
                return newStatus.equals("SHIPPED");

            case "SHIPPED":
                return newStatus.equals("DELIVERED");

            case "DELIVERED":
                return false;

            default:
                return false;
        }
    }


    public List<OrderItem> getOrderItems(int orderId) {

        List<OrderItem> items = new ArrayList<>();

        String sql =
                "SELECT oi.*, m.medicine_name " +
                "FROM order_items oi " +
                "JOIN medicines m " +
                "ON oi.medicine_id = m.medicine_id " +
                "WHERE oi.order_id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderItem item = new OrderItem();

                item.setOrderItemId(
                        rs.getInt("order_item_id")
                );

                item.setOrderId(
                        rs.getInt("order_id")
                );

                item.setMedicineId(
                        rs.getInt("medicine_id")
                );

                item.setMedicineName(
                        rs.getString("medicine_name")
                );

                item.setQuantity(
                        rs.getInt("quantity")
                );

                item.setPrice(
                        rs.getDouble("price")
                );

                items.add(item);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return items;
    }
}