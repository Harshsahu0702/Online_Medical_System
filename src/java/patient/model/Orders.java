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

    public ArrayList<Orders> getOrdersByPatientId(String patientId) {
        return getOrdersByPatientId(patientId, null);
    }

    public ArrayList<Orders> getOrdersByPatientId(String patientId, String status) {
        ArrayList<Orders> orderList = new ArrayList<>();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", System.getenv("DB_PASSWORD"));
            stmt = con.createStatement();

            String q = "SELECT o.order_id, o.patient_id, o.pharmacy_id, o.order_date, o.total_amount, o.order_status, o.delivery_address, p.name AS pharmacy_name, pat.name AS patient_name "
                     + " FROM orders o, pharmacies p, patients pat "
                     + " WHERE o.patient_id = '" + patientId + "' "
                     + " AND o.pharmacy_id = p.pharmacy_id "
                     + " AND o.patient_id = pat.patient_id";

            if (status != null && !status.trim().isEmpty() && !status.equalsIgnoreCase("ALL")) {
                q += " AND o.order_status = '" + status.trim() + "'";
            }

            q += " ORDER BY o.order_date DESC, o.order_id DESC";

            rs = stmt.executeQuery(q);
            while (rs.next()) {
                Orders o = new Orders();
                o.setOrderId(rs.getInt("order_id"));
                o.setPatientId(rs.getString("patient_id"));
                o.setPatientName(rs.getString("patient_name"));
                o.setPharmacyId(rs.getInt("pharmacy_id"));
                o.setPharmacyName(rs.getString("pharmacy_name"));
                o.setOrderDate(rs.getString("order_date"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setDeliveryAddress(rs.getString("delivery_address"));
                orderList.add(o);
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
        return orderList;
    }

    public Orders getOrderById(int orderId) {
        Orders o = null;
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", System.getenv("DB_PASSWORD"));
            stmt = con.createStatement();

            String q = "SELECT o.order_id, o.patient_id, o.pharmacy_id, o.order_date, o.total_amount, o.order_status, o.delivery_address, p.name AS pharmacy_name, pat.name AS patient_name "
                     + " FROM orders o, pharmacies p, patients pat "
                     + " WHERE o.order_id = " + orderId + " "
                     + " AND o.pharmacy_id = p.pharmacy_id "
                     + " AND o.patient_id = pat.patient_id";

            rs = stmt.executeQuery(q);
            if (rs.next()) {
                o = new Orders();
                o.setOrderId(rs.getInt("order_id"));
                o.setPatientId(rs.getString("patient_id"));
                o.setPatientName(rs.getString("patient_name"));
                o.setPharmacyId(rs.getInt("pharmacy_id"));
                o.setPharmacyName(rs.getString("pharmacy_name"));
                o.setOrderDate(rs.getString("order_date"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setDeliveryAddress(rs.getString("delivery_address"));
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
        return o;
    }

    public boolean cancelOrder(int orderId) {
        Connection con = null;
        Statement stmt = null;
        boolean result = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://mysql-e62eab-medicalsystem2026.d.aivencloud.com:26696/online_medical_db", "avnadmin", System.getenv("DB_PASSWORD"));
            stmt = con.createStatement();

            String q = "UPDATE orders SET order_status = 'CANCELLED' WHERE order_id = " + orderId;
            int rows = stmt.executeUpdate(q);
            if (rows > 0) {
                result = true;
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return result;
    }
}
