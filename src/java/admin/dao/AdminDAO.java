package admin.dao;

import admin.model.Admin;
import admin.model.SystemOverview;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDAO {

    public Admin authenticate(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND (role = 'ADMIN' OR role = 'admin')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email != null ? email.trim() : "");
            ps.setString(2, password != null ? password.trim() : "");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setUserId(rs.getInt("user_id"));
                    admin.setName(rs.getString("name"));
                    admin.setEmail(rs.getString("email"));
                    admin.setPhone(rs.getString("phone"));
                    admin.setRole(rs.getString("role"));
                    admin.setStatus(rs.getString("status"));
                    admin.setCreatedAt(rs.getTimestamp("created_at"));
                    return admin;
                }
            }
        } catch (Exception e) {
            System.err.println("Admin authentication error: " + e.getMessage());
        }
        return null;
    }

    public SystemOverview getSystemOverview() {
        SystemOverview overview = new SystemOverview();

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement()) {

            // 1. Doctors
            try (ResultSet rs = stmt.executeQuery("SELECT count(*), SUM(CASE WHEN verification_status = 'APPROVED' THEN 1 ELSE 0 END), SUM(CASE WHEN verification_status = 'PENDING' THEN 1 ELSE 0 END) FROM doctors")) {
                if (rs.next()) {
                    overview.setTotalDoctors(rs.getInt(1));
                    overview.setVerifiedDoctors(rs.getInt(2));
                    overview.setPendingDoctors(rs.getInt(3));
                }
            } catch (Exception ignore) {}

            // 2. Patients
            try (ResultSet rs = stmt.executeQuery("SELECT count(*) FROM patients")) {
                if (rs.next()) overview.setTotalPatients(rs.getInt(1));
            } catch (Exception ignore) {}

            // 3. Pharmacies
            try (ResultSet rs = stmt.executeQuery("SELECT count(*) FROM pharmacies")) {
                if (rs.next()) overview.setTotalPharmacies(rs.getInt(1));
            } catch (Exception ignore) {}

            // 4. Medicines
            try (ResultSet rs = stmt.executeQuery("SELECT count(*) FROM medicines")) {
                if (rs.next()) overview.setTotalMedicines(rs.getInt(1));
            } catch (Exception ignore) {}

            // 5. Orders
            try (ResultSet rs = stmt.executeQuery("SELECT count(*), SUM(CASE WHEN order_status = 'PENDING' OR order_status = 'pending' THEN 1 ELSE 0 END) FROM orders")) {
                if (rs.next()) {
                    overview.setTotalOrders(rs.getInt(1));
                    overview.setPendingOrders(rs.getInt(2));
                }
            } catch (Exception ignore) {}

            // 6. Emergencies
            try (ResultSet rs = stmt.executeQuery("SELECT count(*), SUM(CASE WHEN status != 'RESOLVED' AND status != 'CANCELLED' THEN 1 ELSE 0 END) FROM emergency_requests")) {
                if (rs.next()) {
                    overview.setTotalEmergencies(rs.getInt(1));
                    overview.setActiveEmergencies(rs.getInt(2));
                }
            } catch (Exception ignore) {}

            // 7. Appointments
            try (ResultSet rs = stmt.executeQuery("SELECT count(*) FROM appointments")) {
                if (rs.next()) overview.setTotalAppointments(rs.getInt(1));
            } catch (Exception ignore) {}

        } catch (Exception e) {
            System.err.println("Error fetching system overview: " + e.getMessage());
        }

        return overview;
    }

    public List<Map<String, Object>> getAllDoctors() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT d.doctor_id, d.license_number, d.verification_status, d.experience_years, d.consultation_fee, "
                   + "u.user_id, u.name, u.email, u.phone, u.status as account_status, "
                   + "s.name as specialization "
                   + "FROM doctors d "
                   + "JOIN users u ON d.user_id = u.user_id "
                   + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                   + "ORDER BY d.doctor_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("doctorId", rs.getInt("doctor_id"));
                map.put("userId", rs.getInt("user_id"));
                map.put("name", rs.getString("name"));
                map.put("email", rs.getString("email"));
                map.put("phone", rs.getString("phone"));
                map.put("specialization", rs.getString("specialization") != null ? rs.getString("specialization") : "General Practice");
                map.put("licenseNumber", rs.getString("license_number"));
                map.put("verificationStatus", rs.getString("verification_status"));
                map.put("accountStatus", rs.getString("account_status"));
                map.put("experienceYears", rs.getInt("experience_years"));
                map.put("fee", rs.getDouble("consultation_fee"));
                list.add(map);
            }
        } catch (Exception e) {
            System.err.println("Error listing doctors for admin: " + e.getMessage());
        }
        return list;
    }

    public boolean updateDoctorStatus(int doctorId, String verificationStatus, String accountStatus) {
        String docSql = "UPDATE doctors SET verification_status = ? WHERE doctor_id = ?";
        String userSql = "UPDATE users SET status = ? WHERE user_id = (SELECT user_id FROM doctors WHERE doctor_id = ?)";

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement ps1 = con.prepareStatement(docSql)) {
                ps1.setString(1, verificationStatus);
                ps1.setInt(2, doctorId);
                ps1.executeUpdate();
            }
            if (accountStatus != null && !accountStatus.trim().isEmpty()) {
                try (PreparedStatement ps2 = con.prepareStatement(userSql)) {
                    ps2.setString(1, accountStatus);
                    ps2.setInt(2, doctorId);
                    ps2.executeUpdate();
                }
            }
            con.commit();
            return true;
        } catch (Exception e) {
            System.err.println("Error updating doctor status: " + e.getMessage());
            return false;
        }
    }

    public List<Map<String, Object>> getAllPatients() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT * FROM patients ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("patientId", rs.getString("patient_id"));
                map.put("name", rs.getString("name"));
                map.put("email", rs.getString("email"));
                map.put("contact", rs.getString("contact"));
                map.put("gender", rs.getString("gender"));
                map.put("bloodGroup", rs.getString("blood_group"));
                map.put("address", rs.getString("address"));
                map.put("emergencyContact", rs.getString("emergency_contact"));
                map.put("createdAt", rs.getTimestamp("created_at"));
                list.add(map);
            }
        } catch (Exception e) {
            System.err.println("Error listing patients for admin: " + e.getMessage());
        }
        return list;
    }

    public List<Map<String, Object>> getAllPharmaciesWithStats() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.*, u.email, u.phone, "
                   + "(SELECT COUNT(*) FROM medicines m WHERE m.pharmacy_id = p.pharmacy_id) as total_meds, "
                   + "(SELECT COUNT(*) FROM orders o WHERE o.pharmacy_id = p.pharmacy_id) as total_orders "
                   + "FROM pharmacies p "
                   + "LEFT JOIN users u ON p.user_id = u.user_id "
                   + "ORDER BY p.pharmacy_id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("pharmacyId", rs.getInt("pharmacy_id"));
                map.put("name", rs.getString("name"));
                map.put("email", rs.getString("email") != null ? rs.getString("email") : "N/A");
                map.put("phone", rs.getString("phone") != null ? rs.getString("phone") : "N/A");
                map.put("address", rs.getString("address"));
                map.put("licenseNumber", rs.getString("license_number"));
                map.put("totalMeds", rs.getInt("total_meds"));
                map.put("totalOrders", rs.getInt("total_orders"));
                list.add(map);
            }
        } catch (Exception e) {
            System.err.println("Error listing pharmacies for admin: " + e.getMessage());
        }
        return list;
    }

    public List<Map<String, Object>> getAllEmergencies() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT e.*, p.name as patient_name "
                   + "FROM emergency_requests e "
                   + "LEFT JOIN patients p ON e.patient_id = p.patient_id "
                   + "ORDER BY e.requested_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("emergencyId", rs.getInt("emergency_id"));
                map.put("patientId", rs.getString("patient_id"));
                map.put("patientName", rs.getString("patient_name") != null ? rs.getString("patient_name") : "Emergency Caller");
                map.put("emergencyType", rs.getString("emergency_type"));
                map.put("description", rs.getString("description"));
                map.put("location", rs.getString("location"));
                map.put("contactNumber", rs.getString("contact_number"));
                map.put("severity", rs.getString("severity"));
                map.put("status", rs.getString("status"));
                map.put("requestedAt", rs.getTimestamp("requested_at"));
                map.put("resolvedAt", rs.getTimestamp("resolved_at"));
                list.add(map);
            }
        } catch (Exception e) {
            System.err.println("Error listing emergencies for admin: " + e.getMessage());
        }
        return list;
    }

    public boolean updateEmergencyStatus(int emergencyId, String status) {
        String sql = "UPDATE emergency_requests SET status = ?, resolved_at = " +
                     ("RESOLVED".equalsIgnoreCase(status) ? "CURRENT_TIMESTAMP" : "NULL") +
                     " WHERE emergency_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status != null ? status.toUpperCase() : "PENDING");
            ps.setInt(2, emergencyId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error updating emergency status: " + e.getMessage());
            return false;
        }
    }
}
