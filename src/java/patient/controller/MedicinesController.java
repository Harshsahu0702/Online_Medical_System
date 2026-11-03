package patient.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import patient.model.Medicines;

@WebServlet("/patient/medicines")
public class MedicinesController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String medicineName = req.getParameter("medicineName");
        String category = req.getParameter("category");

        Medicines m = new Medicines();
        ArrayList<Medicines> medicineList = m.getAllMedicines(medicineName, category);

        req.setAttribute("medicineList", medicineList);
        req.getRequestDispatcher("/patient/medicines/medicines.jsp").forward(req, res);
    }
}
