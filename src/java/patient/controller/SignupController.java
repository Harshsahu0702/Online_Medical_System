package patient.controller;

import patient.model.Patient;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.*;
import javax.servlet.http.*;

@WebServlet("/patient/signup")
public class SignupController extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        res.setContentType("text/html");
        
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String gender = req.getParameter("gender");
        String address = req.getParameter("address");
        String contact = req.getParameter("phone");
        String dob = req.getParameter("dob");
        String bloodGroup = req.getParameter("bloodgroup");
        
//        System.out.println(email);
//        System.out.println(password);
//        System.out.println(name);
//        System.out.println(gender);
//        System.out.println(address);
//        System.out.println(contact);
//        System.out.println(dob);
//        System.out.println(bloodGroup);

        Patient patient = new Patient();
        patient.setEmail(email);
        patient.setPassword(password);
        patient.setName(name);
        patient.setGender(gender);
        patient.setAddress(address);
        patient.setContact(contact);
        patient.setDob(dob);
        patient.setBloodGroup(bloodGroup);
        
        try{
            String signupResult = patient.patientSignup();
            //using session to store patientid
            HttpSession ses = req.getSession();
            
            if(signupResult == "success"){
                ses.setAttribute("patientId", patient.getPatientId());
                ses.setAttribute("loginError", "Account has created. Please Login");
                res.sendRedirect(req.getContextPath() + "/patient/Login.jsp");
            }else if(signupResult == "email_exists"){
                ses.setAttribute("signupError", "Email already exists. Please use another email");
                res.sendRedirect(req.getContextPath() + "/patient/Signup.jsp");
            }else{
                ses.setAttribute("singupError", "Unable to create your account. Please try again");
                res.sendRedirect(req.getContextPath() + "/patient/Signup.jsp");
            }
        }catch(Exception e){
            System.out.println(e);
        }
    }
}
