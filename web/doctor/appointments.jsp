<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Appointments - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    String currentFilter = (String) request.getAttribute("currentFilter");
    if (currentFilter == null) currentFilter = "ALL";

    String msgParam = request.getParameter("msg");
%>

<main class="app-container">

    <% if ("accepted".equalsIgnoreCase(msgParam)) { %>
        <div class="alert alert-success">Appointment accepted successfully!</div>
    <% } else if ("rejected".equalsIgnoreCase(msgParam)) { %>
        <div class="alert alert-danger">Appointment marked as rejected.</div>
    <% } %>

    <div class="card">
        <div class="card-title">
            <span>Patient Appointments</span>
            
            <!-- FILTER BUTTONS -->
            <div style="display: flex; gap: 8px; font-size: 13px;">
                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?filter=ALL" class="btn <%= "ALL".equalsIgnoreCase(currentFilter) ? "btn-primary" : "btn-secondary" %> btn-sm">All</a>
                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?filter=PENDING" class="btn <%= "PENDING".equalsIgnoreCase(currentFilter) ? "btn-primary" : "btn-secondary" %> btn-sm">Pending</a>
                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?filter=ACCEPTED" class="btn <%= "ACCEPTED".equalsIgnoreCase(currentFilter) ? "btn-primary" : "btn-secondary" %> btn-sm">Accepted</a>
                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?filter=COMPLETED" class="btn <%= "COMPLETED".equalsIgnoreCase(currentFilter) ? "btn-primary" : "btn-secondary" %> btn-sm">Completed</a>
                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?filter=REJECTED" class="btn <%= "REJECTED".equalsIgnoreCase(currentFilter) ? "btn-primary" : "btn-secondary" %> btn-sm">Rejected</a>
            </div>
        </div>

        <% if (appointments == null || appointments.isEmpty()) { %>
            <div style="text-align: center; padding: 50px 20px; color: #94a3b8;">
                <div style="font-size: 40px; margin-bottom: 8px;">📋</div>
                <p style="margin: 0; font-size: 15px;">No appointments found for filter "<%= currentFilter %>".</p>
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Date & Time</th>
                        <th>Patient Name</th>
                        <th>Phone / Email</th>
                        <th>Type</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Appointment a : appointments) { %>
                        <tr>
                            <td>
                                <div><strong><%= a.getAppointmentDate() %></strong></div>
                                <div style="font-size: 12px; color: #64748b;"><%= a.getAppointmentTime() %></div>
                            </td>
                            <td><strong><%= a.getPatientName() %></strong></td>
                            <td>
                                <div><%= a.getPatientPhone() != null ? a.getPatientPhone() : "N/A" %></div>
                                <div style="font-size: 12px; color: #64748b;"><%= a.getPatientEmail() != null ? a.getPatientEmail() : "" %></div>
                            </td>
                            <td>
                                <span class="badge" style="background:#e0f2fe; color:#0369a1;"><%= a.getAppointmentType() %></span>
                            </td>
                            <td><%= a.getReason() != null ? a.getReason() : "General Consultation" %></td>
                            <td>
                                <% if ("PENDING".equalsIgnoreCase(a.getStatus())) { %>
                                    <span class="badge badge-pending">Pending</span>
                                <% } else if ("ACCEPTED".equalsIgnoreCase(a.getStatus())) { %>
                                    <span class="badge badge-accepted">Accepted</span>
                                <% } else if ("COMPLETED".equalsIgnoreCase(a.getStatus())) { %>
                                    <span class="badge badge-completed">Completed</span>
                                <% } else if ("REJECTED".equalsIgnoreCase(a.getStatus())) { %>
                                    <span class="badge badge-rejected">Rejected</span>
                                <% } else { %>
                                    <span class="badge badge-secondary"><%= a.getStatus() %></span>
                                <% } %>
                            </td>
                            <td>
                                <div style="display: flex; gap: 6px; flex-wrap: wrap;">
                                    <% if ("PENDING".equalsIgnoreCase(a.getStatus())) { %>
                                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=accept&id=<%= a.getAppointmentId() %>" class="btn btn-success btn-sm">Accept</a>
                                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=reject&id=<%= a.getAppointmentId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Reject this appointment request?');">Reject</a>
                                    <% } else if ("ACCEPTED".equalsIgnoreCase(a.getStatus())) { %>
                                        <a href="<%= request.getContextPath() %>/DoctorConsultationServlet?action=start&appointmentId=<%= a.getAppointmentId() %>" class="btn btn-primary btn-sm">Start Consultation</a>
                                    <% } %>
                                    <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=view&id=<%= a.getAppointmentId() %>" class="btn btn-secondary btn-sm">Details</a>
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
