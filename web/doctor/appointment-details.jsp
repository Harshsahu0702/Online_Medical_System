<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.doctor.Appointment" %>
<%@ page import="model.doctor.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Details - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    Appointment appt = (Appointment) request.getAttribute("appointment");
    Patient patient = (Patient) request.getAttribute("patient");
%>

<main class="app-container">

    <div style="margin-bottom: 18px;">
        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet" class="btn btn-secondary btn-sm">← Back to Appointments</a>
    </div>

    <% if (appt != null) { %>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
            
            <!-- APPOINTMENT INFO -->
            <div class="card">
                <div class="card-title">
                    <span>Appointment Info #<%= appt.getAppointmentId() %></span>
                    <% if ("PENDING".equalsIgnoreCase(appt.getStatus())) { %>
                        <span class="badge badge-pending">Pending</span>
                    <% } else if ("ACCEPTED".equalsIgnoreCase(appt.getStatus())) { %>
                        <span class="badge badge-accepted">Accepted</span>
                    <% } else if ("COMPLETED".equalsIgnoreCase(appt.getStatus())) { %>
                        <span class="badge badge-completed">Completed</span>
                    <% } else { %>
                        <span class="badge badge-rejected"><%= appt.getStatus() %></span>
                    <% } %>
                </div>

                <div style="display: flex; flex-direction: column; gap: 14px; font-size: 14px;">
                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Appointment Date</strong>
                        <span style="font-size: 16px; font-weight: 600;"><%= appt.getAppointmentDate() %></span>
                    </div>

                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Scheduled Time</strong>
                        <span style="font-size: 16px; font-weight: 600;"><%= appt.getAppointmentTime() %></span>
                    </div>

                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Consultation Mode</strong>
                        <span class="badge" style="background:#e0f2fe; color:#0369a1; margin-top: 4px;"><%= appt.getAppointmentType() %></span>
                    </div>

                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Reason for Visit</strong>
                        <p style="margin: 4px 0 0; background: #f8fafc; padding: 12px; border-radius: 6px; border: 1px solid #e2e8f0;">
                            <%= (appt.getReason() != null && !appt.getReason().isEmpty()) ? appt.getReason() : "No specific symptoms or notes provided." %>
                        </p>
                    </div>

                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Booking Timestamp</strong>
                        <span><%= appt.getCreatedAt() != null ? appt.getCreatedAt() : "N/A" %></span>
                    </div>
                </div>

                <div style="margin-top: 24px; padding-top: 18px; border-top: 1px solid #edf2f7; display: flex; gap: 10px; flex-wrap: wrap;">
                    <% if ("PENDING".equalsIgnoreCase(appt.getStatus())) { %>
                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=accept&id=<%= appt.getAppointmentId() %>" class="btn btn-success">Accept Appointment</a>
                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=reject&id=<%= appt.getAppointmentId() %>" class="btn btn-danger" onclick="return confirm('Reject this appointment?');">Reject</a>
                    <% } else if ("ACCEPTED".equalsIgnoreCase(appt.getStatus())) { %>
                        <a href="<%= request.getContextPath() %>/DoctorConsultationServlet?action=start&appointmentId=<%= appt.getAppointmentId() %>" class="btn btn-primary">Start Online Consultation</a>
                    <% } %>
                    <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new&patientId=<%= appt.getPatientId() %>" class="btn btn-secondary">Write Prescription</a>
                </div>
            </div>

            <!-- PATIENT PROFILE SNAPSHOT -->
            <div class="card">
                <div class="card-title">
                    <span>Patient Profile</span>
                    <a href="<%= request.getContextPath() %>/DoctorPatientServlet?action=view&id=<%= appt.getPatientId() %>" class="btn btn-secondary btn-sm">Full Medical Record</a>
                </div>

                <div style="display: flex; flex-direction: column; gap: 14px; font-size: 14px;">
                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Patient Name</strong>
                        <span style="font-size: 17px; font-weight: bold; color: #244b6b;"><%= appt.getPatientName() %></span>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                        <div>
                            <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Phone</strong>
                            <span><%= (patient != null && patient.getPhone() != null) ? patient.getPhone() : (appt.getPatientPhone() != null ? appt.getPatientPhone() : "N/A") %></span>
                        </div>
                        <div>
                            <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Email</strong>
                            <span><%= (patient != null && patient.getEmail() != null) ? patient.getEmail() : (appt.getPatientEmail() != null ? appt.getPatientEmail() : "N/A") %></span>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                        <div>
                            <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Gender</strong>
                            <span><%= (patient != null && patient.getGender() != null) ? patient.getGender() : (appt.getPatientGender() != null ? appt.getPatientGender() : "N/A") %></span>
                        </div>
                        <div>
                            <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Blood Group</strong>
                            <span class="badge" style="background: #fee2e2; color: #991b1b;"><%= (patient != null && patient.getBloodGroup() != null) ? patient.getBloodGroup() : "N/A" %></span>
                        </div>
                    </div>

                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Date of Birth</strong>
                        <span><%= (patient != null && patient.getDob() != null) ? patient.getDob() : "Not Specified" %></span>
                    </div>

                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Residential Address</strong>
                        <span><%= (patient != null && patient.getAddress() != null) ? patient.getAddress() : "N/A" %></span>
                    </div>

                    <div>
                        <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Emergency Contact</strong>
                        <span><%= (patient != null && patient.getEmergencyContact() != null) ? patient.getEmergencyContact() : "N/A" %></span>
                    </div>
                </div>
            </div>

        </div>

    <% } else { %>
        <div class="alert alert-danger">Appointment not found.</div>
    <% } %>

</main>

</body>
</html>
