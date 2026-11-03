package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import patient.model.Patient;

@WebServlet("/patient/profile/edit")
public class EditProfileController extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        HttpSession ses = req.getSession();
        String patientId = (String) ses.getAttribute("patientId");
        
        Patient p = new Patient();
        Patient patient = p.getPatientProfileById(patientId);
        
        req.setAttribute("patient", patient);
        req.getRequestDispatcher("/patient/profile/edit-profile.jsp").forward(req, res);
    }
    
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        req.setCharacterEncoding("UTF-8");
        HttpSession ses = req.getSession();
        String patientId = (String) ses.getAttribute("patientId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String dob = req.getParameter("dob");
        String gender = req.getParameter("gender");
        String contact = req.getParameter("contact");
        String address = req.getParameter("address");
        String bloodGroup = req.getParameter("bloodGroup");
        String emergencyName = req.getParameter("emergencyName");
        String emergencyRelation = req.getParameter("emergencyRelation");
        String emergencyContact = req.getParameter("emergencyContact");
        
        Patient patient = new Patient();
        patient.setPatientId(patientId);
        patient.setEmail(email);
        patient.setName(name);
        patient.setDob(dob);
        patient.setGender(gender);
        patient.setContact(contact);
        patient.setAddress(address);
        patient.setBloodGroup(bloodGroup);
        patient.setEmergencyName(emergencyName);
        patient.setEmergencyRelation(emergencyRelation);
        patient.setEmergencyContact(emergencyContact);
        
        String result = patient.updatePatient(patientId);
        if(result.equals("success")){
            if (name != null && !name.trim().isEmpty()) {
                ses.setAttribute("patientName", name.trim());
            }
            if (email != null && !email.trim().isEmpty()) {
                ses.setAttribute("patientEmail", email.trim());
            }
            res.sendRedirect(req.getContextPath() + "/patient/profile?updated=1");
        }else if(result.equals("failure")){
            ses.setAttribute("updateError", "Failed to Update Profile. Please check the values entered.");
            res.sendRedirect(req.getContextPath() + "/patient/profile/edit");
        }else{
            ses.setAttribute("updateError", "Error updating profile. Please try again.");
            res.sendRedirect(req.getContextPath() + "/patient/profile/edit");
        }
    }
}