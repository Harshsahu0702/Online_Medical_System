package pharmacy.controller;

import pharmacy.dao.OrderDAO;
import pharmacy.model.Order;
import pharmacy.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = {"/OrderServlet", "/pharmacy/orders"})
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    private int getPharmacyId(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("pharmacyId");
        return (id != null && id > 0) ? id : 1;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // 1. ORDER DETAILS
        if ("details".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                List<OrderItem> items = orderDAO.getOrderItems(orderId);
                Order order = orderDAO.getOrderById(orderId);

                request.setAttribute("order", order);
                request.setAttribute("orderItems", items);
                request.setAttribute("orderId", orderId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("/pharmacy/orderDetails.jsp").forward(request, response);
            return;
        }

        // 2. LIST ORDERS
        int pharmacyId = getPharmacyId(request);
        List<Order> orders = orderDAO.getOrdersByPharmacy(pharmacyId);
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/pharmacy/order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String status = request.getParameter("status");

                boolean success = orderDAO.updateOrderStatus(orderId, status);
                HttpSession session = request.getSession();
                if (success) {
                    session.setAttribute("orderMessage", "Order #" + orderId + " updated to " + status + " successfully.");
                    session.setAttribute("orderMessageType", "success");
                } else {
                    session.setAttribute("orderMessage", "Could not transition order #" + orderId + " to " + status + ". Please check status transition rules and stock availability.");
                    session.setAttribute("orderMessageType", "danger");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/OrderServlet");
    }
}
