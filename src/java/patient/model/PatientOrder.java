package patient.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class PatientOrder implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderId;
    private String patientId;
    private String patientName;
    private int pharmacyId;
    private String pharmacyName;
    private Timestamp orderDate;
    private double totalAmount;
    private String orderStatus;
    private String deliveryAddress;

    public PatientOrder() {}

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public String getPatientId() { return patientId; }
    public void setPatientId(String patientId) { this.patientId = patientId; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public int getPharmacyId() { return pharmacyId; }
    public void setPharmacyId(int pharmacyId) { this.pharmacyId = pharmacyId; }

    public String getPharmacyName() { return pharmacyName; }
    public void setPharmacyName(String pharmacyName) { this.pharmacyName = pharmacyName; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
}
