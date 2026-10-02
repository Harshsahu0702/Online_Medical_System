<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="patient.model.PatientAppointments" %>

<%
    request.setAttribute("pageTitle", "Appointment Details");
    request.setAttribute("pageDescription", "Review your appointment information and consultation details.");
    PatientAppointments app = (PatientAppointments) request.getAttribute("AppointmentDetails");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Appointment Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/appointments.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <%
                if (app == null) {
            %>
            <section class="card">
                <div class="card-body" style="padding: 40px; text-align: center;">
                    <div class="appointment-empty-icon">✕</div>
                    <h3 class="appointment-empty-title">Appointment Not Found</h3>
                    <p class="appointment-empty-text">The requested appointment could not be retrieved.</p>
                    <div style="margin-top: 20px;">
                        <a href="${pageContext.request.contextPath}/patient/appointments" class="btn btn-primary">Back to Appointments</a>
                    </div>
                </div>
            </section>
            <%
                } else {
                    String docName = app.getDoctorName() != null ? app.getDoctorName() : "Doctor";
                    String initials = "DR";
                    String[] nameParts = docName.trim().split("\\s+");
                    if (nameParts.length >= 2) {
                        initials = ("" + nameParts[0].charAt(0) + nameParts[1].charAt(0)).toUpperCase();
                    } else if (nameParts.length == 1 && !nameParts[0].isEmpty()) {
                        initials = nameParts[0].substring(0, Math.min(2, nameParts[0].length())).toUpperCase();
                    }
                    
                    String status = app.getStatus() != null ? app.getStatus() : "PENDING";
                    String statusClass = "pending";
                    if ("CONFIRMED".equalsIgnoreCase(status)) statusClass = "confirmed";
                    else if ("COMPLETED".equalsIgnoreCase(status)) statusClass = "completed";
                    else if ("CANCELLED".equalsIgnoreCase(status)) statusClass = "cancelled";

                    String type = app.getAppointmentType();
                    String typeDisplay = "ONLINE".equalsIgnoreCase(type) ? "Online Video" : "In-Person Visit";
                    String spec = app.getSpecialization() != null && !app.getSpecialization().trim().isEmpty() ? app.getSpecialization() : "General Consultation";
                    String clinic = app.getClinicName() != null && !app.getClinicName().trim().isEmpty() ? app.getClinicName() : "Clinic";
            %>

            <section class="card">
                <div class="card-body" style="padding: 28px;">
                    <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 16px; margin-bottom: 24px; padding-bottom: 20px; border-bottom: 1px solid var(--border-color);">
                        <div>
                            <span class="appointment-status <%= statusClass %>" style="margin-bottom: 10px;"><%= status %></span>
                            <h2 style="font-size: 20px; font-weight: 700; margin: 8px 0 4px; color: var(--text-main);"><%= spec %> Consultation</h2>
                            <p style="color: var(--text-muted); font-size: 13px; margin: 0;">Appointment ID: #<%= app.getAppointmentId() %></p>
                        </div>
                    </div>

                    <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 28px;">
                        <div class="appointment-doctor-avatar" style="width: 60px; height: 60px; font-size: 20px;">
                            <%= initials %>
                        </div>
                        <div class="appointment-doctor-info">
                            <h3 class="appointment-doctor-name" style="font-size: 18px;"><%= docName %></h3>
                            <p class="appointment-specialty"><%= spec %></p>
                            <p class="appointment-hospital"><%= clinic %></p>
                        </div>
                    </div>

                    <div class="appointment-info-grid">
                        <div class="appointment-info-item">
                            <div class="appointment-info-label">Date</div>
                            <div class="appointment-info-value"><%= app.getAppointmentDate() != null ? app.getAppointmentDate() : "-" %></div>
                        </div>
                        <div class="appointment-info-item">
                            <div class="appointment-info-label">Time</div>
                            <div class="appointment-info-value"><%= app.getAppointmentTime() != null ? app.getAppointmentTime() : "-" %></div>
                        </div>
                        <div class="appointment-info-item">
                            <div class="appointment-info-label">Consultation Type</div>
                            <div class="appointment-info-value"><%= typeDisplay %></div>
                        </div>
                        <div class="appointment-info-item">
                            <div class="appointment-info-label">Consultation Fee</div>
                            <div class="appointment-info-value">$<%= String.format("%.2f", app.getConsultationFee()) %></div>
                        </div>
                    </div>

                    <div style="margin-top: 24px;">
                        <h4 style="font-size: 14px; font-weight: 700; color: var(--text-main); margin-bottom: 8px;">Reason for Visit</h4>
                        <div class="appointment-note" style="margin-top: 0;">
                            <%= app.getReason() != null && !app.getReason().trim().isEmpty() ? app.getReason() : "No specific reason provided." %>
                        </div>
                    </div>

                    <div class="appointment-detail-actions" style="margin-top: 32px;">
                        <a href="${pageContext.request.contextPath}/patient/appointments" class="btn btn-secondary">Back to Appointments</a>
                        <% if ("CONFIRMED".equalsIgnoreCase(status) && "ONLINE".equalsIgnoreCase(type)) { %>
                        <button type="button" class="btn btn-primary" id="joinAppointmentBtn">Join Consultation</button>
                        <% } %>
                    </div>
                </div>
            </section>
            <%
                }
            %>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>