package pharmacy.dao;

import pharmacy.model.Medicine;
import util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAO {

    // Cache column name used in DB: "stock_quantity" (default) or "stock"
    private static volatile String cachedStockColumn = null;

    private static String getStockColumn(Connection con) {
        if (cachedStockColumn != null) {
            return cachedStockColumn;
        }
        try {
            java.sql.DatabaseMetaData meta = con.getMetaData();
            try (ResultSet rs = meta.getColumns(null, null, "medicines", "stock_quantity")) {
                if (rs.next()) {
                    cachedStockColumn = "stock_quantity";
                    return cachedStockColumn;
                }
            }
            try (ResultSet rs = meta.getColumns(null, null, "medicines", "stock")) {
                if (rs.next()) {
                    cachedStockColumn = "stock";
                    return cachedStockColumn;
                }
            }
        } catch (Exception ignore) {
        }
        cachedStockColumn = "stock_quantity";
        return cachedStockColumn;
    }

    public boolean addMedicine(Medicine medicine) {
        if (medicine == null) return false;

        try (Connection con = DBConnection.getConnection()) {
            String stockCol = getStockColumn(con);
            String sql = "INSERT INTO medicines "
                    + "(pharmacy_id, medicine_name, generic_name, category, description, price, "
                    + stockCol + ", expiry_date, manufacturer, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, medicine.getPharmacyId());
                ps.setString(2, medicine.getMedicineName());
                ps.setString(3, medicine.getGenericName());
                ps.setString(4, medicine.getCategory());
                ps.setString(5, medicine.getDescription() != null ? medicine.getDescription() : "");
                ps.setDouble(6, medicine.getPrice());
                ps.setInt(7, medicine.getStock());
                ps.setDate(8, medicine.getExpiryDate());
                ps.setString(9, medicine.getManufacturer());
                ps.setString(10, medicine.getStatus() != null ? medicine.getStatus() : "AVAILABLE");

                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.err.println("Error adding medicine: " + e.getMessage());
            return false;
        }
    }

    public List<Medicine> getAllMedicines(int pharmacyId) {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT * FROM medicines WHERE pharmacy_id = ? ORDER BY medicine_name ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, pharmacyId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    medicines.add(mapMedicine(rs));
                }
            }
        } catch (Exception e) {
            System.err.println("Error getting all medicines: " + e.getMessage());
        }
        return medicines;
    }

    public List<Medicine> searchMedicines(int pharmacyId, String keyword) {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT * FROM medicines WHERE pharmacy_id = ? "
                + "AND (medicine_name LIKE ? OR generic_name LIKE ? OR category LIKE ?) "
                + "ORDER BY medicine_name ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String searchPattern = "%" + (keyword != null ? keyword.trim() : "") + "%";
            ps.setInt(1, pharmacyId);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    medicines.add(mapMedicine(rs));
                }
            }
        } catch (Exception e) {
            System.err.println("Error searching medicines: " + e.getMessage());
        }
        return medicines;
    }

    public Medicine getMedicineById(int medicineId) {
        String sql = "SELECT * FROM medicines WHERE medicine_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, medicineId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapMedicine(rs);
                }
            }
        } catch (Exception e) {
            System.err.println("Error getting medicine by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean updateMedicine(Medicine medicine) {
        if (medicine == null) return false;

        try (Connection con = DBConnection.getConnection()) {
            String stockCol = getStockColumn(con);
            String sql = "UPDATE medicines SET "
                    + "medicine_name = ?, "
                    + "generic_name = ?, "
                    + "category = ?, "
                    + "price = ?, "
                    + stockCol + " = ?, "
                    + "expiry_date = ?, "
                    + "manufacturer = ?, "
                    + "status = ? "
                    + "WHERE medicine_id = ?";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, medicine.getMedicineName());
                ps.setString(2, medicine.getGenericName());
                ps.setString(3, medicine.getCategory());
                ps.setDouble(4, medicine.getPrice());
                ps.setInt(5, medicine.getStock());
                ps.setDate(6, medicine.getExpiryDate());
                ps.setString(7, medicine.getManufacturer());
                ps.setString(8, medicine.getStatus());
                ps.setInt(9, medicine.getMedicineId());

                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.err.println("Error updating medicine: " + e.getMessage());
            return false;
        }
    }

    public boolean updateStock(int medicineId, int stock) {
        try (Connection con = DBConnection.getConnection()) {
            String stockCol = getStockColumn(con);
            String sql = "UPDATE medicines SET " + stockCol + " = ? WHERE medicine_id = ?";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, stock);
                ps.setInt(2, medicineId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.err.println("Error updating stock: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteMedicine(int medicineId) {
        String sql = "DELETE FROM medicines WHERE medicine_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, medicineId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error deleting medicine: " + e.getMessage());
            return false;
        }
    }

    private Medicine mapMedicine(ResultSet rs) throws SQLException {
        Medicine m = new Medicine();
        m.setMedicineId(rs.getInt("medicine_id"));
        m.setPharmacyId(rs.getInt("pharmacy_id"));
        m.setMedicineName(rs.getString("medicine_name"));
        m.setGenericName(rs.getString("generic_name"));
        m.setCategory(rs.getString("category"));

        try { m.setDescription(rs.getString("description")); } catch (SQLException ignore) {}
        m.setPrice(rs.getDouble("price"));

        // Support stock vs stock_quantity column names
        int stockVal = 0;
        try {
            stockVal = rs.getInt("stock_quantity");
        } catch (SQLException e) {
            try {
                stockVal = rs.getInt("stock");
            } catch (SQLException ignore) {}
        }
        m.setStock(stockVal);

        m.setExpiryDate(rs.getDate("expiry_date"));
        m.setManufacturer(rs.getString("manufacturer"));
        m.setStatus(rs.getString("status"));

        return m;
    }
}
