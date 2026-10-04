<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Medicine" %>

<%
    Medicine medicine =
            (Medicine) request.getAttribute("medicine");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Edit Medicine</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        .form-container {
            width: 450px;
        }

        label {
            font-weight: bold;
        }

        input, select {
            width: 100%;
            box-sizing: border-box;
            padding: 8px;
            margin-top: 5px;
        }

        button {
            padding: 9px 15px;
            cursor: pointer;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
        }

    </style>

</head>

<body>

<h2>Edit Medicine</h2>

<%
    if (medicine != null) {
%>

<div class="form-container">

    <form action="MedicineServlet" method="post">

        <input type="hidden"
               name="action"
               value="update">

        <input type="hidden"
               name="medicineId"
               value="<%= medicine.getMedicineId() %>">

        <label>Medicine Name:</label>
        <input type="text"
               name="medicineName"
               value="<%= medicine.getMedicineName() %>"
               required>

        <br><br>

        <label>Generic Name:</label>
        <input type="text"
               name="genericName"
               value="<%= medicine.getGenericName() %>"
               required>

        <br><br>

        <label>Category:</label>
        <input type="text"
               name="category"
               value="<%= medicine.getCategory() %>"
               required>

        <br><br>

        <label>Price:</label>
        <input type="number"
               step="0.01"
               min="0"
               name="price"
               value="<%= medicine.getPrice() %>"
               required>

        <br><br>

        <label>Stock:</label>
        <input type="number"
               min="0"
               name="stock"
               value="<%= medicine.getStock() %>"
               required>

        <br><br>

        <label>Expiry Date:</label>
        <input type="date"
               name="expiryDate"
               value="<%= medicine.getExpiryDate() %>"
               required>

        <br><br>

        <label>Manufacturer:</label>
        <input type="text"
               name="manufacturer"
               value="<%= medicine.getManufacturer() %>"
               required>

        <br><br>

        <label>Status:</label>

        <select name="status">

            <option value="AVAILABLE"
                <%= "AVAILABLE".equals(medicine.getStatus())
                        ? "selected" : "" %>>
                AVAILABLE
            </option>

            <option value="UNAVAILABLE"
                <%= "UNAVAILABLE".equals(medicine.getStatus())
                        ? "selected" : "" %>>
                UNAVAILABLE
            </option>

        </select>

        <br><br>

        <button type="submit">
            Update Medicine
        </button>

    </form>

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