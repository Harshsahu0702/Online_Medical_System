<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("pageTitle", "Emergency Details");
    request.setAttribute("pageDescription", "View nearby emergency facilities and your emergency contact information.");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Emergency Details</title>
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

            <section class="card emergency-hospitals-card">
                <div class="card-body">
                    <div class="section-header">
                        <div>
                            <h2 class="section-title">Nearby Emergency Hospitals</h2>
                            <p>Emergency facilities available for immediate medical assistance.</p>
                        </div>
                    </div>

                    <div class="emergency-hospitals-list">
                        <div class="emergency-hospital-item">
                            <div>
                                <h3>Metro General Hospital</h3>
                                <p>24/7 Emergency Department</p>
                                <span class="hospital-distance">2.4 km away</span>
                            </div>
                            <div class="emergency-item-actions">
                                <a href="tel:112" class="btn btn-danger">Call</a>
                                <button type="button" class="btn btn-secondary">Directions</button>
                            </div>
                        </div>

                        <div class="emergency-hospital-item">
                            <div>
                                <h3>City Care Medical Center</h3>
                                <p>Emergency &amp; Trauma Care</p>
                                <span class="hospital-distance">4.1 km away</span>
                            </div>
                            <div class="emergency-item-actions">
                                <a href="tel:112" class="btn btn-danger">Call</a>
                                <button type="button" class="btn btn-secondary">Directions</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="card emergency-contacts-card">
                <div class="card-body">
                    <div class="section-header">
                        <div>
                            <h2 class="section-title">Emergency Contacts</h2>
                            <p>People who can be contacted in case of an emergency.</p>
                        </div>
                    </div>

                    <div class="emergency-contacts-list">
                        <div class="emergency-contact-item">
                            <div>
                                <h3>Primary Emergency Contact</h3>
                                <p>Family Contact</p>
                            </div>
                            <a href="tel:" class="btn btn-primary">Call Contact</a>
                        </div>

                        <div class="emergency-contact-item">
                            <div>
                                <h3>Emergency Services</h3>
                                <p>National Emergency Number</p>
                            </div>
                            <a href="tel:112" class="btn btn-danger">Call 112</a>
                        </div>
                    </div>
                </div>
            </section>

            <div class="emergency-details-actions">
                <a href="${pageContext.request.contextPath}/patient/emergency/emergency.jsp" class="btn btn-secondary">Back to Emergency</a>
                <a href="${pageContext.request.contextPath}/patient/profile/profile.jsp" class="btn btn-primary">Manage Emergency Information</a>
            </div>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>
<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/emergency.js"></script>
</body>
</html>