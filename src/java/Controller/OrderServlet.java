package Controller;

import dao.OrderDAO;
import model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

if ("details".equals(action)) {

    int orderId =
            Integer.parseInt(request.getParameter("orderId"));

    List<model.OrderItem> items =
            orderDAO.getOrderItems(orderId);

    request.setAttribute("orderItems", items);

    request.setAttribute("orderId", orderId);

    request.getRequestDispatcher("/orderDetails.jsp")
           .forward(request, response);

    return;
}

        // For testing, we are using pharmacy ID 1
        int pharmacyId = 1;

        // Get orders belonging to this pharmacy
        List<Order> orders =
                orderDAO.getOrdersByPharmacy(pharmacyId);

        // Send orders to JSP
        request.setAttribute("orders", orders);

        // Open the orders page
        request.getRequestDispatcher("/order.jsp")
               .forward(request, response);
    }
    
    
    @Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    String action = request.getParameter("action");

    if ("updateStatus".equals(action)) {

        int orderId =
                Integer.parseInt(request.getParameter("orderId"));

        String status =
                request.getParameter("status");

        orderDAO.updateOrderStatus(orderId, status);

        response.sendRedirect("OrderServlet");
    }
}
}