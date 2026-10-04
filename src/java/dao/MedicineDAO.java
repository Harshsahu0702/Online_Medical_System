package dao;

import model.Medicine;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAO {

    // ==========================================
    // 1. ADD MEDICINE
    // ==========================================

    public boolean addMedicine(Medicine medicine) {

        String sql = "INSERT INTO medicines "
                + "(pharmacy_id, medicine_name, generic_name, "
                + "category, price, stock, expiry_date, "
                + "manufacturer, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, medicine.getPharmacyId());
            ps.setString(2, medicine.getMedicineName());
            ps.setString(3, medicine.getGenericName());
            ps.setString(4, medicine.getCategory());
            ps.setDouble(5, medicine.getPrice());
            ps.setInt(6, medicine.getStock());
            ps.setDate(7, medicine.getExpiryDate());
            ps.setString(8, medicine.getManufacturer());
            ps.setString(9, medicine.getStatus());

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 2. GET ALL MEDICINES
    // ==========================================

    public List<Medicine> getAllMedicines(int pharmacyId) {

        List<Medicine> medicines = new ArrayList<>();

        String sql = "SELECT * FROM medicines "
                + "WHERE pharmacy_id = ? "
                + "ORDER BY medicine_name";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, pharmacyId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Medicine medicine = new Medicine();

                medicine.setMedicineId(
                        rs.getInt("medicine_id"));

                medicine.setPharmacyId(
                        rs.getInt("pharmacy_id"));

                medicine.setMedicineName(
                        rs.getString("medicine_name"));

                medicine.setGenericName(
                        rs.getString("generic_name"));

                medicine.setCategory(
                        rs.getString("category"));

                medicine.setPrice(
                        rs.getDouble("price"));

                medicine.setStock(
                        rs.getInt("stock"));

                medicine.setExpiryDate(
                        rs.getDate("expiry_date"));

                medicine.setManufacturer(
                        rs.getString("manufacturer"));

                medicine.setStatus(
                        rs.getString("status"));

                medicines.add(medicine);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return medicines;
    }


    // ==========================================
    // 3. SEARCH MEDICINE
    // ==========================================

    public List<Medicine> searchMedicines(
            int pharmacyId,
            String keyword) {

        List<Medicine> medicines = new ArrayList<>();

        String sql = "SELECT * FROM medicines "
                + "WHERE pharmacy_id = ? "
                + "AND (medicine_name LIKE ? "
                + "OR generic_name LIKE ? "
                + "OR category LIKE ?) "
                + "ORDER BY medicine_name";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            String search = "%" + keyword + "%";

            ps.setInt(1, pharmacyId);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Medicine medicine = new Medicine();

                medicine.setMedicineId(
                        rs.getInt("medicine_id"));

                medicine.setPharmacyId(
                        rs.getInt("pharmacy_id"));

                medicine.setMedicineName(
                        rs.getString("medicine_name"));

                medicine.setGenericName(
                        rs.getString("generic_name"));

                medicine.setCategory(
                        rs.getString("category"));

                medicine.setPrice(
                        rs.getDouble("price"));

                medicine.setStock(
                        rs.getInt("stock"));

                medicine.setExpiryDate(
                        rs.getDate("expiry_date"));

                medicine.setManufacturer(
                        rs.getString("manufacturer"));

                medicine.setStatus(
                        rs.getString("status"));

                medicines.add(medicine);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return medicines;
    }


    // ==========================================
    // 4. GET MEDICINE BY ID
    // ==========================================

    public Medicine getMedicineById(int medicineId) {

        Medicine medicine = null;

        String sql = "SELECT * FROM medicines "
                + "WHERE medicine_id = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, medicineId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                medicine = new Medicine();

                medicine.setMedicineId(
                        rs.getInt("medicine_id"));

                medicine.setPharmacyId(
                        rs.getInt("pharmacy_id"));

                medicine.setMedicineName(
                        rs.getString("medicine_name"));

                medicine.setGenericName(
                        rs.getString("generic_name"));

                medicine.setCategory(
                        rs.getString("category"));

                medicine.setPrice(
                        rs.getDouble("price"));

                medicine.setStock(
                        rs.getInt("stock"));

                medicine.setExpiryDate(
                        rs.getDate("expiry_date"));

                medicine.setManufacturer(
                        rs.getString("manufacturer"));

                medicine.setStatus(
                        rs.getString("status"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return medicine;
    }


    // ==========================================
    // 5. UPDATE MEDICINE
    // ==========================================

    public boolean updateMedicine(Medicine medicine) {

        String sql = "UPDATE medicines SET "
                + "medicine_name = ?, "
                + "generic_name = ?, "
                + "category = ?, "
                + "price = ?, "
                + "stock = ?, "
                + "expiry_date = ?, "
                + "manufacturer = ?, "
                + "status = ? "
                + "WHERE medicine_id = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, medicine.getMedicineName());
            ps.setString(2, medicine.getGenericName());
            ps.setString(3, medicine.getCategory());
            ps.setDouble(4, medicine.getPrice());
            ps.setInt(5, medicine.getStock());
            ps.setDate(6, medicine.getExpiryDate());
            ps.setString(7, medicine.getManufacturer());
            ps.setString(8, medicine.getStatus());
            ps.setInt(9, medicine.getMedicineId());

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 6. DELETE MEDICINE
    // ==========================================

    public boolean deleteMedicine(int medicineId) {

        String sql = "DELETE FROM medicines "
                + "WHERE medicine_id = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, medicineId);

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 7. UPDATE STOCK
    // ==========================================

    public boolean updateStock(
            int medicineId,
            int stock) {

        String sql = "UPDATE medicines "
                + "SET stock = ? "
                + "WHERE medicine_id = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, stock);
            ps.setInt(2, medicineId);

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}