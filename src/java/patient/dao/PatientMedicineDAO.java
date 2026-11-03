package patient.dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PatientMedicineDAO {

    public List<Map<String, Object>> getAllMedicines(String query, String category) {
        List<Map<String, Object>> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT m.*, p.name AS pharmacy_name "
          + "FROM medicines m "
          + "JOIN pharmacies p ON m.pharmacy_id = p.pharmacy_id "
          + "WHERE m.status = 'AVAILABLE' AND m.stock_quantity > 0 "
        );

        List<Object> params = new ArrayList<>();
        if (query != null && !query.trim().isEmpty()) {
            sql.append("AND (m.name LIKE ? OR m.generic_name LIKE ?) ");
            String q = "%" + query.trim() + "%";
            params.add(q);
            params.add(q);
        }
        if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
            sql.append("AND m.category = ? ");
            params.add(category.trim());
        }
        sql.append("ORDER BY m.name ASC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("medicineId", rs.getInt("medicine_id"));
                    map.put("pharmacyId", rs.getInt("pharmacy_id"));
                    map.put("pharmacyName", rs.getString("pharmacy_name"));
                    map.put("name", rs.getString("name"));
                    map.put("genericName", rs.getString("generic_name"));
                    map.put("category", rs.getString("category"));
                    map.put("description", rs.getString("description"));
                    map.put("price", rs.getDouble("price"));
                    map.put("stockQuantity", rs.getInt("stock_quantity"));
                    map.put("expiryDate", rs.getString("expiry_date"));
                    map.put("manufacturer", rs.getString("manufacturer"));
                    map.put("status", rs.getString("status"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientMedicineDAO.getAllMedicines: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public Map<String, Object> getMedicineDetails(int medicineId) {
        String sql = "SELECT m.*, p.name AS pharmacy_name, p.address AS pharmacy_address "
                   + "FROM medicines m "
                   + "JOIN pharmacies p ON m.pharmacy_id = p.pharmacy_id "
                   + "WHERE m.medicine_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, medicineId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("medicineId", rs.getInt("medicine_id"));
                    map.put("pharmacyId", rs.getInt("pharmacy_id"));
                    map.put("pharmacyName", rs.getString("pharmacy_name"));
                    map.put("pharmacyAddress", rs.getString("pharmacy_address"));
                    map.put("name", rs.getString("name"));
                    map.put("genericName", rs.getString("generic_name"));
                    map.put("category", rs.getString("category"));
                    map.put("description", rs.getString("description"));
                    map.put("price", rs.getDouble("price"));
                    map.put("stockQuantity", rs.getInt("stock_quantity"));
                    map.put("expiryDate", rs.getString("expiry_date"));
                    map.put("manufacturer", rs.getString("manufacturer"));
                    map.put("status", rs.getString("status"));
                    return map;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientMedicineDAO.getMedicineDetails: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
