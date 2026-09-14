package dao.doctor;

import model.doctor.Appointment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AppointmentDAO {

    public List<Appointment> getAppointmentsByDoctor(int doctorId, String statusFilter) {
        List<Appointment> list = new ArrayList<Appointment>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT a.appointment_id, a.patient_id, a.doctor_id, a.appointment_date, ");
        sql.append("TIME_FORMAT(a.appointment_time, '%h:%i %p') AS formatted_time, a.appointment_time, ");
        sql.append("a.appointment_type, a.status, a.reason, a.created_at, ");
        sql.append("u.name AS patient_name, u.phone AS patient_phone, u.email AS patient_email, ");
        sql.append("p.gender AS patient_gender, p.blood_group AS patient_blood_group ");
        sql.append("FROM appointments a ");
        sql.append("JOIN patients p ON a.patient_id = p.patient_id ");
        sql.append("JOIN users u ON p.user_id = u.user_id ");
        sql.append("WHERE a.doctor_id = ? ");

        if (statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equalsIgnoreCase("ALL")) {
            sql.append("AND a.status = ? ");
        }

        sql.append("ORDER BY a.appointment_date DESC, a.appointment_time ASC");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql.toString());
            ps.setInt(1, doctorId);

            if (statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equalsIgnoreCase("ALL")) {
                ps.setString(2, statusFilter.toUpperCase());
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setAppointmentId(rs.getInt("appointment_id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setAppointmentTime(rs.getString("formatted_time") != null ? rs.getString("formatted_time") : rs.getString("appointment_time"));
                a.setAppointmentType(rs.getString("appointment_type"));
                a.setStatus(rs.getString("status"));
                a.setReason(rs.getString("reason"));
                a.setCreatedAt(rs.getString("created_at"));
                a.setPatientName(rs.getString("patient_name"));
                a.setPatientPhone(rs.getString("patient_phone"));
                a.setPatientEmail(rs.getString("patient_email"));
                a.setPatientGender(rs.getString("patient_gender"));
                a.setPatientBloodGroup(rs.getString("patient_blood_group"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return list;
    }

    public Appointment getAppointmentById(int appointmentId, int doctorId) {
        String sql = "SELECT a.appointment_id, a.patient_id, a.doctor_id, a.appointment_date, "
                + "TIME_FORMAT(a.appointment_time, '%h:%i %p') AS formatted_time, a.appointment_time, "
                + "a.appointment_type, a.status, a.reason, a.created_at, "
                + "u.name AS patient_name, u.phone AS patient_phone, u.email AS patient_email, "
                + "p.gender AS patient_gender, p.blood_group AS patient_blood_group "
                + "FROM appointments a "
                + "JOIN patients p ON a.patient_id = p.patient_id "
                + "JOIN users u ON p.user_id = u.user_id "
                + "WHERE a.appointment_id = ? AND a.doctor_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.setInt(2, doctorId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Appointment a = new Appointment();
                a.setAppointmentId(rs.getInt("appointment_id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setAppointmentTime(rs.getString("formatted_time") != null ? rs.getString("formatted_time") : rs.getString("appointment_time"));
                a.setAppointmentType(rs.getString("appointment_type"));
                a.setStatus(rs.getString("status"));
                a.setReason(rs.getString("reason"));
                a.setCreatedAt(rs.getString("created_at"));
                a.setPatientName(rs.getString("patient_name"));
                a.setPatientPhone(rs.getString("patient_phone"));
                a.setPatientEmail(rs.getString("patient_email"));
                a.setPatientGender(rs.getString("patient_gender"));
                a.setPatientBloodGroup(rs.getString("patient_blood_group"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return null;
    }

    public boolean updateAppointmentStatus(int appointmentId, int doctorId, String status) {
        String sql = "UPDATE appointments SET status = ? WHERE appointment_id = ? AND doctor_id = ?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, status.toUpperCase());
            ps.setInt(2, appointmentId);
            ps.setInt(3, doctorId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            close(con, ps, null);
        }
    }

    public List<Appointment> getTodayAppointments(int doctorId) {
        List<Appointment> list = new ArrayList<Appointment>();
        String sql = "SELECT a.appointment_id, a.patient_id, a.doctor_id, a.appointment_date, "
                + "TIME_FORMAT(a.appointment_time, '%h:%i %p') AS formatted_time, a.appointment_time, "
                + "a.appointment_type, a.status, a.reason, a.created_at, "
                + "u.name AS patient_name, u.phone AS patient_phone, u.email AS patient_email, "
                + "p.gender AS patient_gender, p.blood_group AS patient_blood_group "
                + "FROM appointments a "
                + "JOIN patients p ON a.patient_id = p.patient_id "
                + "JOIN users u ON p.user_id = u.user_id "
                + "WHERE a.doctor_id = ? AND a.appointment_date = CURDATE() "
                + "ORDER BY a.appointment_time ASC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setAppointmentId(rs.getInt("appointment_id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentDate(rs.getString("appointment_date"));
                a.setAppointmentTime(rs.getString("formatted_time") != null ? rs.getString("formatted_time") : rs.getString("appointment_time"));
                a.setAppointmentType(rs.getString("appointment_type"));
                a.setStatus(rs.getString("status"));
                a.setReason(rs.getString("reason"));
                a.setCreatedAt(rs.getString("created_at"));
                a.setPatientName(rs.getString("patient_name"));
                a.setPatientPhone(rs.getString("patient_phone"));
                a.setPatientEmail(rs.getString("patient_email"));
                a.setPatientGender(rs.getString("patient_gender"));
                a.setPatientBloodGroup(rs.getString("patient_blood_group"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return list;
    }

    public Map<String, Integer> getDoctorDashboardStats(int doctorId) {
        Map<String, Integer> stats = new HashMap<String, Integer>();
        stats.put("todayAppointments", 0);
        stats.put("pendingAppointments", 0);
        stats.put("upcomingAppointments", 0);
        stats.put("completedConsultations", 0);
        stats.put("totalPatients", 0);

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            // 1. Today appointments
            ps = con.prepareStatement("SELECT COUNT(*) FROM appointments WHERE doctor_id = ? AND appointment_date = CURDATE()");
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();
            if (rs.next()) stats.put("todayAppointments", rs.getInt(1));
            rs.close();
            ps.close();

            // 2. Pending appointments
            ps = con.prepareStatement("SELECT COUNT(*) FROM appointments WHERE doctor_id = ? AND status = 'PENDING'");
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();
            if (rs.next()) stats.put("pendingAppointments", rs.getInt(1));
            rs.close();
            ps.close();

            // 3. Upcoming accepted appointments (today or future)
            ps = con.prepareStatement("SELECT COUNT(*) FROM appointments WHERE doctor_id = ? AND status = 'ACCEPTED' AND appointment_date >= CURDATE()");
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();
            if (rs.next()) stats.put("upcomingAppointments", rs.getInt(1));
            rs.close();
            ps.close();

            // 4. Completed consultations
            ps = con.prepareStatement("SELECT COUNT(*) FROM consultations c JOIN appointments a ON c.appointment_id = a.appointment_id WHERE a.doctor_id = ? AND c.consultation_status = 'COMPLETED'");
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();
            if (rs.next()) stats.put("completedConsultations", rs.getInt(1));
            rs.close();
            ps.close();

            // 5. Total distinct patients
            ps = con.prepareStatement("SELECT COUNT(DISTINCT patient_id) FROM appointments WHERE doctor_id = ?");
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();
            if (rs.next()) stats.put("totalPatients", rs.getInt(1));

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return stats;
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
