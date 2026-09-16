<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Medicine Orders");
    request.setAttribute("pageDescription", "Track your medicine orders and review previous purchases.");
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
                            <p class="orders-count" id="ordersCount">Loading orders...</p>
                        </div>
                        <div class="orders-filter">
                            <label class="form-label" for="orderStatusFilter">Order Status</label>
                            <select class="form-control" id="orderStatusFilter">
                                <option value="ALL">All Orders</option>
                                <option value="PROCESSING">Processing</option>
                                <option value="SHIPPED">Shipped</option>
                                <option value="DELIVERED">Delivered</option>
                                <option value="CANCELLED">Cancelled</option>
                            </select>
                        </div>
                    </div>

                    <div class="orders-list" id="ordersListContainer">
                        <!-- Order records are rendered by medicines.js. -->
                    </div>
                </div>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/medicines.js"></script>
</body>
</html>