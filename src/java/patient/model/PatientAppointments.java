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
    
    public ArrayList<PatientAppointments> getAppointments(String patientId){
        ArrayList<PatientAppointments> patientAppointmentsList = new ArrayList<>();
        
        this.patientId = patientId;
        
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db","avnadmin",System.getenv("DB_PASSWORD"));
            stmt = con.createStatement();
            
            String q = "Select a.appointment_id, a.doctor_id, a.appointment_date,"
                + "a.appointment_time, a.appointment_type, a.status, a.reason, "
                + "u.name as doctor_name"
                + " from appointments a, users u, doctors d"
                + " where patient_id='"+patientId+"' "
                + " AND a.doctor_id = d.doctor_id "
                + " AND d.user_id = u.user_id";
            
            rs = stmt.executeQuery(q);
            while(rs.next()){
                PatientAppointments pa = new PatientAppointments();
                
                pa.setAppointmentId(rs.getInt("appointment_id"));
                pa.setDoctorId(rs.getInt("doctor_id"));
                pa.setDoctorName(rs.getString("doctor_name"));
                pa.setAppointmentDate(rs.getString("appointment_date"));
                pa.setAppointmentTime(rs.getString("appointment_time"));
                pa.setAppointmentType(rs.getString("appointment_type"));
                pa.setStatus(rs.getString("status"));
                pa.setReason(rs.getString("reason"));
                
                patientAppointmentsList.add(pa);
            }
        }catch(Exception e){
            System.out.println(e);
        }finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return patientAppointmentsList;
    }
    
    public PatientAppointments getAppointmentByAppId(int appointmentId){
        PatientAppointments AppointmentDetails = null;
        
        this.appointmentId = appointmentId;
        
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db","avnadmin",System.getenv("DB_PASSWORD"));
            stmt = con.createStatement();
            
            String q = "SELECT a.appointment_id, a.doctor_id, a.appointment_date, a.appointment_time, a.appointment_type, "
                    + "a.status, a.reason, p.name AS patientName, u.name AS doctorName, "
                    + "s.name AS specialization, c.clinic_name AS clinicName, d.consultation_fee AS consultationFee "
                    + "FROM appointments a, doctors d, patients p, users u, specializations s, clinics c "
                    + "WHERE a.appointment_id = '" + appointmentId + "' "
                    + "AND a.patient_id = p.patient_id "
                    + "AND a.doctor_id = d.doctor_id "
                    + "AND d.user_id = u.user_id "
                    + "AND d.specialization_id = s.specialization_id "
                    + "AND d.clinic_id = c.clinic_id";
            
            rs = stmt.executeQuery(q);
            if(rs.next()){
                AppointmentDetails = new PatientAppointments();
                AppointmentDetails.setAppointmentId(appointmentId);
                AppointmentDetails.setDoctorId(rs.getInt("doctor_id"));
                AppointmentDetails.setAppointmentDate(rs.getString("appointment_date"));
                AppointmentDetails.setAppointmentTime(rs.getString("appointment_time"));
                AppointmentDetails.setAppointmentType(rs.getString("appointment_type"));
                AppointmentDetails.setStatus(rs.getString("status"));
                AppointmentDetails.setReason(rs.getString("reason"));
                AppointmentDetails.setPatientName(rs.getString("patientName"));
                AppointmentDetails.setDoctorName(rs.getString("doctorName"));
                AppointmentDetails.setSpecialization(rs.getString("specialization"));
                AppointmentDetails.setClinicName(rs.getString("clinicName"));
                AppointmentDetails.setConsultationFee(rs.getDouble("consultationFee"));
            }
        }catch(Exception e){
            System.out.println(e);
        }finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return AppointmentDetails;
    }
}