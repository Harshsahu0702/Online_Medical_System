package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import patient.model.Patient;

@WebServlet("/patient/profile")
public class ProfileController extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        HttpSession ses = req.getSession();
        try{
            String patientId = (String) ses.getAttribute("patientId");
            Patient p = new Patient();
            Patient patient = p.getPatientProfileById(patientId);
            req.setAttribute("patient", patient);
            req.getRequestDispatcher("/patient/profile/profile.jsp").forward(req, res);
        }catch(Exception e){
            System.out.println(e);
            ses.setAttribute("loginError","Error show your data. Please login again");
            res.sendRedirect(req.getContextPath() + "/patient/Login.jsp");  
        }
    }
}
