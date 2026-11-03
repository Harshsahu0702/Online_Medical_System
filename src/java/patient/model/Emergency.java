package patient.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class Emergency {
    int emergencyId;
    String patientId;
    String patientName;
    String emergencyType;
    String description;
    String location;
    String contactNumber;
    String severity;
    String status;
    String requestedAt;
    String resolvedAt;

    public int getEmergencyId() {
        return emergencyId;
    }

    public void setEmergencyId(int emergencyId) {
        this.emergencyId = emergencyId;
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

    public String getEmergencyType() {
        return emergencyType;
    }

    public void setEmergencyType(String emergencyType) {
        this.emergencyType = emergencyType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRequestedAt() {
        return requestedAt;
    }

    public void setRequestedAt(String requestedAt) {
        this.requestedAt = requestedAt;
    }

    public String getResolvedAt() {
        return resolvedAt;
    }

    public void setResolvedAt(String resolvedAt) {
        this.resolvedAt = resolvedAt;
    }

    public ArrayList<Emergency> getEmergencyRequestsByPatientId(String patientId) {
        ArrayList<Emergency> list = new ArrayList<>();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", System.getenv("DB_PASSWORD"));
            stmt = con.createStatement();

            String q = "SELECT e.emergency_id, e.patient_id, e.emergency_type, e.description, e.location, e.contact_number, e.severity, e.status, e.requested_at, e.resolved_at, p.name AS patient_name "
                     + " FROM emergency_requests e, patients p "
                     + " WHERE e.patient_id = p.patient_id ";

            if (patientId != null && !patientId.trim().isEmpty()) {
                q += " AND e.patient_id = '" + patientId.trim() + "'";
            }

            q += " ORDER BY e.requested_at DESC, e.emergency_id DESC";

            rs = stmt.executeQuery(q);
            while (rs.next()) {
                Emergency em = new Emergency();
                em.setEmergencyId(rs.getInt("emergency_id"));
                em.setPatientId(rs.getString("patient_id"));
                em.setPatientName(rs.getString("patient_name"));
                em.setEmergencyType(rs.getString("emergency_type"));
                em.setDescription(rs.getString("description"));
                em.setLocation(rs.getString("location"));
                em.setContactNumber(rs.getString("contact_number"));
                em.setSeverity(rs.getString("severity"));
                em.setStatus(rs.getString("status"));
                em.setRequestedAt(rs.getString("requested_at"));
                em.setResolvedAt(rs.getString("resolved_at"));
                list.add(em);
            }

            // Fallback in case patient is not found in patients table
            if (list.isEmpty()) {
                if (rs != null) rs.close();
                String q2 = "SELECT emergency_id, patient_id, emergency_type, description, location, contact_number, severity, status, requested_at, resolved_at "
                          + " FROM emergency_requests ";
                if (patientId != null && !patientId.trim().isEmpty()) {
                    q2 += " WHERE patient_id = '" + patientId.trim() + "'";
                }
                q2 += " ORDER BY requested_at DESC, emergency_id DESC";

                rs = stmt.executeQuery(q2);
                while (rs.next()) {
                    Emergency em = new Emergency();
                    em.setEmergencyId(rs.getInt("emergency_id"));
                    em.setPatientId(rs.getString("patient_id"));
                    em.setPatientName("-");
                    em.setEmergencyType(rs.getString("emergency_type"));
                    em.setDescription(rs.getString("description"));
                    em.setLocation(rs.getString("location"));
                    em.setContactNumber(rs.getString("contact_number"));
                    em.setSeverity(rs.getString("severity"));
                    em.setStatus(rs.getString("status"));
                    em.setRequestedAt(rs.getString("requested_at"));
                    em.setResolvedAt(rs.getString("resolved_at"));
                    list.add(em);
                }
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
        return list;
    }

    public Emergency getEmergencyById(int emergencyId) {
        Emergency em = null;
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", System.getenv("DB_PASSWORD"));
            stmt = con.createStatement();

            String q = "SELECT e.emergency_id, e.patient_id, e.emergency_type, e.description, e.location, e.contact_number, e.severity, e.status, e.requested_at, e.resolved_at, p.name AS patient_name "
                     + " FROM emergency_requests e, patients p "
                     + " WHERE e.emergency_id = " + emergencyId + " "
                     + " AND e.patient_id = p.patient_id";

            rs = stmt.executeQuery(q);
            if (rs.next()) {
                em = new Emergency();
                em.setEmergencyId(rs.getInt("emergency_id"));
                em.setPatientId(rs.getString("patient_id"));
                em.setPatientName(rs.getString("patient_name"));
                em.setEmergencyType(rs.getString("emergency_type"));
                em.setDescription(rs.getString("description"));
                em.setLocation(rs.getString("location"));
                em.setContactNumber(rs.getString("contact_number"));
                em.setSeverity(rs.getString("severity"));
                em.setStatus(rs.getString("status"));
                em.setRequestedAt(rs.getString("requested_at"));
                em.setResolvedAt(rs.getString("resolved_at"));
            } else {
                if (rs != null) rs.close();
                String q2 = "SELECT emergency_id, patient_id, emergency_type, description, location, contact_number, severity, status, requested_at, resolved_at "
                          + " FROM emergency_requests "
                          + " WHERE emergency_id = " + emergencyId;

                rs = stmt.executeQuery(q2);
                if (rs.next()) {
                    em = new Emergency();
                    em.setEmergencyId(rs.getInt("emergency_id"));
                    em.setPatientId(rs.getString("patient_id"));
                    em.setPatientName("-");
                    em.setEmergencyType(rs.getString("emergency_type"));
                    em.setDescription(rs.getString("description"));
                    em.setLocation(rs.getString("location"));
                    em.setContactNumber(rs.getString("contact_number"));
                    em.setSeverity(rs.getString("severity"));
                    em.setStatus(rs.getString("status"));
                    em.setRequestedAt(rs.getString("requested_at"));
                    em.setResolvedAt(rs.getString("resolved_at"));
                }
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
        return em;
    }

    public boolean createEmergencyRequest(Emergency em) {
        Connection con = null;
        Statement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", System.getenv("DB_PASSWORD"));
            stmt = con.createStatement();

            String pId = em.getPatientId() != null ? em.getPatientId().trim() : "";
            String type = em.getEmergencyType() != null ? em.getEmergencyType().replace("'", "''") : "";
            String desc = em.getDescription() != null ? em.getDescription().replace("'", "''") : "";
            String loc = em.getLocation() != null ? em.getLocation().replace("'", "''") : "";
            String contact = em.getContactNumber() != null ? em.getContactNumber().replace("'", "''") : "";
            String sev = em.getSeverity() != null ? em.getSeverity().replace("'", "''") : "MEDIUM";
            String stat = em.getStatus() != null && !em.getStatus().trim().isEmpty() ? em.getStatus().replace("'", "''") : "PENDING";

            String q = "INSERT INTO emergency_requests (patient_id, emergency_type, description, location, contact_number, severity, status) "
                     + " VALUES ('" + pId + "', '" + type + "', '" + desc + "', '" + loc + "', '" + contact + "', '" + sev + "', '" + stat + "')";

            int rows = stmt.executeUpdate(q);
            return rows > 0;
        } catch (Exception e) {
            System.out.println(e);
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
