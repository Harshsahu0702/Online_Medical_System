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
    
    private static final patient.dao.PatientMedicineDAO medicineDAO = new patient.dao.PatientMedicineDAO();

    public ArrayList<Medicines> getAllMedicines() {
        return getAllMedicines(null, null);
    }

    public ArrayList<Medicines> getAllMedicines(String medicineName, String category) {
        ArrayList<Medicines> medicinesDetails = new ArrayList<>();
        java.util.List<java.util.Map<String, Object>> list = medicineDAO.getAllMedicines(medicineName, category);

        for (java.util.Map<String, Object> map : list) {
            Medicines m = new Medicines();
            m.setMedicineId((Integer) map.get("medicineId"));
            m.setPharmacyName((String) map.get("pharmacyName"));
            m.setMedicineName((String) map.get("name"));
            m.setPrice(String.valueOf(map.get("price")));
            m.setStatus((String) map.get("status"));
            medicinesDetails.add(m);
        }
        return medicinesDetails;
    }

    public Medicines getMedicineById(int medicineId) {
        java.util.Map<String, Object> map = medicineDAO.getMedicineDetails(medicineId);
        if (map == null) return null;

        Medicines m = new Medicines();
        m.setMedicineId(medicineId);
        m.setPharmacyName((String) map.get("pharmacyName"));
        m.setPharmacyId((Integer) map.get("pharmacyId"));
        m.setMedicineName((String) map.get("name"));
        m.setGenericName((String) map.get("genericName"));
        m.setCategory((String) map.get("category"));
        m.setDescription((String) map.get("description"));
        m.setPrice(String.valueOf(map.get("price")));
        if (map.get("stockQuantity") != null) {
            m.setStock_quantity((Integer) map.get("stockQuantity"));
        }
        m.setExpiryDate((String) map.get("expiryDate"));
        m.setManufacturer((String) map.get("manufacturer"));
        m.setStatus((String) map.get("status"));
        return m;
    }
}

