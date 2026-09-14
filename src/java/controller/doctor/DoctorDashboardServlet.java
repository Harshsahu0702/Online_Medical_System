package controller.doctor;

import dao.doctor.AppointmentDAO;
import dao.doctor.DoctorDAO;
import dao.doctor.NotificationDAO;
import model.doctor.Appointment;
import model.doctor.Doctor;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorDashboardServlet", urlPatterns = {"/DoctorDashboardServlet"})
public class DoctorDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");
        int userId = (Integer) session.getAttribute("userId");

        try {
            DoctorDAO doctorDAO = new DoctorDAO();
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            NotificationDAO notificationDAO = new NotificationDAO();

            Doctor doctor = doctorDAO.getDoctorById(doctorId);
            Map<String, Integer> stats = appointmentDAO.getDoctorDashboardStats(doctorId);
            List<Appointment> todayAppointments = appointmentDAO.getTodayAppointments(doctorId);
            int unreadNotifications = notificationDAO.getUnreadCount(userId);

            request.setAttribute("doctor", doctor);
            request.setAttribute("stats", stats);
            request.setAttribute("todayAppointments", todayAppointments);
            request.setAttribute("unreadNotifications", unreadNotifications);

            request.getRequestDispatcher("/doctor/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load doctor dashboard.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
