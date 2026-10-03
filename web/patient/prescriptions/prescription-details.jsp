<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="patient.model.Prescriptions" %>

<%
    request.setAttribute("pageTitle", "Prescription Details");
    request.setAttribute("pageDescription", "Review prescription information, diagnosis, and doctor advice.");

    Prescriptions prescriptionDetail = (Prescriptions) request.getAttribute("prescriptionDetail");
    if (prescriptionDetail == null) {
        String idParam = request.getParameter("prescriptionId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int prescriptionId = Integer.parseInt(idParam.trim());
                Prescriptions prModel = new Prescriptions();
                prescriptionDetail = prModel.getPrescriptionByPrescriptionId(prescriptionId);
            } catch (Exception e) {
                // Ignore parse exception
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Prescription Details</title>
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

            <% if (prescriptionDetail == null) { %>
                <section class="card">
                    <div class="card-body" style="padding: 40px; text-align: center;">
                        <h3 class="section-title">Prescription Not Found</h3>
                        <p style="color: var(--text-muted); margin: 10px 0 20px;">
                            The requested prescription details could not be found.
                        </p>
                        <a href="${pageContext.request.contextPath}/patient/prescriptions" class="btn btn-primary">
                            Back to Prescriptions
                        </a>
                    </div>
                </section>
            <% } else { 
                String rxId = request.getParameter("prescriptionId");
                if (rxId == null || rxId.trim().isEmpty()) {
                    rxId = String.valueOf(prescriptionDetail.getPrescriptionId());
                }
            %>

                <section class="card prescription-details-card">
                    <div class="card-body">
                        <!-- Prescription Header -->
                        <div class="prescription-details-header">
                            <div>
                                <span class="prescription-status active" style="margin-bottom: 8px;">Active</span>
                                <h2 class="section-title">Prescription #RX-<%= rxId %></h2>
                                <p style="color: var(--text-muted); font-size: 13px; margin: 4px 0 0;">
                                    Issued on <%= prescriptionDetail.getPrescriptionDate() != null ? prescriptionDetail.getPrescriptionDate() : "-" %>
                                </p>
                            </div>
                        </div>

                        <div class="prescription-details-content">
                            <!-- Consultation Details Meta -->
                            <div class="prescription-section">
                                <h3 class="prescription-section-title">Details</h3>
                                <div class="prescription-meta">
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Doctor Name</span>
                                        <span class="prescription-meta-value">Dr. <%= prescriptionDetail.getDoctorName() != null ? prescriptionDetail.getDoctorName() : "-" %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Doctor ID</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getDoctorId() %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Patient Name</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getPatientName() != null ? prescriptionDetail.getPatientName() : "-" %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Patient ID</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getPatientId() != null ? prescriptionDetail.getPatientId() : "-" %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Consultation ID</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getConsultationId() %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Date</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getPrescriptionDate() != null ? prescriptionDetail.getPrescriptionDate() : "-" %></span>
                                    </div>
                                </div>
                            </div>

                            <!-- Diagnosis -->
                            <div class="prescription-section">
                                <h3 class="prescription-section-title">Diagnosis</h3>
                                <div class="prescription-instructions">
                                    <%= prescriptionDetail.getDiagnosis() != null && !prescriptionDetail.getDiagnosis().trim().isEmpty() ? prescriptionDetail.getDiagnosis() : "No diagnosis specified." %>
                                </div>
                            </div>

                            <!-- Advice -->
                            <div class="prescription-section">
                                <h3 class="prescription-section-title">Doctor's Advice</h3>
                                <div class="prescription-instructions">
                                    <%= prescriptionDetail.getAdvice() != null && !prescriptionDetail.getAdvice().trim().isEmpty() ? prescriptionDetail.getAdvice() : "No advice recorded." %>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="prescription-detail-actions" style="margin-top: 24px;">
                                <a href="${pageContext.request.contextPath}/patient/prescriptions" class="btn btn-secondary">
                                    &larr; Back to Prescriptions
                                </a>
                            </div>
                        </div>
                    </div>
                </section>

            <% } %>

        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>