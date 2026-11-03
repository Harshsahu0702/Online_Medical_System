<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="patient.model.Medicines" %>

<%
    request.setAttribute("pageTitle", "Medicine Details");
    request.setAttribute("pageDescription", "View medicine information and pharmacy availability.");

    Medicines medicineDetail = (Medicines) request.getAttribute("medicineDetail");
    if (medicineDetail == null) {
        String idParam = request.getParameter("medicineId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int medicineId = Integer.parseInt(idParam.trim());
                Medicines mModel = new Medicines();
                medicineDetail = mModel.getMedicineById(medicineId);
            } catch (Exception e) {
                // Ignore parse errors
            }
        }
    }
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

            <% if (medicineDetail == null) { %>
                <section class="card">
                    <div class="card-body" style="padding: 40px; text-align: center;">
                        <h3 class="section-title">Medicine Not Found</h3>
                        <p style="color: var(--text-muted); margin: 10px 0 20px;">
                            The requested medicine details could not be found.
                        </p>
                        <a href="${pageContext.request.contextPath}/patient/medicines" class="btn btn-primary">
                            Back to Medicines
                        </a>
                    </div>
                </section>
            <% } else { 
                String medName = medicineDetail.getMedicineName() != null ? medicineDetail.getMedicineName() : "Medicine";
                String initials = "MED";
                if (medName.trim().length() >= 2) {
                    initials = medName.trim().substring(0, 2).toUpperCase();
                }
            %>

                <section class="card medicine-details-card">
                    <div class="medicine-details-header">
                        <div class="medicine-details-image" style="font-size: 28px; font-weight: 700;">
                            <%= initials %>
                        </div>
                        <div style="flex: 1;">
                            <% if (medicineDetail.getCategory() != null && !medicineDetail.getCategory().trim().isEmpty()) { %>
                                <span class="badge" style="margin-bottom: 8px;"><%= medicineDetail.getCategory() %></span>
                            <% } %>
                            <h2 class="medicine-details-name"><%= medName %></h2>
                            <% if (medicineDetail.getGenericName() != null && !medicineDetail.getGenericName().trim().isEmpty()) { %>
                                <p class="medicine-details-generic">Generic Name: <%= medicineDetail.getGenericName() %></p>
                            <% } %>
                            <div style="margin-top: 8px;">
                                <span style="font-size: 20px; font-weight: 700; color: var(--text-main);">
                                    ₹ <%= medicineDetail.getPrice() != null ? medicineDetail.getPrice() : "0" %>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="medicine-details-content">
                        <div class="medicine-detail-section">
                            <h3 class="medicine-detail-title">Information</h3>
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; background: var(--bg-surface-subtle); padding: 18px; border-radius: var(--radius-md); border: 1px solid var(--border-color-subtle);">
                                <div>
                                    <span style="color: var(--text-light); font-size: 11px; text-transform: uppercase; font-weight: 600; display: block; margin-bottom: 2px;">Medicine ID</span>
                                    <strong style="color: var(--text-main); font-size: 14px;">#<%= medicineDetail.getMedicineId() %></strong>
                                </div>
                                <div>
                                    <span style="color: var(--text-light); font-size: 11px; text-transform: uppercase; font-weight: 600; display: block; margin-bottom: 2px;">Pharmacy</span>
                                    <strong style="color: var(--text-main); font-size: 14px;"><%= medicineDetail.getPharmacyName() != null ? medicineDetail.getPharmacyName() : "N/A" %></strong>
                                </div>
                                <div>
                                    <span style="color: var(--text-light); font-size: 11px; text-transform: uppercase; font-weight: 600; display: block; margin-bottom: 2px;">Pharmacy ID</span>
                                    <strong style="color: var(--text-main); font-size: 14px;"><%= medicineDetail.getPharmacyId() %></strong>
                                </div>
                                <div>
                                    <span style="color: var(--text-light); font-size: 11px; text-transform: uppercase; font-weight: 600; display: block; margin-bottom: 2px;">Manufacturer</span>
                                    <strong style="color: var(--text-main); font-size: 14px;"><%= medicineDetail.getManufacturer() != null ? medicineDetail.getManufacturer() : "N/A" %></strong>
                                </div>
                                <div>
                                    <span style="color: var(--text-light); font-size: 11px; text-transform: uppercase; font-weight: 600; display: block; margin-bottom: 2px;">Stock Quantity</span>
                                    <strong style="color: var(--text-main); font-size: 14px;"><%= medicineDetail.getStock_quantity() %></strong>
                                </div>
                                <div>
                                    <span style="color: var(--text-light); font-size: 11px; text-transform: uppercase; font-weight: 600; display: block; margin-bottom: 2px;">Expiry Date</span>
                                    <strong style="color: var(--text-main); font-size: 14px;"><%= medicineDetail.getExpiryDate() != null ? medicineDetail.getExpiryDate() : "N/A" %></strong>
                                </div>
                                <div>
                                    <span style="color: var(--text-light); font-size: 11px; text-transform: uppercase; font-weight: 600; display: block; margin-bottom: 2px;">Status</span>
                                    <strong style="color: var(--text-main); font-size: 14px;"><%= medicineDetail.getStatus() != null ? medicineDetail.getStatus() : "N/A" %></strong>
                                </div>
                            </div>
                        </div>

                        <div class="medicine-detail-section">
                            <h3 class="medicine-detail-title">Description</h3>
                            <p class="medicine-detail-text">
                                <%= (medicineDetail.getDescription() != null && !medicineDetail.getDescription().trim().isEmpty()) 
                                    ? medicineDetail.getDescription() 
                                    : "No description available." %>
                            </p>
                        </div>

                        <div style="margin-top: 28px;">
                            <a href="${pageContext.request.contextPath}/patient/medicines" class="btn btn-secondary">
                                &larr; Back to Medicines
                            </a>
                        </div>
                    </div>
                </section>

            <% } %>

        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>