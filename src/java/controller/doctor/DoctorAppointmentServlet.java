package controller.doctor;

import dao.doctor.AppointmentDAO;
import dao.doctor.PatientDAO;
import model.doctor.Appointment;
import model.doctor.Patient;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorAppointmentServlet", urlPatterns = {"/DoctorAppointmentServlet"})
public class DoctorAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");
        AppointmentDAO appointmentDAO = new AppointmentDAO();

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("accept".equalsIgnoreCase(action) && idStr != null) {
            try {
                int appointmentId = Integer.parseInt(idStr);
                appointmentDAO.updateAppointmentStatus(appointmentId, doctorId, "ACCEPTED");
            } catch (NumberFormatException ignored) {}
            response.sendRedirect(request.getContextPath() + "/DoctorAppointmentServlet?msg=accepted");
            return;
        } else if ("reject".equalsIgnoreCase(action) && idStr != null) {
            try {
                int appointmentId = Integer.parseInt(idStr);
                appointmentDAO.updateAppointmentStatus(appointmentId, doctorId, "REJECTED");
            } catch (NumberFormatException ignored) {}
            response.sendRedirect(request.getContextPath() + "/DoctorAppointmentServlet?msg=rejected");
            return;
        } else if ("view".equalsIgnoreCase(action) && idStr != null) {
            try {
                int appointmentId = Integer.parseInt(idStr);
                Appointment appointment = appointmentDAO.getAppointmentById(appointmentId, doctorId);
                if (appointment != null) {
                    PatientDAO patientDAO = new PatientDAO();
                    Patient patient = patientDAO.getPatientDetails(appointment.getPatientId());
                    request.setAttribute("appointment", appointment);
                    request.setAttribute("patient", patient);
                    request.getRequestDispatcher("/doctor/appointment-details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException ignored) {}
            response.sendRedirect(request.getContextPath() + "/DoctorAppointmentServlet");
            return;
        }

        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "ALL";
        }

        List<Appointment> appointments = appointmentDAO.getAppointmentsByDoctor(doctorId, filter);
        request.setAttribute("appointments", appointments);
        request.setAttribute("currentFilter", filter);

        request.getRequestDispatcher("/doctor/appointments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
