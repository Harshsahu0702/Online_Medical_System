<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Patient" %>
<%@ page import="model.doctor.Prescription" %>
<%@ page import="model.doctor.PrescriptionItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Medical Record - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    Patient patient = (Patient) request.getAttribute("patient");
    List<Prescription> pastPrescriptions = (List<Prescription>) request.getAttribute("pastPrescriptions");
%>

<main class="app-container">

    <div style="margin-bottom: 18px; display: flex; justify-content: space-between; align-items: center;">
        <a href="<%= request.getContextPath() %>/DoctorPatientServlet" class="btn btn-secondary btn-sm">← Back to Patient List</a>
        <% if (patient != null) { %>
            <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new&patientId=<%= patient.getPatientId() %>" class="btn btn-primary">+ Create New Prescription</a>
        <% } %>
    </div>

    <% if (patient != null) { %>

        <!-- PATIENT DEMOGRAPHICS -->
        <div class="card">
            <div class="card-title">
                <span>Patient Profile: <%= patient.getName() %></span>
                <span class="badge" style="background:#fee2e2; color:#991b1b;">Blood Group: <%= patient.getBloodGroup() != null ? patient.getBloodGroup() : "N/A" %></span>
            </div>

            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 16px; font-size: 14px;">
                <div>
                    <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Full Name</strong>
                    <span style="font-weight: 600;"><%= patient.getName() %></span>
                </div>
                <div>
                    <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Email Address</strong>
                    <span><%= patient.getEmail() != null ? patient.getEmail() : "N/A" %></span>
                </div>
                <div>
                    <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Phone Number</strong>
                    <span><%= patient.getPhone() != null ? patient.getPhone() : "N/A" %></span>
                </div>
                <div>
                    <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Gender</strong>
                    <span><%= patient.getGender() != null ? patient.getGender() : "N/A" %></span>
                </div>
                <div>
                    <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Date of Birth</strong>
                    <span><%= patient.getDob() != null ? patient.getDob() : "N/A" %></span>
                </div>
                <div>
                    <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Emergency Contact</strong>
                    <span><%= patient.getEmergencyContact() != null ? patient.getEmergencyContact() : "N/A" %></span>
                </div>
                <div style="grid-column: 1 / -1;">
                    <strong style="color: #64748b; display: block; font-size: 12px; text-transform: uppercase;">Residential Address</strong>
                    <span><%= patient.getAddress() != null ? patient.getAddress() : "N/A" %></span>
                </div>
            </div>
        </div>

        <!-- PAST PRESCRIPTIONS / MEDICAL HISTORY -->
        <div class="card">
            <div class="card-title">
                <span>Medical & Prescription History</span>
                <span style="font-size: 13px; font-weight: normal; color: #64748b;">
                    Previous clinical diagnoses and prescribed medicines
                </span>
            </div>

            <% if (pastPrescriptions == null || pastPrescriptions.isEmpty()) { %>
                <div style="text-align: center; padding: 40px 20px; color: #94a3b8;">
                    <div style="font-size: 36px; margin-bottom: 8px;">📑</div>
                    <p style="margin: 0; font-size: 15px;">No previous prescriptions recorded for this patient.</p>
                </div>
            <% } else { %>
                <% for (Prescription pr : pastPrescriptions) { %>
                    <div style="border: 1px solid #e2e8f0; border-radius: 8px; padding: 18px; margin-bottom: 18px; background: #fafcff;">
                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #edf2f7; padding-bottom: 10px; margin-bottom: 12px;">
                            <div>
                                <strong style="font-size: 15px; color: #244b6b;">Prescription #<%= pr.getPrescriptionId() %></strong>
                                <span style="font-size: 13px; color: #64748b; margin-left: 10px;">Date: <%= pr.getPrescriptionDate() %></span>
                            </div>
                            <span style="font-size: 13px; color: #475569;">Doctor: <strong>Dr. <%= pr.getDoctorName() != null ? pr.getDoctorName() : "Doctor" %></strong></span>
                        </div>

                        <div style="margin-bottom: 10px; font-size: 14px;">
                            <strong style="color: #334155;">Diagnosis:</strong> <%= pr.getDiagnosis() != null ? pr.getDiagnosis() : "N/A" %>
                        </div>

                        <% if (pr.getAdvice() != null && !pr.getAdvice().trim().isEmpty()) { %>
                            <div style="margin-bottom: 14px; font-size: 14px;">
                                <strong style="color: #334155;">Clinical Advice:</strong> <%= pr.getAdvice() %>
                            </div>
                        <% } %>

                        <!-- ITEMS TABLE -->
                        <% if (pr.getItems() != null && !pr.getItems().isEmpty()) { %>
                            <table class="data-table" style="background: white; border-radius: 6px; font-size: 13px;">
                                <thead>
                                    <tr>
                                        <th>Medicine</th>
                                        <th>Dosage</th>
                                        <th>Frequency</th>
                                        <th>Duration</th>
                                        <th>Instructions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (PrescriptionItem item : pr.getItems()) { %>
                                        <tr>
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
                        <% } %>
                    </div>
                <% } %>
            <% } %>
        </div>

    <% } else { %>
        <div class="alert alert-danger">Patient details not found.</div>
    <% } %>

</main>

</body>
</html>
