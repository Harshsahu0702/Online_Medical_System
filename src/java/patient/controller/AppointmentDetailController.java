package patient.controller;

import patient.model.PatientAppointments;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/patient/appointment-details")
public class AppointmentDetailController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        String idParam = req.getParameter("appointmentId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            int appointmentId = Integer.parseInt(idParam.trim());
            PatientAppointments pa = new PatientAppointments();
            PatientAppointments AppointmentDetails = pa.getAppointmentByAppId(appointmentId);
            req.setAttribute("AppointmentDetails", AppointmentDetails);
        }
        
        req.getRequestDispatcher("/patient/appointments/appointment-details.jsp").forward(req, res);
    }
}
