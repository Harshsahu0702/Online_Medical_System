package controller.doctor;

import dao.doctor.DoctorAvailabilityDAO;
import model.doctor.DoctorAvailability;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorAvailabilityServlet", urlPatterns = {"/DoctorAvailabilityServlet"})
public class DoctorAvailabilityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");
        DoctorAvailabilityDAO dao = new DoctorAvailabilityDAO();

        String action = request.getParameter("action");
        if ("delete".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    dao.deleteAvailability(id, doctorId);
                } catch (NumberFormatException ignored) {}
            }
            response.sendRedirect(request.getContextPath() + "/DoctorAvailabilityServlet");
            return;
        } else if ("toggle".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("id");
            String statusStr = request.getParameter("status");
            if (idStr != null && statusStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    boolean isAvailable = Boolean.parseBoolean(statusStr);
                    dao.toggleAvailability(id, doctorId, isAvailable);
                } catch (Exception ignored) {}
            }
            response.sendRedirect(request.getContextPath() + "/DoctorAvailabilityServlet");
            return;
        }

        List<DoctorAvailability> availabilities = dao.getAvailabilityByDoctor(doctorId);
        request.setAttribute("availabilities", availabilities);
        request.getRequestDispatcher("/doctor/availability.jsp").forward(request, response);
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

        String dayOfWeek = request.getParameter("dayOfWeek");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String consultationType = request.getParameter("consultationType");
        boolean isAvailable = "true".equalsIgnoreCase(request.getParameter("isAvailable")) || "1".equals(request.getParameter("isAvailable")) || request.getParameter("isAvailable") == null;

        if (dayOfWeek != null && startTime != null && endTime != null) {
            DoctorAvailability da = new DoctorAvailability();
            da.setDoctorId(doctorId);
            da.setDayOfWeek(dayOfWeek);
            da.setStartTime(startTime);
            da.setEndTime(endTime);
            da.setConsultationType(consultationType != null ? consultationType : "Online");
            da.setIsAvailable(isAvailable);

            DoctorAvailabilityDAO dao = new DoctorAvailabilityDAO();
            dao.addAvailability(da);
        }

        response.sendRedirect(request.getContextPath() + "/DoctorAvailabilityServlet?success=1");
    }
}
