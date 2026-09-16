<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Shopping Cart");
    request.setAttribute("pageDescription", "Review your selected medicines before placing your order.");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Shopping Cart</title>
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

            <section class="cart-layout">
                <div class="card cart-items-card">
                    <div class="card-body">
                        <div class="cart-header">
                            <div>
                                <h2 class="section-title">Your Cart</h2>
                                <p id="cartItemCount">Loading cart...</p>
                            </div>
                        </div>

                        <div class="cart-items-list" id="cartItemsContainer">
                            <!-- Cart items are rendered by medicines.js. -->
                        </div>

                        <div class="cart-empty-state" id="cartEmptyState" hidden>
                            <h3>Your cart is empty</h3>
                            <p>Add medicines to your cart to continue.</p>
                            <a href="${pageContext.request.contextPath}/patient/medicines/medicines.jsp" class="btn btn-primary">Browse Medicines</a>
                        </div>
                    </div>
                </div>

                <aside class="card cart-summary-card">
                    <div class="card-body">
                        <h2 class="section-title">Order Summary</h2>
                        <div class="cart-summary-row">
                            <span>Subtotal</span>
                            <strong id="cartSubtotal">$0.00</strong>
                        </div>
                        <div class="cart-summary-row">
                            <span>Delivery</span>
                            <strong id="cartDelivery">$0.00</strong>
                        </div>
                        <div class="cart-summary-divider"></div>
                        <div class="cart-summary-row cart-total-row">
                            <span>Total</span>
                            <strong id="cartTotal">$0.00</strong>
                        </div>
                        <button type="button" class="btn btn-primary cart-checkout-btn" id="checkoutBtn">Proceed to Checkout</button>
                        <a href="${pageContext.request.contextPath}/patient/medicines/medicines.jsp" class="btn btn-secondary cart-continue-btn">Continue Shopping</a>
                    </div>
                </aside>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/medicines.js"></script>
</body>
</html>