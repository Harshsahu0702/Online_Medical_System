<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="patient.model.Medicines" %>

<%
    request.setAttribute("pageTitle", "Medicines");
    request.setAttribute("pageDescription", "Browse available medicines and view details.");

    String medicineName = request.getParameter("medicineName");
    String category = request.getParameter("category");

    ArrayList<Medicines> medicineList = (ArrayList<Medicines>) request.getAttribute("medicineList");
    if (medicineList == null) {
        Medicines mModel = new Medicines();
        medicineList = mModel.getAllMedicines(medicineName, category);
    }
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

            <!-- Search & Category Filter Form -->
            <section class="card medicine-filter-card">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/patient/medicines" method="GET" class="medicine-filter-bar">
                        <div class="medicine-search-field">
                            <label class="form-label" for="medicineSearchTerm">Search Medicines</label>
                            <div class="medicine-search-wrapper">
                                <svg class="icon icon-sm" viewBox="0 0 24 24" aria-hidden="true">
                                    <circle cx="11" cy="11" r="8"/>
                                    <path d="m21 21-4.3-4.3"/>
                                </svg>
                                <input type="search" class="form-control medicine-search-input" id="medicineSearchTerm" name="medicineName" 
                                       placeholder="Search by medicine name..." 
                                       value="<%= medicineName != null ? medicineName : "" %>" autocomplete="off">
                            </div>
                        </div>

                        <div class="medicine-filter-field">
                            <label class="form-label" for="medicineCategoryFilter">Category</label>
                            <select class="form-control" id="medicineCategoryFilter" name="category">
                                <option value="ALL" <%= (category == null || category.equalsIgnoreCase("ALL")) ? "selected" : "" %>>All Categories</option>
                                <option value="Pain Relief" <%= "Pain Relief".equalsIgnoreCase(category) ? "selected" : "" %>>Pain Relief</option>
                                <option value="Cardiovascular" <%= "Cardiovascular".equalsIgnoreCase(category) ? "selected" : "" %>>Cardiovascular</option>
                                <option value="Antibiotics" <%= "Antibiotics".equalsIgnoreCase(category) ? "selected" : "" %>>Antibiotics</option>
                                <option value="Vitamins" <%= "Vitamins".equalsIgnoreCase(category) ? "selected" : "" %>>Vitamins</option>
                                <option value="Digestive Health" <%= "Digestive Health".equalsIgnoreCase(category) ? "selected" : "" %>>Digestive Health</option>
                                <option value="Respiratory" <%= "Respiratory".equalsIgnoreCase(category) ? "selected" : "" %>>Respiratory</option>
                            </select>
                        </div>

                        <div class="medicine-filter-actions">
                            <button type="submit" class="btn btn-primary medicine-submit-btn" id="searchMedicineBtn">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <circle cx="11" cy="11" r="8"/>
                                    <path d="m21 21-4.3-4.3"/>
                                </svg>
                                <span>Search</span>
                            </button>
                            <% if ((medicineName != null && !medicineName.trim().isEmpty()) || (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("ALL"))) { %>
                                <a href="${pageContext.request.contextPath}/patient/medicines" class="btn btn-secondary medicine-reset-btn" title="Clear Filters">
                                    Reset
                                </a>
                            <% } %>
                        </div>
                    </form>
                </div>
            </section>

            <section class="medicine-results-section" aria-label="Available medicines">
                <div class="medicine-results-header">
                    <div>
                        <h2 class="section-title">Available Medicines</h2>
                        <p class="medicine-results-count">
                            <%= (medicineList != null) ? medicineList.size() : 0 %> Medicines available
                        </p>
                    </div>
                </div>

                <% if (medicineList == null || medicineList.isEmpty()) { %>
                    <section class="card">
                        <div class="card-body" style="padding: 40px; text-align: center;">
                            <h3 class="section-title">No Medicines Found</h3>
                            <p style="color: var(--text-muted); margin: 6px 0 0;">
                                No medicines matched your search criteria.
                            </p>
                        </div>
                    </section>
                <% } else { %>
                    <div class="medicine-grid">
                        <% for (Medicines m : medicineList) { 
                            String medName = m.getMedicineName() != null ? m.getMedicineName() : "Medicine";
                            String initials = "MED";
                            if (medName.trim().length() >= 2) {
                                initials = medName.trim().substring(0, 2).toUpperCase();
                            }
                            String status = m.getStatus() != null ? m.getStatus() : "Available";
                        %>
                            <div class="medicine-card" onclick="window.location.href='${pageContext.request.contextPath}/patient/medicine-details?medicineId=<%= m.getMedicineId() %>'" style="cursor: pointer;">
                                <div class="medicine-card-body">
                                    <div class="medicine-image">
                                        <%= initials %>
                                    </div>

                                    <h3 class="medicine-name"><%= medName %></h3>

                                    <% if (m.getPharmacyName() != null && !m.getPharmacyName().trim().isEmpty()) { %>
                                        <p style="color: var(--text-muted); font-size: 13px; margin: 4px 0 0;">
                                            Pharmacy: <strong><%= m.getPharmacyName() %></strong>
                                        </p>
                                    <% } %>
                                </div>

                                <div class="medicine-card-footer">
                                    <div>
                                        <span class="medicine-price-label">Price</span>
                                        <span class="medicine-price">₹ <%= m.getPrice() != null ? m.getPrice() : "0" %></span>
                                    </div>
                                    <div style="display: flex; align-items: center; gap: 8px;">
                                        <span class="medicine-stock available"><%= status %></span>
                                        <a href="${pageContext.request.contextPath}/patient/medicine-details?medicineId=<%= m.getMedicineId() %>" 
                                           class="btn btn-sm btn-primary" onclick="event.stopPropagation();">
                                            View Details &rarr;
                                        </a>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>