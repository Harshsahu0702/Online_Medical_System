<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Patients - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<Patient> patients = (List<Patient>) request.getAttribute("patients");
%>

<main class="app-container">

    <div class="card">
        <div class="card-title">
            <span>Associated Patients</span>
            <span style="font-size: 13px; font-weight: normal; color: #64748b;">
                Patients with appointment and consultation records
            </span>
        </div>

        <% if (patients == null || patients.isEmpty()) { %>
            <div style="text-align: center; padding: 50px 20px; color: #94a3b8;">
                <div style="font-size: 40px; margin-bottom: 8px;">👥</div>
                <p style="margin: 0; font-size: 15px;">No patients found in your records yet.</p>
            </div>
        <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Patient Name</th>
                        <th>Contact (Phone / Email)</th>
                        <th>Gender</th>
                        <th>Blood Group</th>
                        <th>Emergency Contact</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Patient p : patients) { %>
                        <tr>
                            <td><strong><%= p.getName() %></strong></td>
                            <td>
                                <div><%= p.getPhone() != null ? p.getPhone() : "N/A" %></div>
                                <div style="font-size: 12px; color: #64748b;"><%= p.getEmail() != null ? p.getEmail() : "" %></div>
                            </td>
                            <td><%= p.getGender() != null ? p.getGender() : "N/A" %></td>
                            <td>
                                <span class="badge" style="background:#fee2e2; color:#991b1b;"><%= p.getBloodGroup() != null ? p.getBloodGroup() : "N/A" %></span>
                            </td>
                            <td><%= p.getEmergencyContact() != null ? p.getEmergencyContact() : "N/A" %></td>
                            <td>
                                <div style="display: flex; gap: 6px;">
                                    <a href="<%= request.getContextPath() %>/DoctorPatientServlet?action=view&id=<%= p.getPatientId() %>" class="btn btn-primary btn-sm">View Medical History</a>
                                    <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new&patientId=<%= p.getPatientId() %>" class="btn btn-secondary btn-sm">Prescribe</a>
                                </div>
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
