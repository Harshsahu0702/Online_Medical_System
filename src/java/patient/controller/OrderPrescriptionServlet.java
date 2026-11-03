package patient.controller;

import patient.dao.PatientPrescriptionDAO;
import util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

@WebServlet(name = "OrderPrescriptionServlet", urlPatterns = {"/patient/order-prescription"})
public class OrderPrescriptionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        String patientId = null;
        if (session != null) {
            patientId = (String) session.getAttribute("patientId");
        }
        if (patientId == null || patientId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/patient/Login.jsp");
            return;
        }

        String rxIdStr = request.getParameter("prescriptionId");
        String pharmacyIdStr = request.getParameter("pharmacyId");
        String deliveryAddress = request.getParameter("deliveryAddress");

        int pharmacyId = 1;
        if (pharmacyIdStr != null && !pharmacyIdStr.trim().isEmpty()) {
            try {
                pharmacyId = Integer.parseInt(pharmacyIdStr.trim());
            } catch (NumberFormatException ignored) {}
        }

        if (rxIdStr == null || rxIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/patient/prescriptions");
            return;
        }

        try {
            int prescriptionId = Integer.parseInt(rxIdStr.trim());
            PatientPrescriptionDAO rxDAO = new PatientPrescriptionDAO();
            Map<String, Object> rxDetails = rxDAO.getPrescriptionDetails(prescriptionId);

            if (rxDetails == null) {
                response.sendRedirect(request.getContextPath() + "/patient/prescriptions?error=notfound");
                return;
            }

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> items = (List<Map<String, Object>>) rxDetails.get("items");

            if (items == null || items.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/patient/prescription-detail?prescriptionId=" + prescriptionId + "&error=noitems");
                return;
            }

            // Calculate total price and prepare items
            double totalAmount = 0.0;
            try (Connection con = DBConnection.getConnection()) {
                con.setAutoCommit(false);

                // First find prices for items or default to 50.0
                for (Map<String, Object> it : items) {
                    int medId = (Integer) it.get("medicineId");
                    double price = 50.0;
                    if (medId > 0) {
                        try (PreparedStatement pPrice = con.prepareStatement("SELECT price FROM medicines WHERE medicine_id = ?")) {
                            pPrice.setInt(1, medId);
                            try (ResultSet rsPrice = pPrice.executeQuery()) {
                                if (rsPrice.next()) {
                                    price = rsPrice.getDouble("price");
                                }
                            }
                        }
                    }
                    it.put("unitPrice", price);
                    int qty = 1;
                    totalAmount += (price * qty);
                }

                // Insert into orders
                String insertOrderSql = "INSERT INTO orders (patient_id, pharmacy_id, total_amount, order_status, delivery_address, order_date) "
                                      + "VALUES (?, ?, ?, 'PENDING', ?, NOW())";
                int newOrderId = 0;
                try (PreparedStatement psOrder = con.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                    psOrder.setString(1, patientId);
                    psOrder.setInt(2, pharmacyId);
                    psOrder.setDouble(3, totalAmount);
                    psOrder.setString(4, deliveryAddress != null && !deliveryAddress.trim().isEmpty() ? deliveryAddress.trim() : "Patient Registered Address");
                    psOrder.executeUpdate();

                    try (ResultSet gk = psOrder.getGeneratedKeys()) {
                        if (gk.next()) {
                            newOrderId = gk.getInt(1);
                        }
                    }
                }

                if (newOrderId > 0) {
                    String insertItemSql = "INSERT INTO order_items (order_id, medicine_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement psItem = con.prepareStatement(insertItemSql)) {
                        for (Map<String, Object> it : items) {
                            int medId = (Integer) it.get("medicineId");
                            double price = (Double) it.get("unitPrice");
                            int qty = 1;
                            psItem.setInt(1, newOrderId);
                            psItem.setInt(2, medId > 0 ? medId : 1);
                            psItem.setInt(3, qty);
                            psItem.setDouble(4, price);
                            psItem.setDouble(5, price * qty);
                            psItem.addBatch();
                        }
                        psItem.executeBatch();
                    }

                    con.commit();
                    response.sendRedirect(request.getContextPath() + "/patient/orders?msg=ordered");
                    return;
                } else {
                    con.rollback();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/patient/orders?error=1");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/patient/prescriptions");
    }
}