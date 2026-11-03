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

@WebServlet(name = "AdminPatientManagementServlet", urlPatterns = {"/admin/patients"})
public class AdminPatientManagementServlet extends HttpServlet {

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

        List<Map<String, Object>> patients = adminDAO.getAllPatients();
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/admin/patients.jsp").forward(request, response);
    }
}
