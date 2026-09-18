<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- Login page for patient -->
<html>
    <head>
        <title>Patient Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            String loginError = (String) session.getAttribute("loginError");
            if(loginError != null){
        %>
        <div class="error-message">
            <%= loginError %>
        </div>
        <%
            session.removeAttribute("loginError");
            }
        %>
        <form method="post" action="${pageContext.request.contextPath}/patient/login">
            <table>
                <tr>
                    <td>Email: </td>
                    <td><input type="text" name="email" required></td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td><input type="password" name="password" required></td>
                </tr>
                <tr>
                    <td><input type="Submit" value="Submit" ></td>
                </tr>
            </table>
        </form>
        <a href="Signup.jsp">Click to Register</a>
    </body>
</html>

