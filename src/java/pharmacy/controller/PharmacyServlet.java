package pharmacy.controller;

import pharmacy.dao.PharmacyDAO;
import pharmacy.model.Pharmacy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PharmacyServlet", urlPatterns = {"/PharmacyServlet", "/pharmacy/profile"})
public class PharmacyServlet extends HttpServlet {

    private PharmacyDAO pharmacyDAO;

    @Override
    public void init() {
        pharmacyDAO = new PharmacyDAO();
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
        Pharmacy pharmacy = pharmacyDAO.getPharmacyById(pharmacyId);
        request.setAttribute("pharmacy", pharmacy);

        request.getRequestDispatcher("/pharmacy/pharmacyProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int pharmacyId = Integer.parseInt(request.getParameter("pharmacyId"));
            String pharmacyName = request.getParameter("pharmacyName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String licenseNumber = request.getParameter("licenseNumber");

            Pharmacy pharmacy = new Pharmacy();
            pharmacy.setPharmacyId(pharmacyId);
            pharmacy.setPharmacyName(pharmacyName);
            pharmacy.setEmail(email);
            pharmacy.setPhone(phone);
            pharmacy.setAddress(address);
            pharmacy.setLicenseNumber(licenseNumber);

            boolean updated = pharmacyDAO.updatePharmacy(pharmacy);
            HttpSession session = request.getSession();
            if (updated) {
                session.setAttribute("profileMessage", "Pharmacy profile updated successfully.");
                session.setAttribute("profileMessageType", "success");
            } else {
                session.setAttribute("profileMessage", "Could not update pharmacy profile.");
                session.setAttribute("profileMessageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/PharmacyServlet");
    }
}
