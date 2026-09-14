package dao.doctor;

import model.doctor.Medicine;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAO {

    public List<Medicine> getActiveMedicines() {
        List<Medicine> list = new ArrayList<Medicine>();
        String sql = "SELECT medicine_id, pharmacy_id, medicine_name, generic_name, "
                + "category, description, price, stock_quantity, expiry_date, manufacturer, status "
                + "FROM medicines "
                + "ORDER BY medicine_name ASC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Medicine m = new Medicine();
                m.setMedicineId(rs.getInt("medicine_id"));
                m.setPharmacyId(rs.getInt("pharmacy_id"));
                m.setMedicineName(rs.getString("medicine_name"));
                m.setGenericName(rs.getString("generic_name"));
                m.setCategory(rs.getString("category"));
                m.setDescription(rs.getString("description"));
                m.setPrice(rs.getDouble("price"));
                m.setStockQuantity(rs.getInt("stock_quantity"));
                m.setExpiryDate(rs.getString("expiry_date"));
                m.setManufacturer(rs.getString("manufacturer"));
                m.setStatus(rs.getString("status"));
                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return list;
    }

    public Medicine getMedicineById(int medicineId) {
        String sql = "SELECT medicine_id, pharmacy_id, medicine_name, generic_name, "
                + "category, description, price, stock_quantity, expiry_date, manufacturer, status "
                + "FROM medicines WHERE medicine_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, medicineId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Medicine m = new Medicine();
                m.setMedicineId(rs.getInt("medicine_id"));
                m.setPharmacyId(rs.getInt("pharmacy_id"));
                m.setMedicineName(rs.getString("medicine_name"));
                m.setGenericName(rs.getString("generic_name"));
                m.setCategory(rs.getString("category"));
                m.setDescription(rs.getString("description"));
                m.setPrice(rs.getDouble("price"));
                m.setStockQuantity(rs.getInt("stock_quantity"));
                m.setExpiryDate(rs.getString("expiry_date"));
                m.setManufacturer(rs.getString("manufacturer"));
                m.setStatus(rs.getString("status"));
                return m;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return null;
    }

    private void close(Connection con, PreparedStatement ps, ResultSet rs) {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (ps != null) {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
