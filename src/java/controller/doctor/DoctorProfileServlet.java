package controller.doctor;

import dao.doctor.DoctorDAO;
import model.doctor.Clinic;
import model.doctor.Doctor;
import model.doctor.DoctorDocument;
import model.doctor.Specialization;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DoctorProfileServlet", urlPatterns = {"/DoctorProfileServlet"})
public class DoctorProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");

        try {
            DoctorDAO doctorDAO = new DoctorDAO();
            Doctor doctor = doctorDAO.getDoctorById(doctorId);
            List<Specialization> specializations = doctorDAO.getAllSpecializations();
            List<Clinic> clinics = doctorDAO.getAllClinics();
            List<DoctorDocument> documents = doctorDAO.getDoctorDocuments(doctorId);

            request.setAttribute("doctor", doctor);
            request.setAttribute("specializations", specializations);
            request.setAttribute("clinics", clinics);
            request.setAttribute("documents", documents);

            request.getRequestDispatcher("/doctor/profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load doctor profile.");
        }
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
        int userId = (Integer) session.getAttribute("userId");

        try {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String qualification = request.getParameter("qualification");
            String experienceStr = request.getParameter("experience");
            String specializationIdStr = request.getParameter("specializationId");
            String clinicIdStr = request.getParameter("clinicId");
            String consultationFeeStr = request.getParameter("consultationFee");
            String licenseNumber = request.getParameter("licenseNumber");
            String registrationAuthority = request.getParameter("registrationAuthority");
            String bio = request.getParameter("bio");
            String consultationType = request.getParameter("consultationType");

            Doctor doctor = new Doctor();
            doctor.setDoctorId(doctorId);
            doctor.setUserId(userId);
            doctor.setName(name);
            doctor.setPhone(phone);
            doctor.setQualification(qualification);
            doctor.setExperience(experienceStr != null && !experienceStr.isEmpty() ? Integer.parseInt(experienceStr) : 0);
            doctor.setSpecializationId(specializationIdStr != null && !specializationIdStr.isEmpty() ? Integer.parseInt(specializationIdStr) : 0);
            
            if (clinicIdStr != null && !clinicIdStr.trim().isEmpty() && !clinicIdStr.equals("0")) {
                doctor.setClinicId(Integer.parseInt(clinicIdStr));
            } else {
                doctor.setClinicId(null);
            }

            doctor.setConsultationFee(consultationFeeStr != null && !consultationFeeStr.isEmpty() ? Double.parseDouble(consultationFeeStr) : 0.0);
            doctor.setLicenseNumber(licenseNumber);
            doctor.setRegistrationAuthority(registrationAuthority);
            doctor.setBio(bio);
            doctor.setConsultationType(consultationType);

            DoctorDAO doctorDAO = new DoctorDAO();
            boolean success = doctorDAO.updateDoctorProfile(doctor);

            if (success) {
                session.setAttribute("doctorName", name);
                response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?success=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?error=1");
        }
    }
}
