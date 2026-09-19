<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
    <head>
        <title>Patient Sign-up</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            String signupError = (String) session.getAttribute("signupError");
            if(signupError != null){
        %>
        <div class="error-message">
            <%= signupError %>
        </div>
        <%
            session.removeAttribute("signupError");
            }
        %>
        <form method="post" action="${pageContext.request.contextPath}/patient/signup">
            <table>
                <tr>
                    <td>Email: </td>
                    <td><input type="email" name="email" required></td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td><input type="password" name="password"required></td>
                </tr>
                <tr>
                    <td>Name: </td>
                    <td><input type="text" name="name" required></td>
                </tr>
                <tr>
                    <td>Gender: </td>
                    <td><input type="radio" name="gender" value="male" > Male</td>
                    <td><input type="radio" name="gender" value="female"> Female</td>
                </tr>
                <tr>
                    <td>Address: </td>
                    <td><input type="text" name="address" ></td>
                </tr>
                <tr>
                    <td>Phone no: </td>
                    <td><input type="text" name="phone" ></td>
                </tr>
                <tr>
                    <td>D.O.B: </td>
                    <td><input type="date" name="dob" ></td>
                </tr>
                <tr>
                    <td>Blood Group:</td>
                    <td>
                        <select placeholder="Select your Blood Group" name="bloodgroup">
                            <option value="A+">A+</option>
                            <option value="B+">B+</option>
                            <option value="AB+">AB+</option>
                            <option value="O+">O+</option>
                            <option value="A-">A-</option>
                            <option value="B-">B-</option>
                            <option value="AB-">AB-</option>
                            <option value="O-">O-</option>
                        </select>
                    </td>
                </tr>
                <td><br>Add Your Emergency Contact</td>
                <tr>
                    <td>Name :</td>
                    <td><input type="text" name="emergencyName"></td>
                </tr>
                <tr>
                    <td>Relation :</td>
                    <td><input type="text" name="emergencyRelation"></td>
                </tr>
                <tr>
                    <td>Contact :</td>
                    <td><input type="text" name="emergencyContact"></td>
                </tr>
                <tr>
                    <td><br><input type="Submit" value="Submit" ></td>
                </tr>
            </table>
        </form>
        <a href="Login.jsp">Click here to Login</a>  
    </body>
</html>

