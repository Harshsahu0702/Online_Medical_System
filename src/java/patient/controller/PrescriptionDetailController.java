package patient.controller;

import patient.model.Prescriptions;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import java.util.*;

@WebServlet("/patient/prescription-detail")
public class PrescriptionDetailController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        int prescriptionId = Integer.parseInt(req.getParameter("prescriptionId"));
        Prescriptions p = new Prescriptions();
        Prescriptions prescriptionDetail = p.getPrescriptionByPrescriptionId(prescriptionId);
        req.setAttribute("prescriptionDetail", prescriptionDetail);
        req.getRequestDispatcher("/patient/prescriptions/prescription-details.jsp").forward(req, res);
    }
}
