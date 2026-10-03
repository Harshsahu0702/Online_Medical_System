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
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

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
                                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 14px;">
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
                                                <span style="color: var(--text-body); font-size: 13px; font-weight: 500;">
                                                    <%= ord.getPatientName() != null ? ord.getPatientName() : "-" %>
                                                </span>
                                            </div>
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
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>