<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.OrderItem" %>

<%
    List<OrderItem> items =
            (List<OrderItem>) request.getAttribute("orderItems");

    Integer orderId =
            (Integer) request.getAttribute("orderId");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Order Details</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        h2 {
            margin-bottom: 10px;
        }

        table {
            width: 70%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #999;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
        }

    </style>

</head>

<body>

    <h2>Order Details</h2>

    <h3>
        Order ID: <%= orderId %>
    </h3>

    <table>

        <tr>
            <th>Order Item ID</th>
            <th>Medicine</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>

        <%
            if (items != null && !items.isEmpty()) {

                for (OrderItem item : items) {
        %>

        <tr>

            <td>
                <%= item.getOrderItemId() %>
            </td>

            <td>
                <%= item.getMedicineName() %>
            </td>

            <td>
                <%= item.getQuantity() %>
            </td>

            <td>
                ₹<%= item.getPrice() %>
            </td>

        </tr>

        <%
                }

            } else {
        %>

        <tr>

            <td colspan="4">
                No medicines found for this order.
            </td>

        </tr>

        <%
            }
        %>

    </table>

    <a class="back-link" href="OrderServlet">
        Back to Orders
    </a>

</body>

</html>