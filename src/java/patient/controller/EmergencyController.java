package patient.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import patient.model.Emergency;

@WebServlet("/patient/emergency")
public class EmergencyController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession ses = req.getSession();
        String patientId = (String) req.getAttribute("patientId");
        if (patientId == null || patientId.trim().isEmpty()) {
            patientId = (String) ses.getAttribute("patientId");
        }
        if (patientId == null || patientId.trim().isEmpty()) {
            patientId = req.getParameter("patientId");
        }

        String emergencyIdParam = req.getParameter("emergencyId");
        if (emergencyIdParam != null && !emergencyIdParam.trim().isEmpty()) {
            int emergencyId = Integer.parseInt(emergencyIdParam.trim());
            Emergency em = new Emergency();
            Emergency emergencyDetail = em.getEmergencyById(emergencyId);
            req.setAttribute("emergencyDetail", emergencyDetail);
            req.getRequestDispatcher("/patient/emergency/emergency-details.jsp").forward(req, res);
            return;
        }

        Emergency em = new Emergency();
        ArrayList<Emergency> emergencyList = em.getEmergencyRequestsByPatientId(patientId);
        req.setAttribute("emergencyList", emergencyList);
        req.getRequestDispatcher("/patient/emergency/emergency.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession ses = req.getSession();
        String patientId = (String) ses.getAttribute("patientId");
        if (patientId == null || patientId.trim().isEmpty()) {
            patientId = (String) req.getAttribute("patientId");
        }
        if (patientId == null || patientId.trim().isEmpty()) {
            patientId = req.getParameter("patientId");
        }

        String emergencyType = req.getParameter("emergencyType");
        String severity = req.getParameter("severity");
        String contactNumber = req.getParameter("contactNumber");
        String location = req.getParameter("location");
        String description = req.getParameter("description");

        Emergency em = new Emergency();
        em.setPatientId(patientId);
        em.setEmergencyType(emergencyType);
        em.setSeverity(severity);
        em.setContactNumber(contactNumber);
        em.setLocation(location);
        em.setDescription(description);
        em.setStatus("PENDING");

        boolean success = em.createEmergencyRequest(em);
        if (success) {
            ses.setAttribute("emergencySuccess", "Emergency request submitted successfully. Response team has been alerted.");
        } else {
            ses.setAttribute("emergencyError", "Failed to submit emergency request. Please try again or call emergency services.");
        }

        res.sendRedirect(req.getContextPath() + "/patient/emergency");
    }
}
