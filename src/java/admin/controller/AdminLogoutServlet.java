package admin.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminLogoutServlet", urlPatterns = {"/AdminLogoutServlet", "/admin/logout"})
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("adminUser");
            session.removeAttribute("adminName");
            session.removeAttribute("adminEmail");
            session.removeAttribute("adminId");
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp?loggedOut=true");
    }
}
