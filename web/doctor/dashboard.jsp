<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="doctor.model.Doctor" %>
<%@ page import="doctor.model.Appointment" %>
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
    List<Appointment> pendingAppointments = (List<Appointment>) request.getAttribute("pendingAppointments");
    List<Appointment> todayAppointments = (List<Appointment>) request.getAttribute("todayAppointments");
    List<Appointment> doctorQueue = (List<Appointment>) request.getAttribute("doctorQueue");
    if (doctorQueue == null && doctor != null) {
        doctor.dao.AppointmentDAO apptDAO = new doctor.dao.AppointmentDAO();
        doctorQueue = apptDAO.getDoctorQueue(doctor.getDoctorId());
    }
    Integer unreadNotifications = (Integer) request.getAttribute("unreadNotifications");
    if (unreadNotifications == null) unreadNotifications = 0;
    String msgParam = request.getParameter("msg");
%>

<main class="app-container">

    <% if ("accepted".equalsIgnoreCase(msgParam)) { %>
        <div class="alert alert-success" style="padding: 12px 16px; margin-bottom: 20px; background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; border-radius: 8px; font-weight: 500;">
            ✓ Appointment accepted successfully!
        </div>
    <% } else if ("rejected".equalsIgnoreCase(msgParam)) { %>
        <div class="alert alert-danger" style="padding: 12px 16px; margin-bottom: 20px; background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; border-radius: 8px; font-weight: 500;">
            ✕ Appointment request rejected.
        </div>
    <% } %>

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

    <!-- DOCTOR LIVE PATIENT QUEUE SYSTEM -->
    <div class="card" style="border-top: 4px solid #0284c7; box-shadow: 0 4px 14px rgba(2, 132, 199, 0.08);">
        <%
            Appointment nextPatient = (doctorQueue != null && !doctorQueue.isEmpty()) ? doctorQueue.get(0) : null;
        %>
        <div class="card-title" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
            <div style="display: flex; align-items: center; gap: 10px;">
                <span style="font-weight: 700; color: #0369a1; font-size: 17px;">🩺 Live Patient Queue System</span>
                <span class="badge" style="background: #ecfdf5; color: #047857; font-weight: 700; border: 1px solid #a7f3d0;">
                    🟢 Live Queue Active
                </span>
            </div>
            <div style="font-size: 13px; color: #64748b;">
                Patients in Queue: <strong style="color: #0f172a; font-size: 15px;"><%= doctorQueue != null ? doctorQueue.size() : 0 %></strong>
            </div>
        </div>

        <% if (nextPatient != null) { %>
            <%
                boolean isOnlineNext = "ONLINE".equalsIgnoreCase(nextPatient.getAppointmentType());
                boolean isAcceptedNext = "ACCEPTED".equalsIgnoreCase(nextPatient.getStatus());

                String nextApptDate = nextPatient.getAppointmentDate();
                String formattedDay = "";
                String formattedDate = nextApptDate;
                try {
                    java.time.LocalDate ld = java.time.LocalDate.parse(nextApptDate);
                    formattedDay = ld.format(java.time.format.DateTimeFormatter.ofPattern("EEEE"));
                    formattedDate = ld.format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy"));
                } catch (Exception ignored) {}
            %>
            <!-- NEXT UP HERO CARD -->
            <div style="background: linear-gradient(135deg, #f0fdf4 0%, #ecfeff 100%); border: 1.5px solid #86efac; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
                <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 16px;">
                    <div style="display: flex; gap: 16px; align-items: flex-start;">
                        <div style="width: 52px; height: 52px; border-radius: 50%; background: #0284c7; color: white; display: flex; align-items: center; justify-content: center; font-size: 22px; font-weight: bold; flex-shrink: 0; box-shadow: 0 3px 10px rgba(2, 132, 199, 0.3);">
                            #1
                        </div>
                        <div>
                            <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                <span class="badge" style="background: #15803d; color: white; font-weight: 800; font-size: 11px; letter-spacing: 0.5px;">
                                    NEXT PATIENT IN QUEUE
                                </span>
                                <span class="badge" style="background:<%= isOnlineNext ? "#e0f2fe; color:#0369a1;" : "#fef3c7; color:#92400e;" %> font-weight: 600;">
                                    <%= isOnlineNext ? "📹 Online Video Consultation" : "🏥 In-Person Hospital Visit" %>
                                </span>
                                <% if ("ACCEPTED".equalsIgnoreCase(nextPatient.getStatus())) { %>
                                    <span class="badge badge-accepted">Accepted (Ready)</span>
                                <% } else { %>
                                    <span class="badge badge-pending">Pending Confirmation</span>
                                <% } %>
                            </div>

                            <h3 style="margin: 8px 0 4px; font-size: 20px; color: #0f172a;">
                                <%= nextPatient.getPatientName() %>
                            </h3>

                            <!-- DAY AND DATE PROMINENT DISPLAY -->
                            <div style="display: flex; gap: 16px; flex-wrap: wrap; font-size: 13px; color: #334155; margin-top: 6px; background: rgba(2, 132, 199, 0.08); padding: 8px 12px; border-radius: 6px; border: 1px solid rgba(2, 132, 199, 0.2);">
                                <span>🗓️ Day: <strong style="color: #0369a1; font-size: 14px;"><%= !formattedDay.isEmpty() ? formattedDay : "N/A" %></strong></span>
                                <span>📅 Date: <strong style="color: #0369a1; font-size: 14px;"><%= formattedDate %></strong></span>
                                <span>⏰ Time: <strong style="color: #0369a1; font-size: 14px;"><%= nextPatient.getAppointmentTime() %></strong></span>
                            </div>

                            <div style="display: flex; gap: 18px; flex-wrap: wrap; font-size: 13px; color: #475569; margin-top: 8px;">
                                <span>📞 <%= nextPatient.getPatientPhone() != null && !nextPatient.getPatientPhone().isEmpty() ? nextPatient.getPatientPhone() : "N/A" %></span>
                                <% if (nextPatient.getPatientEmail() != null && !nextPatient.getPatientEmail().isEmpty()) { %>
                                    <span>✉️ <%= nextPatient.getPatientEmail() %></span>
                                <% } %>
                            </div>

                            <div style="margin-top: 10px; font-size: 13px; color: #334155; background: rgba(255,255,255,0.7); padding: 8px 12px; border-radius: 6px; display: inline-block; border: 1px solid rgba(0,0,0,0.06);">
                                <strong>Reason / Symptoms:</strong> <%= nextPatient.getReason() != null && !nextPatient.getReason().isEmpty() ? nextPatient.getReason() : "General Consultation" %>
                            </div>
                        </div>
                    </div>

                    <!-- ACTION BUTTONS FOR NEXT PATIENT -->
                    <div style="display: flex; flex-direction: column; gap: 8px; align-self: center;">
                        <% if (isAcceptedNext) { %>
                            <% if (isOnlineNext) { %>
                                <a href="<%= request.getContextPath() %>/DoctorConsultationServlet?action=start&appointmentId=<%= nextPatient.getAppointmentId() %>" 
                                   class="btn btn-primary" 
                                   style="background: #16a34a; border-color: #16a34a; font-weight: 700; padding: 10px 18px; display: inline-flex; align-items: center; gap: 8px; text-decoration: none; border-radius: 6px; box-shadow: 0 3px 10px rgba(22, 163, 74, 0.3);">
                                   📹 Start Video Consultation &rarr;
                                </a>
                            <% } else { %>
                                <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new&patientId=<%= nextPatient.getPatientId() %>&appointmentId=<%= nextPatient.getAppointmentId() %>" 
                                   class="btn btn-primary" 
                                   style="background: #0284c7; border-color: #0284c7; font-weight: 700; padding: 10px 18px; display: inline-flex; align-items: center; gap: 8px; text-decoration: none; border-radius: 6px; box-shadow: 0 3px 10px rgba(2, 132, 199, 0.3);">
                                   💊 Treat &amp; Add Prescription &rarr;
                                </a>
                            <% } %>
                        <% } else { %>
                            <div style="display: flex; gap: 6px;">
                                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=accept&id=<%= nextPatient.getAppointmentId() %>&redirect=dashboard" 
                                   class="btn btn-success" 
                                   style="font-weight: 600; padding: 8px 14px; text-decoration: none;">
                                   ✓ Accept Patient
                                </a>
                                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=reject&id=<%= nextPatient.getAppointmentId() %>&redirect=dashboard" 
                                   class="btn btn-danger" 
                                   style="font-weight: 600; padding: 8px 12px; text-decoration: none;"
                                   onclick="return confirm('Reject this appointment?');">
                                   ✕ Reject
                                </a>
                            </div>
                        <% } %>
                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=view&id=<%= nextPatient.getAppointmentId() %>" 
                           class="btn btn-secondary" 
                           style="text-align: center; text-decoration: none; font-size: 13px;">
                           View Patient Details
                        </a>
                    </div>
                </div>
            </div>

            <!-- UPCOMING QUEUE LIST (IF MORE THAN 1 PATIENT IN QUEUE) -->
            <% if (doctorQueue.size() > 1) { %>
                <div style="margin-top: 14px; margin-bottom: 8px;">
                    <h4 style="margin: 0 0 10px; font-size: 14px; color: #475569; text-transform: uppercase; letter-spacing: 0.5px;">
                        Remaining Patients in Line (<%= doctorQueue.size() - 1 %> Waiting)
                    </h4>
                    <table class="data-table" style="font-size: 13px;">
                        <thead>
                            <tr>
                                <th style="width: 75px;">Queue #</th>
                                <th>Day &amp; Date</th>
                                <th>Time</th>
                                <th>Patient Name</th>
                                <th>Contact</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int qIdx = 1; qIdx < doctorQueue.size(); qIdx++) { 
                                Appointment qAppt = doctorQueue.get(qIdx);
                                boolean isQOnline = "ONLINE".equalsIgnoreCase(qAppt.getAppointmentType());
                                String qDay = "";
                                String qDate = qAppt.getAppointmentDate();
                                try {
                                    java.time.LocalDate qld = java.time.LocalDate.parse(qAppt.getAppointmentDate());
                                    qDay = qld.format(java.time.format.DateTimeFormatter.ofPattern("EEEE"));
                                    qDate = qld.format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy"));
                                } catch (Exception ignored) {}
                            %>
                                <tr>
                                    <td>
                                        <span class="badge" style="background: #e2e8f0; color: #1e293b; font-weight: 700;">
                                            #<%= qIdx + 1 %>
                                        </span>
                                    </td>
                                    <td>
                                        <div style="font-weight: 700; color: #0369a1;">🗓️ <%= qDay %></div>
                                        <div style="font-size: 12px; color: #64748b;">📅 <%= qDate %></div>
                                    </td>
                                    <td><strong><%= qAppt.getAppointmentTime() %></strong></td>
                                    <td><strong><%= qAppt.getPatientName() %></strong></td>
                                    <td><%= qAppt.getPatientPhone() != null && !qAppt.getPatientPhone().isEmpty() ? qAppt.getPatientPhone() : "N/A" %></td>
                                    <td>
                                        <span class="badge" style="background:<%= isQOnline ? "#e0f2fe; color:#0369a1;" : "#fef3c7; color:#92400e;" %> font-size: 11px;">
                                            <%= isQOnline ? "Online Video" : "In-Person Visit" %>
                                        </span>
                                    </td>
                                    <td>
                                        <% if ("ACCEPTED".equalsIgnoreCase(qAppt.getStatus())) { %>
                                            <span class="badge badge-accepted">Accepted</span>
                                        <% } else { %>
                                            <span class="badge badge-pending">Pending</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 6px;">
                                            <% if ("ACCEPTED".equalsIgnoreCase(qAppt.getStatus())) { %>
                                                <% if (isQOnline) { %>
                                                    <a href="<%= request.getContextPath() %>/DoctorConsultationServlet?action=start&appointmentId=<%= qAppt.getAppointmentId() %>" class="btn btn-primary btn-sm">Start</a>
                                                <% } else { %>
                                                    <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new&patientId=<%= qAppt.getPatientId() %>&appointmentId=<%= qAppt.getAppointmentId() %>" class="btn btn-primary btn-sm" style="background:#0284c7; border-color:#0284c7;">+ Prescribe</a>
                                                <% } %>
                                            <% } else { %>
                                                <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=accept&id=<%= qAppt.getAppointmentId() %>&redirect=dashboard" class="btn btn-success btn-sm">Accept</a>
                                            <% } %>
                                            <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=view&id=<%= qAppt.getAppointmentId() %>" class="btn btn-secondary btn-sm">Details</a>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>

        <% } else { %>
            <div style="text-align: center; padding: 30px 20px; color: #94a3b8;">
                <div style="font-size: 32px; margin-bottom: 6px;">🎉</div>
                <p style="margin: 0; font-size: 15px; font-weight: 500; color: #475569;">No patients waiting in queue right now.</p>
                <p style="margin: 4px 0 0; font-size: 13px;">New patient appointments will appear here as soon as they are scheduled.</p>
            </div>
        <% } %>
    </div>

    <!-- PENDING APPOINTMENT REQUESTS (SENT BY PATIENTS) -->
    <div class="card" style="border-top: 4px solid #f59e0b;">
        <div class="card-title" style="display: flex; justify-content: space-between; align-items: center;">
            <div style="display: flex; align-items: center; gap: 8px;">
                <span style="font-weight: 700; color: #b45309;">🔔 Pending Appointment Requests</span>
                <span class="badge" style="background: #fef3c7; color: #92400e; font-weight: 600;">
                    <%= pendingAppointments != null ? pendingAppointments.size() : 0 %> New
                </span>
            </div>
            <span style="font-size: 13px; font-weight: normal; color: #64748b;">
                Requests submitted by patients awaiting your confirmation
            </span>
        </div>

        <% if (pendingAppointments == null || pendingAppointments.isEmpty()) { %>
            <div style="text-align: center; padding: 25px 20px; color: #94a3b8;">
                <p style="margin: 0; font-size: 14px;">No pending appointment requests right now.</p>
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Date & Time</th>
                        <th>Patient Name</th>
                        <th>Phone / Email</th>
                        <th>Type</th>
                        <th>Reason / Symptoms</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Appointment pAppt : pendingAppointments) { %>
                        <tr style="background: #fffbeb;">
                            <td>
                                <div><strong><%= pAppt.getAppointmentDate() %></strong></div>
                                <div style="font-size: 12px; color: #64748b;"><%= pAppt.getAppointmentTime() %></div>
                            </td>
                            <td>
                                <strong style="color: #0f172a;"><%= pAppt.getPatientName() %></strong>
                                <% if (pAppt.getPatientGender() != null && !pAppt.getPatientGender().isEmpty()) { %>
                                    <span style="font-size: 11px; color: #64748b;">(<%= pAppt.getPatientGender() %>)</span>
                                <% } %>
                            </td>
                            <td>
                                <div><%= pAppt.getPatientPhone() != null && !pAppt.getPatientPhone().isEmpty() ? pAppt.getPatientPhone() : "N/A" %></div>
                                <div style="font-size: 12px; color: #64748b;"><%= pAppt.getPatientEmail() != null ? pAppt.getPatientEmail() : "" %></div>
                            </td>
                            <td>
                                <% boolean isOnlineP = "ONLINE".equalsIgnoreCase(pAppt.getAppointmentType()); %>
                                <span class="badge" style="background:<%= isOnlineP ? "#e0f2fe; color:#0369a1;" : "#fef3c7; color:#92400e;" %>">
                                    <%= isOnlineP ? "Online Video" : "In-Person Visit" %>
                                </span>
                            </td>
                            <td>
                                <span><%= pAppt.getReason() != null && !pAppt.getReason().isEmpty() ? pAppt.getReason() : "General Consultation" %></span>
                            </td>
                            <td>
                                <div style="display: flex; gap: 8px;">
                                    <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=accept&id=<%= pAppt.getAppointmentId() %>&redirect=dashboard" 
                                       class="btn btn-success btn-sm" 
                                       style="background: #10b981; color: white; padding: 5px 12px; border-radius: 4px; text-decoration: none; font-weight: 600;">
                                       ✓ Accept
                                    </a>
                                    <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=reject&id=<%= pAppt.getAppointmentId() %>&redirect=dashboard" 
                                       class="btn btn-danger btn-sm" 
                                       style="background: #ef4444; color: white; padding: 5px 12px; border-radius: 4px; text-decoration: none; font-weight: 600;"
                                       onclick="return confirm('Are you sure you want to reject this appointment request?');">
                                       ✕ Reject
                                    </a>
                                    <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=view&id=<%= pAppt.getAppointmentId() %>" 
                                       class="btn btn-secondary btn-sm"
                                       style="background: #e2e8f0; color: #334155; padding: 5px 10px; border-radius: 4px; text-decoration: none;">
                                       Details
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
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
                                <% boolean isOnlineA = "ONLINE".equalsIgnoreCase(appt.getAppointmentType()); %>
                                <span class="badge" style="background:<%= isOnlineA ? "#e0f2fe; color:#0369a1;" : "#fef3c7; color:#92400e;" %>">
                                    <%= isOnlineA ? "Online Video" : "In-Person Visit" %>
                                </span>
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
                                    <% boolean isOnline = "ONLINE".equalsIgnoreCase(appt.getAppointmentType()); %>
                                    <% if ("PENDING".equalsIgnoreCase(appt.getStatus())) { %>
                                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=accept&id=<%= appt.getAppointmentId() %>" class="btn btn-success btn-sm">Accept</a>
                                        <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet?action=reject&id=<%= appt.getAppointmentId() %>" class="btn btn-danger btn-sm">Reject</a>
                                    <% } else if ("ACCEPTED".equalsIgnoreCase(appt.getStatus())) { %>
                                        <% if (isOnline) { %>
                                            <a href="<%= request.getContextPath() %>/DoctorConsultationServlet?action=start&appointmentId=<%= appt.getAppointmentId() %>" class="btn btn-primary btn-sm">Start Consultation</a>
                                        <% } else { %>
                                            <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new&patientId=<%= appt.getPatientId() %>&appointmentId=<%= appt.getAppointmentId() %>" class="btn btn-primary btn-sm" style="background:#0284c7; border-color:#0284c7;">+ Add Prescription</a>
                                        <% } %>
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
