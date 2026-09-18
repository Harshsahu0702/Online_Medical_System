package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import patient.model.Patient;

@WebServlet("/patient/dashboard")
public class DashboardController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException {

        HttpSession session = req.getSession();

        String patientId = (String) session.getAttribute("patientId");

        Patient p = new Patient();

        Patient patient = p.getPatientById(patientId);

        req.setAttribute("patient", patient);

        req.getRequestDispatcher("/patient/dashboard.jsp").forward(req, res);
    }
}
