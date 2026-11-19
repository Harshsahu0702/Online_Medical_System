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
            "SELECT o.order_id, o.patient_id, o.pharmacy_id, o.order_date, o.total_amount, o.order_status, o.delivery_address, "
          + "COALESCE(p.name, 'Local Pharmacy') as pharmacy_name, "
          + "COALESCE(pat.name, 'Patient') as patient_name "
          + "FROM orders o "
          + "LEFT JOIN pharmacies p ON o.pharmacy_id = p.pharmacy_id "
          + "LEFT JOIN patients pat ON o.patient_id = pat.patient_id "
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
                    int orderId = rs.getInt("order_id");
                    Map<String, Object> map = new HashMap<>();
                    map.put("orderId", orderId);
                    map.put("patientId", rs.getString("patient_id"));
                    map.put("patientName", rs.getString("patient_name"));
                    map.put("pharmacyId", rs.getInt("pharmacy_id"));
                    map.put("pharmacyName", rs.getString("pharmacy_name"));
                    map.put("orderDate", rs.getTimestamp("order_date"));
                    map.put("totalAmount", rs.getDouble("total_amount"));
                    map.put("orderStatus", rs.getString("order_status"));
                    map.put("deliveryAddress", rs.getString("delivery_address"));

                    // Fetch medicines list & prices for this order
                    List<Map<String, Object>> items = new ArrayList<>();
                    String itemsSql = "SELECT oi.*, m.medicine_name "
                                    + "FROM order_items oi "
                                    + "LEFT JOIN medicines m ON oi.medicine_id = m.medicine_id "
                                    + "WHERE oi.order_id = ?";
                    try (PreparedStatement psItems = con.prepareStatement(itemsSql)) {
                        psItems.setInt(1, orderId);
                        try (ResultSet rsItems = psItems.executeQuery()) {
                            while (rsItems.next()) {
                                Map<String, Object> item = new HashMap<>();
                                item.put("orderItemId", rsItems.getInt("order_item_id"));
                                item.put("medicineId", rsItems.getInt("medicine_id"));
                                String medName = rsItems.getString("medicine_name");
                                if (medName == null || medName.trim().isEmpty()) {
                                    medName = "Medicine #" + rsItems.getInt("medicine_id");
                                }
                                item.put("medicineName", medName);
                                item.put("quantity", rsItems.getInt("quantity"));
                                item.put("unitPrice", rsItems.getDouble("unit_price"));
                                item.put("subtotal", rsItems.getDouble("subtotal"));
                                items.add(item);
                            }
                        }
                    } catch (Exception itemErr) {
                        System.err.println("Error fetching items for order #" + orderId + ": " + itemErr.getMessage());
                    }
                    map.put("items", items);
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
        String orderSql = "SELECT o.order_id, o.patient_id, o.pharmacy_id, o.order_date, o.total_amount, o.order_status, o.delivery_address, "
                        + "COALESCE(p.name, 'Local Pharmacy') as pharmacy_name, p.address as pharmacy_address, "
                        + "COALESCE(pat.name, 'Patient') as patient_name "
                        + "FROM orders o "
                        + "LEFT JOIN pharmacies p ON o.pharmacy_id = p.pharmacy_id "
                        + "LEFT JOIN patients pat ON o.patient_id = pat.patient_id "
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
                    map.put("patientName", rs.getString("patient_name"));
                    map.put("pharmacyId", rs.getInt("pharmacy_id"));
                    map.put("pharmacyName", rs.getString("pharmacy_name"));
                    map.put("pharmacyAddress", rs.getString("pharmacy_address"));
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