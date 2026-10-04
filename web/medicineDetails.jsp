<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Medicine" %>

<%
    Medicine medicine =
            (Medicine) request.getAttribute("selectedMedicine");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Medicine Details</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        .details {
            width: 500px;
            border: 1px solid #999;
            padding: 20px;
        }

        .row {
            margin-bottom: 12px;
        }

        .label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
        }

    </style>

</head>

<body>

<h2>Medicine Details</h2>

<%
    if (medicine != null) {
%>

<div class="details">

    <div class="row">
        <span class="label">Medicine Name:</span>
        <%= medicine.getMedicineName() %>
    </div>

    <div class="row">
        <span class="label">Generic Name:</span>
        <%= medicine.getGenericName() %>
    </div>

    <div class="row">
        <span class="label">Category:</span>
        <%= medicine.getCategory() %>
    </div>

    <div class="row">
        <span class="label">Price:</span>
        ₹<%= medicine.getPrice() %>
    </div>

    <div class="row">
        <span class="label">Stock:</span>
        <%= medicine.getStock() %>
    </div>

    <div class="row">
        <span class="label">Expiry Date:</span>
        <%= medicine.getExpiryDate() %>
    </div>

    <div class="row">
        <span class="label">Manufacturer:</span>
        <%= medicine.getManufacturer() %>
    </div>

    <div class="row">
        <span class="label">Status:</span>
        <%= medicine.getStatus() %>
    </div>

</div>

<%
    } else {
%>

<p>Medicine not found.</p>

<%
    }
%>

<a class="back-link"
   href="MedicineServlet">
    Back to Medicines
</a>

</body>

</html>