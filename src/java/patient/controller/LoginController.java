package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import patient.model.Patient;

@WebServlet("/patient/login")
public class LoginController extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        res.setContentType("text/html");
        
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        Patient patient = new Patient();
        patient.setEmail(email);
        patient.setPassword(password);
        
        try{
            String loginResult = patient.patientLogin();
            
            HttpSession ses = req.getSession();
            
            if(loginResult.equals("success")){
                ses.setAttribute("patientId", patient.getPatientId());
                res.sendRedirect(req.getContextPath() + "/patient/dashboard");
            }else if(loginResult.equals("invalid")){
                ses.setAttribute("loginError", "Email or password are invalid.");
                res.sendRedirect(req.getContextPath() + "/patient/Login.jsp");
            }else if(loginResult.equals("error")){
                ses.setAttribute("loginError", "Unable to Login.");
                res.sendRedirect(req.getContextPath() + "/patient/Login.jsp");
            }
        }catch(Exception e){
            
        }
    }
}
