<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="patient.model.Emergency" %>

<%
    request.setAttribute("pageTitle", "Emergency Request Details");
    request.setAttribute("pageDescription", "Detailed status and information for this emergency medical request.");

    Emergency emergencyDetail = (Emergency) request.getAttribute("emergencyDetail");
    if (emergencyDetail == null) {
        String idParam = request.getParameter("emergencyId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int emergencyId = Integer.parseInt(idParam.trim());
                Emergency em = new Emergency();
                emergencyDetail = em.getEmergencyById(emergencyId);
            } catch (Exception e) {
                // Ignore parse exception
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Emergency Request Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/emergency.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <% if (emergencyDetail == null) { %>
                <section class="card">
                    <div class="card-body" style="padding: 40px; text-align: center;">
                        <h3 class="section-title">Emergency Request Not Found</h3>
                        <p style="color: var(--text-muted); margin: 10px 0 20px;">
                            The requested emergency details could not be found or does not exist.
                        </p>
                        <a href="${pageContext.request.contextPath}/patient/emergency" class="btn btn-primary" style="text-decoration: none; padding: 10px 20px; border-radius: 6px;">
                            Back to Emergency
                        </a>
                    </div>
                </section>
            <% } else { 
                String sev = emergencyDetail.getSeverity() != null ? emergencyDetail.getSeverity().toUpperCase() : "MEDIUM";
                String sevBg = "#fef3c7";
                String sevColor = "#b45309";
                if ("CRITICAL".equals(sev)) {
                    sevBg = "#fee2e2";
                    sevColor = "#b91c1c";
                } else if ("HIGH".equals(sev)) {
                    sevBg = "#ffedd5";
                    sevColor = "#c2410c";
                } else if ("LOW".equals(sev)) {
                    sevBg = "#ecfdf5";
                    sevColor = "#047857";
                }

                String stat = emergencyDetail.getStatus() != null ? emergencyDetail.getStatus().toUpperCase() : "PENDING";
                String statBg = "#fef3c7";
                String statColor = "#92400e";
                if ("RESOLVED".equals(stat)) {
                    statBg = "#dcfce7";
                    statColor = "#15803d";
                } else if ("CANCELLED".equals(stat)) {
                    statBg = "#f3f4f6";
                    statColor = "#4b5563";
                }
            %>
                <section class="card" style="margin-bottom: 24px;">
                    <div class="card-body" style="padding: 24px;">
                        
                        <!-- Header Banner -->
                        <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 16px; border-bottom: 1px solid var(--border-color); padding-bottom: 18px; margin-bottom: 22px;">
                            <div>
                                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 6px;">
                                    <h2 class="section-title" style="margin: 0; font-size: 20px; color: var(--text-main);">
                                        Emergency Request #EMG-<%= emergencyDetail.getEmergencyId() %>
                                    </h2>
                                    <span style="font-size: 11px; font-weight: 700; padding: 4px 10px; border-radius: 12px; background: <%= sevBg %>; color: <%= sevColor %>;">
                                        <%= sev %>
                                    </span>
                                    <span style="font-size: 11px; font-weight: 700; padding: 4px 10px; border-radius: 12px; background: <%= statBg %>; color: <%= statColor %>;">
                                        <%= stat %>
                                    </span>
                                </div>
                                <span style="font-size: 13px; color: var(--text-muted);">
                                    Submitted on <%= emergencyDetail.getRequestedAt() != null ? emergencyDetail.getRequestedAt() : "N/A" %>
                                </span>
                            </div>

                            <div style="display: flex; gap: 10px;">
                                <% if (emergencyDetail.getContactNumber() != null && !emergencyDetail.getContactNumber().trim().isEmpty()) { %>
                                    <a href="tel:<%= emergencyDetail.getContactNumber() %>" class="btn btn-danger" style="background: #dc2626; color: white; padding: 9px 16px; border-radius: 6px; font-size: 13px; font-weight: 600; text-decoration: none;">
                                        Call <%= emergencyDetail.getContactNumber() %>
                                    </a>
                                <% } %>
                                <a href="tel:112" class="btn btn-secondary" style="border: 1px solid #fecaca; color: #dc2626; background: #fff5f5; padding: 9px 16px; border-radius: 6px; font-size: 13px; font-weight: 600; text-decoration: none;">
                                    Call 112
                                </a>
                            </div>
                        </div>

                        <!-- Details Grid -->
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 18px; margin-bottom: 24px;">
                            <div style="padding: 14px 16px; background: var(--bg-surface-subtle, #f9fafb); border-radius: 6px; border: 1px solid var(--border-color-subtle, #f0f0f0);">
                                <span style="display: block; font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; margin-bottom: 4px;">
                                    Emergency Type
                                </span>
                                <strong style="font-size: 15px; color: var(--text-main);">
                                    <%= emergencyDetail.getEmergencyType() != null ? emergencyDetail.getEmergencyType() : "General" %>
                                </strong>
                            </div>

                            <div style="padding: 14px 16px; background: var(--bg-surface-subtle, #f9fafb); border-radius: 6px; border: 1px solid var(--border-color-subtle, #f0f0f0);">
                                <span style="display: block; font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; margin-bottom: 4px;">
                                    Patient Name / ID
                                </span>
                                <span style="font-size: 14px; color: var(--text-body); font-weight: 500;">
                                    <%= emergencyDetail.getPatientName() != null && !emergencyDetail.getPatientName().equals("-") ? emergencyDetail.getPatientName() : (emergencyDetail.getPatientId() != null ? emergencyDetail.getPatientId() : "-") %>
                                </span>
                            </div>

                            <div style="padding: 14px 16px; background: var(--bg-surface-subtle, #f9fafb); border-radius: 6px; border: 1px solid var(--border-color-subtle, #f0f0f0);">
                                <span style="display: block; font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; margin-bottom: 4px;">
                                    Contact Number
                                </span>
                                <span style="font-size: 14px; color: var(--text-body); font-weight: 500;">
                                    <%= emergencyDetail.getContactNumber() != null ? emergencyDetail.getContactNumber() : "-" %>
                                </span>
                            </div>

                            <div style="padding: 14px 16px; background: var(--bg-surface-subtle, #f9fafb); border-radius: 6px; border: 1px solid var(--border-color-subtle, #f0f0f0);">
                                <span style="display: block; font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; margin-bottom: 4px;">
                                    Status
                                </span>
                                <span style="font-size: 14px; font-weight: 600; color: <%= statColor %>;">
                                    <%= stat %>
                                </span>
                            </div>

                            <div style="padding: 14px 16px; background: var(--bg-surface-subtle, #f9fafb); border-radius: 6px; border: 1px solid var(--border-color-subtle, #f0f0f0); grid-column: 1 / -1;">
                                <span style="display: block; font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; margin-bottom: 4px;">
                                    Location / Address
                                </span>
                                <span style="font-size: 14px; color: var(--text-body); line-height: 1.5;">
                                    <%= emergencyDetail.getLocation() != null ? emergencyDetail.getLocation() : "-" %>
                                </span>
                            </div>

                            <div style="padding: 14px 16px; background: var(--bg-surface-subtle, #f9fafb); border-radius: 6px; border: 1px solid var(--border-color-subtle, #f0f0f0); grid-column: 1 / -1;">
                                <span style="display: block; font-size: 11px; text-transform: uppercase; color: var(--text-light); font-weight: 600; margin-bottom: 4px;">
                                    Description / Medical Notes
                                </span>
                                <p style="margin: 0; font-size: 14px; color: var(--text-body); line-height: 1.6; white-space: pre-wrap;"><%= emergencyDetail.getDescription() != null ? emergencyDetail.getDescription() : "No additional description provided." %></p>
                            </div>
                        </div>

                        <!-- Resolution details if resolved -->
                        <% if (emergencyDetail.getResolvedAt() != null && !emergencyDetail.getResolvedAt().trim().isEmpty()) { %>
                            <div style="padding: 14px 16px; background: #ecfdf5; border: 1px solid #a7f3d0; border-radius: 6px; margin-bottom: 24px; color: #065f46; font-size: 13px;">
                                <strong>Resolved:</strong> This emergency request was marked resolved at <%= emergencyDetail.getResolvedAt() %>.
                            </div>
                        <% } %>

                        <!-- Back Button -->
                        <div style="display: flex; justify-content: flex-start; padding-top: 16px; border-top: 1px solid var(--border-color);">
                            <a href="${pageContext.request.contextPath}/patient/emergency" class="btn btn-secondary" style="padding: 9px 18px; border-radius: 6px; font-size: 13px; text-decoration: none; border: 1px solid var(--border-color); color: var(--text-main);">
                                &larr; Back to Emergency Requests
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