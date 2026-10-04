package Controller;

import dao.MedicineDAO;
import model.Medicine;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/MedicineServlet")
public class MedicineServlet extends HttpServlet {

    private MedicineDAO medicineDAO;

    @Override
    public void init() {
        medicineDAO = new MedicineDAO();
    }

    // SHOW ALL MEDICINES
   @Override
protected void doGet(HttpServletRequest request,
                     HttpServletResponse response)
        throws ServletException, IOException {

    int pharmacyId = 1;

    String action = request.getParameter("action");
    
    // UPDATE STOCK
if ("updateStock".equals(action)) {

    int medicineId =
            Integer.parseInt(request.getParameter("medicineId"));

    int stock =
            Integer.parseInt(request.getParameter("stock"));

    medicineDAO.updateStock(medicineId, stock);

    response.sendRedirect("MedicineServlet");

    return;
}


    if ("delete".equals(action)) {

    int medicineId =
            Integer.parseInt(request.getParameter("id"));

    medicineDAO.deleteMedicine(medicineId);

    response.sendRedirect("MedicineServlet");

    return;
}

    // If user clicked Edit
    if ("edit".equals(action)) {

        int medicineId =
                Integer.parseInt(request.getParameter("id"));

        Medicine medicine =
                medicineDAO.getMedicineById(medicineId);

        request.setAttribute("medicine", medicine);

        request.getRequestDispatcher("/editMedicine.jsp")
               .forward(request, response);

        return;
    }
    
    // VIEW MEDICINE DETAILS
if ("view".equals(action)) {

    int medicineId =
            Integer.parseInt(request.getParameter("id"));

    Medicine medicine =
            medicineDAO.getMedicineById(medicineId);

    request.setAttribute("selectedMedicine", medicine);

    request.getRequestDispatcher("/medicineDetails.jsp")
           .forward(request, response);

    return;
}
// SEARCH SUGGESTIONS
if ("suggest".equals(action)) {

    String keyword = request.getParameter("keyword");

    List<Medicine> medicines =
            medicineDAO.searchMedicines(pharmacyId, keyword);

    response.setContentType("text/html");

    for (Medicine medicine : medicines) {

        response.getWriter().println(
            "<div class='suggestion' " +
            "onclick=\"selectMedicine(" +
            medicine.getMedicineId() + ")\">" +
            medicine.getMedicineName() +
            "</div>"
        );
    }

    return;
}
    

    // Otherwise, show all medicines
    List<Medicine> medicines =
            medicineDAO.getAllMedicines(pharmacyId);

    request.setAttribute("medicines", medicines);

    request.getRequestDispatcher("/medicines.jsp")
           .forward(request, response);
}

    // ADD MEDICINE
@Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    int pharmacyId = 1;

    String action = request.getParameter("action");


    // =========================
    // UPDATE STOCK
    // =========================

    if ("updateStock".equals(action)) {

        int medicineId =
                Integer.parseInt(
                        request.getParameter("medicineId")
                );

        int stock =
                Integer.parseInt(
                        request.getParameter("stock")
                );

        medicineDAO.updateStock(medicineId, stock);

        response.sendRedirect("MedicineServlet");

        return;
    }


    // =========================
    // UPDATE MEDICINE
    // =========================

    if ("update".equals(action)) {

        int medicineId =
                Integer.parseInt(
                        request.getParameter("medicineId")
                );

        String medicineName =
                request.getParameter("medicineName");

        String genericName =
                request.getParameter("genericName");

        String category =
                request.getParameter("category");

        double price =
                Double.parseDouble(
                        request.getParameter("price")
                );

        int stock =
                Integer.parseInt(
                        request.getParameter("stock")
                );

        Date expiryDate =
                Date.valueOf(
                        request.getParameter("expiryDate")
                );

        String manufacturer =
                request.getParameter("manufacturer");

        String status =
                request.getParameter("status");


        Medicine medicine = new Medicine();

        medicine.setMedicineId(medicineId);
        medicine.setPharmacyId(pharmacyId);
        medicine.setMedicineName(medicineName);
        medicine.setGenericName(genericName);
        medicine.setCategory(category);
        medicine.setPrice(price);
        medicine.setStock(stock);
        medicine.setExpiryDate(expiryDate);
        medicine.setManufacturer(manufacturer);
        medicine.setStatus(status);


        medicineDAO.updateMedicine(medicine);

        response.sendRedirect("MedicineServlet");

        return;
    }


    // =========================
    // ADD MEDICINE
    // =========================

    String medicineName =
            request.getParameter("medicineName");

    String genericName =
            request.getParameter("genericName");

    String category =
            request.getParameter("category");

    double price =
            Double.parseDouble(
                    request.getParameter("price")
            );

    int stock =
            Integer.parseInt(
                    request.getParameter("stock")
            );

    Date expiryDate =
            Date.valueOf(
                    request.getParameter("expiryDate")
            );

    String manufacturer =
            request.getParameter("manufacturer");

    String status =
            request.getParameter("status");


    Medicine medicine = new Medicine();

    medicine.setPharmacyId(pharmacyId);
    medicine.setMedicineName(medicineName);
    medicine.setGenericName(genericName);
    medicine.setCategory(category);
    medicine.setPrice(price);
    medicine.setStock(stock);
    medicine.setExpiryDate(expiryDate);
    medicine.setManufacturer(manufacturer);
    medicine.setStatus(status);


    medicineDAO.addMedicine(medicine);

    response.sendRedirect("MedicineServlet");
}

}