package patient.dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PatientDoctorDAO {

    public List<Map<String, Object>> getAllDoctors(String specializationFilter) {
        List<Map<String, Object>> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT d.doctor_id, d.qualification, d.experience, d.consultation_fee, d.bio, "
          + "u.name AS doctor_name, u.email, u.phone, s.name AS specialization, c.clinic_name "
          + "FROM doctors d "
          + "JOIN users u ON d.user_id = u.user_id "
          + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
          + "LEFT JOIN clinics c ON d.clinic_id = c.clinic_id "
          + "WHERE d.status = 'ACTIVE' "
        );

        boolean hasFilter = specializationFilter != null && !specializationFilter.trim().isEmpty() && !specializationFilter.equalsIgnoreCase("All");
        if (hasFilter) {
            sql.append("AND s.name = ? ");
        }
        sql.append("ORDER BY u.name ASC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            if (hasFilter) {
                ps.setString(1, specializationFilter.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("doctorId", rs.getInt("doctor_id"));
                    map.put("doctorName", rs.getString("doctor_name"));
                    map.put("email", rs.getString("email"));
                    map.put("phone", rs.getString("phone"));
                    map.put("qualification", rs.getString("qualification"));
                    map.put("experience", rs.getInt("experience"));
                    map.put("consultationFee", rs.getDouble("consultation_fee"));
                    map.put("bio", rs.getString("bio"));
                    map.put("specialization", rs.getString("specialization"));
                    map.put("clinicName", rs.getString("clinic_name"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientDoctorDAO.getAllDoctors: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public Map<String, Object> getDoctorById(int doctorId) {
        String sql = "SELECT d.doctor_id, d.qualification, d.experience, d.consultation_fee, d.bio, "
                   + "u.name AS doctor_name, u.email, u.phone, s.name AS specialization, c.clinic_name, c.address AS clinic_address "
                   + "FROM doctors d "
                   + "JOIN users u ON d.user_id = u.user_id "
                   + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                   + "LEFT JOIN clinics c ON d.clinic_id = c.clinic_id "
                   + "WHERE d.doctor_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("doctorId", rs.getInt("doctor_id"));
                    map.put("doctorName", rs.getString("doctor_name"));
                    map.put("email", rs.getString("email"));
                    map.put("phone", rs.getString("phone"));
                    map.put("qualification", rs.getString("qualification"));
                    map.put("experience", rs.getInt("experience"));
                    map.put("consultationFee", rs.getDouble("consultation_fee"));
                    map.put("bio", rs.getString("bio"));
                    map.put("specialization", rs.getString("specialization"));
                    map.put("clinicName", rs.getString("clinic_name"));
                    map.put("clinicAddress", rs.getString("clinic_address"));
                    return map;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientDoctorDAO.getDoctorById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public List<Map<String, Object>> getDoctorAvailability(int doctorId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT * FROM doctor_availability WHERE doctor_id = ? ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), start_time ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("availabilityId", rs.getInt("availability_id"));
                    map.put("doctorId", rs.getInt("doctor_id"));
                    map.put("dayOfWeek", rs.getString("day_of_week"));
                    map.put("startTime", rs.getString("start_time"));
                    map.put("endTime", rs.getString("end_time"));
                    map.put("consultationType", rs.getString("consultation_type"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientDoctorDAO.getDoctorAvailability: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public Map<String, Object> getSlotDetailsByAvailabilityId(int availabilityId) {
        String sql = "SELECT da.availability_id, d.doctor_id, u.name AS doctor_name, "
                   + "s.name AS specialization, c.clinic_name, da.day_of_week, "
                   + "da.start_time, da.end_time, da.consultation_type, "
                   + "d.consultation_fee, d.qualification, d.experience "
                   + "FROM doctor_availability da "
                   + "JOIN doctors d ON da.doctor_id = d.doctor_id "
                   + "JOIN users u ON d.user_id = u.user_id "
                   + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                   + "LEFT JOIN clinics c ON d.clinic_id = c.clinic_id "
                   + "WHERE da.availability_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, availabilityId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("availabilityId", rs.getInt("availability_id"));
                    map.put("doctorId", rs.getInt("doctor_id"));
                    map.put("doctorName", rs.getString("doctor_name"));
                    map.put("specialization", rs.getString("specialization") != null ? rs.getString("specialization") : "General Specialist");
                    map.put("clinicName", rs.getString("clinic_name") != null ? rs.getString("clinic_name") : "OmniHealth Clinic");
                    map.put("dayOfWeek", rs.getString("day_of_week"));
                    map.put("startTime", rs.getString("start_time"));
                    map.put("endTime", rs.getString("end_time"));
                    map.put("consultationType", rs.getString("consultation_type") != null ? rs.getString("consultation_type") : "Both");
                    map.put("consultationFee", rs.getFloat("consultation_fee"));
                    map.put("qualification", rs.getString("qualification") != null ? rs.getString("qualification") : "MBBS");
                    map.put("experience", rs.getInt("experience"));
                    return map;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientDoctorDAO.getSlotDetailsByAvailabilityId: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
