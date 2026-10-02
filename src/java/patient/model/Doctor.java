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

    public Doctor getDoctorById(int doctorId) {
        Doctor doctor = null;
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", "REMOVED_DB_PASSWORD");
            stmt = con.createStatement();

            String q = "SELECT d.doctor_id, u.name, u.email, u.phone, s.name AS specialization, c.clinic_name AS clinicName, "
                    + "d.qualification, d.experience, d.consultation_fee, d.bio, d.consultation_type "
                    + "FROM doctors d, users u, specializations s, clinics c "
                    + "WHERE d.doctor_id = '" + doctorId + "' "
                    + "AND d.user_id = u.user_id "
                    + "AND d.specialization_id = s.specialization_id "
                    + "AND d.clinic_id = c.clinic_id";

            rs = stmt.executeQuery(q);
            if (rs.next()) {
                doctor = new Doctor();
                doctor.setDoctorId(rs.getInt("doctor_id"));
                doctor.setName(rs.getString("name"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setSpecialization(rs.getString("specialization"));
                doctor.setClinicName(rs.getString("clinicName"));
                doctor.setQualification(rs.getString("qualification"));
                doctor.setExperience(rs.getInt("experience"));
                doctor.setConsultationFee(rs.getDouble("consultation_fee"));
                doctor.setBio(rs.getString("bio"));
                doctor.setConsultationType(rs.getString("consultation_type"));

                // Fetch availability slots for this doctor
                Statement stmt2 = con.createStatement();
                String q2 = "SELECT availability_id, day_of_week, start_time, end_time, consultation_type "
                        + "FROM doctor_availability "
                        + "WHERE doctor_id = '" + doctorId + "' AND is_available = 1";
                ResultSet rs2 = stmt2.executeQuery(q2);
                ArrayList<DoctorAvailability> availList = new ArrayList<>();
                while (rs2.next()) {
                    DoctorAvailability da = new DoctorAvailability();
                    da.setAvailabilityId(rs2.getInt("availability_id"));
                    da.setDoctorId(doctorId);
                    da.setDay(rs2.getString("day_of_week"));
                    da.setStartTime(rs2.getString("start_time"));
                    da.setEndTime(rs2.getString("end_time"));
                    da.setConsultationType(rs2.getString("consultation_type"));
                    availList.add(da);
                }
                rs2.close();
                stmt2.close();

                doctor.setAvailabilityList(availList);
            }
        } catch (Exception e) {
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

        return doctor;
    }
}
