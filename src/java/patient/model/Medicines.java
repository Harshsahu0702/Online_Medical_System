package patient.model;

import java.util.*;
import java.sql.*;

public class Medicines {
    int medicineId;
    int pharmacyId;
    String pharmacyName;
    String medicineName;
    String genericName;
    String category;
    String description;
    String price;
    int stock_quantity;
    String expiryDate;
    String manufacturer;
    String status;

    public int getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(int medicineId) {
        this.medicineId = medicineId;
    }

    public int getPharmacyId() {
        return pharmacyId;
    }

    public void setPharmacyId(int pharmacyId) {
        this.pharmacyId = pharmacyId;
    }

    public String getPharmacyName() {
        return pharmacyName;
    }

    public void setPharmacyName(String pharmacyName) {
        this.pharmacyName = pharmacyName;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getGenericName() {
        return genericName;
    }

    public void setGenericName(String genericName) {
        this.genericName = genericName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public ArrayList<Medicines> getAllMedicines(){
        return getAllMedicines(null, null);
    }

    public ArrayList<Medicines> getAllMedicines(String medicineName, String category){
        ArrayList<Medicines> medicinesDetails = new ArrayList<>();
        
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", "REMOVED_DB_PASSWORD");
            stmt = con.createStatement();
            
            String q = "select m.medicine_id, m.medicine_name, m.price, m.status, p.name"
                    + " from medicines m, pharmacies p"
                    + " WHERE m.pharmacies_id = p.pharmacies_id";
            
            if (medicineName != null && !medicineName.trim().isEmpty()) {
                q += " AND (m.medicine_name LIKE '%" + medicineName.trim() + "%')";
            }
            if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("ALL")) {
                q += " AND (m.category = '" + category.trim() + "')";
            }
            
            rs = stmt.executeQuery(q);
            
            while(rs.next()){
                Medicines m = new Medicines();
                m.setMedicineId(rs.getInt("medicine_id"));
                m.setPharmacyName(rs.getString("name"));
                m.setMedicineName(rs.getString("medicine_name"));
                m.setPrice(rs.getString("price"));
                m.setStatus(rs.getString("status"));
                
                medicinesDetails.add(m);
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
        return medicinesDetails;
    }
    
    public Medicines getMedicineById(int medicineId){
        Medicines m = null;
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", "REMOVED_DB_PASSWORD");
            stmt = con.createStatement();
            
            String q = "select p.name, m.pharmacy_id, m.medicine_name, m.generic_name, "
                    + " m.category, m.description, m.price, m.stock_quantity,"
                    + " m.expiry_date, m.manufacturer, m.status "
                    + " FROM medicines m, pharmacies p"
                    + " WHERE m.medicine_id = '"+medicineId+"'"
                    + " AND m.pharmacy_id = p.pharmacy_id";
            
            rs = stmt.executeQuery(q);
            
            if(rs.next()){
                m = new Medicines();
                m.setMedicineId(medicineId);
                m.setPharmacyName(rs.getString("name")); //pharmacy name
                m.setPharmacyId(rs.getInt("pharmacy_id"));
                m.setMedicineName(rs.getString("medicine_name"));
                m.setGenericName(rs.getString("generic_name"));
                m.setCategory(rs.getString("category"));
                m.setDescription(rs.getString("description"));
                m.setPrice(rs.getString("price"));
                m.setStock_quantity(rs.getInt("stock_quantity"));
                m.setExpiryDate(rs.getString("expiry_date"));
                m.setManufacturer(rs.getString("manufacturer"));
                m.setStatus(rs.getString("status"));
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
        return m;
    }
}

