package emergency.model;

import emergency.dao.EmergencyDAO;
public class Emergency {
    private int emergencyID;
    private String patientID;
    private String emergencyType;
    private String description;
    private String location;
    private String contact;
    private String severity;
    private String status;
    private String requestedAt;
    private String resolvedAt;

    public Emergency()
    {
        
    }
    
    public void setEmergencyID(int emergencyID) {
        this.emergencyID = emergencyID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public void setPatientID(Integer patientID) {
        this.patientID = patientID != null ? String.valueOf(patientID) : null;
    }

    public void setEmergencyType(String emergencyType) {
        this.emergencyType = emergencyType;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setRequestedAt(String requestedAt) {
        this.requestedAt = requestedAt;
    }

    public void setResolvedAt(String resolvedAt) {
        this.resolvedAt = resolvedAt;
    }

    public int getEmergencyID() {
        return emergencyID;
    }

    public String getPatientID() {
        return patientID;
    }

    public String getEmergencyType() {
        return emergencyType;
    }

    public String getDescription() {
        return description;
    }

    public String getLocation() {
        return location;
    }

    public String getContact() {
        return contact;
    }

    public String getSeverity() {
        return severity;
    }

    public String getStatus() {
        return status;
    }

    public String getRequestedAt() {
        return requestedAt;
    }

    public String getResolvedAt() {
        return resolvedAt;
    }
    public int insert()
    {
        return EmergencyDAO.insertData(this);
    }
}
