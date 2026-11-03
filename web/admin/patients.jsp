<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    List<Map<String, Object>> patients = (List<Map<String, Object>>) request.getAttribute("patients");
    String flash = (String) session.getAttribute("adminFlash");
    if (flash != null) session.removeAttribute("adminFlash");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Patients Directory - OmniHealth Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            margin: 0;
            padding: 0;
            background: #f8fafc;
            color: #0f172a;
            min-height: 100vh;
        }

        .container {
            max-width: 1320px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .page-header {
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            margin: 0 0 0.35rem 0;
            letter-spacing: -0.025em;
        }

        .page-subtitle {
            color: #64748b;
            font-size: 0.95rem;
            margin: 0;
        }

        .alert-flash {
            background: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
            padding: 0.85rem 1.25rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .card {
            background: white;
            border-radius: 14px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 10px 15px -3px rgba(0,0,0,0.03);
            border: 1px solid #e2e8f0;
            overflow: hidden;
        }

        .card-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ffffff;
        }

        .card-header h3 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 700;
        }

        .badge-count {
            background: #e0e7ff;
            color: #4338ca;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 700;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            background: #f8fafc;
            padding: 0.85rem 1.25rem;
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #64748b;
            border-bottom: 1px solid #e2e8f0;
        }

        td {
            padding: 1rem 1.25rem;
            font-size: 0.9rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        tr:hover {
            background: #f8fafc;
        }

        .patient-cell {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .patient-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: linear-gradient(135deg, #0284c7, #0ea5e9);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 0.85rem;
        }

        .blood-badge {
            background: #fee2e2;
            color: #b91c1c;
            padding: 0.25rem 0.5rem;
            border-radius: 6px;
            font-weight: 700;
            font-size: 0.8rem;
            display: inline-block;
        }

        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
            color: #64748b;
        }
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="page-header">
            <div>
                <h1 class="page-title">Patient Records Directory</h1>
                <p class="page-subtitle">Centralized oversight of all patients registered across OmniHealth network</p>
            </div>
        </div>

        <% if (flash != null) { %>
            <div class="alert-flash"><%= flash %></div>
        <% } %>

        <div class="card">
            <div class="card-header">
                <h3>Registered Patients</h3>
                <span class="badge-count"><%= patients != null ? patients.size() : 0 %> Patients</span>
            </div>

            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>Patient</th>
                            <th>Contact & Email</th>
                            <th>Gender</th>
                            <th>Blood Group</th>
                            <th>Address</th>
                            <th>Emergency Contact</th>
                            <th>Registered On</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (patients != null && !patients.isEmpty()) { 
                            for (Map<String, Object> p : patients) { 
                                String pName = (String) p.get("name");
                                String initials = (pName != null && pName.length() >= 2) ? pName.substring(0, 2).toUpperCase() : "PT";
                        %>
                            <tr>
                                <td>
                                    <div class="patient-cell">
                                        <div class="patient-avatar"><%= initials %></div>
                                        <div>
                                            <strong style="display:block; color:#0f172a;"><%= pName != null ? pName : "Patient" %></strong>
                                            <span style="font-size:0.75rem; color:#64748b; font-family:monospace;">ID: <%= p.get("patientId") %></span>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div><%= p.get("email") != null ? p.get("email") : "N/A" %></div>
                                    <div style="font-size: 0.8rem; color: #64748b;"><%= p.get("contact") != null ? p.get("contact") : "N/A" %></div>
                                </td>
                                <td><%= p.get("gender") != null ? p.get("gender") : "N/A" %></td>
                                <td>
                                    <% if (p.get("bloodGroup") != null && !p.get("bloodGroup").toString().isEmpty()) { %>
                                        <span class="blood-badge"><%= p.get("bloodGroup") %></span>
                                    <% } else { %>
                                        <span style="color:#94a3b8;">Unspecified</span>
                                    <% } %>
                                </td>
                                <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                    <%= p.get("address") != null ? p.get("address") : "N/A" %>
                                </td>
                                <td>
                                    <strong><%= p.get("emergencyContact") != null ? p.get("emergencyContact") : "None Listed" %></strong>
                                </td>
                                <td style="font-size: 0.8rem; color: #64748b;">
                                    <%= p.get("createdAt") != null ? p.get("createdAt").toString().substring(0, 16) : "N/A" %>
                                </td>
                            </tr>
                        <%  } 
                        } else { %>
                            <tr>
                                <td colspan="7">
                                    <div class="empty-state">
                                        <h4>No registered patients found.</h4>
                                        <p>Patients will appear here automatically when they sign up on the patient portal.</p>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
