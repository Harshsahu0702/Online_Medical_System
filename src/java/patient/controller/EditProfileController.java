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
        HttpSession ses = req.getSession();
        String patientId = (String) ses.getAttribute("patientId");
        String name = (String) req.getParameter("name");
        String email = (String) req.getParameter("email");
        String dob = (String) req.getParameter("dob");
        String gender = (String) req.getParameter("gender");
        String contact = (String) req.getParameter("contact");
        String address = (String) req.getParameter("address");
        String emergencyName = (String) req.getParameter("emergencyName");
        String emergencyRelation = (String) req.getParameter("emergencyRelation");
        String emergencyContact = (String) req.getParameter("emergencyContact");
        
        Patient patient = new Patient();
//        patient.setPatientId(patientId);
        patient.setEmail(email);
        patient.setName(name);
        patient.setDob(dob);
        patient.setGender(gender);
        patient.setContact(contact);
        patient.setAddress(address);
        patient.setEmergencyName(emergencyName);
        patient.setEmergencyRelation(emergencyRelation);
        patient.setEmergencyContact(emergencyContact);
        
        String result = patient.updatePatient(patientId);
        if(result.equals("success")){
            res.sendRedirect(req.getContextPath() + "/patient/profile");
        }else if(result.equals("failure")){
            ses.setAttribute("updateError", "Failed to Update Profile");
            res.sendRedirect(req.getContextPath() + "/patient/profile/edit");
        }else{
            ses.setAttribute("updateError", "Error to Update Profile");
            res.sendRedirect(req.getContextPath() + "/patient/profile/edit");
        }
    }
}
