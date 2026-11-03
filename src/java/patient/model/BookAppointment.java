package patient.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class BookAppointment {
    private int availabilityId;
    private int doctorId;
    private String doctorName;
    private String specialization;
    private String clinicName;
    private String dayOfWeek;
    private String startTime;
    private String endTime;
    private String consultationType;
    private float consultationFee;
    private String qualification;
    private int experience;

    // Getters and Setters
    public int getAvailabilityId() {
        return availabilityId;
    }

    public void setAvailabilityId(int availabilityId) {
        this.availabilityId = availabilityId;
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

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getConsultationType() {
        return consultationType;
    }

    public void setConsultationType(String consultationType) {
        this.consultationType = consultationType;
    }

    public float getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(float consultationFee) {
        this.consultationFee = consultationFee;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    private static final patient.dao.PatientDoctorDAO doctorDAO = new patient.dao.PatientDoctorDAO();
    private static final patient.dao.PatientAppointmentDAO appointmentDAO = new patient.dao.PatientAppointmentDAO();

    // Fetches full slot and doctor details by availabilityId
    public BookAppointment getSlotDetailsByAvailabilityId(String availabilityIdStr) {
        if (availabilityIdStr == null || availabilityIdStr.trim().isEmpty()) {
            return null;
        }

        try {
            int aId = Integer.parseInt(availabilityIdStr.trim());
            java.util.Map<String, Object> map = doctorDAO.getSlotDetailsByAvailabilityId(aId);
            if (map != null) {
                BookAppointment ba = new BookAppointment();
                ba.setAvailabilityId((Integer) map.get("availabilityId"));
                ba.setDoctorId((Integer) map.get("doctorId"));
                ba.setDoctorName((String) map.get("doctorName"));
                ba.setSpecialization((String) map.get("specialization"));
                ba.setClinicName((String) map.get("clinicName"));
                ba.setDayOfWeek((String) map.get("dayOfWeek"));
                ba.setStartTime((String) map.get("startTime"));
                ba.setEndTime((String) map.get("endTime"));
                ba.setConsultationType((String) map.get("consultationType"));
                if (map.get("consultationFee") != null) {
                    ba.setConsultationFee(((Number) map.get("consultationFee")).floatValue());
                }
                ba.setQualification((String) map.get("qualification"));
                if (map.get("experience") != null) {
                    ba.setExperience((Integer) map.get("experience"));
                }
                return ba;
            }
        } catch (Exception e) {
            System.err.println("getSlotDetailsByAvailabilityId error: " + e);
        }
        return null;
    }

    // Saves appointment into appointments table
    public boolean saveAppointment(String patientId, int doctorId, String appointmentDate, String appointmentTime, String appointmentType, String reason) {
        return appointmentDAO.bookAppointment(patientId, doctorId, appointmentDate, appointmentTime, appointmentType, reason);
    }
}
