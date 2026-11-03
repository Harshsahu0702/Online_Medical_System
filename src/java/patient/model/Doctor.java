package patient.model;

import java.sql.*;
import java.util.ArrayList;

public class Doctor {
    int doctorId;
    String name;
    String email;
    String phone;
    String specialization;
    String clinicName;
    String qualification;
    int experience;
    double consultationFee;
    String bio;
    String consultationType;
    ArrayList<DoctorAvailability> availabilityList;

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public double getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(double consultationFee) {
        this.consultationFee = consultationFee;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getConsultationType() {
        return consultationType;
    }

    public void setConsultationType(String consultationType) {
        this.consultationType = consultationType;
    }

    public ArrayList<DoctorAvailability> getAvailabilityList() {
        return availabilityList;
    }

    public void setAvailabilityList(ArrayList<DoctorAvailability> availabilityList) {
        this.availabilityList = availabilityList;
    }

    private static final patient.dao.PatientDoctorDAO doctorDAO = new patient.dao.PatientDoctorDAO();

    public Doctor getDoctorById(int doctorId) {
        java.util.Map<String, Object> map = doctorDAO.getDoctorById(doctorId);
        if (map == null) return null;

        Doctor doctor = new Doctor();
        doctor.setDoctorId(doctorId);
        doctor.setName((String) map.get("doctorName"));
        doctor.setEmail((String) map.get("email"));
        doctor.setPhone((String) map.get("phone"));
        doctor.setSpecialization((String) map.get("specialization"));
        doctor.setClinicName((String) map.get("clinicName"));
        doctor.setQualification((String) map.get("qualification"));
        if (map.get("experience") != null) {
            doctor.setExperience((Integer) map.get("experience"));
        }
        if (map.get("consultationFee") != null) {
            doctor.setConsultationFee(((Number) map.get("consultationFee")).doubleValue());
        }
        doctor.setBio((String) map.get("bio"));

        java.util.List<java.util.Map<String, Object>> avail = doctorDAO.getDoctorAvailability(doctorId);
        ArrayList<DoctorAvailability> availList = new ArrayList<>();
        for (java.util.Map<String, Object> a : avail) {
            DoctorAvailability da = new DoctorAvailability();
            da.setAvailabilityId((Integer) a.get("availabilityId"));
            da.setDoctorId(doctorId);
            da.setDay((String) a.get("dayOfWeek"));
            da.setStartTime((String) a.get("startTime"));
            da.setEndTime((String) a.get("endTime"));
            da.setConsultationType((String) a.get("consultationType"));
            availList.add(da);
        }
        doctor.setAvailabilityList(availList);
        return doctor;
    }
}
