package patient.dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PatientOrderDAO {

    public List<Map<String, Object>> getOrdersByPatientId(String patientId, String statusFilter) {
        List<Map<String, Object>> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT o.*, p.* "
          + "FROM orders o "
          + "LEFT JOIN pharmacies p ON o.pharmacy_id = p.pharmacy_id "
          + "WHERE o.patient_id = ? "
        );

        boolean hasStatus = statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equalsIgnoreCase("All");
        if (hasStatus) {
            sql.append("AND o.order_status = ? ");
        }
        sql.append("ORDER BY o.order_date DESC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            ps.setString(1, patientId);
            if (hasStatus) {
                ps.setString(2, statusFilter.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("orderId", rs.getInt("order_id"));
                    map.put("patientId", rs.getString("patient_id"));
                    map.put("pharmacyId", rs.getInt("pharmacy_id"));

                    String pName = null;
                    try { pName = rs.getString("pharmacy_name"); } catch (Exception ignore) {}
                    if (pName == null || pName.trim().isEmpty()) {
                        try { pName = rs.getString("name"); } catch (Exception ignore) {}
                    }
                    map.put("pharmacyName", pName != null ? pName : "Local Pharmacy");
                    map.put("orderDate", rs.getTimestamp("order_date"));
                    map.put("totalAmount", rs.getDouble("total_amount"));
                    map.put("orderStatus", rs.getString("order_status"));
                    map.put("deliveryAddress", rs.getString("delivery_address"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientOrderDAO.getOrdersByPatientId: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public Map<String, Object> getOrderDetails(int orderId) {
        String orderSql = "SELECT o.*, p.* "
                        + "FROM orders o "
                        + "LEFT JOIN pharmacies p ON o.pharmacy_id = p.pharmacy_id "
                        + "WHERE o.order_id = ?";

        String itemsSql = "SELECT oi.*, m.medicine_name "
                        + "FROM order_items oi "
                        + "LEFT JOIN medicines m ON oi.medicine_id = m.medicine_id "
                        + "WHERE oi.order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(orderSql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("orderId", rs.getInt("order_id"));
                    map.put("patientId", rs.getString("patient_id"));
                    map.put("pharmacyId", rs.getInt("pharmacy_id"));

                    String pName = null;
                    try { pName = rs.getString("pharmacy_name"); } catch (Exception ignore) {}
                    if (pName == null || pName.trim().isEmpty()) {
                        try { pName = rs.getString("name"); } catch (Exception ignore) {}
                    }
                    map.put("pharmacyName", pName != null ? pName : "Local Pharmacy");
                    map.put("pharmacyAddress", rs.getString("address"));
                    map.put("orderDate", rs.getTimestamp("order_date"));
                    map.put("totalAmount", rs.getDouble("total_amount"));
                    map.put("orderStatus", rs.getString("order_status"));
                    map.put("deliveryAddress", rs.getString("delivery_address"));

                    List<Map<String, Object>> items = new ArrayList<>();
                    try (PreparedStatement ps2 = con.prepareStatement(itemsSql)) {
                        ps2.setInt(1, orderId);
                        try (ResultSet rs2 = ps2.executeQuery()) {
                            while (rs2.next()) {
                                Map<String, Object> item = new HashMap<>();
                                item.put("orderItemId", rs2.getInt("order_item_id"));
                                item.put("medicineId", rs2.getInt("medicine_id"));
                                item.put("medicineName", rs2.getString("medicine_name"));
                                item.put("quantity", rs2.getInt("quantity"));
                                item.put("unitPrice", rs2.getDouble("unit_price"));
                                item.put("subtotal", rs2.getDouble("subtotal"));
                                items.add(item);
                            }
                        }
                    }
                    map.put("items", items);
                    return map;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientOrderDAO.getOrderDetails: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean cancelOrder(int orderId) {
        String sql = "UPDATE orders SET order_status = 'CANCELLED' WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error cancelling order: " + e.getMessage());
            return false;
        }
    }
}