<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="patient.model.Orders" %>

<%
    request.setAttribute("pageTitle", "Medicine Orders");
    request.setAttribute("pageDescription", "Track your medicine orders and review previous purchases.");

    String selectedStatus = request.getParameter("status");

    ArrayList<Orders> orderList = (ArrayList<Orders>) request.getAttribute("orderList");
    if (orderList == null) {
        String patientId = (String) session.getAttribute("patientId");
        if (patientId != null && !patientId.trim().isEmpty()) {
            Orders oModel = new Orders();
            orderList = oModel.getOrdersByPatientId(patientId, selectedStatus);
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Medicine Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/medicines.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <% if ("ordered".equals(request.getParameter("msg"))) { %>
                <div style="background: #ecfdf5; border: 1.5px solid #10b981; border-radius: 12px; padding: 16px 20px; margin-bottom: 24px; display: flex; align-items: center; gap: 14px; box-shadow: 0 4px 12px rgba(16,185,129,0.1);">
                    <div style="width: 40px; height: 40px; border-radius: 50%; background: #10b981; color: white; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
                        ✓
                    </div>
                    <div>
                        <h4 style="margin: 0; color: #065f46; font-size: 15px; font-weight: 700;">Prescription Sent to Pharmacy Successfully!</h4>
                        <p style="margin: 3px 0 0; color: #047857; font-size: 13px;">Your prescribed medicines order has been submitted to the Central Pharmacy. It is currently marked as <strong>PENDING</strong> confirmation.</p>
                    </div>
                </div>
            <% } %>

            <section class="card orders-card">
                <div class="card-body">
                    <div class="orders-header">
                        <div>
                            <h2 class="section-title">My Orders</h2>
                            <p class="orders-count">
                                <%= (orderList != null) ? orderList.size() : 0 %> Orders recorded
                            </p>
                        </div>
                        <div class="orders-filter">
                            <form method="get" action="${pageContext.request.contextPath}/patient/orders" style="display: flex; align-items: center; gap: 8px; margin: 0;">
                                <label class="form-label" for="orderStatusFilter" style="margin: 0; white-space: nowrap;">Order Status</label>
                                <select class="form-control" id="orderStatusFilter" name="status" onchange="this.form.submit();" style="min-width: 140px;">
                                    <option value="ALL" <%= (selectedStatus == null || selectedStatus.equalsIgnoreCase("ALL")) ? "selected" : "" %>>All Orders</option>
                                    <option value="PENDING" <%= "PENDING".equalsIgnoreCase(selectedStatus) ? "selected" : "" %>>Pending</option>
                                    <option value="PROCESSING" <%= "PROCESSING".equalsIgnoreCase(selectedStatus) ? "selected" : "" %>>Processing</option>
                                    <option value="SHIPPED" <%= "SHIPPED".equalsIgnoreCase(selectedStatus) ? "selected" : "" %>>Shipped</option>
                                    <option value="DELIVERED" <%= "DELIVERED".equalsIgnoreCase(selectedStatus) ? "selected" : "" %>>Delivered</option>
                                    <option value="CANCELLED" <%= "CANCELLED".equalsIgnoreCase(selectedStatus) ? "selected" : "" %>>Cancelled</option>
                                </select>
                            </form>
                        </div>
                    </div>

                    <% if (orderList == null || orderList.isEmpty()) { %>
                        <div class="card" style="margin-top: 16px;">
                            <div class="card-body" style="padding: 40px; text-align: center;">
                                <h3 class="section-title">No Orders Found</h3>
                                <p style="color: var(--text-muted); margin: 6px 0 16px;">
                                    You have not placed any medicine orders matching this criteria.
                                </p>
                                <a href="${pageContext.request.contextPath}/patient/medicines" class="btn btn-primary">
                                    Browse Medicines
                                </a>
                            </div>
                        </div>
                    <% } else { %>
                        <div class="order-list" style="margin-top: 20px;">
                            <% for (Orders ord : orderList) { 
                                String status = ord.getOrderStatus() != null ? ord.getOrderStatus() : "PENDING";
                                String statusClass = status.toLowerCase();
                            %>
                                <div class="order-card">
                                    <div class="order-header">
                                        <div>
                                            <h4 class="order-number">Order #ORD-<%= ord.getOrderId() %></h4>
                                            <p class="order-date"><%= ord.getOrderDate() != null ? ord.getOrderDate() : "-" %></p>
                                        </div>
                                        <span class="order-status <%= statusClass %>"><%= status %></span>
                                    </div>

                                    <div class="order-body">
                                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 14px; margin-bottom: 14px;">
                                            <div>
                                                <span style="font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; display: block; margin-bottom: 2px;">Pharmacy</span>
                                                <strong style="color: var(--text-main); font-size: 13px;">
                                                    <%= ord.getPharmacyName() != null ? ord.getPharmacyName() : "Pharmacy" %>
                                                </strong>
                                                <span style="color: var(--text-muted); font-size: 11px;">(#<%= ord.getPharmacyId() %>)</span>
                                            </div>
                                            <div>
                                                <span style="font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; display: block; margin-bottom: 2px;">Delivery Address</span>
                                                <span style="color: var(--text-body); font-size: 13px;">
                                                    <%= ord.getDeliveryAddress() != null && !ord.getDeliveryAddress().trim().isEmpty() ? ord.getDeliveryAddress() : "Standard Address" %>
                                                </span>
                                            </div>
                                            <div>
                                                <span style="font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; display: block; margin-bottom: 2px;">Patient Name</span>
                                                <span style="color: var(--text-body); font-size: 13px; font-weight: 600;">
                                                    <%= (ord.getPatientName() != null && !ord.getPatientName().trim().isEmpty()) ? ord.getPatientName() : "Patient" %>
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Prescribed Medicines & Price Breakdown -->
                                        <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; overflow: hidden; margin-top: 10px;">
                                            <div style="padding: 10px 14px; background: #f1f5f9; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center;">
                                                <div style="display: flex; align-items: center; gap: 8px;">
                                                    <span style="font-size: 15px;">💊</span>
                                                    <span style="font-size: 12px; font-weight: 700; color: #334155; text-transform: uppercase; letter-spacing: 0.03em;">Ordered Medicines</span>
                                                </div>
                                                <span style="font-size: 12px; color: #64748b; font-weight: 600;">
                                                    <%= (ord.getItems() != null) ? ord.getItems().size() : 0 %> Item(s)
                                                </span>
                                            </div>

                                            <% if (ord.getItems() != null && !ord.getItems().isEmpty()) { %>
                                                <table style="width: 100%; border-collapse: collapse; font-size: 13px;">
                                                    <thead>
                                                        <tr style="border-bottom: 1px solid #e2e8f0; color: #64748b; font-size: 11px; text-transform: uppercase;">
                                                            <th style="padding: 8px 14px; text-align: left; font-weight: 600;">Medicine Name</th>
                                                            <th style="padding: 8px 14px; text-align: center; font-weight: 600;">Qty</th>
                                                            <th style="padding: 8px 14px; text-align: right; font-weight: 600;">Unit Price</th>
                                                            <th style="padding: 8px 14px; text-align: right; font-weight: 600;">Subtotal</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (java.util.Map<String, Object> item : ord.getItems()) { %>
                                                            <tr style="border-bottom: 1px solid #f1f5f9; background: white;">
                                                                <td style="padding: 9px 14px; color: #0f172a; font-weight: 600;">
                                                                    <%= item.get("medicineName") %>
                                                                </td>
                                                                <td style="padding: 9px 14px; text-align: center;">
                                                                    <span style="background: #e2e8f0; color: #334155; padding: 2px 8px; border-radius: 12px; font-weight: 700; font-size: 11px;">
                                                                        <%= item.get("quantity") %>
                                                                    </span>
                                                                </td>
                                                                <td style="padding: 9px 14px; text-align: right; color: #64748b;">
                                                                    ₹ <%= String.format("%.2f", (Double) item.get("unitPrice")) %>
                                                                </td>
                                                                <td style="padding: 9px 14px; text-align: right; color: #047857; font-weight: 700;">
                                                                    ₹ <%= String.format("%.2f", (Double) item.get("subtotal")) %>
                                                                </td>
                                                            </tr>
                                                        <% } %>
                                                    </tbody>
                                                </table>
                                            <% } else { %>
                                                <div style="padding: 12px 14px; color: #94a3b8; font-size: 12px; font-style: italic;">
                                                    Individual medicine item details not found for this order.
                                                </div>
                                            <% } %>
                                        </div>
                                    </div>

                                    <div class="order-footer">
                                        <div>
                                            <span class="order-total-label">Total Amount</span>
                                            <span class="order-total">₹ <%= String.format("%.2f", ord.getTotalAmount()) %></span>
                                        </div>

                                        <% if ("PENDING".equalsIgnoreCase(status) || "PROCESSING".equalsIgnoreCase(status)) { %>
                                            <div>
                                                <form method="post" action="${pageContext.request.contextPath}/patient/orders" onsubmit="return confirm('Are you sure you want to cancel this order?');" style="margin: 0;">
                                                    <input type="hidden" name="action" value="cancel">
                                                    <input type="hidden" name="orderId" value="<%= ord.getOrderId() %>">
                                                    <button type="submit" class="btn btn-sm btn-secondary" style="color: #b91c1c; border-color: #fecdd3; cursor: pointer;">
                                                        Cancel Order
                                                    </button>
                                                </form>
                                            </div>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } %>

                </div>
            </section>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>