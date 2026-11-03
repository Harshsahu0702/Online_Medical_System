<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pharmacy.model.Order" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String orderMessage = (String) session.getAttribute("orderMessage");
    String orderMessageType = (String) session.getAttribute("orderMessageType");
    if (orderMessage != null) {
        session.removeAttribute("orderMessage");
        session.removeAttribute("orderMessageType");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prescription Orders & Fulfillment - PharmaCare Pro</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            margin: 0;
            padding: 0;
            background: #f8fafc;
            color: #0f172a;
            min-height: 100vh;
        }

        .container {
            max-width: 1280px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            margin: 0;
            letter-spacing: -0.025em;
        }

        .page-subtitle {
            margin: 0.25rem 0 0 0;
            color: #64748b;
            font-size: 0.925rem;
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            font-size: 0.925rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-danger {
            background: #fff1f2;
            color: #9f1239;
            border: 1px solid #fecdd3;
        }

        .table-card {
            background: white;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.9rem;
        }

        .data-table th {
            background: #f8fafc;
            color: #475569;
            font-weight: 600;
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table td {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
            vertical-align: middle;
        }

        .data-table tr:hover td {
            background: #f8fafc;
        }

        .status-select-form {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }

        .select-status {
            padding: 0.4rem 0.65rem;
            border-radius: 6px;
            font-size: 0.825rem;
            font-weight: 700;
            border: 1px solid #cbd5e1;
            background: white;
            outline: none;
            cursor: pointer;
            font-family: inherit;
        }

        .btn-update {
            background: #059669;
            color: white;
            border: none;
            padding: 0.4rem 0.75rem;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.15s;
        }

        .btn-update:hover {
            background: #047857;
        }

        .btn-details {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            background: #f1f5f9;
            color: #334155;
            padding: 0.45rem 0.85rem;
            border-radius: 6px;
            font-size: 0.825rem;
            font-weight: 600;
            text-decoration: none;
            border: 1px solid #cbd5e1;
            transition: all 0.15s;
        }

        .btn-details:hover {
            background: #e2e8f0;
            color: #0f172a;
        }
    </style>
</head>
<body>

<jsp:include page="/pharmacy/navbar.jsp" />

<div class="container">

    <div class="page-header">
        <div>
            <h1 class="page-title">Patient Orders & Prescription Fulfillment</h1>
            <p class="page-subtitle">Track incoming medication requests, update delivery stages, and automatically manage inventory deductions</p>
        </div>
    </div>

    <% if (orderMessage != null) { %>
    <div class="alert <%= "danger".equals(orderMessageType) ? "alert-danger" : "alert-success" %>">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 14 14"></polyline></svg>
        <%= orderMessage %>
    </div>
    <% } %>

    <div class="table-card">
        <% if (orders != null && !orders.isEmpty()) { %>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Order #</th>
                    <th>Patient</th>
                    <th>Total Amount</th>
                    <th>Delivery Address</th>
                    <th>Current Status & Update</th>
                    <th>Order Date</th>
                    <th style="text-align: right;">Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Order order : orders) {
                    String status = order.getStatus() != null ? order.getStatus().toUpperCase() : "PENDING";
                %>
                <tr>
                    <td><strong>#<%= order.getOrderId() %></strong></td>
                    <td>
                        <strong><%= order.getPatientName() %></strong><br>
                        <span style="font-size: 0.775rem; color: #64748b;">Patient ID #<%= order.getPatientId() %></span>
                    </td>
                    <td><strong style="color: #047857;">&#8377;<%= String.format("%.2f", order.getTotalAmount()) %></strong></td>
                    <td>
                        <span style="max-width: 250px; display: inline-block; white-space: normal; line-height: 1.35;">
                            <%= order.getAddress() %>
                        </span>
                    </td>
                    <td>
                        <form action="<%= request.getContextPath() %>/OrderServlet" method="post" class="status-select-form">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

                            <select name="status" class="select-status">
                                <option value="PENDING" <%= "PENDING".equals(status) ? "selected" : "" %>>PENDING</option>
                                <option value="ACCEPTED" <%= "ACCEPTED".equals(status) ? "selected" : "" %>>ACCEPTED</option>
                                <option value="PROCESSING" <%= "PROCESSING".equals(status) ? "selected" : "" %>>PROCESSING</option>
                                <option value="SHIPPED" <%= "SHIPPED".equals(status) ? "selected" : "" %>>SHIPPED</option>
                                <option value="DELIVERED" <%= "DELIVERED".equals(status) ? "selected" : "" %>>DELIVERED</option>
                            </select>

                            <button type="submit" class="btn-update">Update</button>
                        </form>
                    </td>
                    <td><%= order.getOrderDate() != null ? order.getOrderDate() : "Recent" %></td>
                    <td style="text-align: right;">
                        <a href="<%= request.getContextPath() %>/OrderServlet?action=details&orderId=<%= order.getOrderId() %>" class="btn-details">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            View Items
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } else { %>
        <div style="text-align: center; padding: 4rem; color: #64748b;">
            <p style="font-size: 1.1rem; font-weight: 700; color: #0f172a; margin: 0 0 0.5rem 0;">No pharmacy orders to display</p>
            <span>Orders submitted by patients via prescriptions or the medicine store will appear here for processing.</span>
        </div>
        <% } %>
    </div>

</div>

</body>
</html>
