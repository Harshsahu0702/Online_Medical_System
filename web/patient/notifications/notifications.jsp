<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Notifications");
    request.setAttribute("pageDescription", "Stay updated with your appointments, prescriptions, orders, and other important alerts.");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Notifications</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/notifications.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <section class="card notifications-card">
                <div class="card-body">
                    <div class="notifications-header">
                        <div>
                            <h2 class="section-title">Notifications</h2>
                            <p id="notificationCount">Loading notifications...</p>
                        </div>
                        <button type="button" class="btn btn-secondary" id="markAllReadBtn">Mark All as Read</button>
                    </div>

                    <div class="notifications-list" id="notificationsListContainer">
                        <!-- Notifications are rendered by notifications.js. -->
                    </div>
                </div>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/notifications.js"></script>
</body>
</html>