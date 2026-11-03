package patient.model;

import java.sql.*;
import java.util.ArrayList;

public class Orders {
    int orderId;
    String patientId;
    String patientName;
    int pharmacyId;
    String pharmacyName;
    String orderDate;
    double totalAmount;
    String orderStatus;
    String deliveryAddress;

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

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    private static final patient.dao.PatientOrderDAO orderDAO = new patient.dao.PatientOrderDAO();

    public ArrayList<Orders> getOrdersByPatientId(String patientId) {
        return getOrdersByPatientId(patientId, null);
    }

    public ArrayList<Orders> getOrdersByPatientId(String patientId, String status) {
        ArrayList<Orders> orderList = new ArrayList<>();
        java.util.List<java.util.Map<String, Object>> list = orderDAO.getOrdersByPatientId(patientId, status);

        for (java.util.Map<String, Object> map : list) {
            Orders o = new Orders();
            o.setOrderId((Integer) map.get("orderId"));
            o.setPatientId((String) map.get("patientId"));
            o.setPharmacyId((Integer) map.get("pharmacyId"));
            o.setPharmacyName((String) map.get("pharmacyName"));
            o.setOrderDate(map.get("orderDate") != null ? map.get("orderDate").toString() : "");
            if (map.get("totalAmount") != null) {
                o.setTotalAmount(((Number) map.get("totalAmount")).doubleValue());
            }
            o.setOrderStatus((String) map.get("orderStatus"));
            o.setDeliveryAddress((String) map.get("deliveryAddress"));
            orderList.add(o);
        }
        return orderList;
    }

    public Orders getOrderById(int orderId) {
        java.util.Map<String, Object> map = orderDAO.getOrderDetails(orderId);
        if (map == null) return null;

        Orders o = new Orders();
        o.setOrderId((Integer) map.get("orderId"));
        o.setPatientId((String) map.get("patientId"));
        o.setPharmacyId((Integer) map.get("pharmacyId"));
        o.setPharmacyName((String) map.get("pharmacyName"));
        o.setOrderDate(map.get("orderDate") != null ? map.get("orderDate").toString() : "");
        if (map.get("totalAmount") != null) {
            o.setTotalAmount(((Number) map.get("totalAmount")).doubleValue());
        }
        o.setOrderStatus((String) map.get("orderStatus"));
        o.setDeliveryAddress((String) map.get("deliveryAddress"));
        return o;
    }

    public boolean cancelOrder(int orderId) {
        return orderDAO.cancelOrder(orderId);
    }
}
