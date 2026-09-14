package controller.doctor;

import dao.doctor.MedicineDAO;
import dao.doctor.PatientDAO;
import dao.doctor.PrescriptionDAO;
import model.doctor.Medicine;
import model.doctor.Patient;
import model.doctor.Prescription;
import model.doctor.PrescriptionItem;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorPrescriptionServlet", urlPatterns = {"/DoctorPrescriptionServlet"})
public class DoctorPrescriptionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");
        String action = request.getParameter("action");
        PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
        MedicineDAO medicineDAO = new MedicineDAO();
        PatientDAO patientDAO = new PatientDAO();

        if ("new".equalsIgnoreCase(action)) {
            String patientIdStr = request.getParameter("patientId");
            String consultationIdStr = request.getParameter("consultationId");

            List<Medicine> medicines = medicineDAO.getActiveMedicines();
            request.setAttribute("medicines", medicines);

            if (patientIdStr != null && !patientIdStr.isEmpty()) {
                try {
                    int patientId = Integer.parseInt(patientIdStr);
                    Patient patient = patientDAO.getPatientDetails(patientId);
                    request.setAttribute("patient", patient);
                } catch (NumberFormatException ignored) {}
            }

            if (consultationIdStr != null && !consultationIdStr.isEmpty()) {
                request.setAttribute("consultationId", consultationIdStr);
            }

            // Also load list of all patients for dropdown if patient is not preselected
            List<Patient> allPatients = patientDAO.getPatientsByDoctor(doctorId);
            request.setAttribute("allPatients", allPatients);

            request.getRequestDispatcher("/doctor/prescription.jsp").forward(request, response);
            return;

        } else if ("view".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int prescriptionId = Integer.parseInt(idStr);
                    Prescription prescription = prescriptionDAO.getPrescriptionById(prescriptionId);
                    request.setAttribute("prescription", prescription);
                } catch (NumberFormatException ignored) {}
            }
        }

        List<Prescription> prescriptions = prescriptionDAO.getPrescriptionsByDoctor(doctorId);
        request.setAttribute("prescriptions", prescriptions);
        request.getRequestDispatcher("/doctor/prescriptions.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");

        try {
            String consultationIdStr = request.getParameter("consultationId");
            String patientIdStr = request.getParameter("patientId");
            String prescriptionDate = request.getParameter("prescriptionDate");
            String diagnosis = request.getParameter("diagnosis");
            String advice = request.getParameter("advice");

            int patientId = Integer.parseInt(patientIdStr);
            int consultationId = 0;
            if (consultationIdStr != null && !consultationIdStr.trim().isEmpty()) {
                consultationId = Integer.parseInt(consultationIdStr);
            }

            Prescription prescription = new Prescription();
            prescription.setConsultationId(consultationId);
            prescription.setPatientId(patientId);
            prescription.setDoctorId(doctorId);
            prescription.setPrescriptionDate(prescriptionDate);
            prescription.setDiagnosis(diagnosis);
            prescription.setAdvice(advice);

            // Extract items arrays
            String[] medicineIds = request.getParameterValues("medicineId[]");
            String[] dosages = request.getParameterValues("dosage[]");
            String[] frequencies = request.getParameterValues("frequency[]");
            String[] durations = request.getParameterValues("duration[]");
            String[] instructions = request.getParameterValues("instructions[]");

            List<PrescriptionItem> items = new ArrayList<PrescriptionItem>();

            if (medicineIds != null && medicineIds.length > 0) {
                for (int i = 0; i < medicineIds.length; i++) {
                    if (medicineIds[i] != null && !medicineIds[i].trim().isEmpty() && !medicineIds[i].equals("0")) {
                        PrescriptionItem item = new PrescriptionItem();
                        item.setMedicineId(Integer.parseInt(medicineIds[i]));
                        item.setDosage(dosages != null && i < dosages.length ? dosages[i] : "");
                        item.setFrequency(frequencies != null && i < frequencies.length ? frequencies[i] : "");
                        item.setDuration(durations != null && i < durations.length ? durations[i] : "");
                        item.setInstructions(instructions != null && i < instructions.length ? instructions[i] : "");
                        items.add(item);
                    }
                }
            }

            PrescriptionDAO prescriptionDAO = new PrescriptionDAO();
            boolean success = prescriptionDAO.createPrescriptionWithItems(prescription, items);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/DoctorPrescriptionServlet?success=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/DoctorPrescriptionServlet?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/DoctorPrescriptionServlet?error=1");
        }
    }
}
