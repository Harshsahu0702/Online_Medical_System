<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="patient.model.Prescriptions" %>

<%
    request.setAttribute("pageTitle", "Prescriptions");
    request.setAttribute("pageDescription", "View your prescriptions and treatment details.");

    ArrayList<Prescriptions> prescriptionList = (ArrayList<Prescriptions>) request.getAttribute("prescriptionList");
    if (prescriptionList == null) {
        String patientId = (String) session.getAttribute("patientId");
        if (patientId != null && !patientId.trim().isEmpty()) {
            Prescriptions prModel = new Prescriptions();
            prescriptionList = prModel.getPrescriptionByPatientId(patientId);
        }
    }
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
                            <p class="prescriptions-count">
                                <%= (prescriptionList != null) ? prescriptionList.size() : 0 %> Prescriptions found
                            </p>
                        </div>
                    </div>

                    <% if (prescriptionList == null || prescriptionList.isEmpty()) { %>
                        <div class="prescription-empty">
                            <div class="prescription-empty-icon">
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                                    <path d="M14 2v6h6"/>
                                    <path d="M8 13h8"/>
                                    <path d="M8 17h5"/>
                                </svg>
                            </div>
                            <h3 class="prescription-empty-title">No Prescriptions Found</h3>
                            <p class="prescription-empty-text">You do not have any prescriptions issued yet.</p>
                        </div>
                    <% } else { %>
                        <div class="prescription-list">
                            <% for (Prescriptions pr : prescriptionList) { %>
                                <div class="prescription-card" onclick="window.location.href='${pageContext.request.contextPath}/patient/prescription-detail?prescriptionId=<%= pr.getPrescriptionId() %>'" style="cursor: pointer;">
                                    <div class="prescription-header">
                                        <div class="prescription-header-info">
                                            <h3 class="prescription-title">Prescription #RX-<%= pr.getPrescriptionId() %></h3>
                                            <p class="prescription-doctor">Prescribed by Dr. <%= pr.getDoctorName() != null ? pr.getDoctorName() : "Doctor" %></p>
                                        </div>
                                        <span class="prescription-status active">Active</span>
                                    </div>
                                    <div class="prescription-body">
                                        <div class="prescription-meta">
                                            <div class="prescription-meta-item">
                                                <span class="prescription-meta-label">Date Issued</span>
                                                <span class="prescription-meta-value"><%= pr.getPrescriptionDate() != null ? pr.getPrescriptionDate() : "-" %></span>
                                            </div>
                                            <div class="prescription-meta-item">
                                                <span class="prescription-meta-label">Patient</span>
                                                <span class="prescription-meta-value"><%= pr.getPatientName() != null ? pr.getPatientName() : "-" %></span>
                                            </div>
                                            <div class="prescription-meta-item">
                                                <span class="prescription-meta-label">Diagnosis</span>
                                                <span class="prescription-meta-value"><%= (pr.getDiagnosis() != null && !pr.getDiagnosis().trim().isEmpty()) ? pr.getDiagnosis() : "General Consultation" %></span>
                                            </div>
                                        </div>
                                        <% if (pr.getAdvice() != null && !pr.getAdvice().trim().isEmpty()) { %>
                                            <div class="prescription-instructions">
                                                <strong>Advice:</strong> <%= pr.getAdvice() %>
                                            </div>
                                        <% } %>
                                    </div>
                                    <div class="prescription-footer">
                                        <a href="${pageContext.request.contextPath}/patient/prescription-detail?prescriptionId=<%= pr.getPrescriptionId() %>" class="btn btn-sm btn-primary">
                                            View Details &rarr;
                                        </a>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } %>

                </div>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>