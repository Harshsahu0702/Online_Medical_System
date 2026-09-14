package dao.doctor;

import model.doctor.Consultation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ConsultationDAO {

    public Consultation getOrCreateConsultation(int appointmentId) {
        Consultation existing = getConsultationByAppointmentId(appointmentId);
        if (existing != null) {
            return existing;
        }

        // Create new consultation for this appointment
        String defaultLink = "https://meet.jit.si/OnlineMedicalSystem_Appt_" + appointmentId;
        String insertSql = "INSERT INTO consultations (appointment_id, consultation_status, meeting_link) VALUES (?, 'SCHEDULED', ?)";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet generatedKeys = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, appointmentId);
            ps.setString(2, defaultLink);
            ps.executeUpdate();

            generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                int newId = generatedKeys.getInt(1);
                return getConsultationById(newId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, generatedKeys);
        }
        return null;
    }

    public Consultation getConsultationById(int consultationId) {
        String sql = "SELECT c.consultation_id, c.appointment_id, c.started_at, c.ended_at, "
                + "c.consultation_status, c.meeting_link, c.notes, "
                + "a.doctor_id, a.patient_id, a.appointment_date, "
                + "TIME_FORMAT(a.appointment_time, '%h:%i %p') AS formatted_time, a.appointment_time, "
                + "a.appointment_type, a.reason, u.name AS patient_name "
                + "FROM consultations c "
                + "JOIN appointments a ON c.appointment_id = a.appointment_id "
                + "JOIN patients p ON a.patient_id = p.patient_id "
                + "JOIN users u ON p.user_id = u.user_id "
                + "WHERE c.consultation_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, consultationId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Consultation c = new Consultation();
                c.setConsultationId(rs.getInt("consultation_id"));
                c.setAppointmentId(rs.getInt("appointment_id"));
                c.setStartedAt(rs.getString("started_at"));
                c.setEndedAt(rs.getString("ended_at"));
                c.setConsultationStatus(rs.getString("consultation_status"));
                c.setMeetingLink(rs.getString("meeting_link"));
                c.setNotes(rs.getString("notes"));
                c.setDoctorId(rs.getInt("doctor_id"));
                c.setPatientId(rs.getInt("patient_id"));
                c.setAppointmentDate(rs.getString("appointment_date"));
                c.setAppointmentTime(rs.getString("formatted_time") != null ? rs.getString("formatted_time") : rs.getString("appointment_time"));
                c.setAppointmentType(rs.getString("appointment_type"));
                c.setReason(rs.getString("reason"));
                c.setPatientName(rs.getString("patient_name"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return null;
    }

    public Consultation getConsultationByAppointmentId(int appointmentId) {
        String sql = "SELECT c.consultation_id, c.appointment_id, c.started_at, c.ended_at, "
                + "c.consultation_status, c.meeting_link, c.notes, "
                + "a.doctor_id, a.patient_id, a.appointment_date, "
                + "TIME_FORMAT(a.appointment_time, '%h:%i %p') AS formatted_time, a.appointment_time, "
                + "a.appointment_type, a.reason, u.name AS patient_name "
                + "FROM consultations c "
                + "JOIN appointments a ON c.appointment_id = a.appointment_id "
                + "JOIN patients p ON a.patient_id = p.patient_id "
                + "JOIN users u ON p.user_id = u.user_id "
                + "WHERE c.appointment_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Consultation c = new Consultation();
                c.setConsultationId(rs.getInt("consultation_id"));
                c.setAppointmentId(rs.getInt("appointment_id"));
                c.setStartedAt(rs.getString("started_at"));
                c.setEndedAt(rs.getString("ended_at"));
                c.setConsultationStatus(rs.getString("consultation_status"));
                c.setMeetingLink(rs.getString("meeting_link"));
                c.setNotes(rs.getString("notes"));
                c.setDoctorId(rs.getInt("doctor_id"));
                c.setPatientId(rs.getInt("patient_id"));
                c.setAppointmentDate(rs.getString("appointment_date"));
                c.setAppointmentTime(rs.getString("formatted_time") != null ? rs.getString("formatted_time") : rs.getString("appointment_time"));
                c.setAppointmentType(rs.getString("appointment_type"));
                c.setReason(rs.getString("reason"));
                c.setPatientName(rs.getString("patient_name"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return null;
    }

    public boolean startConsultation(int consultationId, String meetingLink) {
        String sql = "UPDATE consultations SET consultation_status = 'ONGOING', "
                + "started_at = COALESCE(started_at, NOW()), meeting_link = ? "
                + "WHERE consultation_id = ?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, meetingLink);
            ps.setInt(2, consultationId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            close(con, ps, null);
        }
    }

    public boolean updateConsultationNotes(int consultationId, String notes) {
        String sql = "UPDATE consultations SET notes = ? WHERE consultation_id = ?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, notes);
            ps.setInt(2, consultationId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            close(con, ps, null);
        }
    }

    public boolean endConsultation(int consultationId, String notes) {
        Connection con = null;
        PreparedStatement psConsultation = null;
        PreparedStatement psAppt = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 1. Update consultation
            String updateConsultationSql = "UPDATE consultations SET consultation_status = 'COMPLETED', "
                    + "ended_at = NOW(), notes = ? WHERE consultation_id = ?";
            psConsultation = con.prepareStatement(updateConsultationSql);
            psConsultation.setString(1, notes);
            psConsultation.setInt(2, consultationId);
            psConsultation.executeUpdate();

            // 2. Update appointment status to COMPLETED
            String updateApptSql = "UPDATE appointments SET status = 'COMPLETED' "
                    + "WHERE appointment_id = (SELECT appointment_id FROM consultations WHERE consultation_id = ?)";
            psAppt = con.prepareStatement(updateApptSql);
            psAppt.setInt(1, consultationId);
            psAppt.executeUpdate();

            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try { con.rollback(); } catch (SQLException ignored) {}
            }
            return false;
        } finally {
            if (psAppt != null) try { psAppt.close(); } catch (SQLException ignored) {}
            if (psConsultation != null) try { psConsultation.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    }

    public List<Consultation> getConsultationsByDoctor(int doctorId) {
        List<Consultation> list = new ArrayList<Consultation>();
        String sql = "SELECT c.consultation_id, c.appointment_id, c.started_at, c.ended_at, "
                + "c.consultation_status, c.meeting_link, c.notes, "
                + "a.doctor_id, a.patient_id, a.appointment_date, "
                + "TIME_FORMAT(a.appointment_time, '%h:%i %p') AS formatted_time, a.appointment_time, "
                + "a.appointment_type, a.reason, u.name AS patient_name "
                + "FROM consultations c "
                + "JOIN appointments a ON c.appointment_id = a.appointment_id "
                + "JOIN patients p ON a.patient_id = p.patient_id "
                + "JOIN users u ON p.user_id = u.user_id "
                + "WHERE a.doctor_id = ? "
                + "ORDER BY c.consultation_id DESC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Consultation c = new Consultation();
                c.setConsultationId(rs.getInt("consultation_id"));
                c.setAppointmentId(rs.getInt("appointment_id"));
                c.setStartedAt(rs.getString("started_at"));
                c.setEndedAt(rs.getString("ended_at"));
                c.setConsultationStatus(rs.getString("consultation_status"));
                c.setMeetingLink(rs.getString("meeting_link"));
                c.setNotes(rs.getString("notes"));
                c.setDoctorId(rs.getInt("doctor_id"));
                c.setPatientId(rs.getInt("patient_id"));
                c.setAppointmentDate(rs.getString("appointment_date"));
                c.setAppointmentTime(rs.getString("formatted_time") != null ? rs.getString("formatted_time") : rs.getString("appointment_time"));
                c.setAppointmentType(rs.getString("appointment_type"));
                c.setReason(rs.getString("reason"));
                c.setPatientName(rs.getString("patient_name"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return list;
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
