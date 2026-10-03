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
    
    public ArrayList<Prescriptions> getPrescriptionByPatientId(String patientId){
        this.patientId = patientId;
        
        ArrayList<Prescriptions> prescriptionLists = new ArrayList<>();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db","avnadmin","REMOVED_DB_PASSWORD");
            stmt = con.createStatement();
            
            String q = "select pr.prescription_id, pr.consultation_id, pr.doctor_id, "
                    + " pr.prescription_date, pr.diagnosis, pr.advice, "
                    + " u.name as doctorName, p.name as patientName "
                    + " FROM prescriptions pr, users u, patients p, doctors d"
                    + " WHERE patient_id='"+patientId+"'"
                    + " AND pr.patient_id = p.patient_id"
                    + " AND pr.doctor_id = d.doctor_id"
                    + " AND d.user_id = u.user_id";
            
            rs = stmt.executeQuery(q);
            while(rs.next()){
                Prescriptions pd = new Prescriptions();
                pd.setPrescriptionId(rs.getInt("prescription_id"));
                pd.setConsultationId(rs.getInt("consultation_id"));
                pd.setDoctorId(rs.getInt("doctor_id"));
                pd.setPrescriptionDate(rs.getString("prescription_date"));
                pd.setDiagnosis(rs.getString("diagnosis"));
                pd.setAdvice(rs.getString("advice"));
                pd.setDoctorName(rs.getString("doctorName"));
                pd.setPatientName(rs.getString("patientName"));
                
                prescriptionLists.add(pd);
            }
        }catch (Exception e) {
            System.out.println(e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return prescriptionLists;
    }
    
    public Prescriptions getPrescriptionByPrescriptionId(int prescriptionId){
        this.prescriptionId = prescriptionId;
        
        Prescriptions pd = new Prescriptions();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db","avnadmin","REMOVED_DB_PASSWORD");
            stmt = con.createStatement();
            
            String q = "select pr.consultation_id, pr.patient_id, pr.doctor_id, "
                    + " pr.prescription_date, pr.diagnosis, pr.advice, "
                    + " u.name as doctorName, p.name as patientName "
                    + " FROM prescriptions pr, users u, patients p, doctors d"
                    + " WHERE prescription_id='"+prescriptionId+"'"
                    + " AND pr.patient_id = p.patient_id"
                    + " AND pr.doctor_id = d.doctor_id"
                    + " AND d.user_id = u.user_id";
            
            rs = stmt.executeQuery(q);
            if(rs.next()){
                pd.setConsultationId(rs.getInt("consultation_id"));
                pd.setPatientId(rs.getString("patient_id"));
                pd.setDoctorId(rs.getInt("doctor_id"));
                pd.setPrescriptionDate(rs.getString("prescription_date"));
                pd.setDiagnosis(rs.getString("diagnosis"));
                pd.setAdvice(rs.getString("advice"));
                pd.setDoctorName(rs.getString("doctorName"));
                pd.setPatientName(rs.getString("patientName"));
            }
        }catch (Exception e) {
            System.out.println(e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return pd; //pd means prescriptionDetails
    }
    
}
