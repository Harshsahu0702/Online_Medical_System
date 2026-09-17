package dao.doctor;

import model.doctor.Prescription;
import model.doctor.PrescriptionItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PrescriptionDAO {

    public boolean createPrescriptionWithItems(Prescription prescription, List<PrescriptionItem> items) {
        String prescriptionSql = "INSERT INTO prescriptions (consultation_id, patient_id, doctor_id, prescription_date, diagnosis, advice) "
                + "VALUES (?, ?, ?, COALESCE(?, CURDATE()), ?, ?)";

        String itemSql = "INSERT INTO prescription_items (prescription_id, medicine_id, dosage, frequency, duration, instructions) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        Connection con = null;
        PreparedStatement psPrescription = null;
        PreparedStatement psItem = null;
        ResultSet generatedKeys = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 1. Insert Prescription header
            psPrescription = con.prepareStatement(prescriptionSql, Statement.RETURN_GENERATED_KEYS);
            
            if (prescription.getConsultationId() > 0) {
                psPrescription.setInt(1, prescription.getConsultationId());
            } else {
                psPrescription.setNull(1, java.sql.Types.INTEGER);
            }
            
            psPrescription.setInt(2, prescription.getPatientId());
            psPrescription.setInt(3, prescription.getDoctorId());
            
            if (prescription.getPrescriptionDate() != null && !prescription.getPrescriptionDate().trim().isEmpty()) {
                psPrescription.setString(4, prescription.getPrescriptionDate());
            } else {
                psPrescription.setNull(4, java.sql.Types.DATE);
            }
            
            psPrescription.setString(5, prescription.getDiagnosis());
            psPrescription.setString(6, prescription.getAdvice());

            int rows = psPrescription.executeUpdate();
            if (rows == 0) {
                con.rollback();
                return false;
            }

            // 2. Get Generated Prescription ID
            generatedKeys = psPrescription.getGeneratedKeys();
            int prescriptionId = 0;
            if (generatedKeys.next()) {
                prescriptionId = generatedKeys.getInt(1);
            } else {
                con.rollback();
                return false;
            }

            // 3. Insert Prescription Items
            if (items != null && !items.isEmpty()) {
                psItem = con.prepareStatement(itemSql);
                for (PrescriptionItem item : items) {
                    psItem.setInt(1, prescriptionId);
                    psItem.setInt(2, item.getMedicineId());
                    psItem.setString(3, item.getDosage());
                    psItem.setString(4, item.getFrequency());
                    psItem.setString(5, item.getDuration());
                    psItem.setString(6, item.getInstructions());
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }

            // 4. Commit Transaction
            con.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException ignored) {}
            if (psItem != null) try { psItem.close(); } catch (SQLException ignored) {}
            if (psPrescription != null) try { psPrescription.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    }

    public List<Prescription> getPrescriptionsByDoctor(int doctorId) {
        List<Prescription> list = new ArrayList<Prescription>();
        String sql = "SELECT pr.prescription_id, pr.consultation_id, pr.patient_id, pr.doctor_id, "
                + "pr.prescription_date, pr.diagnosis, pr.advice, "
                + "u.name AS patient_name "
                + "FROM prescriptions pr "
                + "JOIN patients p ON pr.patient_id = p.patient_id "
                + "JOIN users u ON p.user_id = u.user_id "
                + "WHERE pr.doctor_id = ? "
                + "ORDER BY pr.prescription_date DESC, pr.prescription_id DESC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Prescription p = new Prescription();
                p.setPrescriptionId(rs.getInt("prescription_id"));
                p.setConsultationId(rs.getInt("consultation_id"));
                p.setPatientId(rs.getInt("patient_id"));
                p.setDoctorId(rs.getInt("doctor_id"));
                p.setPrescriptionDate(rs.getString("prescription_date"));
                p.setDiagnosis(rs.getString("diagnosis"));
                p.setAdvice(rs.getString("advice"));
                p.setPatientName(rs.getString("patient_name"));

                // Fetch items for this prescription
                p.setItems(getPrescriptionItems(p.getPrescriptionId(), con));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return list;
    }

    public Prescription getPrescriptionById(int prescriptionId) {
        String sql = "SELECT pr.prescription_id, pr.consultation_id, pr.patient_id, pr.doctor_id, "
                + "pr.prescription_date, pr.diagnosis, pr.advice, "
                + "u_pat.name AS patient_name, u_doc.name AS doctor_name, s.name AS specialization_name "
                + "FROM prescriptions pr "
                + "JOIN patients p ON pr.patient_id = p.patient_id "
                + "JOIN users u_pat ON p.user_id = u_pat.user_id "
                + "JOIN doctors d ON pr.doctor_id = d.doctor_id "
                + "JOIN users u_doc ON d.user_id = u_doc.user_id "
                + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                + "WHERE pr.prescription_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, prescriptionId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Prescription p = new Prescription();
                p.setPrescriptionId(rs.getInt("prescription_id"));
                p.setConsultationId(rs.getInt("consultation_id"));
                p.setPatientId(rs.getInt("patient_id"));
                p.setDoctorId(rs.getInt("doctor_id"));
                p.setPrescriptionDate(rs.getString("prescription_date"));
                p.setDiagnosis(rs.getString("diagnosis"));
                p.setAdvice(rs.getString("advice"));
                p.setPatientName(rs.getString("patient_name"));
                p.setDoctorName(rs.getString("doctor_name"));
                p.setDoctorSpecialization(rs.getString("specialization_name"));

                p.setItems(getPrescriptionItems(prescriptionId, con));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con, ps, rs);
        }
        return null;
    }

    public List<PrescriptionItem> getPrescriptionItems(int prescriptionId, Connection con) {
        List<PrescriptionItem> items = new ArrayList<PrescriptionItem>();
        String sql = "SELECT pi.prescription_item_id, pi.prescription_id, pi.medicine_id, "
                + "pi.dosage, pi.frequency, pi.duration, pi.instructions, "
                + "m.medicine_name, m.generic_name, m.category "
                + "FROM prescription_items pi "
                + "JOIN medicines m ON pi.medicine_id = m.medicine_id "
                + "WHERE pi.prescription_id = ?";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, prescriptionId);
            rs = ps.executeQuery();

            while (rs.next()) {
                PrescriptionItem item = new PrescriptionItem();
                item.setPrescriptionItemId(rs.getInt("prescription_item_id"));
                item.setPrescriptionId(rs.getInt("prescription_id"));
                item.setMedicineId(rs.getInt("medicine_id"));
                item.setDosage(rs.getString("dosage"));
                item.setFrequency(rs.getString("frequency"));
                item.setDuration(rs.getString("duration"));
                item.setInstructions(rs.getString("instructions"));
                item.setMedicineName(rs.getString("medicine_name"));
                item.setGenericName(rs.getString("generic_name"));
                item.setCategory(rs.getString("category"));
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
        }
        return items;
    }

    public List<Prescription> getPrescriptionsByPatient(int patientId) {
        List<Prescription> list = new ArrayList<Prescription>();
        String sql = "SELECT pr.prescription_id, pr.consultation_id, pr.patient_id, pr.doctor_id, "
                + "pr.prescription_date, pr.diagnosis, pr.advice, "
                + "u_doc.name AS doctor_name "
                + "FROM prescriptions pr "
                + "JOIN doctors d ON pr.doctor_id = d.doctor_id "
                + "JOIN users u_doc ON d.user_id = u_doc.user_id "
                + "WHERE pr.patient_id = ? "
                + "ORDER BY pr.prescription_date DESC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, patientId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Prescription p = new Prescription();
                p.setPrescriptionId(rs.getInt("prescription_id"));
                p.setConsultationId(rs.getInt("consultation_id"));
                p.setPatientId(rs.getInt("patient_id"));
                p.setDoctorId(rs.getInt("doctor_id"));
                p.setPrescriptionDate(rs.getString("prescription_date"));
                p.setDiagnosis(rs.getString("diagnosis"));
                p.setAdvice(rs.getString("advice"));
                p.setDoctorName(rs.getString("doctor_name"));
                p.setItems(getPrescriptionItems(p.getPrescriptionId(), con));
                list.add(p);
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
