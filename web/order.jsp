<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>

<!DOCTYPE html>
<html>
<head>
    <title>Pharmacy Orders</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        h2 {
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #999;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .btn {
            padding: 7px 12px;
            text-decoration: none;
            border: 1px solid #777;
            background-color: #eee;
            color: black;
            border-radius: 4px;
        }

        select {
            padding: 6px;
        }

        button {
            padding: 6px 10px;
            cursor: pointer;
        }
    </style>
</head>

<body>

<h2>Pharmacy Orders</h2>

<%
    List<Order> orders =
            (List<Order>) request.getAttribute("orders");
%>

<% if (orders != null && !orders.isEmpty()) { %>

<table>

    <tr>
        <th>Order ID</th>
        <th>Patient ID</th>
        <th>Total Amount</th>
        <th>Address</th>
        <th>Status</th>
        <th>Order Date</th>
        <th>Actions</th>
    </tr>

    <% for (Order order : orders) { %>

    <tr>

        <td>
            <%= order.getOrderId() %>
        </td>

        <td>
            <%= order.getPatientId() %>
        </td>

        <td>
            ₹<%= order.getTotalAmount() %>
        </td>

        <td>
            <%= order.getAddress() %>
        </td>

        <td>

            <form action="OrderServlet"
                  method="post"
                  style="display:inline;">

                <input type="hidden"
                       name="action"
                       value="updateStatus">

                <input type="hidden"
                       name="orderId"
                       value="<%= order.getOrderId() %>">

                <select name="status">

                    <option value="PENDING"
                        <%= "PENDING".equals(order.getStatus()) ? "selected" : "" %>>
                        PENDING
                    </option>

                    <option value="ACCEPTED"
                        <%= "ACCEPTED".equals(order.getStatus()) ? "selected" : "" %>>
                        ACCEPTED
                    </option>

                    <option value="PROCESSING"
                        <%= "PROCESSING".equals(order.getStatus()) ? "selected" : "" %>>
                        PROCESSING
                    </option>

                    <option value="SHIPPED"
                        <%= "SHIPPED".equals(order.getStatus()) ? "selected" : "" %>>
                        SHIPPED
                    </option>

                    <option value="DELIVERED"
                        <%= "DELIVERED".equals(order.getStatus()) ? "selected" : "" %>>
                        DELIVERED
                    </option>

                </select>

                <button type="submit">
                    Update
                </button>

            </form>

        </td>

        <td>
            <%= order.getOrderDate() %>
        </td>

        <td>
            <a class="btn"
               href="OrderServlet?action=details&orderId=<%= order.getOrderId() %>">
                View Details
            </a>
        </td>

    </tr>

    <% } %>

</table>

<% } else { %>

<p>No orders found.</p>

<% } %>

<br>

<a href="MedicineServlet">Manage Medicines</a>
<br><br>

<a href="PharmacyServlet">Pharmacy Profile</a>

</body>
</html>