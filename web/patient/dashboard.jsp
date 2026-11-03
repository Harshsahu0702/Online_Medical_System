<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="patient.model.Patient" %>
<%@ page import="patient.model.PatientAppointments" %>
<%@ page import="patient.model.Prescriptions" %>
<%@ page import="patient.model.Orders" %>
<%
    request.setAttribute("pageTitle", "Dashboard");
    request.setAttribute("pageDescription", "Overview of your healthcare activity, appointments, medications, and health information.");
%>

<% 
    Patient patient = (Patient) request.getAttribute("patient");
    if (patient == null) {
        String sPid = (String) session.getAttribute("patientId");
        if (sPid != null) {
            patient = new Patient().getPatientById(sPid);
        }
    }
    String name = (patient != null && patient.getName() != null) ? patient.getName() : (String) session.getAttribute("patientName");
    if (name == null || name.trim().isEmpty()) {
        name = "Patient";
    }

    String patientId = (String) session.getAttribute("patientId");
    PatientAppointments latestAppt = null;
    ArrayList<Prescriptions> recentPrescriptions = null;
    ArrayList<Orders> recentOrders = null;
    int totalApptsCount = 0;
    int upcomingApptsCount = 0;
    int totalPrescriptionsCount = 0;
    int totalOrdersCount = 0;
    Orders latestOrder = null;

    if (patientId != null && !patientId.trim().isEmpty()) {
        try {
            PatientAppointments paModel = new PatientAppointments();
            ArrayList<PatientAppointments> appts = paModel.getAppointments(patientId);
            if (appts != null && !appts.isEmpty()) {
                totalApptsCount = appts.size();
                for (PatientAppointments a : appts) {
                    if ("ACCEPTED".equalsIgnoreCase(a.getStatus()) || "PENDING".equalsIgnoreCase(a.getStatus()) || "CONFIRMED".equalsIgnoreCase(a.getStatus())) {
                        upcomingApptsCount++;
                        if (latestAppt == null) {
                            latestAppt = a;
                        }
                    }
                }
                if (latestAppt == null) latestAppt = appts.get(0);
            }

            Prescriptions prModel = new Prescriptions();
            recentPrescriptions = prModel.getPrescriptionByPatientId(patientId);
            if (recentPrescriptions != null) {
                totalPrescriptionsCount = recentPrescriptions.size();
            }

            Orders oModel = new Orders();
            recentOrders = oModel.getOrdersByPatientId(patientId, null);
            if (recentOrders != null && !recentOrders.isEmpty()) {
                totalOrdersCount = recentOrders.size();
                latestOrder = recentOrders.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">

                        <title>MediCore | Patient Dashboard</title>

                        <!-- Common Patient Styles -->
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">

                        <!-- Dashboard Styles -->
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/dashboard.css">
                    </head>

                    <body>

                        <!-- ================================================================
         APPLICATION LAYOUT
         ================================================================ -->

                        <div class="app-layout">

                            <!-- ============================================================
             SIDEBAR COMPONENT
             ============================================================ -->

                            <jsp:include page="components/sidebar.jsp" />

                            <!-- ============================================================
             MAIN APPLICATION AREA
             ============================================================ -->

                            <div class="app-main">

                                <!-- ========================================================
                 NAVBAR COMPONENT
                 ======================================================== -->

                                <jsp:include page="components/navbar.jsp" />

                                <!-- ========================================================
                 DASHBOARD CONTENT
                 ======================================================== -->

                                <main class="page-container">

                                    <!-- ====================================================
                     PAGE HEADER
                     ==================================================== -->

                                    <jsp:include page="components/patient-header.jsp" />

                                    <!-- ====================================================
                                                     WELCOME BANNER
                                                     ==================================================== -->

                                    <section class="dash-welcome-banner">
                                        <div class="dash-welcome-text">
                                            <h2>Welcome back, <%= name %> 👋</h2>
                                            <p>
                                                <% if (latestAppt != null) { %>
                                                    You have a consultation with <strong>Dr. <%= latestAppt.getDoctorName() != null ? latestAppt.getDoctorName() : "Doctor" %></strong> (<%= latestAppt.getAppointmentDate() != null ? latestAppt.getAppointmentDate() : "Scheduled" %>). Manage your appointments, prescriptions, and pharmacy orders below.
                                                <% } else { %>
                                                    Manage your appointments, digital prescriptions, and pharmacy medicine deliveries from your personal health portal.
                                                <% } %>
                                            </p>
                                        </div>
                                        <div class="dash-welcome-actions">
                                            <a href="${pageContext.request.contextPath}/patient/appointments/book-appointments.jsp"
                                                class="btn btn-secondary dash-book-btn">
                                                <svg class="icon icon-sm" viewBox="0 0 24 24" aria-hidden="true">
                                                    <path d="M12 5v14" />
                                                    <path d="M5 12h14" />
                                                </svg>
                                                Book Consultation
                                            </a>
                                        </div>
                                    </section>

                                    <!-- ====================================================
                                                     KEY HEALTH & ACTIVITY METRICS
                                                     ==================================================== -->

                                    <section class="vitals-grid" aria-label="Key health metrics">

                                        <!-- Total Appointments -->
                                        <a href="${pageContext.request.contextPath}/patient/appointments/appointments.jsp" class="vital-card" style="text-decoration: none; color: inherit;">
                                            <div class="vital-icon-box vital-blood-pressure" style="background: #e0f2fe; color: #0284c7;">
                                                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                    <rect width="18" height="18" x="3" y="4" rx="2" ry="2"/>
                                                    <line x1="16" x2="16" y1="2" y2="6"/>
                                                    <line x1="8" x2="8" y1="2" y2="6"/>
                                                    <line x1="3" x2="21" y1="10" y2="10"/>
                                                </svg>
                                            </div>
                                            <div>
                                                <div class="vital-value">
                                                    <%= totalApptsCount %>
                                                    <span style="font-size: 13px; font-weight: 500; color: #0284c7;">total</span>
                                                </div>
                                                <div class="vital-label">
                                                    <%= upcomingApptsCount > 0 ? (upcomingApptsCount + " Upcoming") : "Consultations" %>
                                                </div>
                                            </div>
                                        </a>

                                        <!-- Prescriptions -->
                                        <a href="${pageContext.request.contextPath}/patient/prescriptions" class="vital-card" style="text-decoration: none; color: inherit;">
                                            <div class="vital-icon-box vital-heart-rate" style="background: #fef3c7; color: #d97706;">
                                                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                    <path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 0 0 7 7Z"/>
                                                    <path d="m8.5 8.5 7 7"/>
                                                </svg>
                                            </div>
                                            <div>
                                                <div class="vital-value">
                                                    <%= totalPrescriptionsCount %>
                                                    <span style="font-size: 13px; font-weight: 500; color: #d97706;">issued</span>
                                                </div>
                                                <div class="vital-label">
                                                    Digital Prescriptions
                                                </div>
                                            </div>
                                        </a>

                                        <!-- Pharmacy Orders -->
                                        <a href="${pageContext.request.contextPath}/patient/orders" class="vital-card" style="text-decoration: none; color: inherit;">
                                            <div class="vital-icon-box vital-glucose" style="background: #ecfdf5; color: #059669;">
                                                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                    <circle cx="8" cy="21" r="1"/>
                                                    <circle cx="19" cy="21" r="1"/>
                                                    <path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/>
                                                </svg>
                                            </div>
                                            <div>
                                                <div class="vital-value">
                                                    <%= totalOrdersCount %>
                                                    <span style="font-size: 13px; font-weight: 500; color: #059669;">orders</span>
                                                </div>
                                                <div class="vital-label">
                                                    Pharmacy Deliveries
                                                </div>
                                            </div>
                                        </a>

                                        <!-- Emergency SOS -->
                                        <a href="${pageContext.request.contextPath}/patient/emergency/emergency.jsp" class="vital-card" style="text-decoration: none; color: inherit;">
                                            <div class="vital-icon-box vital-general" style="background: #fee2e2; color: #dc2626;">
                                                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                    <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
                                                </svg>
                                            </div>
                                            <div>
                                                <div class="vital-value" style="color: #dc2626;">
                                                    24/7
                                                    <span style="font-size: 13px; font-weight: 600; color: #dc2626;">Active</span>
                                                </div>
                                                <div class="vital-label">
                                                    SOS Ambulance Support
                                                </div>
                                            </div>
                                        </a>
                                    </section>

                                    <!-- ====================================================
                     QUICK ACTIONS
                     ==================================================== -->

                                    <section class="quick-actions-bar" aria-label="Quick actions">

                                        <!-- Check Symptoms -->

                                        <a href="${pageContext.request.contextPath}/patient/medical-assistant/medical-assistant.jsp"
                                            class="quick-action-btn">
                                            <div class="quick-action-icon quick-action-assistant">
                                                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                    <path
                                                        d="m12 3-1.9 5.8a2 2 0 0 1-1.3 1.3L3 12l5.8 1.9a2 2 0 0 1 1.3 1.3L12 21l1.9-5.8a2 2 0 0 1 1.3-1.3L21 12l-5.8-1.9a2 2 0 0 1-1.3-1.3z" />
                                                </svg>
                                            </div>
                                            <span>Check Symptoms</span>
                                        </a>

                                        <!-- Find Specialists -->

                                        <a href="${pageContext.request.contextPath}/patient/doctors/find-doctor.jsp"
                                            class="quick-action-btn">
                                            <div class="quick-action-icon quick-action-doctors">
                                                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                    <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                                                    <circle cx="9" cy="7" r="4" />
                                                </svg>
                                            </div>
                                            <span>Find Specialists</span>
                                        </a>

                                        <!-- Order Medicine -->

                                        <a href="${pageContext.request.contextPath}/patient/medicines/medicines.jsp"
                                            class="quick-action-btn">
                                            <div class="quick-action-icon quick-action-medicines">
                                                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                    <path
                                                        d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z" />
                                                </svg>
                                            </div>
                                            <span>Order Medicine</span>
                                        </a>

                                        <!-- Emergency -->
                                        <a href="${pageContext.request.contextPath}/patient/emergency/emergency.jsp"
                                            class="quick-action-btn">
                                            <div class="quick-action-icon quick-action-emergency">
                                                <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                    <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2" />
                                                </svg>
                                            </div>
                                            <span>Emergency Center</span>
                                        </a>
                                    </section>

                                    <!-- ====================================================
                     MAIN DASHBOARD GRID
                     ==================================================== -->

                                    <section class="dash-main-grid">

                                        <!-- ==================================================
                         LEFT COLUMN
                         ================================================== -->

                                        <div class="dash-column">
                                            <!-- Upcoming Consultation -->
                                            <article class="card">
                                                <div class="card-header">
                                                    <div class="card-title">
                                                        <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                            <rect width="18" height="18" x="3" y="4" rx="2" />
                                                            <path d="M16 2v4" />
                                                            <path d="M8 2v4" />
                                                            <path d="M3 10h18" />
                                                        </svg>
                                                        Upcoming Consultation
                                                    </div>
                                                    <a href="${pageContext.request.contextPath}/patient/appointments/appointments.jsp"
                                                        class="btn btn-sm btn-secondary">
                                                        View All
                                                    </a>
                                                </div>
                                                <div class="card-body">
                                                    <% if (latestAppt != null) { 
                                                        String meetUrl = latestAppt.getMeetingLink();
                                                        boolean hasMeetLink = (meetUrl != null && !meetUrl.trim().isEmpty());
                                                        boolean isConsultationActive = ("ONGOING".equalsIgnoreCase(latestAppt.getConsultationStatus())
                                                                                     || "IN_PROGRESS".equalsIgnoreCase(latestAppt.getConsultationStatus()));
                                                    %>
                                                        <div class="appointment-preview">
                                                            <div class="appointment-date" style="background: #e0f2fe; color: #0284c7; min-width: 60px; text-align: center; border-radius: 8px; padding: 6px;">
                                                                <strong style="font-size: 16px;">#<%= latestAppt.getAppointmentId() %></strong>
                                                                <span style="font-size: 11px; text-transform: uppercase;"><%= latestAppt.getStatus() %></span>
                                                            </div>
                                                            <div class="appointment-info">
                                                                <h3>Dr. <%= latestAppt.getDoctorName() != null ? latestAppt.getDoctorName() : "Doctor" %></h3>
                                                                <p><%= latestAppt.getSpecialization() != null ? latestAppt.getSpecialization() : "Medical Consultant" %></p>
                                                                <span class="badge badge-info">
                                                                    📅 <%= latestAppt.getAppointmentDate() != null ? latestAppt.getAppointmentDate() : "Scheduled" %> (<%= latestAppt.getAppointmentTime() != null ? latestAppt.getAppointmentTime() : "Assigned" %>)
                                                                </span>
                                                                <span class="badge badge-neutral">
                                                                    <%= latestAppt.getAppointmentType() != null ? latestAppt.getAppointmentType() : "Online Consultation" %>
                                                                </span>
                                                            </div>
                                                            <div class="appointment-actions" id="dashApptActions" style="display: flex; gap: 8px; flex-wrap: wrap; align-items: center;">
                                                                <a href="${pageContext.request.contextPath}/patient/appointment-detail?appointmentId=<%= latestAppt.getAppointmentId() %>"
                                                                    class="btn btn-sm btn-secondary">
                                                                    Details
                                                                </a>
                                                                <% if (hasMeetLink && (isConsultationActive || "ACCEPTED".equalsIgnoreCase(latestAppt.getStatus()) || "CONFIRMED".equalsIgnoreCase(latestAppt.getStatus()))) { %>
                                                                    <a id="dashJoinCallBtn" href="<%= meetUrl %>" target="_blank" class="btn btn-sm btn-primary" style="background: #16a34a; border-color: #16a34a; color: #ffffff; font-weight: 700; text-decoration: none; display: inline-flex; align-items: center; gap: 5px; box-shadow: 0 4px 12px rgba(22, 163, 74, 0.35);">
                                                                        📹 Join Call
                                                                    </a>
                                                                <% } else if ("ACCEPTED".equalsIgnoreCase(latestAppt.getStatus()) || "CONFIRMED".equalsIgnoreCase(latestAppt.getStatus())) { %>
                                                                    <span id="dashWaitingBadge" class="badge" style="background: #f0fdf4; color: #166534; border: 1px solid #bbf7d0; font-size: 11px; font-weight: 600; padding: 6px 12px; border-radius: 6px; display: inline-flex; align-items: center; gap: 4px;">
                                                                        ✓ Accepted • Waiting for Meeting Link
                                                                    </span>
                                                                <% } %>
                                                            </div>
                                                        </div>
                                                    <% } else { %>
                                                        <div style="padding: 24px; text-align: center; color: var(--text-muted);">
                                                            <p style="margin: 0 0 10px;">No upcoming consultations scheduled.</p>
                                                            <a href="${pageContext.request.contextPath}/patient/appointments/book-appointments.jsp" class="btn btn-sm btn-primary">Book Consultation</a>
                                                        </div>
                                                    <% } %>
                                                </div>
                                            </article>

                                            <!-- Active Prescriptions -->
                                            <article class="card">
                                                <div class="card-header">
                                                    <div class="card-title">
                                                        <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                            <path
                                                                d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 0 0 7 7Z" />
                                                        </svg>
                                                        My Prescriptions
                                                    </div>
                                                    <a href="${pageContext.request.contextPath}/patient/prescriptions/prescriptions.jsp"
                                                        class="btn btn-sm btn-secondary">
                                                        View All
                                                    </a>
                                                </div>
                                                <div class="card-body card-body-no-padding">
                                                    <% if (recentPrescriptions != null && !recentPrescriptions.isEmpty()) { %>
                                                        <div class="table-responsive">
                                                            <table class="data-table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Prescription</th>
                                                                        <th>Doctor</th>
                                                                        <th>Diagnosis</th>
                                                                        <th>Date</th>
                                                                        <th>Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% for (int i = 0; i < Math.min(recentPrescriptions.size(), 3); i++) {
                                                                        Prescriptions pr = recentPrescriptions.get(i);
                                                                    %>
                                                                        <tr>
                                                                            <td><strong>#RX-<%= pr.getPrescriptionId() %></strong></td>
                                                                            <td>Dr. <%= pr.getDoctorName() != null ? pr.getDoctorName() : "Doctor" %></td>
                                                                            <td><%= (pr.getDiagnosis() != null && !pr.getDiagnosis().trim().isEmpty()) ? pr.getDiagnosis() : "General Consultation" %></td>
                                                                            <td><%= pr.getPrescriptionDate() != null ? pr.getPrescriptionDate() : "-" %></td>
                                                                            <td>
                                                                                <a href="${pageContext.request.contextPath}/patient/prescription-detail?prescriptionId=<%= pr.getPrescriptionId() %>" class="btn btn-sm btn-primary" style="padding: 4px 10px; font-size: 12px; text-decoration: none;">
                                                                                    Order Medicines →
                                                                                </a>
                                                                            </td>
                                                                        </tr>
                                                                    <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    <% } else { %>
                                                        <div style="padding: 24px; text-align: center; color: var(--text-muted);">
                                                            <p style="margin: 0;">No active prescriptions issued yet.</p>
                                                        </div>
                                                    <% } %>
                                                </div>
                                            </article>
                                        </div>

                                        <!-- ==================================================
                         RIGHT COLUMN
                         ================================================== -->
                                        <div class="dash-column">

                                            <!-- Medical Snapshot -->

                                            <article class="card">
                                                <div class="card-header">
                                                    <div class="card-title">
                                                        <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                                                            <circle cx="12" cy="12" r="10" />
                                                            <path d="M12 16v-4" />
                                                            <path d="M12 8h.01" />
                                                        </svg>
                                                        Medical Snapshot
                                                    </div>
                                                </div>
                                                <div class="card-body snapshot-list">
                                                    <div class="snapshot-item">
                                                        <span>Blood Group:</span>
                                                        <strong style="color: #0284c7;"><%= (patient != null && patient.getBloodGroup() != null && !patient.getBloodGroup().isEmpty()) ? patient.getBloodGroup() : "Not Specified" %></strong>
                                                    </div>
                                                    <div class="snapshot-item">
                                                        <span>Gender / DOB:</span>
                                                        <strong><%= (patient != null && patient.getGender() != null) ? patient.getGender() : "N/A" %> (<%= (patient != null && patient.getDob() != null) ? patient.getDob() : "N/A" %>)</strong>
                                                    </div>
                                                    <div class="snapshot-item">
                                                        <span>Phone Contact:</span>
                                                        <strong><%= (patient != null && patient.getContact() != null) ? patient.getContact() : "Not Provided" %></strong>
                                                    </div>
                                                    <div class="snapshot-item">
                                                        <span>Emergency Contact:</span>
                                                        <strong style="color: #dc2626;"><%= (patient != null && patient.getEmergencyName() != null && !patient.getEmergencyName().isEmpty()) ? (patient.getEmergencyName() + " (" + patient.getEmergencyRelation() + ") - " + patient.getEmergencyContact()) : "Not Configured" %></strong>
                                                    </div>
                                                    <div class="snapshot-item">
                                                        <span>Delivery Address:</span>
                                                        <span style="font-size: 12px; color: #475569;"><%= (patient != null && patient.getAddress() != null && !patient.getAddress().isEmpty()) ? patient.getAddress() : "Not Provided" %></span>
                                                    </div>
                                                    <div style="padding-top: 10px; text-align: right;">
                                                        <a href="${pageContext.request.contextPath}/patient/profile/edit" style="font-size: 12px; color: #0284c7; text-decoration: none; font-weight: 600;">✏️ Update Profile Details</a>
                                                    </div>
                                                </div>
                                            </article>
                                            <!-- Recent Activity -->

                                            <article class="card">
                                                <div class="card-header">
                                                    <div class="card-title">
                                                        Recent Activity
                                                    </div>
                                                </div>
                                                <div class="card-body recent-activity-list">
                                                    <%
                                                        Prescriptions latestRx = (recentPrescriptions != null && !recentPrescriptions.isEmpty()) ? recentPrescriptions.get(0) : null;
                                                        boolean hasActivity = (latestAppt != null || latestRx != null || latestOrder != null);
                                                        if (!hasActivity) {
                                                    %>
                                                        <div style="padding: 16px; color: #64748b; font-size: 13px; text-align: center;">
                                                            No recent activity recorded yet. When you book consultations or request medications, live updates will appear here.
                                                        </div>
                                                    <%
                                                        } else {
                                                            if (latestAppt != null) {
                                                    %>
                                                        <div class="activity-item">
                                                            <span class="activity-dot activity-primary"></span>
                                                            <div>
                                                                <strong>Appointment (<%= latestAppt.getStatus() != null ? latestAppt.getStatus() : "Scheduled" %>):</strong>
                                                                With Dr. <%= latestAppt.getDoctorName() != null ? latestAppt.getDoctorName() : "Doctor" %>
                                                                <span class="activity-time"><%= latestAppt.getAppointmentDate() != null ? latestAppt.getAppointmentDate() : "" %> <%= latestAppt.getAppointmentTime() != null ? latestAppt.getAppointmentTime() : "" %> &bull; <%= latestAppt.getAppointmentType() != null ? latestAppt.getAppointmentType() : "Consultation" %></span>
                                                            </div>
                                                        </div>
                                                    <%
                                                            }
                                                            if (latestRx != null) {
                                                    %>
                                                        <div class="activity-item">
                                                            <span class="activity-dot" style="background-color: #0284c7;"></span>
                                                            <div>
                                                                <strong>Digital Prescription #<%= latestRx.getPrescriptionId() %>:</strong>
                                                                Issued by Dr. <%= latestRx.getDoctorName() != null ? latestRx.getDoctorName() : "Doctor" %>
                                                                <span class="activity-time"><%= latestRx.getPrescriptionDate() != null ? latestRx.getPrescriptionDate() : "Recently issued" %></span>
                                                            </div>
                                                        </div>
                                                    <%
                                                            }
                                                            if (latestOrder != null) {
                                                    %>
                                                        <div class="activity-item">
                                                            <span class="activity-dot activity-success"></span>
                                                            <div>
                                                                <strong>Pharmacy Order #<%= latestOrder.getOrderId() %> (<%= latestOrder.getOrderStatus() != null ? latestOrder.getOrderStatus() : "Processing" %>):</strong>
                                                                <%= latestOrder.getPharmacyName() != null ? latestOrder.getPharmacyName() : "Partner Pharmacy" %> &bull; &#8377;<%= String.format("%.2f", latestOrder.getTotalAmount()) %>
                                                                <span class="activity-time"><%= latestOrder.getOrderDate() != null ? latestOrder.getOrderDate() : "Recent" %></span>
                                                            </div>
                                                        </div>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </div>
                                            </article>
                                        </div>
                                    </section>
                                </main>
                                <!-- ========================================================
                 FOOTER COMPONENT
                 ======================================================== -->

                                <jsp:include page="components/footer.jsp" />

                            </div>

                        </div>


                        <!-- ================================================================
         DASHBOARD JAVASCRIPT
         ================================================================ -->

                        <script src="${pageContext.request.contextPath}/patient/js/patient-common.js">
                        </script>

                        <script src="${pageContext.request.contextPath}/patient/js/dashboard.js">
                        </script>

                    </body>

                    </html>