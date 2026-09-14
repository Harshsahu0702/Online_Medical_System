package controller.doctor;

import dao.doctor.DoctorDAO;
import model.doctor.Doctor;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorLoginServlet", urlPatterns = {"/DoctorLoginServlet"})
public class DoctorLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("doctorId") != null) {
            response.sendRedirect(request.getContextPath() + "/DoctorDashboardServlet");
            return;
        }
        request.getRequestDispatcher("/doctor/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please provide both email and password.");
            request.getRequestDispatcher("/doctor/login.jsp").forward(request, response);
            return;
        }

        DoctorDAO doctorDAO = new DoctorDAO();
        Doctor doctor = doctorDAO.loginDoctor(email.trim(), password);

        if (doctor != null) {
            // Check status
            if ("PENDING".equalsIgnoreCase(doctor.getStatus())) {
                request.setAttribute("errorMessage", "Your account is pending verification by the admin. Please wait for approval.");
                request.getRequestDispatcher("/doctor/login.jsp").forward(request, response);
                return;
            } else if ("REJECTED".equalsIgnoreCase(doctor.getStatus()) || "INACTIVE".equalsIgnoreCase(doctor.getStatus())) {
                request.setAttribute("errorMessage", "Your account is currently inactive or rejected. Please contact support.");
                request.getRequestDispatcher("/doctor/login.jsp").forward(request, response);
                return;
            }

            // Create clean session
            HttpSession session = request.getSession(true);
            session.setAttribute("doctorId", doctor.getDoctorId());
            session.setAttribute("userId", doctor.getUserId());
            session.setAttribute("doctorName", doctor.getName());
            session.setAttribute("doctorEmail", doctor.getEmail());
            session.setAttribute("specializationName", doctor.getSpecializationName());
            session.setAttribute("role", "DOCTOR");

            response.sendRedirect(request.getContextPath() + "/DoctorDashboardServlet");
        } else {
            request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("/doctor/login.jsp").forward(request, response);
        }
    }
}
