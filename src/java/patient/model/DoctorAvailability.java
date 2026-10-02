package patient.model;

import java.sql.*;
import java.util.ArrayList;

public class DoctorAvailability {

//    int availabilityId;
//    int doctorID;
//    String days;
//    String startTime;
//    String endTime;
//    String consultationType;
//    String isAvailable;
//    
//    public int getAvailabilityId() {
//        return availabilityId;
//    }
//    
//    public void setAvailabilityId(int availabilityId){
//        this.availabilityId = availabilityId;
//    }
//
//    public int getDoctorID() {
//        return doctorID;
//    }
//
//    public void setDoctorID(int doctorID) {
//        this.doctorID = doctorID;
//    }
//
//    public String getDays() {
//        return days;
//    }
//
//    public void setDays(String days) {
//        this.days = days;
//    }
//
//    public String getStartTime() {
//        return startTime;
//    }
//
//    public void setStartTime(String startTime) {
//        this.startTime = startTime;
//    }
//
//    public String getEndTime() {
//        return endTime;
//    }
//
//    public void setEndTime(String endTime) {
//        this.endTime = endTime;
//    }
//
//    public String getConsultationType() {
//        return consultationType;
//    }
//
//    public void setConsultationType(String consultationType) {
//        this.consultationType = consultationType;
//    }
//
//    public String getIsAvailable() {
//        return isAvailable;
//    }
//
//    public void setIsAvailable(String isAvailable) {
//        this.isAvailable = isAvailable;
//    }
//    
    
    int availabilityId;
    int doctorId;
    String day;
    String startTime;
    String endTime;
    String consultationType;
    String doctorName;
    String specialization;
    String clinicName;
    String doctorQualification;
    int doctorExperience;
    float consultationFee;
    
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

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
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

    public String getDoctorQualification() {
        return doctorQualification;
    }

    public void setDoctorQualification(String doctorQualification) {
        this.doctorQualification = doctorQualification;
    }

    public int getDoctorExperience() {
        return doctorExperience;
    }

    public void setDoctorExperience(int doctorExperience) {
        this.doctorExperience = doctorExperience;
    }

    public float getConsultationFee() {
        return consultationFee;
    }
    
    public void setConsultationFee(float consulationFee) {
        this.consultationFee = consulationFee;
    }
    
    
    
    public ArrayList<DoctorAvailability> getAvailableDoctors(String searchTerm, String specialty, String day) {

        ArrayList<DoctorAvailability> availableDoctors = new ArrayList<>();
        
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db","avnadmin","REMOVED_DB_PASSWORD");
            stmt = con.createStatement();
            
            String q = "SELECT" +
                        "    da.availability_id AS availabilityId," +
                        "    d.doctor_id AS doctorId," +
                        "    da.day_of_week AS day," +
                        "    da.start_time AS startTime," +
                        "    da.end_time AS endTime," +
                        "    da.consultation_type AS consultationType," +
                        "    u.name AS doctorName," +
                        "    c.clinic_name AS clinicName," +
                        "    s.name AS specialization," +
                        "    d.qualification AS doctorQualification," +
                        "    d.experience AS doctorExperience," +
                        "    d.consultation_fee AS consultationFee" +
                        " FROM doctor_availability da," +
                        "     users u," +
                        "     clinics c," +
                        "     doctors d," +
                        "     specializations s" +
                        " WHERE da.is_available = 1" +
                        "  AND da.doctor_id = d.doctor_id" +
                        "  AND d.user_id = u.user_id" +
                        "  AND d.specialization_id = s.specialization_id" +
                        "  AND d.clinic_id = c.clinic_id";
            
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                q += " AND (u.name LIKE '%" + searchTerm.trim() + "%' OR c.clinic_name LIKE '%" + searchTerm.trim() + "%')";
            }
            if (specialty != null && !specialty.trim().isEmpty() && !specialty.equalsIgnoreCase("ALL")) {
                q += " AND s.name = '" + specialty.trim() + "'";
            }
            if (day != null && !day.trim().isEmpty() && !day.equalsIgnoreCase("ALL")) {
                q += " AND da.day_of_week = '" + day.trim() + "'";
            }
            
            q += " ORDER BY d.doctor_id, FIELD(da.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), da.start_time";
            
            rs = stmt.executeQuery(q);
            
            while(rs.next()){
                DoctorAvailability da = new DoctorAvailability();
                
//                da.setAvailabilityId(rs.getInt("availability_id"));
//                da.setDoctorID(rs.getInt("doctor_id"));
//                da.setDays(rs.getString("day_of_week"));
//                da.setStartTime(rs.getString("start_time"));
//                da.setEndTime(rs.getString("end_time"));
//                da.setConsultationType(rs.getString("consultation_type"));

                da.setAvailabilityId(rs.getInt("availabilityId"));
                da.setDoctorId(rs.getInt("doctorId"));
                da.setDay(rs.getString("day"));
                da.setStartTime(rs.getString("startTime"));
                da.setEndTime(rs.getString("endTime"));
                da.setDoctorName(rs.getString("doctorName"));
                da.setSpecialization(rs.getString("specialization"));
                da.setClinicName(rs.getString("clinicName"));
                da.setDoctorQualification(rs.getString("doctorQualification"));
                da.setDoctorExperience(rs.getInt("doctorExperience"));
                da.setConsultationFee(rs.getFloat("consultationFee"));
                da.setConsultationType(rs.getString("consultationType"));
                
                availableDoctors.add(da);
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
        return availableDoctors;
    }
}
