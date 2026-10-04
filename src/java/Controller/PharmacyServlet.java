package Controller;

import dao.PharmacyDAO;
import model.Pharmacy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/PharmacyServlet")
public class PharmacyServlet extends HttpServlet {

    private PharmacyDAO pharmacyDAO;

    @Override
    public void init() {
        pharmacyDAO = new PharmacyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // For testing, pharmacy ID 1
        int pharmacyId = 1;

        Pharmacy pharmacy =
                pharmacyDAO.getPharmacyById(pharmacyId);

        request.setAttribute("pharmacy", pharmacy);

        request.getRequestDispatcher("/pharmacyProfile.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int pharmacyId =
                Integer.parseInt(
                        request.getParameter("pharmacyId")
                );

        String pharmacyName =
                request.getParameter("pharmacyName");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String address =
                request.getParameter("address");

        String licenseNumber =
                request.getParameter("licenseNumber");


        Pharmacy pharmacy = new Pharmacy();

        pharmacy.setPharmacyId(pharmacyId);
        pharmacy.setPharmacyName(pharmacyName);
        pharmacy.setEmail(email);
        pharmacy.setPhone(phone);
        pharmacy.setAddress(address);
        pharmacy.setLicenseNumber(licenseNumber);


        pharmacyDAO.updatePharmacy(pharmacy);


        response.sendRedirect("PharmacyServlet");
    }
}