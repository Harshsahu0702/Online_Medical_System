package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import patient.model.BookAppointment;

@WebServlet("/patient/book-slot")
public class BookSlotController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String availabilityId = req.getParameter("availabilityId");
        if (availabilityId == null || availabilityId.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/patient/find-doctor");
            return;
        }

        BookAppointment ba = new BookAppointment();
        BookAppointment slot = ba.getSlotDetailsByAvailabilityId(availabilityId);

        if (slot == null) {
            res.sendRedirect(req.getContextPath() + "/patient/find-doctor");
            return;
        }

        req.setAttribute("slot", slot);
        req.getRequestDispatcher("/patient/appointments/book-slot.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String patientId = (String) session.getAttribute("patientId");

        if (patientId == null || patientId.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/patient/Login.jsp");
            return;
        }
  
        String availabilityId = req.getParameter("availabilityId");
        String doctorIdStr = req.getParameter("doctorId");
        String appointmentDate = req.getParameter("appointmentDate");
        String appointmentTime = req.getParameter("appointmentTime");
        String consultationType = req.getParameter("consultationType");
        String reason = req.getParameter("reason");

        if (doctorIdStr == null || appointmentDate == null || appointmentTime == null) {
            res.sendRedirect(req.getContextPath() + "/patient/book-slot?availabilityId=" + availabilityId + "&error=missing_fields");
            return;
        }

        int doctorId;
        try {
            doctorId = Integer.parseInt(doctorIdStr.trim());
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/patient/find-doctor");
            return;
        }

        BookAppointment ba = new BookAppointment();
        boolean saved = ba.saveAppointment(patientId, doctorId, appointmentDate, appointmentTime, consultationType, reason);

        if (saved) {
            session.setAttribute("appointmentSuccess", "Your appointment has been successfully scheduled!");
            res.sendRedirect(req.getContextPath() + "/patient/appointments");
        } else {
            res.sendRedirect(req.getContextPath() + "/patient/book-slot?availabilityId=" + availabilityId + "&error=save_failed");
        }
    }
}
