package patient.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import patient.model.Orders;

@WebServlet("/patient/orders")
public class OrdersController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession ses = req.getSession();
        String patientId = (String) req.getAttribute("patientId");
        if (patientId == null || patientId.trim().isEmpty()) {
            patientId = (String) ses.getAttribute("patientId");
        }
        if (patientId == null || patientId.trim().isEmpty()) {
            patientId = req.getParameter("patientId");
        }

        String status = req.getParameter("status");

        Orders o = new Orders();
        ArrayList<Orders> orderList = o.getOrdersByPatientId(patientId, status);

        req.setAttribute("orderList", orderList);
        req.getRequestDispatcher("/patient/medicines/orders.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("cancel".equalsIgnoreCase(action)) {
            String orderIdParam = req.getParameter("orderId");
            if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
                int orderId = Integer.parseInt(orderIdParam.trim());
                Orders o = new Orders();
                o.cancelOrder(orderId);
            }
        }
        res.sendRedirect(req.getContextPath() + "/patient/orders");
    }
}
