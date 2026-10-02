package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/patient/prescriptions")
public class PrecriptionController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        
        req.getRequestDispatcher("/patient/prescriptions/prescriptions.jsp").forward(req, res);
    }
}
