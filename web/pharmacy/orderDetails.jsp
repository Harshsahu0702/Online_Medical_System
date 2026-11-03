<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pharmacy.model.OrderItem" %>
<%@ page import="pharmacy.model.Order" %>

<%
    List<OrderItem> items = (List<OrderItem>) request.getAttribute("orderItems");
    Integer orderId = (Integer) request.getAttribute("orderId");
    Order order = (Order) request.getAttribute("order");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order #<%= orderId %> Item Breakdown - PharmaCare Pro</title>
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
            max-width: 900px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .card {
            background: white;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .card-header {
            padding: 1.75rem 2rem;
            background: linear-gradient(135deg, #065f46 0%, #047857 100%);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-title {
            font-size: 1.5rem;
            font-weight: 800;
            margin: 0;
            letter-spacing: -0.02em;
        }

        .meta-strip {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.25rem;
            padding: 1.5rem 2rem;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            font-size: 0.875rem;
        }

        @media (max-width: 600px) {
            .meta-strip {
                grid-template-columns: 1fr;
            }
        }

        .meta-label {
            display: block;
            font-size: 0.75rem;
            text-transform: uppercase;
            font-weight: 700;
            color: #64748b;
            margin-bottom: 0.25rem;
        }

        .meta-value {
            font-weight: 600;
            color: #1e293b;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.925rem;
        }

        .data-table th {
            background: #f8fafc;
            color: #475569;
            font-weight: 600;
            padding: 1rem 2rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table td {
            padding: 1rem 2rem;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
        }

        .grand-total {
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 1.5rem;
            background: #ffffff;
            border-top: 1px solid #e2e8f0;
        }

        .grand-total-label {
            font-size: 1rem;
            font-weight: 600;
            color: #64748b;
        }

        .grand-total-amount {
            font-size: 1.5rem;
            font-weight: 800;
            color: #047857;
        }

        .actions {
            margin-top: 1.5rem;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: white;
            color: #475569;
            padding: 0.65rem 1.25rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.925rem;
            text-decoration: none;
            border: 1px solid #cbd5e1;
            transition: all 0.15s;
        }

        .btn-back:hover {
            background: #f1f5f9;
            color: #0f172a;
        }
    </style>
</head>
<body>

<jsp:include page="/pharmacy/navbar.jsp" />

<div class="container">

    <div class="card">
        <div class="card-header">
            <div>
                <h1 class="order-title">Prescription Order #<%= orderId %></h1>
                <span style="font-size: 0.85rem; color: #a7f3d0;">Itemized Medication Breakdown & Quantities</span>
            </div>
            <% if (order != null && order.getStatus() != null) { %>
            <div style="background: rgba(255, 255, 255, 0.2); padding: 0.4rem 0.85rem; border-radius: 9999px; font-weight: 700; font-size: 0.825rem;">
                <%= order.getStatus() %>
            </div>
            <% } %>
        </div>

        <% if (order != null) { %>
        <div class="meta-strip">
            <div>
                <span class="meta-label">Patient Name</span>
                <span class="meta-value"><%= order.getPatientName() %></span>
            </div>
            <div>
                <span class="meta-label">Order Date</span>
                <span class="meta-value"><%= order.getOrderDate() != null ? order.getOrderDate() : "N/A" %></span>
            </div>
            <div>
                <span class="meta-label">Delivery Destination</span>
                <span class="meta-value"><%= order.getAddress() != null ? order.getAddress() : "Default Address" %></span>
            </div>
        </div>
        <% } %>

        <% if (items != null && !items.isEmpty()) {
            double calculatedTotal = 0.0;
        %>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Item ID</th>
                    <th>Medication Name</th>
                    <th>Quantity</th>
                    <th>Unit Price</th>
                    <th style="text-align: right;">Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderItem item : items) {
                    double subtotal = item.getPrice() * item.getQuantity();
                    calculatedTotal += subtotal;
                %>
                <tr>
                    <td style="font-family: monospace; font-weight: 600; color: #64748b;">#<%= item.getOrderItemId() %></td>
                    <td>
                        <strong><%= item.getMedicineName() %></strong><br>
                        <span style="font-size: 0.775rem; color: #64748b;">Medicine Ref #<%= item.getMedicineId() %></span>
                    </td>
                    <td><strong><%= item.getQuantity() %> units</strong></td>
                    <td>&#8377;<%= String.format("%.2f", item.getPrice()) %></td>
                    <td style="text-align: right; font-weight: 700;">&#8377;<%= String.format("%.2f", subtotal) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div class="grand-total">
            <span class="grand-total-label">Invoice Total:</span>
            <span class="grand-total-amount">
                &#8377;<%= String.format("%.2f", (order != null && order.getTotalAmount() > 0) ? order.getTotalAmount() : calculatedTotal) %>
            </span>
        </div>
        <% } else { %>
        <div style="text-align: center; padding: 4rem; color: #64748b;">
            <p style="font-weight: 600; margin: 0 0 0.5rem 0;">No medication items recorded under this order ID.</p>
        </div>
        <% } %>
    </div>

    <div class="actions">
        <a href="<%= request.getContextPath() %>/OrderServlet" class="btn-back">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
            Back to Orders List
        </a>
    </div>

</div>

</body>
</html>
