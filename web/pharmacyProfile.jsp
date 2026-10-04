<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Pharmacy" %>

<!DOCTYPE html>
<html>
<head>

    <title>Pharmacy Profile</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        .profile-form {
            width: 450px;
        }

        label {
            font-weight: bold;
        }

        input, textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 8px;
            margin-top: 5px;
        }

        textarea {
            resize: vertical;
        }

        button {
            padding: 8px 15px;
            cursor: pointer;
        }

        .links {
            margin-top: 25px;
        }

        .links a {
            margin-right: 20px;
        }
    </style>

</head>

<body>

<h2>Pharmacy Profile</h2>

<%
    Pharmacy pharmacy =
            (Pharmacy) request.getAttribute("pharmacy");
%>

<% if (pharmacy != null) { %>

<div class="profile-form">

<form action="PharmacyServlet" method="post">

    <input type="hidden"
           name="pharmacyId"
           value="<%= pharmacy.getPharmacyId() %>">

    <label>Pharmacy Name:</label>
    <input type="text"
           name="pharmacyName"
           value="<%= pharmacy.getPharmacyName() %>"
           required>

    <br><br>

    <label>Email:</label>
    <input type="email"
           name="email"
           value="<%= pharmacy.getEmail() %>"
           required>

    <br><br>

    <label>Phone:</label>
    <input type="text"
           name="phone"
           value="<%= pharmacy.getPhone() %>"
           required>

    <br><br>

    <label>Address:</label>
    <textarea name="address"
              rows="3"
              required><%= pharmacy.getAddress() %></textarea>

    <br><br>

    <label>License Number:</label>
    <input type="text"
           name="licenseNumber"
           value="<%= pharmacy.getLicenseNumber() %>"
           required>

    <br><br>

    <button type="submit">
        Update Profile
    </button>

</form>

</div>

<% } else { %>

    <p>Pharmacy not found.</p>

<% } %>

<div class="links">

    <a href="MedicineServlet">
        Manage Medicines
    </a>

    <a href="OrderServlet">
        View Orders
    </a>

    <a href="dashboard.jsp">
        Back to Dashboard
    </a>

</div>

</body>
</html>