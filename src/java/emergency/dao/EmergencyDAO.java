package emergency.dao;

import emergency.model.Emergency;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class EmergencyDAO {

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        return DBConnection.getConnection();
    }

    public static String getPatientIdByUserId(int userId) {
        String sql = "SELECT patient_id FROM patients WHERE user_id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("patient_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
        return null;
    }

    public static boolean isPatientExists(String patientId, Connection con) {
        String sql = "SELECT 1 FROM patients WHERE patient_id = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, patientId);
            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        }
        return false;
    }

    public static int insertData(Emergency emergency) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "INSERT INTO emergency_requests (patient_id, emergency_type, description, location, contact_number, severity, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            con = getConnection();

            // Validate patientID if provided to prevent foreign key constraint violation
            if (emergency.getPatientID() != null && !emergency.getPatientID().trim().isEmpty()) {
                if (!isPatientExists(emergency.getPatientID(), con)) {
                    emergency.setPatientID((String) null);
                }
            }

            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            if (emergency.getPatientID() == null || emergency.getPatientID().trim().isEmpty()) {
                 ps.setNull(1, java.sql.Types.VARCHAR);
            } else {
                ps.setString(1, emergency.getPatientID());
            }
            ps.setString(2, emergency.getEmergencyType());
            ps.setString(3, emergency.getDescription());
            ps.setString(4, emergency.getLocation());
            ps.setString(5, emergency.getContact());
            ps.setString(6, emergency.getSeverity());
            ps.setString(7, emergency.getStatus() != null ? emergency.getStatus() : "Pending");

            int p = ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                emergency.setEmergencyID(id);
            }
            return p;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
        return 0;
    }

    public static Emergency getEmergencyById(int id) {
        String sql = "SELECT * FROM emergency_requests WHERE emergency_id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Emergency e = new Emergency();
                    e.setEmergencyID(rs.getInt("emergency_id"));
                    e.setPatientID(rs.getString("patient_id"));
                    e.setEmergencyType(rs.getString("emergency_type"));
                    e.setDescription(rs.getString("description"));
                    e.setLocation(rs.getString("location"));
                    e.setContact(rs.getString("contact_number"));
                    e.setSeverity(rs.getString("severity"));
                    e.setStatus(rs.getString("status"));
                    e.setRequestedAt(rs.getString("requested_at"));
                    e.setResolvedAt(rs.getString("resolved_at"));
                    return e;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Emergency> getAllEmergencies() {
        List<Emergency> list = new ArrayList<>();
        String sql = "SELECT * FROM emergency_requests ORDER BY requested_at DESC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Emergency e = new Emergency();
                e.setEmergencyID(rs.getInt("emergency_id"));
                e.setPatientID(rs.getString("patient_id"));
                e.setEmergencyType(rs.getString("emergency_type"));
                e.setDescription(rs.getString("description"));
                e.setLocation(rs.getString("location"));
                e.setContact(rs.getString("contact_number"));
                e.setSeverity(rs.getString("severity"));
                e.setStatus(rs.getString("status"));
                e.setRequestedAt(rs.getString("requested_at"));
                e.setResolvedAt(rs.getString("resolved_at"));
                list.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean updateStatus(int emergencyId, String status) {
        String sql = "UPDATE emergency_requests SET status = ?, resolved_at = "
                   + ("RESOLVED".equalsIgnoreCase(status) ? "CURRENT_TIMESTAMP" : "resolved_at")
                   + " WHERE emergency_id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, emergencyId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}