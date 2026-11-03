package patient.dao;

import patient.model.Patient;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class PatientDAO {

    public String registerPatient(Patient patient) {
        if (patient.getPatientId() == null || patient.getPatientId().trim().isEmpty()) {
            patient.setPatientId(UUID.randomUUID().toString());
        }

        String sql = "INSERT INTO patients (patient_id, email, password, name, gender, address, contact, blood_group, dob, emergency_name, emergency_relation, emergency_contact) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, patient.getPatientId());
            ps.setString(2, patient.getEmail());
            ps.setString(3, patient.getPassword());
            ps.setString(4, patient.getName());
            ps.setString(5, patient.getGender());
            ps.setString(6, patient.getAddress());
            ps.setString(7, patient.getContact());
            ps.setString(8, patient.getBloodGroup());
            ps.setString(9, patient.getDob());
            ps.setString(10, patient.getEmergencyName());
            ps.setString(11, patient.getEmergencyRelation());
            ps.setString(12, patient.getEmergencyContact());

            int rows = ps.executeUpdate();
            return rows > 0 ? "success" : "failed";

        } catch (SQLIntegrityConstraintViolationException e) {
            System.err.println("SQLIntegrityConstraintViolationException in PatientDAO.registerPatient: " + e.getMessage());
            return "email_exists";
        } catch (Exception e) {
            System.err.println("Exception in PatientDAO.registerPatient: " + e.getMessage());
            e.printStackTrace();
            return "error";
        }
    }

    public Patient authenticate(String email, String password) {
        String sql = "SELECT * FROM patients WHERE email = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Patient p = mapResultSetToPatient(rs);
                    return p;
                }
            }
        } catch (Exception e) {
            System.err.println("Exception in PatientDAO.authenticate: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public Patient getPatientById(String patientId) {
        String sql = "SELECT * FROM patients WHERE patient_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, patientId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPatient(rs);
                }
            }
        } catch (Exception e) {
            System.err.println("Exception in PatientDAO.getPatientById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePatientProfile(Patient patient) {
        String sql = "UPDATE patients SET name = ?, dob = ?, gender = ?, contact = ?, email = ?, address = ?, "
                   + "emergency_name = ?, emergency_relation = ?, emergency_contact = ?, blood_group = ? "
                   + "WHERE patient_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, patient.getName());
            ps.setString(2, patient.getDob());
            ps.setString(3, patient.getGender());
            ps.setString(4, patient.getContact());
            ps.setString(5, patient.getEmail());
            ps.setString(6, patient.getAddress());
            ps.setString(7, patient.getEmergencyName());
            ps.setString(8, patient.getEmergencyRelation());
            ps.setString(9, patient.getEmergencyContact());
            ps.setString(10, patient.getBloodGroup());
            ps.setString(11, patient.getPatientId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Exception in PatientDAO.updatePatientProfile: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patients ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToPatient(rs));
            }
        } catch (Exception e) {
            System.err.println("Exception in PatientDAO.getAllPatients: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    private Patient mapResultSetToPatient(ResultSet rs) throws Exception {
        Patient p = new Patient();
        p.setPatientId(rs.getString("patient_id"));
        try { p.setUserId(rs.getInt("user_id")); } catch (Exception ignored) {}
        p.setEmail(rs.getString("email"));
        p.setName(rs.getString("name"));
        p.setGender(rs.getString("gender"));
        p.setAddress(rs.getString("address"));
        p.setContact(rs.getString("contact"));
        p.setDob(rs.getString("dob"));
        p.setBloodGroup(rs.getString("blood_group"));
        p.setEmergencyName(rs.getString("emergency_name"));
        p.setEmergencyRelation(rs.getString("emergency_relation"));
        p.setEmergencyContact(rs.getString("emergency_contact"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }
}
