package controller.doctor;

import dao.doctor.AppointmentDAO;
import dao.doctor.ConsultationDAO;
import dao.doctor.PatientDAO;
import model.doctor.Appointment;
import model.doctor.Consultation;
import model.doctor.Patient;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorConsultationServlet", urlPatterns = {"/DoctorConsultationServlet"})
public class DoctorConsultationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");
        ConsultationDAO consultationDAO = new ConsultationDAO();
        String action = request.getParameter("action");

        if ("start".equalsIgnoreCase(action)) {
            String apptIdStr = request.getParameter("appointmentId");
            if (apptIdStr != null) {
                try {
                    int apptId = Integer.parseInt(apptIdStr);
                    Consultation consultation = consultationDAO.getOrCreateConsultation(apptId);
                    if (consultation != null) {
                        String link = consultation.getMeetingLink();
                        if (link == null || link.trim().isEmpty()) {
                            link = "https://meet.jit.si/OnlineMedicalSystem_Appt_" + apptId;
                        }
                        consultationDAO.startConsultation(consultation.getConsultationId(), link);
                        response.sendRedirect(request.getContextPath() + "/DoctorConsultationServlet?action=meeting&id=" + consultation.getConsultationId());
                        return;
                    }
                } catch (NumberFormatException ignored) {}
            }
            response.sendRedirect(request.getContextPath() + "/DoctorAppointmentServlet");
            return;

        } else if ("meeting".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int consultationId = Integer.parseInt(idStr);
                    Consultation consultation = consultationDAO.getConsultationById(consultationId);
                    if (consultation != null && consultation.getDoctorId() == doctorId) {
                        PatientDAO patientDAO = new PatientDAO();
                        Patient patient = patientDAO.getPatientDetails(consultation.getPatientId());

                        request.setAttribute("consultation", consultation);
                        request.setAttribute("patient", patient);
                        request.getRequestDispatcher("/doctor/online-meeting.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException ignored) {}
            }
            response.sendRedirect(request.getContextPath() + "/DoctorConsultationServlet");
            return;

        } else if ("end".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("id");
            String notes = request.getParameter("notes");
            if (idStr != null) {
                try {
                    int consultationId = Integer.parseInt(idStr);
                    Consultation consultation = consultationDAO.getConsultationById(consultationId);
                    if (consultation != null && consultation.getDoctorId() == doctorId) {
                        consultationDAO.endConsultation(consultationId, notes != null ? notes : consultation.getNotes());
                        // Redirect to prescription creation for this consultation
                        response.sendRedirect(request.getContextPath() + "/DoctorPrescriptionServlet?action=new&consultationId=" + consultationId + "&patientId=" + consultation.getPatientId());
                        return;
                    }
                } catch (NumberFormatException ignored) {}
            }
            response.sendRedirect(request.getContextPath() + "/DoctorConsultationServlet");
            return;
        }

        List<Consultation> consultations = consultationDAO.getConsultationsByDoctor(doctorId);
        request.setAttribute("consultations", consultations);
        request.getRequestDispatcher("/doctor/consultation.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        ConsultationDAO consultationDAO = new ConsultationDAO();

        if ("saveNotes".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("consultationId");
            String notes = request.getParameter("notes");
            if (idStr != null) {
                try {
                    int consultationId = Integer.parseInt(idStr);
                    Consultation c = consultationDAO.getConsultationById(consultationId);
                    if (c != null && c.getDoctorId() == doctorId) {
                        consultationDAO.updateConsultationNotes(consultationId, notes);
                        response.sendRedirect(request.getContextPath() + "/DoctorConsultationServlet?action=meeting&id=" + consultationId + "&saved=1");
                        return;
                    }
                } catch (NumberFormatException ignored) {}
            }
        }

        doGet(request, response);
    }
}
