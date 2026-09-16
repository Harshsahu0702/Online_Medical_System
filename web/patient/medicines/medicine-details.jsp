<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Medicine Details");
    request.setAttribute("pageDescription", "View medicine information, usage details, and availability.");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Medicine Details</title>
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

            <section class="card medicine-details-card">
                <div class="card-body">
                    <div class="medicine-details-layout">
                        <div class="medicine-image">AM</div>

                        <div class="medicine-details-content">
                            <span class="badge">Cardiovascular</span>
                            <h2 class="section-title">Amlodipine 5 mg</h2>
                            <p class="medicine-manufacturer">MediCore Pharmaceuticals</p>

                            <div class="medicine-price-section">
                                <span class="medicine-price">$12.50</span>
                                <span class="medicine-stock">In Stock</span>
                            </div>

                            <div class="medicine-description">
                                <h3 class="section-title">Description</h3>
                                <p>Amlodipine is commonly used to help manage high blood pressure and certain cardiovascular conditions.</p>
                            </div>

                            <div class="medicine-information">
                                <div class="medicine-info-item">
                                    <span class="info-label">Dosage Form</span>
                                    <strong>Tablet</strong>
                                </div>
                                <div class="medicine-info-item">
                                    <span class="info-label">Strength</span>
                                    <strong>5 mg</strong>
                                </div>
                                <div class="medicine-info-item">
                                    <span class="info-label">Pack Size</span>
                                    <strong>30 Tablets</strong>
                                </div>
                            </div>

                            <div class="medicine-purchase">
                                <div class="form-group">
                                    <label class="form-label" for="medicineQuantity">Quantity</label>
                                    <input type="number" class="form-control" id="medicineQuantity" name="quantity" value="1" min="1" max="10">
                                </div>
                                <button type="button" class="btn btn-primary" id="addMedicineToCartBtn">Add to Cart</button>
                            </div>
                        </div>
                    </div>

                    <div class="medicine-warning">
                        <h3 class="section-title">Important Information</h3>
                        <p>Use this medicine only as directed by your doctor or pharmacist. Check the prescription and product instructions before use.</p>
                    </div>

                    <div class="medicine-details-actions">
                        <a href="${pageContext.request.contextPath}/patient/medicines/medicines.jsp" class="btn btn-secondary">Back to Medicines</a>
                        <a href="${pageContext.request.contextPath}/patient/medicines/cart.jsp" class="btn btn-primary">View Cart</a>
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