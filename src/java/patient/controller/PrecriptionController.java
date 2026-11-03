package patient.controller;

import patient.model.Prescriptions;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.*;

@WebServlet("/patient/prescriptions")
public class PrecriptionController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        HttpSession ses = req.getSession(false);
        String patientId = null;
        if (ses != null) {
            patientId = (String) ses.getAttribute("patientId");
        }
        if (patientId == null || patientId.trim().isEmpty()) {
            patientId = (String) req.getAttribute("patientId");
        }
        if (patientId == null || patientId.trim().isEmpty()) {
            patientId = req.getParameter("patientId");
        }

        if (patientId == null || patientId.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/patient/Login.jsp");
            return;
        }

        Prescriptions pr = new Prescriptions();
        ArrayList<Prescriptions> prescriptionList = pr.getPrescriptionByPatientId(patientId);
        req.setAttribute("prescriptionList", prescriptionList);
        req.getRequestDispatcher("/patient/prescriptions/prescriptions.jsp").forward(req, res);
    }
}
