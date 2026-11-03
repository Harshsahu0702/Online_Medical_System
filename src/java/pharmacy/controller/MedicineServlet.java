package pharmacy.controller;

import pharmacy.dao.MedicineDAO;
import pharmacy.model.Medicine;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "MedicineServlet", urlPatterns = {"/MedicineServlet", "/pharmacy/medicines"})
public class MedicineServlet extends HttpServlet {

    private MedicineDAO medicineDAO;

    @Override
    public void init() {
        medicineDAO = new MedicineDAO();
    }

    private int getPharmacyId(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("pharmacyId");
        return (id != null && id > 0) ? id : 1;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int pharmacyId = getPharmacyId(request);
        String action = request.getParameter("action");

        // 1. UPDATE STOCK VIA GET
        if ("updateStock".equals(action)) {
            try {
                int medicineId = Integer.parseInt(request.getParameter("medicineId"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                medicineDAO.updateStock(medicineId, stock);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/MedicineServlet");
            return;
        }

        // 2. DELETE MEDICINE
        if ("delete".equals(action)) {
            try {
                int medicineId = Integer.parseInt(request.getParameter("id"));
                medicineDAO.deleteMedicine(medicineId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/MedicineServlet");
            return;
        }

        // 3. EDIT MEDICINE
        if ("edit".equals(action)) {
            try {
                int medicineId = Integer.parseInt(request.getParameter("id"));
                Medicine medicine = medicineDAO.getMedicineById(medicineId);
                request.setAttribute("medicine", medicine);
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("/pharmacy/editMedicine.jsp").forward(request, response);
            return;
        }

        // 4. VIEW MEDICINE DETAILS
        if ("view".equals(action)) {
            try {
                int medicineId = Integer.parseInt(request.getParameter("id"));
                Medicine medicine = medicineDAO.getMedicineById(medicineId);
                request.setAttribute("selectedMedicine", medicine);
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("/pharmacy/medicineDetails.jsp").forward(request, response);
            return;
        }

        // 5. LIVE SEARCH SUGGESTIONS (AJAX)
        if ("suggest".equals(action)) {
            String keyword = request.getParameter("keyword");
            List<Medicine> medicines = medicineDAO.searchMedicines(pharmacyId, keyword);

            response.setContentType("text/html;charset=UTF-8");
            StringBuilder sb = new StringBuilder();
            if (medicines.isEmpty()) {
                sb.append("<div class='suggestion empty-suggestion'>No matching medicines found</div>");
            } else {
                for (Medicine medicine : medicines) {
                    sb.append("<div class='suggestion' onclick=\"selectMedicine(")
                      .append(medicine.getMedicineId())
                      .append(")\">")
                      .append("<div class='sugg-name'>").append(escapeHtml(medicine.getMedicineName())).append("</div>")
                      .append("<div class='sugg-meta'>").append(escapeHtml(medicine.getGenericName())).append(" &bull; &#8377;").append(medicine.getPrice()).append("</div>")
                      .append("</div>");
                }
            }
            response.getWriter().write(sb.toString());
            return;
        }

        // 6. DEFAULT: LIST ALL MEDICINES
        List<Medicine> medicines = medicineDAO.getAllMedicines(pharmacyId);
        request.setAttribute("medicines", medicines);
        request.getRequestDispatcher("/pharmacy/medicines.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int pharmacyId = getPharmacyId(request);
        String action = request.getParameter("action");

        // 1. UPDATE STOCK
        if ("updateStock".equals(action)) {
            try {
                int medicineId = Integer.parseInt(request.getParameter("medicineId"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                medicineDAO.updateStock(medicineId, stock);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/MedicineServlet");
            return;
        }

        // 2. UPDATE MEDICINE
        if ("update".equals(action)) {
            try {
                int medicineId = Integer.parseInt(request.getParameter("medicineId"));
                String medicineName = request.getParameter("medicineName");
                String genericName = request.getParameter("genericName");
                String category = request.getParameter("category");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                Date expiryDate = Date.valueOf(request.getParameter("expiryDate"));
                String manufacturer = request.getParameter("manufacturer");
                String status = request.getParameter("status");

                Medicine medicine = new Medicine();
                medicine.setMedicineId(medicineId);
                medicine.setPharmacyId(pharmacyId);
                medicine.setMedicineName(medicineName);
                medicine.setGenericName(genericName);
                medicine.setCategory(category);
                medicine.setDescription(description != null ? description : "");
                medicine.setPrice(price);
                medicine.setStock(stock);
                medicine.setExpiryDate(expiryDate);
                medicine.setManufacturer(manufacturer);
                medicine.setStatus(status);

                medicineDAO.updateMedicine(medicine);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/MedicineServlet");
            return;
        }

        // 3. ADD MEDICINE
        try {
            String medicineName = request.getParameter("medicineName");
            String genericName = request.getParameter("genericName");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            Date expiryDate = Date.valueOf(request.getParameter("expiryDate"));
            String manufacturer = request.getParameter("manufacturer");
            String status = request.getParameter("status");

            Medicine medicine = new Medicine();
            medicine.setPharmacyId(pharmacyId);
            medicine.setMedicineName(medicineName);
            medicine.setGenericName(genericName);
            medicine.setCategory(category);
            medicine.setDescription(description != null ? description : "");
            medicine.setPrice(price);
            medicine.setStock(stock);
            medicine.setExpiryDate(expiryDate);
            medicine.setManufacturer(manufacturer);
            medicine.setStatus(status != null ? status : "AVAILABLE");

            medicineDAO.addMedicine(medicine);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/MedicineServlet");
    }

    private String escapeHtml(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;");
    }
}
