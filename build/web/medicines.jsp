<%@ page import="java.util.List" %>
<%@ page import="model.Medicine" %>

<!DOCTYPE html>
<html>
<head>
    <title>Medicine Catalog</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        h1 {
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #999;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        input, select {
            padding: 7px;
        }

        button {
            padding: 7px 12px;
            cursor: pointer;
        }

        .search-container {
            position: relative;
            width: 350px;
        }

        #medicineSearch {
            width: 100%;
            box-sizing: border-box;
        }

        #suggestions {
            position: absolute;
            width: 100%;
            background: white;
            border: 1px solid #ccc;
            z-index: 1000;
        }

        .suggestion {
            padding: 8px;
            cursor: pointer;
        }

        .suggestion:hover {
            background-color: #f2f2f2;
        }

        .add-section {
            margin-top: 30px;
        }
    </style>
</head>

<body>

<h1>Medicine Catalog</h1>

<!-- ================= SEARCH ================= -->

<h2>Search Medicine</h2>

<div class="search-container">

    <input type="text"
           id="medicineSearch"
           placeholder="Search medicine..."
           autocomplete="off">

    <div id="suggestions"></div>

</div>

<!-- ================= MEDICINE TABLE ================= -->

<table>

    <tr>
        <th>ID</th>
        <th>Medicine Name</th>
        <th>Generic Name</th>
        <th>Category</th>
        <th>Price</th>
        <th>Stock</th>
        <th>Expiry Date</th>
        <th>Manufacturer</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

<%
    List<Medicine> medicines =
            (List<Medicine>) request.getAttribute("medicines");

    if (medicines != null && !medicines.isEmpty()) {

        for (Medicine medicine : medicines) {
%>

    <tr>

        <td>
            <%= medicine.getMedicineId() %>
        </td>

        <td>
            <%= medicine.getMedicineName() %>
        </td>

        <td>
            <%= medicine.getGenericName() %>
        </td>

        <td>
            <%= medicine.getCategory() %>
        </td>

        <td>
            ?<%= medicine.getPrice() %>
        </td>

        <td>
            <%= medicine.getStock() %>
        </td>

        <td>
            <%= medicine.getExpiryDate() %>
        </td>

        <td>
            <%= medicine.getManufacturer() %>
        </td>

        <td>
            <%= medicine.getAvailabilityStatus() %>
        </td>

        <td>

            <a href="MedicineServlet?action=edit&id=<%= medicine.getMedicineId() %>">
                Edit
            </a>

            &nbsp; | &nbsp;

            <a href="MedicineServlet?action=view&id=<%= medicine.getMedicineId() %>">
                View
            </a>

            &nbsp; | &nbsp;

            <a href="updateStock.jsp?id=<%= medicine.getMedicineId() %>">
                Update Stock
            </a>

            &nbsp; | &nbsp;

            <a href="MedicineServlet?action=delete&id=<%= medicine.getMedicineId() %>"
               onclick="return confirm('Are you sure you want to delete this medicine?');">
                Delete
            </a>

        </td>

    </tr>

<%
        }

    } else {
%>

    <tr>
        <td colspan="10">
            No medicines found.
        </td>
    </tr>

<%
    }
%>

</table>

<!-- ================= ADD MEDICINE ================= -->

<div class="add-section">

    <h2>Add Medicine</h2>

    <form action="MedicineServlet" method="post">

        <label>Medicine Name:</label><br>
        <input type="text"
               name="medicineName"
               required>
        <br><br>

        <label>Generic Name:</label><br>
        <input type="text"
               name="genericName"
               required>
        <br><br>

        <label>Category:</label><br>
        <input type="text"
               name="category"
               required>
        <br><br>

        <label>Price:</label><br>
        <input type="number"
               step="0.01"
               name="price"
               required>
        <br><br>

        <label>Stock:</label><br>
        <input type="number"
               name="stock"
               min="0"
               required>
        <br><br>

        <label>Expiry Date:</label><br>
        <input type="date"
               name="expiryDate"
               required>
        <br><br>

        <label>Manufacturer:</label><br>
        <input type="text"
               name="manufacturer"
               required>
        <br><br>

        <label>Status:</label><br>

        <select name="status">

            <option value="AVAILABLE">
                AVAILABLE
            </option>

            <option value="UNAVAILABLE">
                UNAVAILABLE
            </option>

        </select>

        <br><br>

        <button type="submit">
            Add Medicine
        </button>

    </form>

</div>

<hr>

<a href="OrderServlet">View Orders</a>
<br><br>

<a href="PharmacyServlet">Pharmacy Profile</a>
<br><br>

<a href="dashboard.jsp">Back to Dashboard</a>

<!-- ================= SEARCH JAVASCRIPT ================= -->

<script>

    const searchBox =
        document.getElementById("medicineSearch");

    const suggestionsBox =
        document.getElementById("suggestions");

    searchBox.addEventListener("input", function () {

        const keyword =
            searchBox.value.trim();

        if (keyword.length === 0) {

            suggestionsBox.innerHTML = "";

            return;
        }

        fetch(
            "MedicineServlet?action=suggest&keyword="
            + encodeURIComponent(keyword)
        )

        .then(response => response.text())

        .then(data => {

            suggestionsBox.innerHTML = data;

        })

        .catch(error => {

            console.error(
                "Search error:",
                error
            );

        });

    });


    function selectMedicine(medicineId) {

        window.location.href =
            "MedicineServlet?action=view&id="
            + medicineId;

    }

</script>

</body>
</html>