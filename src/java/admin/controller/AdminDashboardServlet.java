package admin.controller;

import admin.dao.AdminDAO;
import admin.model.SystemOverview;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/AdminDashboardServlet", "/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

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

        SystemOverview overview = adminDAO.getSystemOverview();
        List<Map<String, Object>> recentDoctors = adminDAO.getAllDoctors();
        List<Map<String, Object>> recentEmergencies = adminDAO.getAllEmergencies();

        request.setAttribute("overview", overview);
        request.setAttribute("recentDoctors", recentDoctors.size() > 5 ? recentDoctors.subList(0, 5) : recentDoctors);
        request.setAttribute("recentEmergencies", recentEmergencies.size() > 5 ? recentEmergencies.subList(0, 5) : recentEmergencies);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
