package patient.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/patient/logout")
public class LogoutController extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession ses = req.getSession(false);
        if (ses != null) {
            ses.removeAttribute("patientId");
            ses.removeAttribute("patientName");
            ses.removeAttribute("patientEmail");
            ses.invalidate();
        }
        res.sendRedirect(req.getContextPath() + "/MainLogin.jsp?role=patient");
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        doGet(req, res);
    }
}

