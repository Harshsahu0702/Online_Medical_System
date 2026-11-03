package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import patient.model.Emergency;

@WebServlet("/patient/emergency-details")
public class EmergencyDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String emergencyIdParam = req.getParameter("emergencyId");
        if (emergencyIdParam != null && !emergencyIdParam.trim().isEmpty()) {
            int emergencyId = Integer.parseInt(emergencyIdParam.trim());
            Emergency em = new Emergency();
            Emergency emergencyDetail = em.getEmergencyById(emergencyId);
            req.setAttribute("emergencyDetail", emergencyDetail);
        }
        req.getRequestDispatcher("/patient/emergency/emergency-details.jsp").forward(req, res);
    }
}
