package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import patient.model.Doctor;

@WebServlet("/patient/doctor-details")
public class DoctorDetailsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String docIdParam = req.getParameter("doctorId");
        if (docIdParam != null && !docIdParam.trim().isEmpty()) {
            int doctorId = Integer.parseInt(docIdParam.trim());
            Doctor docModel = new Doctor();
            Doctor doctor = docModel.getDoctorById(doctorId);
            req.setAttribute("doctor", doctor);
        }
        req.getRequestDispatcher("/patient/doctors/doctor-details.jsp").forward(req, res);
    }
}
