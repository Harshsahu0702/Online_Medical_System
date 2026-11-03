package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import patient.model.Medicines;

@WebServlet("/patient/medicine-details")
public class MedicineDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int medicineId = Integer.parseInt(req.getParameter("medicineId"));
        Medicines m = new Medicines();
        Medicines medicineDetail = m.getMedicineById(medicineId);
        req.setAttribute("medicineDetail", medicineDetail);
        req.getRequestDispatcher("/patient/medicines/medicine-details.jsp").forward(req, res);
    }
}
