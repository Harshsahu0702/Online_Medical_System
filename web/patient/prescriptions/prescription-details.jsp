<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Prescription Details");
    request.setAttribute("pageDescription", "Review your prescription, medications, dosage instructions, and treatment information.");
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

            <section class="card prescription-details-card">
                <div class="card-body">
                    <div class="prescription-details-header">
                        <div>
                            <span class="badge badge-success">Active</span>
                            <h2 class="section-title">Prescription #RX-1001</h2>
                            <p>Issued on September 10, 2026</p>
                        </div>
                    </div>

                    <div class="prescription-doctor-info">
                        <div class="doctor-img">SJ</div>
                        <div>
                            <h3>Dr. Sarah Jenkins, MD</h3>
                            <p>Cardiology</p>
                            <p>Metro Heart Institute</p>
                        </div>
                    </div>

                    <div class="prescription-info-grid">
                        <div class="prescription-info-item">
                            <span class="info-label">Diagnosis</span>
                            <strong>Hypertension</strong>
                        </div>
                        <div class="prescription-info-item">
                            <span class="info-label">Valid Until</span>
                            <strong>December 10, 2026</strong>
                        </div>
                        <div class="prescription-info-item">
                            <span class="info-label">Medications</span>
                            <strong>2 Medicines</strong>
                        </div>
                    </div>

                    <div class="prescription-medications">
                        <h3 class="section-title">Prescribed Medicines</h3>

                        <div class="prescription-medicine-item">
                            <div>
                                <h4>Amlodipine 5 mg</h4>
                                <p>Take 1 tablet once daily after breakfast.</p>
                            </div>
                            <span class="badge">30 Tablets</span>
                        </div>

                        <div class="prescription-medicine-item">
                            <div>
                                <h4>Atorvastatin 10 mg</h4>
                                <p>Take 1 tablet once daily at bedtime.</p>
                            </div>
                            <span class="badge">30 Tablets</span>
                        </div>
                    </div>

                    <div class="prescription-notes">
                        <h3 class="section-title">Doctor's Instructions</h3>
                        <p>Monitor your blood pressure regularly and maintain a low-sodium diet. Follow up after four weeks.</p>
                    </div>

                    <div class="prescription-details-actions">
                        <a href="${pageContext.request.contextPath}/patient/prescriptions/prescriptions.jsp" class="btn btn-secondary">Back to Prescriptions</a>
                        <button type="button" class="btn btn-primary" id="downloadPrescriptionBtn">Download Prescription</button>
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