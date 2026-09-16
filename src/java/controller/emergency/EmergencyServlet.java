package controller.emergency;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.doctor.Emergency;

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
            
            HttpSession ses = req.getSession();
            if (ses != null)
            {
                Object patientId = ses.getAttribute("userId");
                if (patientId != null && patientId instanceof Integer)
                {
                    emergency.setPatientID((Integer)patientId);
                }
                if (patientId != null && patientId instanceof String)
                {
                    emergency.setPatientID(Integer.parseInt((String)patientId));
                }
            }
            
            emergency.setSeverity(severity);
            emergency.setStatus("Pending");
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
