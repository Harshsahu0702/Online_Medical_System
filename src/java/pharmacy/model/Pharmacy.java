package pharmacy.model;

import java.io.Serializable;

public class Pharmacy implements Serializable {

    private int pharmacyId;
    private String pharmacyName;
    private String email;
    private String phone;
    private String address;
    private String licenseNumber;

    public Pharmacy() {
    }

    public Pharmacy(int pharmacyId, String pharmacyName, String email, String phone, String address, String licenseNumber) {
        this.pharmacyId = pharmacyId;
        this.pharmacyName = pharmacyName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.licenseNumber = licenseNumber;
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

    // Alias for patient module compatibility
    public String getName() {
        return pharmacyName;
    }

    public void setName(String name) {
        this.pharmacyName = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
}
