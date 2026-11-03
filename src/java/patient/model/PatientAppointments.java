package patient.model;

import java.sql.*;
import java.util.ArrayList;

public class PatientAppointments {
    int appointmentId;
    String patientId;
    String patientName;
    int doctorId;
    String doctorName;
    String appointmentDate;
    String appointmentTime;
    String appointmentType;
    String status;
    String reason;
    String specialization;
    String clinicName;
    double consultationFee;
    String meetingLink;
    String consultationStatus;

    public String getMeetingLink() {
        return meetingLink;
    }

    public void setMeetingLink(String meetingLink) {
        this.meetingLink = meetingLink;
    }

    public String getConsultationStatus() {
        return consultationStatus;
    }

    public void setConsultationStatus(String consultationStatus) {
        this.consultationStatus = consultationStatus;
    }
    
    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
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

    public String getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(String appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(String appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getAppointmentType() {
        return appointmentType;
    }

    public void setAppointmentType(String appointmentType) {
        this.appointmentType = appointmentType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
    
    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getClinicName() {
        return clinicName;
    }

    public void setClinicName(String clinicName) {
        this.clinicName = clinicName;
    }

    public double getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(double consultationFee) {
        this.consultationFee = consultationFee;
    }
    
    private static final patient.dao.PatientAppointmentDAO appointmentDAO = new patient.dao.PatientAppointmentDAO();

    public ArrayList<PatientAppointments> getAppointments(String patientId) {
        ArrayList<PatientAppointments> patientAppointmentsList = new ArrayList<>();
        this.patientId = patientId;

        java.util.List<java.util.Map<String, Object>> list = appointmentDAO.getAppointmentsByPatientId(patientId);
        for (java.util.Map<String, Object> map : list) {
            PatientAppointments pa = new PatientAppointments();
            pa.setAppointmentId((Integer) map.get("appointmentId"));
            pa.setDoctorId((Integer) map.get("doctorId"));
            pa.setDoctorName((String) map.get("doctorName"));
            pa.setSpecialization((String) map.get("specialization"));
            pa.setAppointmentDate((String) map.get("appointmentDate"));
            pa.setAppointmentTime((String) map.get("appointmentTime"));
            pa.setAppointmentType((String) map.get("appointmentType"));
            pa.setStatus((String) map.get("status"));
            pa.setReason((String) map.get("reason"));
            pa.setMeetingLink((String) map.get("meetingLink"));
            pa.setConsultationStatus((String) map.get("consultationStatus"));
            patientAppointmentsList.add(pa);
        }
        return patientAppointmentsList;
    }

    public PatientAppointments getAppointmentByAppId(int appointmentId) {
        this.appointmentId = appointmentId;
        java.util.Map<String, Object> map = appointmentDAO.getAppointmentDetails(appointmentId);
        if (map == null) return null;

        PatientAppointments ad = new PatientAppointments();
        ad.setAppointmentId(appointmentId);
        ad.setDoctorId((Integer) map.get("doctorId"));
        ad.setAppointmentDate((String) map.get("appointmentDate"));
        ad.setAppointmentTime((String) map.get("appointmentTime"));
        ad.setAppointmentType((String) map.get("appointmentType"));
        ad.setStatus((String) map.get("status"));
        ad.setReason((String) map.get("reason"));
        ad.setPatientName((String) map.get("patientName"));
        ad.setDoctorName((String) map.get("doctorName"));
        ad.setSpecialization((String) map.get("specialization"));
        ad.setClinicName((String) map.get("clinicName"));
        ad.setMeetingLink((String) map.get("meetingLink"));
        ad.setConsultationStatus((String) map.get("consultationStatus"));
        if (map.get("consultationFee") != null) {
            ad.setConsultationFee(((Number) map.get("consultationFee")).doubleValue());
        }
        return ad;
    }
}