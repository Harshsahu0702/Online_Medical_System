package admin.controller;

import admin.dao.AdminDAO;
import admin.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/AdminLoginServlet", "/admin/login"})
public class AdminLoginServlet extends HttpServlet {

    private AdminDAO adminDAO;

    @Override
    public void init() {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminUser") != null) {
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
            return;
        }
        request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Admin admin = adminDAO.authenticate(email, password);

        if (admin != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("adminUser", admin);
            session.setAttribute("adminName", admin.getName());
            session.setAttribute("adminEmail", admin.getEmail());
            session.setAttribute("adminId", admin.getUserId());
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
        } else {
            request.setAttribute("errorMessage", "Invalid administrator credentials. Access restricted.");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }
}
