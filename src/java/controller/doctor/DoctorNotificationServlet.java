package controller.doctor;

import dao.doctor.NotificationDAO;
import model.doctor.Notification;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorNotificationServlet", urlPatterns = {"/DoctorNotificationServlet"})
public class DoctorNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        NotificationDAO notificationDAO = new NotificationDAO();

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("read".equalsIgnoreCase(action) && idStr != null) {
            try {
                int notificationId = Integer.parseInt(idStr);
                notificationDAO.markAsRead(notificationId, userId);
            } catch (NumberFormatException ignored) {}
            response.sendRedirect(request.getContextPath() + "/DoctorNotificationServlet");
            return;
        } else if ("readAll".equalsIgnoreCase(action)) {
            notificationDAO.markAllAsRead(userId);
            response.sendRedirect(request.getContextPath() + "/DoctorNotificationServlet");
            return;
        }

        List<Notification> notifications = notificationDAO.getNotificationsByUserId(userId);
        int unreadCount = notificationDAO.getUnreadCount(userId);

        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);
        request.getRequestDispatcher("/doctor/notifications.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
