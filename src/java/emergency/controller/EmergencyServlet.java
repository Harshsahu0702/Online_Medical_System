package emergency.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import emergency.model.Emergency;
import emergency.dao.EmergencyDAO;

public class EmergencyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    Emergency em = EmergencyDAO.getEmergencyById(id);
                    if (em != null) {
                        req.setAttribute("emergency", em);
                        req.setAttribute("emergencyID", em.getEmergencyID());
                        req.getRequestDispatcher("/emergency/success.jsp").forward(req, res);
                        return;
                    }
                } catch (Exception ignored) {}
            }
            req.getRequestDispatcher("/emergency/emergency.jsp").forward(req, res);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse res)
                throws IOException, ServletException
        {
            String emergencyType = req.getParameter("type");
            String  description = req.getParameter("description");
            String location = req.getParameter("location");
            String contact = req.getParameter("contact");
            String severity = req.getParameter("severity");
            
            Emergency emergency = new Emergency();
            
            emergency.setEmergencyType(emergencyType);
            emergency.setDescription(description);
            emergency.setLocation(location);
            emergency.setContact(contact);
            
            emergency.setSeverity(severity);
            emergency.setStatus("Pending");

            HttpSession ses = req.getSession(false);
            if (ses != null)
            {
                Object patientIdObj = ses.getAttribute("patientId");
                if (patientIdObj != null)
                {
                    emergency.setPatientID(String.valueOf(patientIdObj));
                }
                else
                {
                    // Check if logged in user is a registered patient (not a DOCTOR/ADMIN)
                    Object roleObj = ses.getAttribute("role");
                    Object userIdObj = ses.getAttribute("userId");
                    if (userIdObj != null && !"DOCTOR".equalsIgnoreCase(String.valueOf(roleObj)))
                    {
                        try {
                            int userId = (userIdObj instanceof Integer) ? (Integer) userIdObj : Integer.parseInt(String.valueOf(userIdObj));
                            String patientId = EmergencyDAO.getPatientIdByUserId(userId);
                            if (patientId != null) {
                                emergency.setPatientID(patientId);
                            }
                        } catch (Exception ignored) {}
                    }
                }
            }
            int b = emergency.insert();
            if(b>0)
            {
                req.setAttribute("emergencyID", emergency.getEmergencyID());

                req.getRequestDispatcher("/emergency/success.jsp")
                .forward(req, res);
            }
            else
            {
                req.getRequestDispatcher("/emergency/failure.jsp")
                .forward(req, res);
            }
        }
}
