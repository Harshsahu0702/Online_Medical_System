<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    List<Map<String, Object>> emergencies = (List<Map<String, Object>>) request.getAttribute("emergencies");
    String flash = (String) session.getAttribute("adminFlash");
    if (flash != null) session.removeAttribute("adminFlash");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emergency Dispatch & SOS Management - OmniHealth Admin</title>
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
            max-width: 1380px;
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
            background: #fee2e2;
            color: #b91c1c;
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

        .badge-sev {
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-block;
        }

        .sev-critical { background: #fee2e2; color: #991b1b; border: 1px solid #f87171; }
        .sev-high { background: #ffedd5; color: #9a3412; border: 1px solid #fdba74; }
        .sev-moderate { background: #fef9c3; color: #854d0e; }
        .sev-low { background: #e0f2fe; color: #075985; }

        .status-pill {
            padding: 0.25rem 0.65rem;
            border-radius: 9999px;
            font-size: 0.78rem;
            font-weight: 700;
            display: inline-block;
        }

        .status-pending { background: #fee2e2; color: #dc2626; animation: pulse 2s infinite; }
        .status-dispatched { background: #e0e7ff; color: #4338ca; }
        .status-resolved { background: #ecfdf5; color: #059669; }
        .status-cancelled { background: #f1f5f9; color: #64748b; }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.6; }
        }

        .btn-update {
            padding: 0.4rem 0.75rem;
            background: #0284c7;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.15s;
        }

        .btn-update:hover {
            background: #0369a1;
        }

        .select-status {
            padding: 0.35rem 0.6rem;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            background: white;
            color: #0f172a;
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
                <h1 class="page-title">Live Emergency Dispatch Center</h1>
                <p class="page-subtitle">Real-time triage, ambulance coordination, and SOS response management</p>
            </div>
            <div>
                <a href="<%= request.getContextPath() %>/emergency/emergency.jsp" target="_blank" class="btn-update" style="background:#dc2626; text-decoration:none; padding: 0.6rem 1.2rem; display:inline-block;">
                    + Test Patient SOS Trigger 🚨
                </a>
            </div>
        </div>

        <% if (flash != null) { %>
            <div class="alert-flash"><%= flash %></div>
        <% } %>

        <div class="card">
            <div class="card-header">
                <h3>Incident Log</h3>
                <span class="badge-count"><%= emergencies != null ? emergencies.size() : 0 %> Logged Emergencies</span>
            </div>

            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>Incident ID</th>
                            <th>Caller / Patient</th>
                            <th>Type & Severity</th>
                            <th>Description</th>
                            <th>Location Details</th>
                            <th>Timestamp</th>
                            <th>Triage Status</th>
                            <th>Admin Dispatch Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (emergencies != null && !emergencies.isEmpty()) { 
                            for (Map<String, Object> em : emergencies) { 
                                String sev = em.get("severity") != null ? em.get("severity").toString().toUpperCase() : "MODERATE";
                                String sevClass = "sev-moderate";
                                if (sev.contains("CRIT")) sevClass = "sev-critical";
                                else if (sev.contains("HIGH")) sevClass = "sev-high";
                                else if (sev.contains("LOW")) sevClass = "sev-low";

                                String st = em.get("status") != null ? em.get("status").toString().toUpperCase() : "PENDING";
                                String stClass = "status-pending";
                                if (st.contains("DISP")) stClass = "status-dispatched";
                                else if (st.contains("RESOL")) stClass = "status-resolved";
                                else if (st.contains("CANC")) stClass = "status-cancelled";
                        %>
                            <tr>
                                <td>
                                    <strong style="font-family:monospace; color:#dc2626;">#EM-<%= em.get("emergencyId") %></strong>
                                </td>
                                <td>
                                    <strong><%= em.get("patientName") %></strong>
                                    <div style="font-size:0.8rem; color:#64748b;">📞 <%= em.get("contactNumber") != null ? em.get("contactNumber") : "N/A" %></div>
                                </td>
                                <td>
                                    <div style="font-weight:600; margin-bottom: 0.2rem;"><%= em.get("emergencyType") != null ? em.get("emergencyType") : "General Emergency" %></div>
                                    <span class="badge-sev <%= sevClass %>"><%= sev %></span>
                                </td>
                                <td style="max-width: 250px;">
                                    <div style="color: #334155; font-size: 0.85rem;"><%= em.get("description") != null ? em.get("description") : "No description provided." %></div>
                                </td>
                                <td style="max-width: 220px;">
                                    <div style="font-weight: 600; color: #0f172a; font-size: 0.85rem;">📍 <%= em.get("location") != null ? em.get("location") : "Unknown GPS / Address" %></div>
                                </td>
                                <td style="font-size: 0.8rem; color: #64748b;">
                                    <%= em.get("requestedAt") != null ? em.get("requestedAt").toString().substring(0, 16) : "Just now" %>
                                </td>
                                <td>
                                    <span class="status-pill <%= stClass %>"><%= st %></span>
                                </td>
                                <td>
                                    <form action="<%= request.getContextPath() %>/admin/emergencies" method="POST" style="display:flex; gap:0.4rem; align-items:center;">
                                        <input type="hidden" name="emergencyId" value="<%= em.get("emergencyId") %>">
                                        <select name="status" class="select-status">
                                            <option value="PENDING" <%= "PENDING".equalsIgnoreCase(st) ? "selected" : "" %>>Pending</option>
                                            <option value="DISPATCHED" <%= "DISPATCHED".equalsIgnoreCase(st) ? "selected" : "" %>>Dispatched</option>
                                            <option value="RESOLVED" <%= "RESOLVED".equalsIgnoreCase(st) ? "selected" : "" %>>Resolved</option>
                                            <option value="CANCELLED" <%= "CANCELLED".equalsIgnoreCase(st) ? "selected" : "" %>>Cancelled</option>
                                        </select>
                                        <button type="submit" class="btn-update">Update</button>
                                    </form>
                                </td>
                            </tr>
                        <%  } 
                        } else { %>
                            <tr>
                                <td colspan="8">
                                    <div class="empty-state">
                                        <h4>No emergency requests recorded.</h4>
                                        <p>Incoming emergency distress calls will be listed here in real-time.</p>
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
