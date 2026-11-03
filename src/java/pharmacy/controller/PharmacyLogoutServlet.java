package pharmacy.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PharmacyLogoutServlet", urlPatterns = {"/PharmacyLogoutServlet", "/pharmacy/logout"})
public class PharmacyLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("pharmacyId");
            session.removeAttribute("pharmacyUser");
            session.removeAttribute("pharmacyName");
            session.removeAttribute("pharmacyEmail");
            session.removeAttribute("pharmacyLicense");
            // If only pharmacy was logged in, invalidate session
            session.invalidate();
        }

        response.sendRedirect(request.getContextPath() + "/MainLogin.jsp?role=pharmacy");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

