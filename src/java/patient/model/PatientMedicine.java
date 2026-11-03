package patient.model;

import java.io.Serializable;

public class PatientMedicine implements Serializable {
    private static final long serialVersionUID = 1L;

    private int medicineId;
    private int pharmacyId;
    private String pharmacyName;
    private String name;
    private String genericName;
    private String category;
    private String description;
    private double price;
    private int stockQuantity;
    private String expiryDate;
    private String manufacturer;
    private String status;

    public PatientMedicine() {}

    public int getMedicineId() { return medicineId; }
    public void setMedicineId(int medicineId) { this.medicineId = medicineId; }

    public int getPharmacyId() { return pharmacyId; }
    public void setPharmacyId(int pharmacyId) { this.pharmacyId = pharmacyId; }

    public String getPharmacyName() { return pharmacyName; }
    public void setPharmacyName(String pharmacyName) { this.pharmacyName = pharmacyName; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getGenericName() { return genericName; }
    public void setGenericName(String genericName) { this.genericName = genericName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }

    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
