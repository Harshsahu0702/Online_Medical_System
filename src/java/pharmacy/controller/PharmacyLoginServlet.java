package pharmacy.controller;

import pharmacy.dao.PharmacyDAO;
import pharmacy.model.Pharmacy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PharmacyLoginServlet", urlPatterns = {"/PharmacyLoginServlet", "/pharmacy/login"})
public class PharmacyLoginServlet extends HttpServlet {

    private PharmacyDAO pharmacyDAO;

    @Override
    public void init() {
        pharmacyDAO = new PharmacyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("pharmacyId") != null) {
            response.sendRedirect(request.getContextPath() + "/PharmacyDashboardServlet");
            return;
        }

        request.getRequestDispatcher("/pharmacy/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please enter both pharmacy email and password.");
            request.getRequestDispatcher("/pharmacy/login.jsp").forward(request, response);
            return;
        }

        Pharmacy pharmacy = pharmacyDAO.loginPharmacy(email.trim(), password);

        if (pharmacy != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("pharmacyId", pharmacy.getPharmacyId());
            session.setAttribute("pharmacyUser", pharmacy);
            session.setAttribute("pharmacyName", pharmacy.getPharmacyName());
            session.setAttribute("pharmacyEmail", pharmacy.getEmail());
            session.setAttribute("pharmacyLicense", pharmacy.getLicenseNumber());
            session.setAttribute("role", "PHARMACY");

            response.sendRedirect(request.getContextPath() + "/PharmacyDashboardServlet");
        } else {
            request.setAttribute("errorMessage", "Invalid pharmacy credentials. Please check your email and password.");
            request.setAttribute("enteredEmail", email.trim());
            request.getRequestDispatcher("/pharmacy/login.jsp").forward(request, response);
        }
    }
}

