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

                    <%
                        boolean isOnline = "ONLINE".equalsIgnoreCase(type);
                        String meetLink = app.getMeetingLink();
                        boolean hasMeetLink = (meetLink != null && !meetLink.trim().isEmpty());
                        boolean isLiveOngoing = ("ONGOING".equalsIgnoreCase(app.getConsultationStatus())
                                             || "IN_PROGRESS".equalsIgnoreCase(app.getConsultationStatus()));
                    %>

                    <% if (isOnline && hasMeetLink && (isLiveOngoing || "ACCEPTED".equalsIgnoreCase(status) || "CONFIRMED".equalsIgnoreCase(status))) { %>
                        <div id="liveMeetingRoomBanner" style="margin-top: 28px; background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); color: white; border-radius: 12px; padding: 24px; border: 2px solid #22c55e;">
                            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 14px;">
                                <div>
                                    <span class="badge" style="background: #22c55e; color: white; margin-bottom: 8px; font-weight: 700;">
                                        📹 Consultation Video Meeting Ready
                                    </span>
                                    <h3 style="margin: 6px 0 4px; color: white; font-size: 18px;">
                                        Video Consultation with Dr. <%= docName %>
                                    </h3>
                                    <p style="margin: 0; color: #94a3b8; font-size: 13px;">
                                        Your doctor has provided the meeting link. Click below to join the call.
                                    </p>
                                </div>
                                <div>
                                    <a id="liveMeetingBtn" href="<%= meetLink %>" target="_blank" class="btn btn-primary" 
                                       style="background: #22c55e; border-color: #22c55e; padding: 12px 24px; font-size: 15px; font-weight: 700; display: inline-flex; align-items: center; gap: 8px; box-shadow: 0 4px 14px rgba(34, 197, 94, 0.4); text-decoration: none;">
                                        <span>🚀 Join Video Call Now</span>
                                    </a>
                                </div>
                            </div>
                            <div id="liveRoomUrlText" style="margin-top: 14px; background: rgba(255,255,255,0.08); padding: 8px 14px; border-radius: 6px; font-family: monospace; font-size: 12px; color: #cbd5e1; word-break: break-all;">
                                Meeting URL: <%= meetLink %>
                            </div>
                        </div>
                    <% } else if (isOnline && ("ACCEPTED".equalsIgnoreCase(status) || "CONFIRMED".equalsIgnoreCase(status))) { %>
                        <div id="waitingForDoctorBanner" style="margin-top: 28px; background: #f0fdf4; border: 1.5px solid #86efac; border-radius: 12px; padding: 20px 24px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 14px;">
                            <div style="display: flex; align-items: center; gap: 14px;">
                                <div style="font-size: 28px;">⏳</div>
                                <div>
                                    <h4 style="margin: 0; color: #166534; font-size: 16px; font-weight: 700;">Appointment Accepted</h4>
                                    <p style="margin: 4px 0 0; color: #15803d; font-size: 13px;">
                                        Your appointment is confirmed. Waiting for doctor to provide the Google Meet link.
                                    </p>
                                </div>
                            </div>
                        </div>
                    <% } %>
                            </div>
                            <span class="badge" style="background: #bbf7d0; color: #14532d; font-weight: 700; padding: 6px 14px; border-radius: 20px; font-size: 12px;">
                                Status: Accepted
                            </span>
                        </div>
                    <% } %>

                    <div class="appointment-detail-actions" style="margin-top: 32px; display: flex; gap: 12px; align-items: center; flex-wrap: wrap;">
                        <a href="${pageContext.request.contextPath}/patient/appointments" class="btn btn-secondary">
                            &larr; Back to Appointments
                        </a>
                        <a href="${pageContext.request.contextPath}/patient/prescriptions" class="btn btn-secondary">
                            View My Prescriptions
                        </a>
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