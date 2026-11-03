<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    List<Map<String, Object>> doctors = (List<Map<String, Object>>) request.getAttribute("doctors");
    String flash = (String) session.getAttribute("adminFlash");
    if (flash != null) session.removeAttribute("adminFlash");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Licensing & Approvals - OmniHealth Admin</title>
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
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            margin: 0 0 0.35rem 0;
            letter-spacing: -0.025em;
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
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9rem;
            text-align: left;
        }

        .data-table th {
            background: #f8fafc;
            color: #475569;
            font-weight: 600;
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table td {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
            vertical-align: middle;
        }

        .status-pill {
            display: inline-block;
            padding: 0.25rem 0.65rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .status-pill.approved { background: #d1fae5; color: #047857; }
        .status-pill.pending { background: #fef3c7; color: #b45309; }
        .status-pill.rejected { background: #fee2e2; color: #b91c1c; }
        .status-pill.active { background: #e0f2fe; color: #0369a1; }
        .status-pill.suspended { background: #fee2e2; color: #991b1b; }

        .btn-action {
            padding: 0.4rem 0.75rem;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.15s;
        }

        .btn-approve { background: #059669; color: white; }
        .btn-approve:hover { background: #047857; }

        .btn-reject { background: #fee2e2; color: #b91c1c; }
        .btn-reject:hover { background: #fecdd3; }

        .action-form {
            display: inline-flex;
            gap: 0.4rem;
        }
    </style>
</head>
<body>

<jsp:include page="/admin/navbar.jsp" />

<div class="container">

    <div class="page-header">
        <h1 class="page-title">Physician Licensing & Account Governance</h1>
        <p style="color: #64748b; margin: 0;">Validate medical registrations, approve new doctors, and toggle practice privileges</p>
    </div>

    <% if (flash != null) { %>
    <div class="alert-flash">
        <%= flash %>
    </div>
    <% } %>

    <div class="card">
        <% if (doctors != null && !doctors.isEmpty()) { %>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Doctor Name & Contact</th>
                    <th>Specialization</th>
                    <th>Medical License</th>
                    <th>Experience</th>
                    <th>Fee</th>
                    <th>Verification</th>
                    <th>Account</th>
                    <th style="text-align: right;">Admin Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, Object> doc : doctors) {
                    String vStat = (String) doc.get("verificationStatus");
                    if (vStat == null) vStat = "PENDING";
                    String accStat = (String) doc.get("accountStatus");
                    if (accStat == null) accStat = "ACTIVE";
                    int docId = (Integer) doc.get("doctorId");
                %>
                <tr>
                    <td>
                        <strong><%= doc.get("name") %></strong><br>
                        <span style="font-size: 0.8rem; color: #64748b;"><%= doc.get("email") %> &bull; <%= doc.get("phone") %></span>
                    </td>
                    <td><%= doc.get("specialization") %></td>
                    <td style="font-family: monospace; font-weight: 600;"><%= doc.get("licenseNumber") %></td>
                    <td><%= doc.get("experienceYears") %> Yrs</td>
                    <td>&#8377;<%= doc.get("fee") %></td>
                    <td>
                        <span class="status-pill <%= vStat.toLowerCase() %>"><%= vStat %></span>
                    </td>
                    <td>
                        <span class="status-pill <%= accStat.toLowerCase() %>"><%= accStat %></span>
                    </td>
                    <td style="text-align: right;">
                        <div class="action-form">
                            <% if (!"APPROVED".equalsIgnoreCase(vStat)) { %>
                            <form action="<%= request.getContextPath() %>/admin/doctors" method="post">
                                <input type="hidden" name="action" value="approve">
                                <input type="hidden" name="doctorId" value="<%= docId %>">
                                <button type="submit" class="btn-action btn-approve">Approve</button>
                            </form>
                            <% } %>
                            <% if (!"REJECTED".equalsIgnoreCase(vStat)) { %>
                            <form action="<%= request.getContextPath() %>/admin/doctors" method="post">
                                <input type="hidden" name="action" value="reject">
                                <input type="hidden" name="doctorId" value="<%= docId %>">
                                <button type="submit" class="btn-action btn-reject">Reject</button>
                            </form>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } else { %>
        <div style="padding: 3rem; text-align: center; color: #64748b;">
            No doctor records found in the database.
        </div>
        <% } %>
    </div>

</div>

</body>
</html>
