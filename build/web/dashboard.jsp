<!DOCTYPE html>
<html>
<head>

    <title>Pharmacy Dashboard</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            margin-bottom: 10px;
        }

        .menu {
            margin-top: 30px;
        }

        .menu a {
            display: block;
            width: 250px;
            padding: 12px;
            margin-bottom: 15px;
            text-decoration: none;
            border: 1px solid #999;
            border-radius: 5px;
        }

        .menu a:hover {
            background-color: #f2f2f2;
        }
    </style>

</head>

<body>

<h1>Pharmacy Dashboard</h1>

<h2>Welcome to Pharmacy Management</h2>

<p>
    Manage medicines, orders, and pharmacy information from this dashboard.
</p>

<div class="menu">

    <a href="MedicineServlet">
        Medicine Catalog
    </a>

    <a href="OrderServlet">
        Orders
    </a>

    <a href="PharmacyServlet">
        Pharmacy Profile
    </a>

</div>

</body>
</html>