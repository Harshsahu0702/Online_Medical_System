<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    List<Map<String, Object>> pharmacies = (List<Map<String, Object>>) request.getAttribute("pharmacies");
    String flash = (String) session.getAttribute("adminFlash");
    if (flash != null) session.removeAttribute("adminFlash");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy Network Management - OmniHealth Admin</title>
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
            background: #ecfdf5;
            color: #047857;
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

        .pharm-cell {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .pharm-icon {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: linear-gradient(135deg, #059669, #10b981);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1rem;
        }

        .license-badge {
            background: #f1f5f9;
            color: #334155;
            padding: 0.2rem 0.55rem;
            border-radius: 6px;
            font-family: monospace;
            font-size: 0.82rem;
            border: 1px solid #cbd5e1;
        }

        .kpi-pill {
            display: inline-flex;
            align-items: center;
            padding: 0.2rem 0.6rem;
            border-radius: 6px;
            font-weight: 700;
            font-size: 0.85rem;
            background: #eff6ff;
            color: #1d4ed8;
        }

        .btn-view {
            padding: 0.4rem 0.85rem;
            background: #f1f5f9;
            color: #334155;
            border-radius: 8px;
            font-size: 0.82rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.15s;
            display: inline-block;
        }

        .btn-view:hover {
            background: #e2e8f0;
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
                <h1 class="page-title">Pharmacy Network Oversight</h1>
                <p class="page-subtitle">Manage licensed pharmacies, live medication stock catalogs, and prescription orders</p>
            </div>
            <div>
                <a href="<%= request.getContextPath() %>/pharmacy/dashboard" target="_blank" class="btn-view" style="background:#059669; color:white; padding: 0.6rem 1.2rem;">
                    Launch Pharmacy Portal ↗
                </a>
            </div>
        </div>

        <% if (flash != null) { %>
            <div class="alert-flash"><%= flash %></div>
        <% } %>

        <div class="card">
            <div class="card-header">
                <h3>Affiliated Pharmacies</h3>
                <span class="badge-count"><%= pharmacies != null ? pharmacies.size() : 0 %> Active Facilities</span>
            </div>

            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>Pharmacy Facility</th>
                            <th>License Number</th>
                            <th>Contact Info</th>
                            <th>Location / Address</th>
                            <th>Medications in Catalog</th>
                            <th>Customer Orders</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (pharmacies != null && !pharmacies.isEmpty()) { 
                            for (Map<String, Object> ph : pharmacies) { 
                        %>
                            <tr>
                                <td>
                                    <div class="pharm-cell">
                                        <div class="pharm-icon">💊</div>
                                        <div>
                                            <strong style="display:block; color:#0f172a;"><%= ph.get("name") != null ? ph.get("name") : "Pharmacy" %></strong>
                                            <span style="font-size:0.75rem; color:#64748b;">ID #<%= ph.get("pharmacyId") %></span>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="license-badge"><%= ph.get("licenseNumber") != null ? ph.get("licenseNumber") : "N/A" %></span>
                                </td>
                                <td>
                                    <div><%= ph.get("email") != null ? ph.get("email") : "N/A" %></div>
                                    <div style="font-size: 0.8rem; color: #64748b;"><%= ph.get("phone") != null ? ph.get("phone") : "N/A" %></div>
                                </td>
                                <td style="max-width: 240px; color:#475569;">
                                    <%= ph.get("address") != null ? ph.get("address") : "Main Hospital Campus" %>
                                </td>
                                <td>
                                    <span class="kpi-pill"><%= ph.get("totalMeds") %> Meds</span>
                                </td>
                                <td>
                                    <span class="kpi-pill" style="background:#fef3c7; color:#b45309;"><%= ph.get("totalOrders") %> Orders</span>
                                </td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/medicines" target="_blank" class="btn-view">Browse Medicines ↗</a>
                                </td>
                            </tr>
                        <%  } 
                        } else { %>
                            <tr>
                                <td colspan="7">
                                    <div class="empty-state">
                                        <h4>No pharmacies found.</h4>
                                        <p>Pharmacies will appear here when registered.</p>
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
