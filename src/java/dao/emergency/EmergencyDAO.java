package dao.emergency;

import model.emergency.Emergency;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

public class EmergencyDAO
{
    private static final String URL =
            "jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db?sslMode=REQUIRED&connectionTimeZone=Asia/Kolkata";

    private static final String USER = "avnadmin";
    private static Connection getConnection() throws SQLException, ClassNotFoundException
    {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String password = System.getenv("DB_PASSWORD");
            if (password == null) {
                password = "";
            }
            return DriverManager.getConnection(URL, USER, password);
    }

    public static Integer getPatientIdByUserId(int userId) {
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
                return rs.getInt("patient_id");
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

    public static boolean isPatientExists(int patientId, Connection con) {
        String sql = "SELECT 1 FROM patients WHERE patient_id = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, patientId);
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

    public static int insertData(Emergency emergency)
    {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "insert into emergency_requests (patient_id,"
                + "emergency_type,description,location,contact_number,severity,status)"
                + "values (?,?,?,?,?,?,?)";
        try {
            con = getConnection();

            // Validate patientID if provided to prevent foreign key constraint violation
            if (emergency.getPatientID() != null) {
                if (!isPatientExists(emergency.getPatientID(), con)) {
                    emergency.setPatientID(null);
                }
            }

            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            if (emergency.getPatientID() == null) {
                 ps.setNull(1, java.sql.Types.INTEGER);
            } 
            else {
                ps.setInt(1, emergency.getPatientID());
            }
            ps.setString(2, emergency.getEmergencyType());
            ps.setString(3, emergency.getDescription());
            ps.setString(4, emergency.getLocation());
            ps.setString(5, emergency.getContact());
            ps.setString(6, emergency.getSeverity());
            ps.setString(7, emergency.getStatus());
            int p = ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                emergency.setEmergencyID(id);
            }
            return p;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
        return 0;
    }
}