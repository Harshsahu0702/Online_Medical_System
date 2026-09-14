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

    // DOCTOR LOGIN
    public Doctor loginDoctor(String email, String password) {
        String sql = "SELECT d.doctor_id, d.user_id, d.specialization_id, d.clinic_id, d.qualification, "
                + "d.experience, d.license_number, d.consultation_fee, d.registration_authority, d.bio, "
                + "d.consultation_type, u.name, u.email, u.phone, u.status, s.name AS specialization_name, c.clinic_name "
                + "FROM users u "
                + "JOIN doctors d ON u.user_id = d.user_id "
                + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                + "LEFT JOIN clinics c ON d.clinic_id = c.clinic_id "
                + "WHERE u.email = ? AND u.password = ? AND u.role = 'DOCTOR'";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                Doctor d = new Doctor();
                d.setDoctorId(rs.getInt("doctor_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setSpecializationId(rs.getInt("specialization_id"));
                
                int clinicId = rs.getInt("clinic_id");
                if (!rs.wasNull()) {
                    d.setClinicId(clinicId);
                }
                
                d.setQualification(rs.getString("qualification"));
                d.setExperience(rs.getInt("experience"));
                d.setLicenseNumber(rs.getString("license_number"));
                d.setConsultationFee(rs.getDouble("consultation_fee"));
                d.setRegistrationAuthority(rs.getString("registration_authority"));
                d.setBio(rs.getString("bio"));
                d.setConsultationType(rs.getString("consultation_type"));
                d.setName(rs.getString("name"));
                d.setEmail(rs.getString("email"));
                d.setPhone(rs.getString("phone"));
                d.setStatus(rs.getString("status"));
                d.setSpecializationName(rs.getString("specialization_name"));
                d.setClinicName(rs.getString("clinic_name"));
                return d;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    // GET DOCTOR BY ID
    public Doctor getDoctorById(int doctorId) {
        String sql = "SELECT d.doctor_id, d.user_id, d.specialization_id, d.clinic_id, d.qualification, "
                + "d.experience, d.license_number, d.consultation_fee, d.registration_authority, d.bio, "
                + "d.consultation_type, u.name, u.email, u.phone, u.status, s.name AS specialization_name, c.clinic_name "
                + "FROM doctors d "
                + "JOIN users u ON d.user_id = u.user_id "
                + "LEFT JOIN specializations s ON d.specialization_id = s.specialization_id "
                + "LEFT JOIN clinics c ON d.clinic_id = c.clinic_id "
                + "WHERE d.doctor_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Doctor d = new Doctor();
                d.setDoctorId(rs.getInt("doctor_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setSpecializationId(rs.getInt("specialization_id"));
                
                int clinicId = rs.getInt("clinic_id");
                if (!rs.wasNull()) {
                    d.setClinicId(clinicId);
                }
                
                d.setQualification(rs.getString("qualification"));
                d.setExperience(rs.getInt("experience"));
                d.setLicenseNumber(rs.getString("license_number"));
                d.setConsultationFee(rs.getDouble("consultation_fee"));
                d.setRegistrationAuthority(rs.getString("registration_authority"));
                d.setBio(rs.getString("bio"));
                d.setConsultationType(rs.getString("consultation_type"));
                d.setName(rs.getString("name"));
                d.setEmail(rs.getString("email"));
                d.setPhone(rs.getString("phone"));
                d.setStatus(rs.getString("status"));
                d.setSpecializationName(rs.getString("specialization_name"));
                d.setClinicName(rs.getString("clinic_name"));
                return d;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    // UPDATE DOCTOR PROFILE
    public boolean updateDoctorProfile(Doctor doctor) {
        String updateDoctorSql = "UPDATE doctors SET specialization_id = ?, clinic_id = ?, qualification = ?, "
                + "experience = ?, license_number = ?, consultation_fee = ?, registration_authority = ?, bio = ?, "
                + "consultation_type = ? WHERE doctor_id = ?";

        String updateUserSql = "UPDATE users SET name = ?, phone = ? WHERE user_id = ?";

        Connection con = null;
        PreparedStatement psDoctor = null;
        PreparedStatement psUser = null;

        try {
            con = getConnection();
            con.setAutoCommit(false);

            // Update doctors table
            psDoctor = con.prepareStatement(updateDoctorSql);
            psDoctor.setInt(1, doctor.getSpecializationId());
            if (doctor.getClinicId() == null || doctor.getClinicId() == 0) {
                psDoctor.setNull(2, java.sql.Types.INTEGER);
            } else {
                psDoctor.setInt(2, doctor.getClinicId());
            }
            psDoctor.setString(3, doctor.getQualification());
            psDoctor.setInt(4, doctor.getExperience());
            psDoctor.setString(5, doctor.getLicenseNumber());
            psDoctor.setDouble(6, doctor.getConsultationFee());
            psDoctor.setString(7, doctor.getRegistrationAuthority());
            psDoctor.setString(8, doctor.getBio());
            psDoctor.setString(9, doctor.getConsultationType());
            psDoctor.setInt(10, doctor.getDoctorId());
            psDoctor.executeUpdate();

            // Update users table
            psUser = con.prepareStatement(updateUserSql);
            psUser.setString(1, doctor.getName());
            psUser.setString(2, doctor.getPhone());
            psUser.setInt(3, doctor.getUserId());
            psUser.executeUpdate();

            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            rollbackConnection(con);
            return false;
        } finally {
            if (psUser != null) {
                try { psUser.close(); } catch (SQLException ignored) {}
            }
            if (psDoctor != null) {
                try { psDoctor.close(); } catch (SQLException ignored) {}
            }
            if (con != null) {
                try { con.close(); } catch (SQLException ignored) {}
            }
        }
    }

    // GET DOCTOR DOCUMENTS
    public List<DoctorDocument> getDoctorDocuments(int doctorId) {
        List<DoctorDocument> list = new ArrayList<DoctorDocument>();
        String sql = "SELECT document_id, doctor_id, document_type, file_name, file_path, verification_status, uploaded_at "
                + "FROM doctor_documents WHERE doctor_id = ? ORDER BY document_id ASC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, doctorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                DoctorDocument doc = new DoctorDocument();
                doc.setDocumentId(rs.getInt("document_id"));
                doc.setDoctorId(rs.getInt("doctor_id"));
                doc.setDocumentType(rs.getString("document_type"));
                doc.setFileName(rs.getString("file_name"));
                doc.setFilePath(rs.getString("file_path"));
                doc.setVerificationStatus(rs.getString("verification_status"));
                doc.setUploadedAt(rs.getTimestamp("uploaded_at"));
                list.add(doc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    // GET DOCTOR DOCUMENT BY ID
    public DoctorDocument getDoctorDocumentById(int documentId) {
        String sql = "SELECT document_id, doctor_id, document_type, file_name, file_path, verification_status, uploaded_at "
                + "FROM doctor_documents WHERE document_id = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, documentId);
            rs = ps.executeQuery();

            if (rs.next()) {
                DoctorDocument doc = new DoctorDocument();
                doc.setDocumentId(rs.getInt("document_id"));
                doc.setDoctorId(rs.getInt("doctor_id"));
                doc.setDocumentType(rs.getString("document_type"));
                doc.setFileName(rs.getString("file_name"));
                doc.setFilePath(rs.getString("file_path"));
                doc.setVerificationStatus(rs.getString("verification_status"));
                doc.setUploadedAt(rs.getTimestamp("uploaded_at"));
                return doc;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    // SAVE OR UPDATE DOCTOR DOCUMENT
    public boolean saveOrUpdateDoctorDocument(DoctorDocument doc) {
        String checkSql = "SELECT document_id FROM doctor_documents WHERE doctor_id = ? AND document_type = ?";
        String updateSql = "UPDATE doctor_documents SET file_name = ?, file_path = ?, verification_status = 'PENDING', uploaded_at = CURRENT_TIMESTAMP WHERE doctor_id = ? AND document_type = ?";
        String insertSql = "INSERT INTO doctor_documents (doctor_id, document_type, file_name, file_path, verification_status) VALUES (?, ?, ?, ?, 'PENDING')";

        Connection con = null;
        PreparedStatement psCheck = null;
        PreparedStatement psAction = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            psCheck = con.prepareStatement(checkSql);
            psCheck.setInt(1, doc.getDoctorId());
            psCheck.setString(2, doc.getDocumentType());
            rs = psCheck.executeQuery();

            if (rs.next()) {
                psAction = con.prepareStatement(updateSql);
                psAction.setString(1, doc.getFileName());
                psAction.setString(2, doc.getFilePath());
                psAction.setInt(3, doc.getDoctorId());
                psAction.setString(4, doc.getDocumentType());
                psAction.executeUpdate();
            } else {
                psAction = con.prepareStatement(insertSql);
                psAction.setInt(1, doc.getDoctorId());
                psAction.setString(2, doc.getDocumentType());
                psAction.setString(3, doc.getFileName());
                psAction.setString(4, doc.getFilePath());
                psAction.executeUpdate();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (psAction != null) {
                try { psAction.close(); } catch (SQLException ignored) {}
            }
            closeResources(con, psCheck, rs);
        }
    }

    // HELPER TO CLOSE RESOURCES
    private void closeResources(Connection con, PreparedStatement ps, ResultSet rs) {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (ps != null) {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
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