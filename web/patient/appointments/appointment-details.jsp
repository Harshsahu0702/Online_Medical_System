<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Appointment Details");
    request.setAttribute("pageDescription", "Review your appointment information and consultation details.");
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

            <section class="card appointment-details-card">
                <div class="card-body">
                    <div class="appointment-details-header">
                        <div>
                            <span class="badge badge-success">Upcoming</span>
                            <h2 class="section-title">Cardiology Consultation</h2>
                            <p class="appointment-id">Appointment ID: MC-APT-1001</p>
                        </div>
                    </div>

                    <div class="appointment-doctor-info">
                        <div class="doctor-img">SJ</div>
                        <div>
                            <h3>Dr. Sarah Jenkins, MD</h3>
                            <p>Cardiology</p>
                            <p>Metro Heart Institute</p>
                        </div>
                    </div>

                    <div class="appointment-info-grid">
                        <div class="appointment-info-item">
                            <span class="info-label">Date</span>
                            <strong>September 18, 2026</strong>
                        </div>
                        <div class="appointment-info-item">
                            <span class="info-label">Time</span>
                            <strong>10:00 AM</strong>
                        </div>
                        <div class="appointment-info-item">
                            <span class="info-label">Consultation Type</span>
                            <strong>Video Consultation</strong>
                        </div>
                        <div class="appointment-info-item">
                            <span class="info-label">Consultation Fee</span>
                            <strong>$60</strong>
                        </div>
                    </div>

                    <div class="appointment-reason">
                        <h3 class="section-title">Reason for Visit</h3>
                        <p>Routine cardiovascular consultation and follow-up.</p>
                    </div>

                    <div class="appointment-details-actions">
                        <a href="${pageContext.request.contextPath}/patient/appointments/appointments.jsp" class="btn btn-secondary">Back to Appointments</a>
                        <button type="button" class="btn btn-primary" id="joinAppointmentBtn">Join Consultation</button>
                        <button type="button" class="btn btn-danger" id="cancelAppointmentBtn">Cancel Appointment</button>
                    </div>
                </div>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/appointments.js"></script>
</body>
</html> 