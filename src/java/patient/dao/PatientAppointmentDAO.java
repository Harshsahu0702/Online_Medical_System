package patient.dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PatientAppointmentDAO {

    public List<Map<String, Object>> getAppointmentsByPatientId(String patientId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT a.appointment_id, a.doctor_id, a.appointment_date, "
                   + "a.appointment_time, a.appointment_type, a.status, a.reason, "
                   + "u.name as doctor_name, s.name as specialization, "
                   + "co.meeting_link, co.consultation_status "
                   + "FROM appointments a "
                   + "JOIN doctors d ON a.doctor_id = d.doctor_id "
                   + "JOIN users u ON d.user_id = u.user_id "
                   + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                   + "LEFT JOIN consultations co ON a.appointment_id = co.appointment_id "
                   + "WHERE a.patient_id = ? "
                   + "ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("appointmentId", rs.getInt("appointment_id"));
                    map.put("doctorId", rs.getInt("doctor_id"));
                    map.put("doctorName", rs.getString("doctor_name"));
                    map.put("specialization", rs.getString("specialization"));
                    map.put("appointmentDate", rs.getString("appointment_date"));
                    map.put("appointmentTime", rs.getString("appointment_time"));
                    map.put("appointmentType", rs.getString("appointment_type"));
                    map.put("status", rs.getString("status"));
                    map.put("reason", rs.getString("reason"));
                    map.put("meetingLink", rs.getString("meeting_link"));
                    map.put("consultationStatus", rs.getString("consultation_status"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientAppointmentDAO.getAppointmentsByPatientId: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public Map<String, Object> getAppointmentDetails(int appointmentId) {
        String sql = "SELECT a.appointment_id, a.doctor_id, a.appointment_date, a.appointment_time, a.appointment_type, "
                   + "a.status, a.reason, p.name AS patientName, u.name AS doctorName, "
                   + "s.name AS specialization, c.clinic_name AS clinicName, d.consultation_fee AS consultationFee, "
                   + "co.meeting_link, co.consultation_status "
                   + "FROM appointments a "
                   + "JOIN doctors d ON a.doctor_id = d.doctor_id "
                   + "JOIN patients p ON a.patient_id = p.patient_id "
                   + "JOIN users u ON d.user_id = u.user_id "
                   + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                   + "LEFT JOIN clinics c ON d.clinic_id = c.clinic_id "
                   + "LEFT JOIN consultations co ON a.appointment_id = co.appointment_id "
                   + "WHERE a.appointment_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("appointmentId", rs.getInt("appointment_id"));
                    map.put("doctorId", rs.getInt("doctor_id"));
                    map.put("patientName", rs.getString("patientName"));
                    map.put("doctorName", rs.getString("doctorName"));
                    map.put("specialization", rs.getString("specialization"));
                    map.put("clinicName", rs.getString("clinicName"));
                    map.put("consultationFee", rs.getDouble("consultationFee"));
                    map.put("appointmentDate", rs.getString("appointment_date"));
                    map.put("appointmentTime", rs.getString("appointment_time"));
                    map.put("appointmentType", rs.getString("appointment_type"));
                    map.put("status", rs.getString("status"));
                    map.put("reason", rs.getString("reason"));
                    map.put("meetingLink", rs.getString("meeting_link"));
                    map.put("consultationStatus", rs.getString("consultation_status"));
                    return map;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientAppointmentDAO.getAppointmentDetails: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean bookAppointment(String patientId, int doctorId, String appointmentDate, String appointmentTime, String appointmentType, String reason) {
        String sql = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, appointment_type, status, reason) "
                   + "VALUES (?, ?, ?, ?, ?, 'PENDING', ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, patientId);
            ps.setInt(2, doctorId);
            ps.setString(3, appointmentDate);
            ps.setString(4, appointmentTime);
            ps.setString(5, appointmentType);
            ps.setString(6, reason != null ? reason : "");

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error in PatientAppointmentDAO.bookAppointment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean cancelAppointment(int appointmentId) {
        String sql = "UPDATE appointments SET status = 'CANCELLED' WHERE appointment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error cancelling appointment: " + e.getMessage());
            return false;
        }
    }
}
