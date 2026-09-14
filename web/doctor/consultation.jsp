<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Consultation" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultation Management - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<Consultation> consultations = (List<Consultation>) request.getAttribute("consultations");
%>

<main class="app-container">

    <div class="card">
        <div class="card-title">
            <span>Consultation Sessions</span>
            <span style="font-size: 13px; font-weight: normal; color: #64748b;">
                Active, scheduled and completed consultations
            </span>
        </div>

        <% if (consultations == null || consultations.isEmpty()) { %>
            <div style="text-align: center; padding: 50px 20px; color: #94a3b8;">
                <div style="font-size: 40px; margin-bottom: 8px;">📹</div>
                <p style="margin: 0; font-size: 15px;">No consultations recorded yet.</p>
                <p style="font-size: 13px; margin-top: 4px;">Start a consultation from accepted appointments in the Appointments tab.</p>
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Session ID</th>
                        <th>Patient</th>
                        <th>Appointment Date/Time</th>
                        <th>Status</th>
                        <th>Started / Ended</th>
                        <th>Meeting Link</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Consultation c : consultations) { %>
                        <tr>
                            <td><strong>#<%= c.getConsultationId() %></strong></td>
                            <td><strong><%= c.getPatientName() %></strong></td>
                            <td>
                                <div><%= c.getAppointmentDate() %></div>
                                <div style="font-size: 12px; color: #64748b;"><%= c.getAppointmentTime() %></div>
                            </td>
                            <td>
                                <% if ("ONGOING".equalsIgnoreCase(c.getConsultationStatus())) { %>
                                    <span class="badge badge-ongoing">Ongoing</span>
                                <% } else if ("COMPLETED".equalsIgnoreCase(c.getConsultationStatus())) { %>
                                    <span class="badge badge-completed">Completed</span>
                                <% } else { %>
                                    <span class="badge badge-pending">Scheduled</span>
                                <% } %>
                            </td>
                            <td style="font-size: 12px;">
                                <div>Started: <%= c.getStartedAt() != null ? c.getStartedAt() : "Not yet" %></div>
                                <div>Ended: <%= c.getEndedAt() != null ? c.getEndedAt() : "-" %></div>
                            </td>
                            <td>
                                <% if (c.getMeetingLink() != null && !c.getMeetingLink().isEmpty()) { %>
                                    <a href="<%= c.getMeetingLink() %>" target="_blank" class="btn btn-sm" style="background:#e0f2fe; color:#0369a1; text-decoration:none;">Open Video Room</a>
                                <% } else { %>
                                    <span style="color:#94a3b8;">N/A</span>
                                <% } %>
                            </td>
                            <td>
                                <div style="display: flex; gap: 6px;">
                                    <a href="<%= request.getContextPath() %>/DoctorConsultationServlet?action=meeting&id=<%= c.getConsultationId() %>" class="btn btn-primary btn-sm">
                                        <%= "COMPLETED".equalsIgnoreCase(c.getConsultationStatus()) ? "View Notes" : "Enter Dashboard" %>
                                    </a>
                                    <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new&consultationId=<%= c.getConsultationId() %>&patientId=<%= c.getPatientId() %>" class="btn btn-secondary btn-sm">Prescribe</a>
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
