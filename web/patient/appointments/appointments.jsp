<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Appointments");
    request.setAttribute("pageDescription", "View your schedule, join video visits, or book a new medical consultation.");
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
                <a href="${pageContext.request.contextPath}/patient/appointments/book-appointments.jsp" class="btn btn-primary">
                    <svg class="icon icon-sm" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 5v14M5 12h14"/>
                    </svg>
                    Schedule New Appointment
                </a>
            </div>

            <div class="tabs-nav">
                <button class="tab-btn active" type="button" onclick="Appointments.switchTab('upcoming', this)">Upcoming (2)</button>
                <button class="tab-btn" type="button" onclick="Appointments.switchTab('completed', this)">Past Consultations (2)</button>
                <button class="tab-btn" type="button" onclick="Appointments.switchTab('cancelled', this)">Cancelled (1)</button>
            </div>

            <section id="appointmentsListContainer" class="appointments-list-container">
                <!-- Appointment records are rendered by appointments.js. -->
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/appointments.js"></script>
</body>
</html>