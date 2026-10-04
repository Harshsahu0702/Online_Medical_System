package model;

import java.sql.Date;

public class Medicine {

    private int medicineId;
    private int pharmacyId;
    private String medicineName;
    private String genericName;
    private String category;
    private double price;
    private int stock;
    private Date expiryDate;
    private String manufacturer;
    private String status;

    // Constructor
    public Medicine() {
    }

    // Getters and Setters

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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
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
    
    public String getAvailabilityStatus() {

    if (expiryDate != null &&
        expiryDate.before(new java.sql.Date(System.currentTimeMillis()))) {

        return "EXPIRED";
    }

    if (stock <= 0) {
        return "OUT_OF_STOCK";
    }

    return "AVAILABLE";
}
}