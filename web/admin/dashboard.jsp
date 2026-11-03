<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="admin.model.SystemOverview" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    SystemOverview overview = (SystemOverview) request.getAttribute("overview");
    if (overview == null) {
        overview = new SystemOverview();
    }
    List<Map<String, Object>> recentDoctors = (List<Map<String, Object>>) request.getAttribute("recentDoctors");
    List<Map<String, Object>> recentEmergencies = (List<Map<String, Object>>) request.getAttribute("recentEmergencies");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Master Admin Control Console - OmniHealth</title>
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

        .hero-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 50%, #312e81 100%);
            border-radius: 16px;
            padding: 2.25rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            box-shadow: 0 10px 15px -3px rgba(15, 23, 42, 0.2);
        }

        .hero-title {
            font-size: 1.85rem;
            font-weight: 800;
            margin: 0 0 0.5rem 0;
            letter-spacing: -0.025em;
        }

        .hero-subtitle {
            margin: 0;
            color: #c7d2fe;
            font-size: 0.95rem;
        }

        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.25rem;
            margin-bottom: 2rem;
        }

        .kpi-card {
            background: white;
            border-radius: 14px;
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .kpi-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08);
        }

        .kpi-label {
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #64748b;
            letter-spacing: 0.05em;
        }

        .kpi-val {
            font-size: 2rem;
            font-weight: 800;
            margin: 0.35rem 0;
            color: #0f172a;
        }

        .kpi-sub {
            font-size: 0.8rem;
            color: #64748b;
        }

        .grid-2col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        @media (max-width: 992px) {
            .grid-2col {
                grid-template-columns: 1fr;
            }
        }

        .section-card {
            background: white;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .section-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-title {
            font-size: 1.1rem;
            font-weight: 700;
            margin: 0;
            color: #0f172a;
        }

        .section-link {
            font-size: 0.85rem;
            font-weight: 600;
            color: #4f46e5;
            text-decoration: none;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
        }

        .data-table th {
            background: #f8fafc;
            color: #475569;
            font-weight: 600;
            padding: 0.75rem 1.25rem;
            border-bottom: 1px solid #e2e8f0;
            text-align: left;
        }

        .data-table td {
            padding: 0.85rem 1.25rem;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
            vertical-align: middle;
        }

        .status-pill {
            display: inline-block;
            padding: 0.2rem 0.6rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .status-pill.approved { background: #d1fae5; color: #047857; }
        .status-pill.pending { background: #fef3c7; color: #b45309; }
        .status-pill.rejected { background: #fee2e2; color: #b91c1c; }
        .status-pill.active { background: #e0f2fe; color: #0369a1; }
        .status-pill.dispatched { background: #fed7aa; color: #c2410c; }
        .status-pill.resolved { background: #d1fae5; color: #047857; }

        .btn-action-sm {
            padding: 0.35rem 0.7rem;
            border-radius: 6px;
            font-size: 0.775rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            border: 1px solid transparent;
        }

        .btn-view {
            background: #eef2ff;
            color: #4338ca;
            border-color: #c7d2fe;
        }
    </style>
</head>
<body>

<jsp:include page="/admin/navbar.jsp" />

<div class="container">

    <div class="hero-banner">
        <div>
            <h1 class="hero-title">System Governance Console</h1>
            <p class="hero-subtitle">Unified administration across Doctors, Patients, Dispensaries, and Critical Emergency Response</p>
        </div>
        <div>
            <span style="background: rgba(255, 255, 255, 0.15); padding: 0.5rem 1rem; border-radius: 8px; font-weight: 600; font-size: 0.85rem;">
                Platform: Production Online
            </span>
        </div>
    </div>

    <!-- 5-MODULE KPI GRID -->
    <div class="kpi-grid">
        <div class="kpi-card">
            <div class="kpi-label">Doctors Registry</div>
            <div class="kpi-val"><%= overview.getTotalDoctors() %></div>
            <div class="kpi-sub">
                <strong style="color: #059669;"><%= overview.getVerifiedDoctors() %></strong> Verified &bull;
                <strong style="color: #d97706;"><%= overview.getPendingDoctors() %></strong> Pending
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-label">Registered Patients</div>
            <div class="kpi-val"><%= overview.getTotalPatients() %></div>
            <div class="kpi-sub">Active patient profiles in system</div>
        </div>

        <div class="kpi-card">
            <div class="kpi-label">Pharmacies</div>
            <div class="kpi-val"><%= overview.getTotalPharmacies() %></div>
            <div class="kpi-sub">
                <strong style="color: #0284c7;"><%= overview.getTotalMedicines() %></strong> Catalog medicines listed
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-label">Emergency Alerts</div>
            <div class="kpi-val" style="color: <%= overview.getActiveEmergencies() > 0 ? "#e11d48" : "#0f172a" %>;">
                <%= overview.getActiveEmergencies() %>
            </div>
            <div class="kpi-sub">
                Active alerts (<%= overview.getTotalEmergencies() %> lifetime total)
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-label">Consultations & Orders</div>
            <div class="kpi-val"><%= overview.getTotalOrders() %></div>
            <div class="kpi-sub">
                Orders (<strong style="color: #d97706;"><%= overview.getPendingOrders() %></strong> pending) &bull; <%= overview.getTotalAppointments() %> appts
            </div>
        </div>
    </div>

    <!-- 2-COLUMN MONITOR -->
    <div class="grid-2col">

        <!-- DOCTOR LICENSING QUEUE -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">Doctor Verification Queue</h2>
                <a href="<%= request.getContextPath() %>/admin/doctors" class="section-link">Manage All Doctors &rarr;</a>
            </div>

            <% if (recentDoctors != null && !recentDoctors.isEmpty()) { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Doctor</th>
                        <th>Specialization</th>
                        <th>License</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> doc : recentDoctors) {
                        String vStat = (String) doc.get("verificationStatus");
                        if (vStat == null) vStat = "PENDING";
                    %>
                    <tr>
                        <td>
                            <strong><%= doc.get("name") %></strong><br>
                            <span style="font-size: 0.75rem; color: #64748b;"><%= doc.get("email") %></span>
                        </td>
                        <td><%= doc.get("specialization") %></td>
                        <td style="font-family: monospace;"><%= doc.get("licenseNumber") %></td>
                        <td>
                            <span class="status-pill <%= vStat.toLowerCase() %>"><%= vStat %></span>
                        </td>
                        <td>
                            <a href="<%= request.getContextPath() %>/admin/doctors" class="btn-action-sm btn-view">Review</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
            <div style="padding: 2.5rem; text-align: center; color: #64748b;">
                No doctor registrations found in the system.
            </div>
            <% } %>
        </div>

        <!-- LIVE EMERGENCY DISPATCH MONITOR -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">Emergency Response Monitor</h2>
                <a href="<%= request.getContextPath() %>/admin/emergencies" class="section-link">Live Dispatch &rarr;</a>
            </div>

            <% if (recentEmergencies != null && !recentEmergencies.isEmpty()) { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Caller</th>
                        <th>Location</th>
                        <th>Severity</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> em : recentEmergencies) {
                        String st = (String) em.get("status");
                        if (st == null) st = "PENDING";
                        String sev = (String) em.get("severity");
                    %>
                    <tr>
                        <td><strong>#<%= em.get("emergencyId") %></strong></td>
                        <td>
                            <strong><%= em.get("patientName") %></strong><br>
                            <span style="font-size: 0.75rem; color: #64748b;"><%= em.get("contactNumber") %></span>
                        </td>
                        <td><%= em.get("location") %></td>
                        <td>
                            <span style="font-weight: 700; color: <%= "CRITICAL".equalsIgnoreCase(sev) || "HIGH".equalsIgnoreCase(sev) ? "#e11d48" : "#d97706" %>;">
                                <%= sev %>
                            </span>
                        </td>
                        <td>
                            <span class="status-pill <%= st.toLowerCase() %>"><%= st %></span>
                        </td>
                        <td>
                            <a href="<%= request.getContextPath() %>/admin/emergencies" class="btn-action-sm btn-view">Dispatch</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
            <div style="padding: 2.5rem; text-align: center; color: #059669; font-weight: 600;">
                No active emergency SOS requests reported right now.
            </div>
            <% } %>
        </div>

    </div>

</div>

</body>
</html>
