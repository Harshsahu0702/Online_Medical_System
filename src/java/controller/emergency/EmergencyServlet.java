package controller.emergency;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.emergency.Emergency;

public class EmergencyServlet extends HttpServlet {
        protected void doPost(HttpServletRequest req, HttpServletResponse res)
                throws IOException,ServletException
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
                    if (patientIdObj instanceof Integer)
                    {
                        emergency.setPatientID((Integer) patientIdObj);
                    }
                    else if (patientIdObj instanceof String)
                    {
                        try {
                            emergency.setPatientID(Integer.parseInt((String) patientIdObj));
                        } catch (Exception ignored) {}
                    }
                }
                else
                {
                    // Check if logged in user is a registered patient (not a DOCTOR/ADMIN)
                    Object roleObj = ses.getAttribute("role");
                    Object userIdObj = ses.getAttribute("userId");
                    if (userIdObj != null && !"DOCTOR".equalsIgnoreCase(String.valueOf(roleObj)))
                    {
                        try {
                            int userId = (userIdObj instanceof Integer) ? (Integer) userIdObj : Integer.parseInt((String) userIdObj);
                            Integer patientId = dao.emergency.EmergencyDAO.getPatientIdByUserId(userId);
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
