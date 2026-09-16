<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Medicines");
    request.setAttribute("pageDescription", "Browse medicines, view details, and add products to your cart.");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Medicines</title>
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

            <section class="card medicine-filter-card">
                <div class="card-body">
                    <div class="medicine-filter-bar">
                        <div class="medicine-search-field">
                            <label class="form-label" for="medicineSearchTerm">Search Medicines</label>
                            <div class="medicine-search-wrapper">
                                <svg class="icon icon-sm" viewBox="0 0 24 24" aria-hidden="true">
                                    <circle cx="11" cy="11" r="8"/>
                                    <path d="m21 21-4.3-4.3"/>
                                </svg>
                                <input type="search" class="form-control medicine-search-input" id="medicineSearchTerm" placeholder="Search by medicine name or category..." autocomplete="off">
                            </div>
                        </div>
                        <div class="medicine-filter-field">
                            <label class="form-label" for="medicineCategoryFilter">Category</label>
                            <select class="form-control" id="medicineCategoryFilter">
                                <option value="ALL">All Categories</option>
                                <option value="Pain Relief">Pain Relief</option>
                                <option value="Cardiovascular">Cardiovascular</option>
                                <option value="Antibiotics">Antibiotics</option>
                                <option value="Vitamins">Vitamins</option>
                                <option value="Digestive Health">Digestive Health</option>
                            </select>
                        </div>
                    </div>
                </div>
            </section>

            <section class="medicine-results-section" aria-label="Available medicines">
                <div class="medicine-results-header">
                    <div>
                        <h2 class="section-title">Available Medicines</h2>
                        <p class="medicine-results-count" id="medicineResultsCount">Loading medicines...</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/patient/medicines/cart.jsp" class="btn btn-primary">View Cart</a>
                </div>

                <div class="medicine-grid" id="medicineGridContainer">
                    <!-- Medicine cards are rendered by medicines.js. -->
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