package doctor.controller;

import doctor.dao.PatientDAO;
import doctor.dao.PrescriptionDAO;
import doctor.model.Patient;
import doctor.model.Prescription;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorPatientServlet", urlPatterns = {"/DoctorPatientServlet"})
public class DoctorPatientServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");
        PatientDAO patientDAO = new PatientDAO();

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("view".equalsIgnoreCase(action) && idStr != null && !idStr.trim().isEmpty()) {
            Patient patient = patientDAO.getPatientDetails(idStr);
            if (patient != null) {
                PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
                List<Prescription> pastPrescriptions = prescriptionDAO.getPrescriptionsByPatient(idStr);

                request.setAttribute("patient", patient);
                request.setAttribute("pastPrescriptions", pastPrescriptions);
                request.getRequestDispatcher("/doctor/patient-details.jsp").forward(request, response);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/DoctorPatientServlet");
            return;
        }

        List<Patient> patients = patientDAO.getPatientsByDoctor(doctorId);
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/doctor/patients.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
