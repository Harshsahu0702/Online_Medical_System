<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Prescription" %>
<%@ page import="model.doctor.PrescriptionItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prescriptions - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<Prescription> prescriptions = (List<Prescription>) request.getAttribute("prescriptions");
    Prescription detailedPrescription = (Prescription) request.getAttribute("prescription");
    String successParam = request.getParameter("success");
%>

<main class="app-container">

    <div style="margin-bottom: 18px; display: flex; justify-content: space-between; align-items: center;">
        <div>
            <% if (detailedPrescription != null) { %>
                <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet" class="btn btn-secondary btn-sm">← Back to All Prescriptions</a>
            <% } %>
        </div>
        <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new" class="btn btn-primary">+ Write New Prescription</a>
    </div>

    <% if ("1".equals(successParam)) { %>
        <div class="alert alert-success">Prescription created and saved successfully!</div>
    <% } %>

    <!-- DETAILED PRESCRIPTION VIEW (IF SELECTED) -->
    <% if (detailedPrescription != null) { %>
        <div class="card" style="border: 2px solid #244b6b; padding: 30px; margin-bottom: 30px;">
            <!-- PRESCRIPTION HEADER -->
            <div style="display: flex; justify-content: space-between; border-bottom: 2px solid #244b6b; padding-bottom: 15px; margin-bottom: 20px;">
                <div>
                    <h2 style="margin: 0; color: #244b6b; font-size: 22px;">Dr. <%= detailedPrescription.getDoctorName() %></h2>
                    <p style="margin: 4px 0 0; color: #64748b; font-size: 13px;"><%= detailedPrescription.getDoctorSpecialization() != null ? detailedPrescription.getDoctorSpecialization() : "Consultant Specialist" %></p>
                </div>
                <div style="text-align: right;">
                    <div style="font-weight: bold; font-size: 16px; color: #244b6b;">Rx Prescription #<%= detailedPrescription.getPrescriptionId() %></div>
                    <div style="font-size: 13px; color: #64748b; margin-top: 4px;">Date: <strong><%= detailedPrescription.getPrescriptionDate() %></strong></div>
                </div>
            </div>

            <!-- PATIENT INFO STRIP -->
            <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 12px 16px; margin-bottom: 20px; display: flex; justify-content: space-between; font-size: 14px;">
                <div><strong>Patient:</strong> <%= detailedPrescription.getPatientName() %></div>
                <div><strong>Consultation ID:</strong> <%= detailedPrescription.getConsultationId() > 0 ? ("#" + detailedPrescription.getConsultationId()) : "Direct Prescription" %></div>
            </div>

            <!-- DIAGNOSIS & ADVICE -->
            <div style="margin-bottom: 20px; font-size: 14px;">
                <div style="margin-bottom: 8px;">
                    <strong style="color: #244b6b;">Clinical Diagnosis:</strong>
                    <span><%= detailedPrescription.getDiagnosis() %></span>
                </div>
                <% if (detailedPrescription.getAdvice() != null && !detailedPrescription.getAdvice().trim().isEmpty()) { %>
                    <div>
                        <strong style="color: #244b6b;">General Advice:</strong>
                        <span><%= detailedPrescription.getAdvice() %></span>
                    </div>
                <% } %>
            </div>

            <!-- MEDICINES TABLE -->
            <div style="margin-bottom: 25px;">
                <h4 style="margin: 0 0 10px 0; color: #244b6b; font-size: 16px;">Prescribed Medications (Rx)</h4>
                <% if (detailedPrescription.getItems() != null && !detailedPrescription.getItems().isEmpty()) { %>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Medicine Name</th>
                                <th>Dosage</th>
                                <th>Frequency</th>
                                <th>Duration</th>
                                <th>Instructions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int idx = 1; for (PrescriptionItem item : detailedPrescription.getItems()) { %>
                                <tr>
                                    <td><%= idx++ %></td>
                                    <td>
                                        <strong><%= item.getMedicineName() != null ? item.getMedicineName() : ("Medicine #" + item.getMedicineId()) %></strong>
                                        <% if (item.getGenericName() != null) { %>
                                            <div style="font-size: 11px; color: #64748b;"><%= item.getGenericName() %></div>
                                        <% } %>
                                    </td>
                                    <td><%= item.getDosage() %></td>
                                    <td><%= item.getFrequency() %></td>
                                    <td><%= item.getDuration() %></td>
                                    <td><%= item.getInstructions() %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p style="color: #64748b; font-style: italic;">No medication items recorded.</p>
                <% } %>
            </div>

            <div style="text-align: right; margin-top: 30px; padding-top: 15px; border-top: 1px dashed #cbd5e1;">
                <button type="button" class="btn btn-secondary" onclick="window.print()">🖨 Print Prescription</button>
            </div>
        </div>
    <% } %>

    <!-- ALL PRESCRIPTIONS LIST -->
    <div class="card">
        <div class="card-title">
            <span>Prescription History</span>
            <span style="font-size: 13px; font-weight: normal; color: #64748b;">
                List of all prescriptions issued by you
            </span>
        </div>

        <% if (prescriptions == null || prescriptions.isEmpty()) { %>
            <div style="text-align: center; padding: 50px 20px; color: #94a3b8;">
                <div style="font-size: 40px; margin-bottom: 8px;">💊</div>
                <p style="margin: 0; font-size: 15px;">No prescriptions generated yet.</p>
                <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new" class="btn btn-primary" style="margin-top: 14px;">+ Write Your First Prescription</a>
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Rx #</th>
                        <th>Date</th>
                        <th>Patient</th>
                        <th>Diagnosis</th>
                        <th>Medicines Count</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Prescription pr : prescriptions) { %>
                        <tr>
                            <td><strong>#<%= pr.getPrescriptionId() %></strong></td>
                            <td><%= pr.getPrescriptionDate() %></td>
                            <td><strong><%= pr.getPatientName() %></strong></td>
                            <td><%= pr.getDiagnosis() != null ? pr.getDiagnosis() : "N/A" %></td>
                            <td>
                                <span class="badge" style="background:#dcfce7; color:#166534;"><%= pr.getItems() != null ? pr.getItems().size() : 0 %> items</span>
                            </td>
                            <td>
                                <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=view&id=<%= pr.getPrescriptionId() %>" class="btn btn-primary btn-sm">View Details / Print</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

</main>

</body>
</html>
