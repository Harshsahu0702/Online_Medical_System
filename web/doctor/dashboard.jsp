<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.doctor.Doctor" %>
<%@ page import="model.doctor.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - Online Medical System</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    Doctor doctor = (Doctor) request.getAttribute("doctor");
    Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
    List<Appointment> todayAppointments = (List<Appointment>) request.getAttribute("todayAppointments");
    Integer unreadNotifications = (Integer) request.getAttribute("unreadNotifications");
    if (unreadNotifications == null) unreadNotifications = 0;
%>

<main class="app-container">

    <!-- WELCOME BANNER -->
    <div class="card" style="background: linear-gradient(135deg, #244b6b 0%, #3498db 100%); color: white; border: none;">
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;">
            <div>
                <h1 style="margin: 0; font-size: 24px;">Welcome Back, Dr. <%= doctor != null ? doctor.getName() : "Doctor" %>!</h1>
                <p style="margin: 6px 0 0; opacity: 0.9; font-size: 14px;">
                    Specialization: <strong><%= (doctor != null && doctor.getSpecializationName() != null) ? doctor.getSpecializationName() : "General" %></strong> | 
                    Clinic: <strong><%= (doctor != null && doctor.getClinicName() != null) ? doctor.getClinicName() : "Main Hospital" %></strong>
                </p>
            </div>
            <div>
                <a href="<%= request.getContextPath() %>/DoctorAvailabilityServlet" class="btn" style="background: white; color: #244b6b;">Manage Availability</a>
                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet" class="btn" style="background: rgba(255,255,255,0.2); color: white; margin-left: 8px;">View All Appointments</a>
            </div>
        </div>
    </div>

    <!-- METRICS GRID -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-label">Today's Appointments</div>
            <div class="stat-value"><%= (stats != null && stats.get("todayAppointments") != null) ? String.valueOf(stats.get("todayAppointments")) : "0" %></div>
        </div>
        <div class="stat-card warning">
            <div class="stat-label">Pending Requests</div>
            <div class="stat-value"><%= (stats != null && stats.get("pendingAppointments") != null) ? String.valueOf(stats.get("pendingAppointments")) : "0" %></div>
        </div>
        <div class="stat-card accent">
            <div class="stat-label">Upcoming / Accepted</div>
            <div class="stat-value"><%= (stats != null && stats.get("upcomingAppointments") != null) ? String.valueOf(stats.get("upcomingAppointments")) : "0" %></div>
        </div>
        <div class="stat-card">
            <div class="stat-label">Completed Consultations</div>
            <div class="stat-value"><%= (stats != null && stats.get("completedConsultations") != null) ? String.valueOf(stats.get("completedConsultations")) : "0" %></div>
        </div>
        <div class="stat-card accent">
            <div class="stat-label">Total Patients</div>
            <div class="stat-value"><%= (stats != null && stats.get("totalPatients") != null) ? String.valueOf(stats.get("totalPatients")) : "0" %></div>
        </div>
        <div class="stat-card danger">
            <div class="stat-label">Unread Notifications</div>
            <div class="stat-value"><%= unreadNotifications %></div>
        </div>
    </div>

    <!-- TODAY'S SCHEDULE -->
    <div class="card">
        <div class="card-title">
            <span>Today's Appointment Schedule</span>
            <span style="font-size: 13px; font-weight: normal; color: #64748b;">
                Showing today's confirmed & pending visits
            </span>
        </div>

        <% if (todayAppointments == null || todayAppointments.isEmpty()) { %>
            <div style="text-align: center; padding: 40px 20px; color: #94a3b8;">
                <div style="font-size: 36px; margin-bottom: 8px;">📅</div>
                <p style="margin: 0; font-size: 15px;">No appointments scheduled for today.</p>
                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet" class="btn btn-primary" style="margin-top: 14px;">View All Appointments</a>
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Time</th>
                        <th>Patient Name</th>
                        <th>Phone</th>
                        <th>Type</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Appointment appt : todayAppointments) { %>
                        <tr>
                            <td><strong><%= appt.getAppointmentTime() %></strong></td>
                            <td><%= appt.getPatientName() %></td>
                            <td><%= appt.getPatientPhone() != null ? appt.getPatientPhone() : "N/A" %></td>
                            <td>
                                <span class="badge" style="background:#e0f2fe; color:#0369a1;"><%= appt.getAppointmentType() %></span>
                            </td>
                            <td><%= appt.getReason() != null ? appt.getReason() : "General Checkup" %></td>
                            <td>
                                <% if ("PENDING".equalsIgnoreCase(appt.getStatus())) { %>
                                    <span class="badge badge-pending">Pending</span>
                                <% } else if ("ACCEPTED".equalsIgnoreCase(appt.getStatus())) { %>
                                    <span class="badge badge-accepted">Accepted</span>
                                <% } else if ("COMPLETED".equalsIgnoreCase(appt.getStatus())) { %>
                                    <span class="badge badge-completed">Completed</span>
                                <% } else { %>
                                    <span class="badge badge-rejected"><%= appt.getStatus() %></span>
                                <% } %>
                            </td>
                            <td>
                                <div style="display: flex; gap: 6px;">
                                    <% if ("PENDING".equalsIgnoreCase(appt.getStatus())) { %>
                                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=accept&id=<%= appt.getAppointmentId() %>" class="btn btn-success btn-sm">Accept</a>
                                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=reject&id=<%= appt.getAppointmentId() %>" class="btn btn-danger btn-sm">Reject</a>
                                    <% } else if ("ACCEPTED".equalsIgnoreCase(appt.getStatus())) { %>
                                        <a href="<%= request.getContextPath() %>/DoctorConsultationServlet?action=start&appointmentId=<%= appt.getAppointmentId() %>" class="btn btn-primary btn-sm">Start Consultation</a>
                                    <% } %>
                                    <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=view&id=<%= appt.getAppointmentId() %>" class="btn btn-secondary btn-sm">Details</a>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

</main>

</body>
</html>
