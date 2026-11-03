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

@WebServlet(name = "AdminDoctorManagementServlet", urlPatterns = {"/admin/doctors"})
public class AdminDoctorManagementServlet extends HttpServlet {

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

        List<Map<String, Object>> doctors = adminDAO.getAllDoctors();
        request.setAttribute("doctors", doctors);
        request.getRequestDispatcher("/admin/doctors.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            int doctorId = Integer.parseInt(request.getParameter("doctorId"));

            if ("approve".equals(action)) {
                adminDAO.updateDoctorStatus(doctorId, "APPROVED", "ACTIVE");
                session.setAttribute("adminFlash", "Doctor #" + doctorId + " has been officially verified and approved.");
            } else if ("reject".equals(action)) {
                adminDAO.updateDoctorStatus(doctorId, "REJECTED", "SUSPENDED");
                session.setAttribute("adminFlash", "Doctor #" + doctorId + " verification was rejected.");
            } else if ("toggleStatus".equals(action)) {
                String newStatus = request.getParameter("newStatus");
                adminDAO.updateDoctorStatus(doctorId, "APPROVED", newStatus);
                session.setAttribute("adminFlash", "Doctor #" + doctorId + " status updated to " + newStatus + ".");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/doctors");
    }
}
