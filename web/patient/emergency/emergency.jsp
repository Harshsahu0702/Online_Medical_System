<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Emergency Assistance");
    request.setAttribute("pageDescription", "Get immediate access to emergency services and important medical information.");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Emergency Assistance</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/emergency.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <section class="emergency-alert card">
                <div class="card-body">
                    <div class="emergency-alert-content">
                        <div class="emergency-icon" aria-hidden="true">!</div>
                        <div>
                            <h2>Need Emergency Help?</h2>
                            <p>If you are experiencing a life-threatening emergency, contact your local emergency service immediately.</p>
                        </div>
                    </div>
                    <a href="tel:112" class="btn btn-danger emergency-call-btn">Call Emergency Services</a>
                </div>
            </section>

            <section class="emergency-services-section">
                <div class="section-header">
                    <div>
                        <h2 class="section-title">Emergency Services</h2>
                        <p>Quickly access essential emergency assistance.</p>
                    </div>
                </div>

                <div class="emergency-services-grid">
                    <div class="card emergency-service-card">
                        <div class="card-body">
                            <div class="emergency-service-icon">+</div>
                            <h3>Ambulance</h3>
                            <p>Request immediate medical transportation.</p>
                            <a href="tel:112" class="btn btn-danger">Call Ambulance</a>
                        </div>
                    </div>

                    <div class="card emergency-service-card">
                        <div class="card-body">
                            <div class="emergency-service-icon">H</div>
                            <h3>Nearby Hospitals</h3>
                            <p>Find emergency departments and nearby hospitals.</p>
                            <a href="${pageContext.request.contextPath}/patient/emergency/emergency-details.jsp" class="btn btn-primary">View Hospitals</a>
                        </div>
                    </div>

                    <div class="card emergency-service-card">
                        <div class="card-body">
                            <div class="emergency-service-icon">C</div>
                            <h3>Emergency Contacts</h3>
                            <p>Access your saved emergency contacts.</p>
                            <a href="${pageContext.request.contextPath}/patient/emergency/emergency-details.jsp" class="btn btn-primary">View Contacts</a>
                        </div>
                    </div>
                </div>
            </section>

            <section class="card emergency-medical-info">
                <div class="card-body">
                    <h2 class="section-title">Your Emergency Medical Information</h2>
                    <div class="emergency-info-grid">
                        <div class="emergency-info-item">
                            <span class="info-label">Blood Group</span>
                            <strong>O+</strong>
                        </div>
                        <div class="emergency-info-item">
                            <span class="info-label">Allergies</span>
                            <strong>None Recorded</strong>
                        </div>
                        <div class="emergency-info-item">
                            <span class="info-label">Emergency Contact</span>
                            <strong>Primary Contact</strong>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/patient/profile/profile.jsp" class="btn btn-secondary">Update Medical Information</a>
                </div>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/emergency.js"></script>
</body>
</html>