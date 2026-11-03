package admin.controller;

import admin.dao.AdminDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminEmergencyManagementServlet", urlPatterns = {"/admin/emergencies"})
public class AdminEmergencyManagementServlet extends HttpServlet {

    private AdminDAO adminDAO;

    @Override
    public void init() {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        List<Map<String, Object>> emergencies = adminDAO.getAllEmergencies();
        request.setAttribute("emergencies", emergencies);
        request.getRequestDispatcher("/admin/emergencies.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        try {
            int emergencyId = Integer.parseInt(request.getParameter("emergencyId"));
            String status = request.getParameter("status");

            boolean updated = adminDAO.updateEmergencyStatus(emergencyId, status);
            if (updated) {
                session.setAttribute("adminFlash", "Emergency Request #" + emergencyId + " updated to " + status + ".");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/emergencies");
    }
}
