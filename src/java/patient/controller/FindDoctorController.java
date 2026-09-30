package patient.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

import patient.model.DoctorAvailability;

@WebServlet("/patient/find-doctor")
public class FindDoctorController extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        
        String searchTerm = req.getParameter("searchTerm");
        String specialty  = req.getParameter("specialty");
        String day        = req.getParameter("day");
        
        DoctorAvailability da = new DoctorAvailability();
        ArrayList<DoctorAvailability> list = da.getAvailableDoctors(searchTerm, specialty, day);
        
        req.setAttribute("doctorList", list);
        req.getRequestDispatcher("/patient/doctors/find-doctor.jsp").forward(req, res);
    }
}
