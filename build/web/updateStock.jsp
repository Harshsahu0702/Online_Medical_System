<%@ page import="model.Medicine" %>

<%
    int medicineId =
            Integer.parseInt(request.getParameter("id"));
%>

<!DOCTYPE html>
<html>

<head>

    <title>Update Stock</title>

</head>

<body>

    <h2>Update Medicine Stock</h2>

   <form action="MedicineServlet" method="post">

    <input type="hidden"
           name="action"
           value="updateStock">

    <input type="hidden"
           name="medicineId"
           value="<%= medicineId %>">

    <input type="number"
           name="stock"
           min="0"
           required>

    <button type="submit">
        Update Stock
    </button>

</form>
    <br>

    <a href="MedicineServlet">
        Back to Medicines
    </a>

</body>

</html>