package patient.model;

import java.io.Serializable;

public class PatientPrescription implements Serializable {
    private static final long serialVersionUID = 1L;

    private int prescriptionId;
    private int consultationId;
    private String patientId;
    private String patientName;
    private int doctorId;
    private String doctorName;
    private String prescriptionDate;
    private String diagnosis;
    private String advice;

    public PatientPrescription() {}

    public int getPrescriptionId() { return prescriptionId; }
    public void setPrescriptionId(int prescriptionId) { this.prescriptionId = prescriptionId; }

    public int getConsultationId() { return consultationId; }
    public void setConsultationId(int consultationId) { this.consultationId = consultationId; }

    public String getPatientId() { return patientId; }
    public void setPatientId(String patientId) { this.patientId = patientId; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }

    public String getPrescriptionDate() { return prescriptionDate; }
    public void setPrescriptionDate(String prescriptionDate) { this.prescriptionDate = prescriptionDate; }

    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }

    public String getAdvice() { return advice; }
    public void setAdvice(String advice) { this.advice = advice; }
}
