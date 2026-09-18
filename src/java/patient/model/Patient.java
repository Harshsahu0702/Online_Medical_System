package patient.model;

import java.sql.*;
import java.util.UUID;

public class Patient {
    String email;
    String password;
    String name;
    String gender;
    String address;
    String contact;
    String dob;
    String bloodGroup;
    String patientId = UUID.randomUUID().toString();

    public String getPatientId() {
        return patientId;
    }
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String Contact) {
        this.contact = contact;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getBloodGroup() {
        return bloodGroup;
    }

    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
    }
    public String patientSignup(){
        Connection con = null;
        Statement stmt = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db","avnadmin","REMOVED_DB_PASSWORD");
            stmt = con.createStatement();
            
            String q = "INSERT INTO patients (patient_id, email, password, name, gender, address, contact, blood_group, dob) "
                        + "VALUES ('"+patientId+"','"+email+"','"+password+"','"+name+"','"+gender+"','"+address+"','"+contact+"','"+bloodGroup+"','"+dob+"')";
            
            int x = stmt.executeUpdate(q);
            if(x>0){
                return "success";
            }else{
                return "failed";
            }
        }catch(SQLIntegrityConstraintViolationException e) {
            return "email_exists";
        
        }catch(Exception e){
            System.out.println(e);
            return "error";
        }finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }
    public String patientLogin(){
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db","avnadmin","REMOVED_DB_PASSWORD");
            stmt = con.createStatement();
            
            String q = "select * from patients where email='"+email+"' and password='"+password+"'";
            
            rs = stmt.executeQuery(q);
            if(rs.next()){
                patientId = rs.getString("patient_id");
                email = rs.getString("email");
//                password = rs.getString("password");
                name = rs.getString("name");
                gender = rs.getString("gender");
                contact = rs.getString("contact");
                address = rs.getString("address");
                dob = rs.getString("dob");
                bloodGroup = rs.getString("blood_group");
                return "success";
            }else{
                return "invalid";
            }
        }catch(Exception e){
            return "error";
        }finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }
    public Patient getPatientById(String patientId){
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db","avnadmin","REMOVED_DB_PASSWORD");
            stmt = con.createStatement();
            
            String q = "select * from patients where patient_id='"+patientId+"'";
            
            rs = stmt.executeQuery(q);
            if(rs.next()){
                Patient patient = new Patient();

                patient.patientId = rs.getString("patient_id");
                patient.email = rs.getString("email");
                patient.name = rs.getString("name");
                patient.gender = rs.getString("gender");
                patient.contact = rs.getString("contact");
                patient.address = rs.getString("address");
                patient.dob = rs.getString("dob");
                patient.bloodGroup = rs.getString("blood_group");

                return patient;
            }else{
                return null;
            }
        }catch(Exception e){
            System.out.println(e);
            return null;
        }finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }
}
