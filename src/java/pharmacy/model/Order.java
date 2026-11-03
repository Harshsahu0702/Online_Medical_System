package pharmacy.model;

import java.io.Serializable;
import java.sql.Date;

public class Order implements Serializable {

    private int orderId;
    private String patientId;
    private String patientName;
    private int pharmacyId;
    private String pharmacyName;
    private double totalAmount;
    private String address;
    private String status;
    private Date orderDate;

    public Order() {
    }

    public Order(int orderId, String patientId, int pharmacyId, double totalAmount, String address, String status, Date orderDate) {
        this.orderId = orderId;
        this.patientId = patientId;
        this.pharmacyId = pharmacyId;
        this.totalAmount = totalAmount;
        this.address = address;
        this.status = status;
        this.orderDate = orderDate;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = String.valueOf(patientId);
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
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

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // Alias for deliveryAddress
    public String getDeliveryAddress() {
        return address;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.address = deliveryAddress;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Alias for orderStatus
    public String getOrderStatus() {
        return status;
    }

    public void setOrderStatus(String orderStatus) {
        this.status = orderStatus;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}
