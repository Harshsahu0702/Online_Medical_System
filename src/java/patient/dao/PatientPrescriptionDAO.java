package patient.dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PatientPrescriptionDAO {

    public List<Map<String, Object>> getPrescriptionsByPatientId(String patientId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT pr.prescription_id, pr.consultation_id, pr.doctor_id, "
                   + "pr.prescription_date, pr.diagnosis, pr.advice, "
                   + "COALESCE(u.name, 'Doctor') as doctorName, COALESCE(p.name, 'Patient') as patientName "
                   + "FROM prescriptions pr "
                   + "LEFT JOIN patients p ON pr.patient_id = p.patient_id "
                   + "LEFT JOIN doctors d ON pr.doctor_id = d.doctor_id "
                   + "LEFT JOIN users u ON d.user_id = u.user_id "
                   + "WHERE pr.patient_id = ? "
                   + "ORDER BY pr.prescription_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("prescriptionId", rs.getInt("prescription_id"));
                    map.put("consultationId", rs.getInt("consultation_id"));
                    map.put("doctorId", rs.getInt("doctor_id"));
                    map.put("prescriptionDate", rs.getString("prescription_date"));
                    map.put("diagnosis", rs.getString("diagnosis"));
                    map.put("advice", rs.getString("advice"));
                    map.put("doctorName", rs.getString("doctorName"));
                    map.put("patientName", rs.getString("patientName"));
                    map.put("patientAddress", rs.getString("patientAddress"));
                    map.put("patientContact", rs.getString("patientContact"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientPrescriptionDAO.getPrescriptionsByPatientId: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public Map<String, Object> getPrescriptionDetails(int prescriptionId) {
        String sql = "SELECT pr.prescription_id, pr.consultation_id, pr.patient_id, pr.doctor_id, "
                   + "pr.prescription_date, pr.diagnosis, pr.advice, "
                   + "COALESCE(u.name, 'Doctor') as doctorName, COALESCE(p.name, 'Patient') as patientName, "
                   + "p.address as patientAddress, p.contact as patientContact "
                   + "FROM prescriptions pr "
                   + "LEFT JOIN patients p ON pr.patient_id = p.patient_id "
                   + "LEFT JOIN doctors d ON pr.doctor_id = d.doctor_id "
                   + "LEFT JOIN users u ON d.user_id = u.user_id "
                   + "WHERE pr.prescription_id = ?";

        String itemsSql = "SELECT pi.*, m.medicine_name FROM prescription_items pi "
                        + "LEFT JOIN medicines m ON pi.medicine_id = m.medicine_id "
                        + "WHERE pi.prescription_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, prescriptionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("prescriptionId", rs.getInt("prescription_id"));
                    map.put("consultationId", rs.getInt("consultation_id"));
                    map.put("patientId", rs.getString("patient_id"));
                    map.put("doctorId", rs.getInt("doctor_id"));
                    map.put("prescriptionDate", rs.getString("prescription_date"));
                    map.put("diagnosis", rs.getString("diagnosis"));
                    map.put("advice", rs.getString("advice"));
                    map.put("doctorName", rs.getString("doctorName"));
                    map.put("patientName", rs.getString("patientName"));
                    map.put("patientAddress", rs.getString("patientAddress"));
                    map.put("patientContact", rs.getString("patientContact"));

                    List<Map<String, Object>> items = new ArrayList<>();
                    try (PreparedStatement ps2 = con.prepareStatement(itemsSql)) {
                        ps2.setInt(1, prescriptionId);
                        try (ResultSet rs2 = ps2.executeQuery()) {
                            while (rs2.next()) {
                                Map<String, Object> item = new HashMap<>();
                                item.put("itemId", rs2.getInt("prescription_item_id"));
                                item.put("medicineId", rs2.getInt("medicine_id"));
                                String medName = rs2.getString("medicine_name");
                                if (medName == null || medName.trim().isEmpty()) {
                                    medName = "Medicine #" + rs2.getInt("medicine_id");
                                }
                                item.put("medicineName", medName);
                                item.put("dosage", rs2.getString("dosage"));
                                item.put("frequency", rs2.getString("frequency"));
                                item.put("duration", rs2.getString("duration"));
                                item.put("instructions", rs2.getString("instructions"));
                                items.add(item);
                            }
                        }
                    } catch (Exception err) {
                        System.err.println("Error fetching prescription items: " + err.getMessage());
                        err.printStackTrace();
                    }
                    map.put("items", items);
                    return map;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in PatientPrescriptionDAO.getPrescriptionDetails: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}