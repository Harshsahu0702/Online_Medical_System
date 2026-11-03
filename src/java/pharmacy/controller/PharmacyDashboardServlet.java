package pharmacy.controller;

import pharmacy.dao.MedicineDAO;
import pharmacy.dao.OrderDAO;
import pharmacy.dao.PharmacyDAO;
import pharmacy.model.Medicine;
import pharmacy.model.Order;
import pharmacy.model.Pharmacy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PharmacyDashboardServlet", urlPatterns = {"/PharmacyDashboardServlet", "/pharmacy/dashboard"})
public class PharmacyDashboardServlet extends HttpServlet {

    private PharmacyDAO pharmacyDAO;
    private MedicineDAO medicineDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        pharmacyDAO = new PharmacyDAO();
        medicineDAO = new MedicineDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pharmacyId") == null) {
            response.sendRedirect(request.getContextPath() + "/PharmacyLoginServlet");
            return;
        }
        int pharmacyId = (Integer) session.getAttribute("pharmacyId");

        Pharmacy pharmacy = pharmacyDAO.getPharmacyById(pharmacyId);
        List<Medicine> medicines = medicineDAO.getAllMedicines(pharmacyId);
        List<Order> orders = orderDAO.getOrdersByPharmacy(pharmacyId);

        int totalMedicines = medicines.size();
        int lowStockCount = 0;
        int outOfStockCount = 0;
        int expiredCount = 0;

        for (Medicine m : medicines) {
            String status = m.getAvailabilityStatus();
            if ("OUT_OF_STOCK".equals(status)) {
                outOfStockCount++;
            } else if (m.getStock() < 10) {
                lowStockCount++;
            }
            if ("EXPIRED".equals(status)) {
                expiredCount++;
            }
        }

        int totalOrders = orders.size();
        int pendingOrders = 0;
        int acceptedOrders = 0;
        int deliveredOrders = 0;
        double totalRevenue = 0.0;

        for (Order o : orders) {
            String status = o.getStatus() != null ? o.getStatus().toUpperCase() : "PENDING";
            if ("PENDING".equals(status)) {
                pendingOrders++;
            } else if ("ACCEPTED".equals(status) || "PROCESSING".equals(status) || "SHIPPED".equals(status)) {
                acceptedOrders++;
            } else if ("DELIVERED".equals(status)) {
                deliveredOrders++;
                totalRevenue += o.getTotalAmount();
            }
        }

        request.setAttribute("pharmacy", pharmacy);
        request.setAttribute("totalMedicines", totalMedicines);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("outOfStockCount", outOfStockCount);
        request.setAttribute("expiredCount", expiredCount);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("acceptedOrders", acceptedOrders);
        request.setAttribute("deliveredOrders", deliveredOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("recentOrders", orders.size() > 5 ? orders.subList(0, 5) : orders);
        request.setAttribute("medicines", medicines);

        request.getRequestDispatcher("/pharmacy/dashboard.jsp").forward(request, response);
    }
}