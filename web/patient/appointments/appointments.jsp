<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@page import="patient.model.PatientAppointments" %>
<%
    request.setAttribute("pageTitle", "Appointments");
    request.setAttribute("pageDescription", "View your schedule, join video visits, or book a new medical consultation.");
%>

<% 
    ArrayList<PatientAppointments> patientAppointmentLists = (ArrayList<PatientAppointments>) request.getAttribute("patientAppointmentList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Appointments</title>
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

            <div class="page-header-actions">
                <a href="${pageContext.request.contextPath}/patient/find-doctor" class="btn btn-primary">
                    <svg class="icon icon-sm" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 5v14M5 12h14"/>
                    </svg>
                    Schedule New Appointment
                </a>
            </div>
            <br>

<!--            <div class="tabs-nav">
                <button class="tab-btn active" type="button" onclick="Appointments.switchTab('upcoming', this)">Upcoming (2)</button>
                <button class="tab-btn" type="button" onclick="Appointments.switchTab('completed', this)">Past Consultations (2)</button>
                <button class="tab-btn" type="button" onclick="Appointments.switchTab('cancelled', this)">Cancelled (1)</button>
            </div>-->

            <section id="appointmentsListContainer" class="appointments-list-container">
                <%  
                    if (patientAppointmentLists == null || patientAppointmentLists.isEmpty()) {
                %>
                    <div class="appointment-empty">
                        <div class="appointment-empty-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect width="18" height="18" x="3" y="4" rx="2" ry="2"/>
                                <line x1="16" y1="2" x2="16" y2="6"/>
                                <line x1="8" y1="2" x2="8" y2="6"/>
                                <line x1="3" y1="10" x2="21" y2="10"/>
                            </svg>
                        </div>
                        <h3 class="appointment-empty-title">No Appointments Found</h3>
                        <p class="appointment-empty-text">You don't have any appointments scheduled yet. Click "Schedule New Appointment" to book your consultation.</p>
                    </div>
                <%
                    } else {
                        for (PatientAppointments patientAppointment : patientAppointmentLists) {
                            String docName = patientAppointment.getDoctorName();
                            String initials = (docName != null && docName.length() >= 2) ? docName.substring(0, 2).toUpperCase() : "DR";
                            String status = patientAppointment.getStatus() != null ? patientAppointment.getStatus() : "PENDING";
                            String statusClass = status.toLowerCase();
                            String type = patientAppointment.getAppointmentType();
                            String typeDisplay = "ONLINE".equalsIgnoreCase(type) ? "Online Video" : "In-Person Visit";
                %>
                    <div class="appointment-card" onclick="window.location.href='${pageContext.request.contextPath}/patient/appointment-details?appointmentId=<%= patientAppointment.getAppointmentId() %>'" style="cursor: pointer;">
                        <div class="appointment-main">
                            <div class="appointment-doctor-avatar">
                                <%= initials %>
                            </div>
                            <div class="appointment-doctor-info">
                                <h4 class="appointment-doctor-name"><%= docName != null ? docName : "Doctor" %></h4>
                                <% if (patientAppointment.getReason() != null && !patientAppointment.getReason().trim().isEmpty()) { %>
                                    <p class="appointment-reason"><%= patientAppointment.getReason() %></p>
                                <% } %>
                            </div>
                        </div>

                        <div class="appointment-details">
                            <div class="appointment-detail">
                                <span class="appointment-detail-label">Date</span>
                                <span class="appointment-detail-value"><%= patientAppointment.getAppointmentDate() %></span>
                            </div>
                            <div class="appointment-detail">
                                <span class="appointment-detail-label">Time</span>
                                <span class="appointment-detail-value"><%= patientAppointment.getAppointmentTime() %></span>
                            </div>
                            <div class="appointment-detail">
                                <span class="appointment-detail-label">Consultation</span>
                                <span class="appointment-detail-value"><%= typeDisplay %></span>
                            </div>
                            <div class="appointment-detail">
                                <span class="appointment-detail-label">Status</span>
                                <span class="appointment-status <%= statusClass %>"><%= status %></span>
                            </div>
                            <%
                                if(!status.equalsIgnoreCase("CANCELLED")){
                            %>
                            <div class="appointment-detail" onclick="event.stopPropagation()">
                                <form method="post" action="${pageContext.request.contextPath}/patient/appointments" style="margin: 0;" onsubmit="return confirm('Are you sure you want to cancel this appointment?');">
                                    <input type="hidden" name="appointmentId" value="<%= patientAppointment.getAppointmentId() %>">
                                    <input type="hidden" name="doctorId" value="<%= patientAppointment.getDoctorId() %>">
                                    <button type="submit" class="btn btn-sm btn-secondary" style="color: #b91c1c; border-color: #fecdd3; cursor: pointer;">Cancel</button>
                                </form>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <br>
                <%
                        }   
                    }
                %>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>