<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Prescriptions");
    request.setAttribute("pageDescription", "View and manage your prescribed medications and treatment plans.");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Prescriptions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/prescriptions.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <section class="card prescriptions-card">
                <div class="card-body">
                    <div class="prescriptions-header">
                        <div>
                            <h2 class="section-title">My Prescriptions</h2>
                            <p class="prescriptions-count" id="prescriptionsCount">Loading prescriptions...</p>
                        </div>
                        <div class="prescriptions-filter">
                            <label class="form-label" for="prescriptionStatusFilter">Status</label>
                            <select class="form-control" id="prescriptionStatusFilter">
                                <option value="ALL">All Prescriptions</option>
                                <option value="ACTIVE">Active</option>
                                <option value="COMPLETED">Completed</option>
                            </select>
                        </div>
                    </div>

                    <div class="prescriptions-list" id="prescriptionsList">
                        <!-- Prescription records are rendered by prescriptions.js. -->
                    </div>
                </div>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/prescriptions.js"></script>
</body>
</html>