package dao.doctor;

import model.doctor.Doctor;
import model.doctor.DoctorDocument;
import model.doctor.Specialization;
import model.doctor.Clinic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {
    // DATABASE CONNECTION

    private static final String URL =
            "jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db?sslMode=REQUIRED";

    private static final String USER = "avnadmin";

    

    private Connection getConnection() throws SQLException, ClassNotFoundException {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String password = System.getenv("DB_PASSWORD");

            return DriverManager.getConnection(URL, USER, password);
    }

    // GET ALL SPECIALIZATIONS

    public List<Specialization> getAllSpecializations() throws SQLException {

        List<Specialization> list = new ArrayList<Specialization>();

        String sql =
                "SELECT specialization_id, name, description "
                + "FROM specializations "
                + "ORDER BY name";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = getConnection();

            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Specialization s = new Specialization();

                s.setSpecializationId(rs.getInt("specialization_id"));

                s.setName(rs.getString("name"));

                s.setDescription(rs.getString("description"));

                list.add(s);
            }

        } catch (ClassNotFoundException e) {

            e.printStackTrace();

        } finally {

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return list;
    }

    // GET ALL CLINICS

    public List<Clinic> getAllClinics() throws SQLException {

        List<Clinic> list = new ArrayList<Clinic>();

        String sql =
                "SELECT clinic_id, clinic_name, address, city, "
                + "phone, opening_time, closing_time "
                + "FROM clinics "
                + "ORDER BY clinic_name";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = getConnection();

            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Clinic c = new Clinic();

                c.setClinicId(rs.getInt("clinic_id"));

                c.setClinicName(rs.getString("clinic_name"));

                c.setAddress(rs.getString("address"));

                c.setCity(rs.getString("city"));

                c.setPhone(rs.getString("phone"));

                list.add(c);
            }

        } catch (ClassNotFoundException e) {

            e.printStackTrace();

        } finally {

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return list;
    }

    // REGISTER DOCTOR

    public boolean registerDoctor(Doctor doctor, List<DoctorDocument> documents) {

        Connection con = null;

        PreparedStatement userPs = null;
        PreparedStatement doctorPs = null;
        PreparedStatement documentPs = null;

        ResultSet generatedKeys = null;

        try {

            con = getConnection();
            con.setAutoCommit(false);

            // 1. INSERT INTO USERS

            String userSql =
                    "INSERT INTO users "
                    + "(name, email, password, phone, role, status) "
                    + "VALUES (?, ?, ?, ?, 'DOCTOR', 'PENDING')";

            userPs =con.prepareStatement(userSql,Statement.RETURN_GENERATED_KEYS);

            userPs.setString(1, doctor.getName());

            userPs.setString(2, doctor.getEmail());

            userPs.setString(3, doctor.getPassword());

            userPs.setString(4, doctor.getPhone());

            int userRows = userPs.executeUpdate();

            if (userRows == 0) {
                con.rollback();
                return false;
            }

            // 2. GET GENERATED USER ID

            generatedKeys = userPs.getGeneratedKeys();

            int userId;

            if (generatedKeys.next()) {

                userId = generatedKeys.getInt(1);

            } else {

                con.rollback();

                return false;
            }

            // 3. INSERT INTO DOCTORS

            String doctorSql =
                    "INSERT INTO doctors "
                    + "(user_id, specialization_id, clinic_id, "
                    + "qualification, experience, license_number, "
                    + "consultation_fee, registration_authority, "
                    + "bio, consultation_type) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            doctorPs =
                    con.prepareStatement(
                            doctorSql,
                            Statement.RETURN_GENERATED_KEYS
                    );

            doctorPs.setInt(1, userId);

            doctorPs.setInt(2, doctor.getSpecializationId());

            // Clinic is optional

            if (doctor.getClinicId() == null) {

                doctorPs.setNull(
                        3,
                        java.sql.Types.INTEGER
                );

            } else {

                doctorPs.setInt(
                        3,
                        doctor.getClinicId()
                );
            }

            doctorPs.setString(4, doctor.getQualification());

            doctorPs.setInt(5, doctor.getExperience());

            doctorPs.setString(6, doctor.getLicenseNumber());

            doctorPs.setDouble(7, doctor.getConsultationFee());

            doctorPs.setString(8, doctor.getRegistrationAuthority());

            doctorPs.setString(9, doctor.getBio());

            doctorPs.setString(10, doctor.getConsultationType());

            int doctorRows = doctorPs.executeUpdate();

            if (doctorRows == 0) {

                con.rollback();

                return false;
            }

            // 4. GET GENERATED DOCTOR ID

            generatedKeys.close();

            generatedKeys = doctorPs.getGeneratedKeys();

            int doctorId;

            if (generatedKeys.next()) {

                doctorId = generatedKeys.getInt(1);

            } else {

                con.rollback();

                return false;
            }

            // 5. INSERT DOCUMENTS

            String documentSql =
                    "INSERT INTO doctor_documents "
                    + "(doctor_id, document_type, file_name, "
                    + "file_path, verification_status) "
                    + "VALUES (?, ?, ?, ?, 'PENDING')";

            documentPs =
                    con.prepareStatement(
                            documentSql
                    );

            if (documents != null) {

                for (DoctorDocument document : documents) {

                    documentPs.setInt(1, doctorId);

                    documentPs.setString(2, document.getDocumentType());

                    documentPs.setString(3, document.getFileName());

                    documentPs.setString(4, document.getFilePath());

                    documentPs.addBatch();
                }

                documentPs.executeBatch();
            }

            // 6. COMMIT

            con.commit();

            return true;

        } catch (ClassNotFoundException e) {

            e.printStackTrace();

            rollbackConnection(con);

            return false;

        } catch (SQLException e) {

            e.printStackTrace();

            rollbackConnection(con);

            return false;

        } finally {

            if (generatedKeys != null) {

                try {
                    generatedKeys.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (userPs != null) {

                try {
                    userPs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (doctorPs != null) {

                try {
                    doctorPs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (documentPs != null) {

                try {
                    documentPs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (con != null) {

                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // ROLLBACK

    private void rollbackConnection(Connection con) {

        if (con != null) {

            try {

                con.rollback();

            } catch (SQLException e) {

                e.printStackTrace();
            }
        }
    }
}