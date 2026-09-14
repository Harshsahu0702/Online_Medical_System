package model.doctor;

public class DoctorDocument {

    private int documentId;
    private int doctorId;

    private String documentType;
    private String fileName;
    private String filePath;

    private String verificationStatus;
    private java.sql.Timestamp uploadedAt;

    // CONSTRUCTOR
    public DoctorDocument() {
    }

    // DOCUMENT ID
    public int getDocumentId() {
        return documentId;
    }

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }
    // DOCTOR ID
    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }
    // DOCUMENT TYPE
    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }
    // FILE NAME
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    // FILE PATH
    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    // VERIFICATION STATUS
    public String getVerificationStatus() {
        return verificationStatus;
    }

    public void setVerificationStatus(String verificationStatus) {
        this.verificationStatus = verificationStatus;
    }
    // UPLOADED AT
    public java.sql.Timestamp getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(java.sql.Timestamp uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
}