package patient.controller;

//importing codes from doctor modules, for updating the status to cancel
import dao.doctor.AppointmentDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.ArrayList;
import patient.model.PatientAppointments;

@WebServlet("/patient/appointments")
public class AppointmentsController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession ses = req.getSession();
        String patientId = (String) ses.getAttribute("patientId");
        
        PatientAppointments pa = new PatientAppointments();
        ArrayList<PatientAppointments> patientAppointmentList = pa.getAppointments(patientId);
        req.setAttribute("patientAppointmentList", patientAppointmentList);
        req.getRequestDispatcher("/patient/appointments/appointments.jsp").forward(req, res);
    }
    
    //updating the status , using this only for cancel from patient side
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        int appointmentId = Integer.parseInt(req.getParameter("appointmentId").trim());
        int doctorId = Integer.parseInt(req.getParameter("doctorId").trim());
        
        AppointmentDAO cancelAppointment = new AppointmentDAO();
        cancelAppointment.updateAppointmentStatus(appointmentId, doctorId, "CANCELLED");
        
        res.sendRedirect(req.getContextPath() + "/patient/appointments");  
    }
}
