package doctor.dao;

import doctor.model.Patient;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    public List<Patient> getPatientsByDoctor(int doctorId) {
        List<Patient> list = new ArrayList<Patient>();
        String sql = "SELECT DISTINCT p.patient_id, p.dob, p.gender, p.blood_group, "
                + "p.address, p.emergency_contact, p.name, p.email, p.contact AS phone "
                + "FROM patients p "
                + "JOIN appointments a ON p.patient_id = a.patient_id "
                + "WHERE a.doctor_id = ? "
                + "ORDER BY p.name ASC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Patient p = new Patient();
                p.setPatientId(rs.getString("patient_id"));
                p.setDob(rs.getString("dob"));
                p.setGender(rs.getString("gender"));
                p.setBloodGroup(rs.getString("blood_group"));
                p.setAddress(rs.getString("address"));
                p.setEmergencyContact(rs.getString("emergency_contact"));
                p.setName(rs.getString("name"));
                p.setEmail(rs.getString("email"));
                p.setPhone(rs.getString("phone"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return list;
    }

    public Patient getPatientDetails(String patientId) {
        if (patientId == null || patientId.trim().isEmpty()) {
            return null;
        }
        String sql = "SELECT p.patient_id, p.dob, p.gender, p.blood_group, "
                + "p.address, p.emergency_contact, p.name, p.email, p.contact AS phone "
                + "FROM patients p "
                + "WHERE p.patient_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, patientId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Patient p = new Patient();
                p.setPatientId(rs.getString("patient_id"));
                p.setDob(rs.getString("dob"));
                p.setGender(rs.getString("gender"));
                p.setBloodGroup(rs.getString("blood_group"));
                p.setAddress(rs.getString("address"));
                p.setEmergencyContact(rs.getString("emergency_contact"));
                p.setName(rs.getString("name"));
                p.setEmail(rs.getString("email"));
                p.setPhone(rs.getString("phone"));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return null;
    }

    public Patient getPatientDetails(int patientId) {
        return getPatientDetails(String.valueOf(patientId));
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
