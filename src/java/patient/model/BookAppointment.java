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

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", System.getenv("DB_PASSWORD"));
    }

    // Fetches full slot and doctor details by availabilityId using Statement
    public BookAppointment getSlotDetailsByAvailabilityId(String availabilityIdStr) {
        if (availabilityIdStr == null || availabilityIdStr.trim().isEmpty()) {
            return null;
        }

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            con = getConnection();
            stmt = con.createStatement();
            String q = "SELECT "
                    + "    da.availability_id, "
                    + "    d.doctor_id, "
                    + "    u.name AS doctor_name, "
                    + "    s.name AS specialization, "
                    + "    c.clinic_name, "
                    + "    da.day_of_week, "
                    + "    da.start_time, "
                    + "    da.end_time, "
                    + "    da.consultation_type, "
                    + "    d.consultation_fee, "
                    + "    d.qualification, "
                    + "    d.experience "
                    + "FROM doctor_availability da "
                    + "JOIN doctors d ON da.doctor_id = d.doctor_id "
                    + "JOIN users u ON d.user_id = u.user_id "
                    + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                    + "LEFT JOIN clinics c ON d.clinic_id = c.clinic_id "
                    + "WHERE da.availability_id = " + availabilityIdStr.trim();

            rs = stmt.executeQuery(q);

            if (rs.next()) {
                BookAppointment ba = new BookAppointment();
                ba.setAvailabilityId(rs.getInt("availability_id"));
                ba.setDoctorId(rs.getInt("doctor_id"));
                ba.setDoctorName(rs.getString("doctor_name"));
                ba.setSpecialization(rs.getString("specialization") != null ? rs.getString("specialization") : "General Specialist");
                ba.setClinicName(rs.getString("clinic_name") != null ? rs.getString("clinic_name") : "Medical Center");
                ba.setDayOfWeek(rs.getString("day_of_week"));
                ba.setStartTime(rs.getString("start_time"));
                ba.setEndTime(rs.getString("end_time"));
                ba.setConsultationType(rs.getString("consultation_type") != null ? rs.getString("consultation_type") : "Both");
                ba.setConsultationFee(rs.getFloat("consultation_fee"));
                ba.setQualification(rs.getString("qualification") != null ? rs.getString("qualification") : "MBBS");
                ba.setExperience(rs.getInt("experience"));
                return ba;
            }
        } catch (Exception e) {
            System.out.println("getSlotDetailsByAvailabilityId error: " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return null;
    }

    // Saves appointment into appointments table using Statement
    public boolean saveAppointment(String patientId, int doctorId, String appointmentDate, String appointmentTime, String appointmentType, String reason) {
        Connection con = null;
        Statement stmt = null;
        try {
            con = getConnection();
            stmt = con.createStatement();

            // Safely escape single quotes if reason contains any
            String safeReason = (reason != null) ? reason.replace("'", "''") : "";

            String q = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, appointment_type, status, reason) "
                    + "VALUES ('" + patientId + "', " + doctorId + ", '" + appointmentDate + "', '" + appointmentTime + "', '" + appointmentType + "', 'PENDING', '" + safeReason + "')";

            int rows = stmt.executeUpdate(q);
            return rows > 0;
        } catch (Exception e) {
            System.out.println("saveAppointment error: " + e);
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }
}
