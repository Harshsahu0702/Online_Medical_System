package pharmacy.model;

import java.io.Serializable;
import java.sql.Date;

public class Medicine implements Serializable {

    private int medicineId;
    private int pharmacyId;
    private String medicineName;
    private String genericName;
    private String category;
    private String description;
    private double price;
    private int stock;
    private Date expiryDate;
    private String manufacturer;
    private String status;

    public Medicine() {
    }

    public Medicine(int medicineId, int pharmacyId, String medicineName, String genericName,
                    String category, String description, double price, int stock,
                    Date expiryDate, String manufacturer, String status) {
        this.medicineId = medicineId;
        this.pharmacyId = pharmacyId;
        this.medicineName = medicineName;
        this.genericName = genericName;
        this.category = category;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.expiryDate = expiryDate;
        this.manufacturer = manufacturer;
        this.status = status;
    }

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    // Compatibility alias for Doctor/Patient modules
    public int getStockQuantity() {
        return stock;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stock = stockQuantity;
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

    /**
     * Calculates dynamic availability status based on stock and expiration date.
     */
    public String getAvailabilityStatus() {
        if (expiryDate != null && expiryDate.before(new Date(System.currentTimeMillis()))) {
            return "EXPIRED";
        }
        if (stock <= 0) {
            return "OUT_OF_STOCK";
        }
        if ("UNAVAILABLE".equalsIgnoreCase(status)) {
            return "UNAVAILABLE";
        }
        return "AVAILABLE";
    }
}
