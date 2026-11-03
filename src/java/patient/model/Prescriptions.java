package patient.model;

import java.util.*;
import java.sql.*;

public class Prescriptions {
    int prescriptionId;
    int consultationId;
    String patientId;
    String patientName;
    int doctorId;
    String doctorName;
    String prescriptionDate;
    String diagnosis;
    String advice;
    List<Map<String, Object>> items = new ArrayList<>();

    public List<Map<String, Object>> getItems() {
        return items;
    }

    public void setItems(List<Map<String, Object>> items) {
        this.items = items;
    }

    public int getPrescriptionId() {
        return prescriptionId;
    }

    public void setPrescriptionId(int prescriptionId) {
        this.prescriptionId = prescriptionId;
    }

    public int getConsultationId() {
        return consultationId;
    }

    public void setConsultationId(int consultationId) {
        this.consultationId = consultationId;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getPrescriptionDate() {
        return prescriptionDate;
    }

    public void setPrescriptionDate(String prescriptionDate) {
        this.prescriptionDate = prescriptionDate;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getAdvice() {
        return advice;
    }

    public void setAdvice(String advice) {
        this.advice = advice;
    }
    
    private static final patient.dao.PatientPrescriptionDAO prescriptionDAO = new patient.dao.PatientPrescriptionDAO();

    public ArrayList<Prescriptions> getPrescriptionByPatientId(String patientId) {
        this.patientId = patientId;
        ArrayList<Prescriptions> prescriptionLists = new ArrayList<>();

        java.util.List<java.util.Map<String, Object>> list = prescriptionDAO.getPrescriptionsByPatientId(patientId);
        for (java.util.Map<String, Object> map : list) {
            Prescriptions pd = new Prescriptions();
            pd.setPrescriptionId((Integer) map.get("prescriptionId"));
            pd.setConsultationId((Integer) map.get("consultationId"));
            pd.setDoctorId((Integer) map.get("doctorId"));
            pd.setPrescriptionDate((String) map.get("prescriptionDate"));
            pd.setDiagnosis((String) map.get("diagnosis"));
            pd.setAdvice((String) map.get("advice"));
            pd.setDoctorName((String) map.get("doctorName"));
            pd.setPatientName((String) map.get("patientName"));
            prescriptionLists.add(pd);
        }
        return prescriptionLists;
    }

    public Prescriptions getPrescriptionByPrescriptionId(int prescriptionId) {
        this.prescriptionId = prescriptionId;
        java.util.Map<String, Object> map = prescriptionDAO.getPrescriptionDetails(prescriptionId);
        if (map == null) return null;

        Prescriptions pd = new Prescriptions();
        pd.setPrescriptionId(prescriptionId);
        pd.setConsultationId((Integer) map.get("consultationId"));
        pd.setPatientId((String) map.get("patientId"));
        pd.setDoctorId((Integer) map.get("doctorId"));
        pd.setPrescriptionDate((String) map.get("prescriptionDate"));
        pd.setDiagnosis((String) map.get("diagnosis"));
        pd.setAdvice((String) map.get("advice"));
        pd.setDoctorName((String) map.get("doctorName"));
        pd.setPatientName((String) map.get("patientName"));
        if (map.get("items") != null) {
            pd.setItems((List<Map<String, Object>>) map.get("items"));
        }
        return pd;
    }
    
}
