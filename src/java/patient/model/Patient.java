package patient.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Patient implements Serializable {
    private static final long serialVersionUID = 1L;

    private String patientId;
    private Integer userId;
    private String email;
    private String password;
    private String name;
    private String gender;
    private String address;
    private String contact;
    private String dob;
    private String bloodGroup;
    private String emergencyName;
    private String emergencyRelation;
    private String emergencyContact;
    private Timestamp createdAt;

    public Patient() {}

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getBloodGroup() {
        return bloodGroup;
    }

    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
    }

    public String getEmergencyName() {
        return emergencyName;
    }

    public void setEmergencyName(String emergencyName) {
        this.emergencyName = emergencyName;
    }

    public String getEmergencyRelation() {
        return emergencyRelation;
    }

    public void setEmergencyRelation(String emergencyRelation) {
        this.emergencyRelation = emergencyRelation;
    }

    public String getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    private static final patient.dao.PatientDAO patientDAO = new patient.dao.PatientDAO();

    public String patientSignup() {
        String result = patientDAO.registerPatient(this);
        return result;
    }

    public String patientLogin() {
        Patient p = patientDAO.authenticate(this.email, this.password);
        if (p != null) {
            this.patientId = p.getPatientId();
            this.userId = p.getUserId();
            this.name = p.getName();
            this.gender = p.getGender();
            this.contact = p.getContact();
            this.address = p.getAddress();
            this.dob = p.getDob();
            this.bloodGroup = p.getBloodGroup();
            this.emergencyName = p.getEmergencyName();
            this.emergencyRelation = p.getEmergencyRelation();
            this.emergencyContact = p.getEmergencyContact();
            return "success";
        }
        return "invalid";
    }

    public Patient getPatientById(String id) {
        return patientDAO.getPatientById(id);
    }

    public Patient getPatientProfileById(String id) {
        return patientDAO.getPatientById(id);
    }

    public String updatePatient(String id) {
        this.patientId = id;
        boolean ok = patientDAO.updatePatientProfile(this);
        return ok ? "success" : "failure";
    }
}
