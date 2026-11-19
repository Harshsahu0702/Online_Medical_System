<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    List<Map<String, Object>> doctors = (List<Map<String, Object>>) request.getAttribute("doctors");
    String flash = (String) session.getAttribute("adminFlash");
    if (flash != null) session.removeAttribute("adminFlash");

    int totalDocs = doctors != null ? doctors.size() : 0;
    int pendingCount = 0;
    int approvedCount = 0;
    int rejectedCount = 0;

    if (doctors != null) {
        for (Map<String, Object> d : doctors) {
            String v = (String) d.get("verificationStatus");
            if ("PENDING".equalsIgnoreCase(v)) pendingCount++;
            else if ("APPROVED".equalsIgnoreCase(v) || "ACTIVE".equalsIgnoreCase(v)) approvedCount++;
            else if ("REJECTED".equalsIgnoreCase(v) || "SUSPENDED".equalsIgnoreCase((String) d.get("accountStatus"))) rejectedCount++;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Physician Licensing &amp; Document Verification - OmniHealth Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --brand-navy: #0b1e33;
            --brand-teal: #088395;
            --brand-green: #059669;
            --brand-red: #dc2626;
            --border-color: #e2e8f0;
            --text-heading: #0f172a;
            --text-muted: #64748b;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            margin: 0;
            padding: 0;
            background: #f8fafc;
            color: var(--text-heading);
            min-height: 100vh;
        }

        .container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .page-header {
            margin-bottom: 1.75rem;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--brand-navy);
            letter-spacing: -0.02em;
            margin: 0 0 0.35rem 0;
        }

        /* METRIC CARDS STRIP */
        .metrics-strip {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 1rem;
            margin-bottom: 1.75rem;
        }

        .metric-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.15rem 1.25rem;
            box-shadow: 0 2px 4px rgba(15, 23, 42, 0.04);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .metric-info h5 {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            margin: 0 0 0.25rem 0;
            font-weight: 700;
        }

        .metric-info .metric-num {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--brand-navy);
            line-height: 1;
        }

        .metric-badge {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .alert-flash {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #065f46;
            padding: 0.9rem 1.25rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.65rem;
        }

        /* CONTROLS BAR: SEARCH & TABS */
        .controls-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 14px 14px 0 0;
            padding: 1rem 1.25rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            border-bottom: none;
        }

        .filter-tabs {
            display: flex;
            background: #f1f5f9;
            padding: 0.25rem;
            border-radius: 8px;
            gap: 0.25rem;
        }

        .filter-tab {
            padding: 0.45rem 0.85rem;
            border-radius: 6px;
            border: none;
            background: transparent;
            font-family: inherit;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--text-muted);
            cursor: pointer;
            transition: all 0.15s;
        }

        .filter-tab.active {
            background: #ffffff;
            color: var(--brand-navy);
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
        }

        .search-box {
            position: relative;
            display: flex;
            align-items: center;
            min-width: 280px;
        }

        .search-box svg {
            position: absolute;
            left: 0.85rem;
            color: #94a3b8;
            pointer-events: none;
        }

        .search-input {
            width: 100%;
            padding: 0.55rem 0.85rem 0.55rem 2.4rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.85rem;
            font-family: inherit;
            outline: none;
            transition: border-color 0.15s;
        }

        .search-input:focus {
            border-color: var(--brand-teal);
        }

        /* MAIN DATA TABLE */
        .table-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 0 0 14px 14px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.04);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.875rem;
        }

        .data-table th {
            background: #f8fafc;
            padding: 0.95rem 1.25rem;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            font-weight: 700;
            border-bottom: 1px solid var(--border-color);
        }

        .data-table td {
            padding: 1.1rem 1.25rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .data-table tr:hover {
            background: #f8fafc;
        }

        /* STATUS PILLS */
        .status-pill {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.65rem;
            border-radius: 6px;
            font-size: 0.725rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .status-pill.pending { background: #fef3c7; color: #b45309; }
        .status-pill.approved { background: #dcfce7; color: #15803d; }
        .status-pill.active { background: #dcfce7; color: #15803d; }
        .status-pill.rejected { background: #fee2e2; color: #b91c1c; }
        .status-pill.suspended { background: #fee2e2; color: #b91c1c; }

        .docs-count-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            background: #f1f5f9;
            color: var(--brand-navy);
            border: 1px solid var(--border-color);
            padding: 0.25rem 0.55rem;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        /* BUTTONS */
        .btn-review-modal {
            background: var(--brand-navy);
            color: #ffffff;
            border: none;
            padding: 0.45rem 0.95rem;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            transition: all 0.15s;
        }

        .btn-review-modal:hover {
            background: #162f4d;
        }

        .btn-approve-direct {
            background: #059669;
            color: white;
            border: none;
            padding: 0.45rem 0.75rem;
            border-radius: 6px;
            font-size: 0.775rem;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-approve-direct:hover { background: #047857; }

        .btn-reject-direct {
            background: #fee2e2;
            color: #b91c1c;
            border: none;
            padding: 0.45rem 0.75rem;
            border-radius: 6px;
            font-size: 0.775rem;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-reject-direct:hover { background: #fecdd3; }

        /* MODAL STYLES */
        .modal-backdrop {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.65);
            backdrop-filter: blur(4px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            overflow-y: auto;
        }

        .modal-backdrop.show {
            display: flex;
            animation: modalFadeIn 0.2s ease-out;
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: scale(0.98); }
            to { opacity: 1; transform: scale(1); }
        }

        .modal-dialog {
            background: #ffffff;
            border-radius: 16px;
            max-width: 820px;
            width: 100%;
            max-height: 90vh;
            display: flex;
            flex-direction: column;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
        }

        .modal-header {
            padding: 1.25rem 1.75rem;
            background: #f8fafc;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-header-info h3 {
            margin: 0;
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--brand-navy);
        }

        .modal-close-btn {
            background: transparent;
            border: none;
            font-size: 1.5rem;
            color: #94a3b8;
            cursor: pointer;
            padding: 0.25rem;
            line-height: 1;
        }

        .modal-close-btn:hover { color: var(--text-heading); }

        .modal-body {
            padding: 1.75rem;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 1.75rem;
        }

        .section-label {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--brand-teal);
            font-weight: 800;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .credentials-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            background: #f8fafc;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 1.25rem;
        }

        @media (max-width: 768px) {
            .credentials-grid {
                grid-template-columns: 1fr;
            }
        }

        .cred-item label {
            display: block;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-muted);
            margin-bottom: 0.25rem;
        }

        .cred-item div {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--brand-navy);
        }

        /* DOCUMENT PREVIEW CARDS */
        .documents-list-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        @media (max-width: 650px) {
            .documents-list-grid {
                grid-template-columns: 1fr;
            }
        }

        .document-card {
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 1rem 1.15rem;
            background: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: 0.75rem;
            transition: all 0.15s;
        }

        .document-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 4px 10px rgba(0,0,0,0.04);
        }

        .doc-top-row {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
        }

        .doc-icon-wrap {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            background: #f1f5f9;
            color: var(--brand-teal);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .doc-name-type h4 {
            margin: 0 0 0.15rem 0;
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--brand-navy);
        }

        .doc-name-type span {
            font-size: 0.75rem;
            color: var(--text-muted);
            word-break: break-all;
        }

        .btn-view-document {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
            background: #f1f5f9;
            color: var(--brand-navy);
            border: 1px solid #cbd5e1;
            padding: 0.5rem 0.85rem;
            border-radius: 6px;
            font-size: 0.775rem;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.15s;
        }

        .btn-view-document:hover {
            background: #e2e8f0;
            color: var(--brand-navy);
        }

        .modal-footer {
            padding: 1.25rem 1.75rem;
            background: #f8fafc;
            border-top: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-actions-right {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .btn-modal-approve {
            background: #059669;
            color: #ffffff;
            border: none;
            padding: 0.65rem 1.25rem;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
        }

        .btn-modal-approve:hover { background: #047857; }

        .btn-modal-reject {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            padding: 0.65rem 1.15rem;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
        }

        .btn-modal-reject:hover { background: #fecdd3; }

        .btn-modal-close {
            background: #ffffff;
            border: 1px solid var(--border-color);
            color: var(--text-muted);
            padding: 0.65rem 1.15rem;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>

<jsp:include page="/admin/navbar.jsp" />

<div class="container">

    <div class="page-header">
        <div>
            <h1 class="page-title">Physician Licensing &amp; Document Verification</h1>
            <p style="color: #64748b; margin: 0; font-size: 0.95rem;">Review medical degrees, verify regulatory council certificates, and grant practicing authorization.</p>
        </div>
    </div>

    <!-- METRICS STRIP -->
    <div class="metrics-strip">
        <div class="metric-card">
            <div class="metric-info">
                <h5>Total Physicians</h5>
                <div class="metric-num"><%= totalDocs %></div>
            </div>
            <div class="metric-badge" style="background: #f1f5f9; color: var(--brand-navy);">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M22 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
            </div>
        </div>

        <div class="metric-card" style="border-color: #fde68a;">
            <div class="metric-info">
                <h5 style="color: #b45309;">Pending Review</h5>
                <div class="metric-num" style="color: #b45309;"><%= pendingCount %></div>
            </div>
            <div class="metric-badge" style="background: #fef3c7; color: #b45309;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
            </div>
        </div>

        <div class="metric-card" style="border-color: #a7f3d0;">
            <div class="metric-info">
                <h5 style="color: #047857;">Authorized / Active</h5>
                <div class="metric-num" style="color: #047857;"><%= approvedCount %></div>
            </div>
            <div class="metric-badge" style="background: #ecfdf5; color: #047857;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
            </div>
        </div>

        <div class="metric-card">
            <div class="metric-info">
                <h5>Rejected / Suspended</h5>
                <div class="metric-num" style="color: #dc2626;"><%= rejectedCount %></div>
            </div>
            <div class="metric-badge" style="background: #fee2e2; color: #dc2626;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
            </div>
        </div>
    </div>

    <% if (flash != null) { %>
    <div class="alert-flash">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
        <%= flash %>
    </div>
    <% } %>

    <!-- SEARCH & FILTER BAR -->
    <div class="controls-card">
        <div class="filter-tabs">
            <button type="button" class="filter-tab active" onclick="applyStatusFilter('ALL', this)">All (<%= totalDocs %>)</button>
            <button type="button" class="filter-tab" onclick="applyStatusFilter('PENDING', this)">Pending (<%= pendingCount %>)</button>
            <button type="button" class="filter-tab" onclick="applyStatusFilter('APPROVED', this)">Approved (<%= approvedCount %>)</button>
            <button type="button" class="filter-tab" onclick="applyStatusFilter('REJECTED', this)">Suspended (<%= rejectedCount %>)</button>
        </div>

        <div class="search-box">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            <input type="text" id="doctorSearchInput" class="search-input" placeholder="Search by doctor, email, license, specialty..." onkeyup="filterDoctorsTable()">
        </div>
    </div>

    <!-- MAIN TABLE -->
    <div class="table-card">
        <% if (doctors != null && !doctors.isEmpty()) { %>
        <table class="data-table" id="doctorsDataTable">
            <thead>
                <tr>
                    <th>Doctor Name &amp; Contact</th>
                    <th>Specialization &amp; Degree</th>
                    <th>License &amp; Authority</th>
                    <th>Experience &amp; Fee</th>
                    <th>Verification</th>
                    <th>Uploaded Docs</th>
                    <th style="text-align: right;">Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, Object> doc : doctors) {
                    String vStat = (String) doc.get("verificationStatus");
                    if (vStat == null) vStat = "PENDING";
                    String accStat = (String) doc.get("accountStatus");
                    if (accStat == null) accStat = "PENDING";
                    int docId = (Integer) doc.get("doctorId");
                    List<Map<String, Object>> docsList = (List<Map<String, Object>>) doc.get("documents");
                    int docsCount = docsList != null ? docsList.size() : 0;
                %>
                <tr class="doctor-row" data-status="<%= vStat.toUpperCase() %>">
                    <td>
                        <strong style="color: var(--brand-navy); font-size: 0.95rem;"><%= doc.get("name") %></strong><br>
                        <span style="font-size: 0.775rem; color: #64748b;"><%= doc.get("email") %> &bull; <%= doc.get("phone") %></span>
                    </td>
                    <td>
                        <strong><%= doc.get("specialization") %></strong><br>
                        <span style="font-size: 0.75rem; color: #64748b;"><%= doc.get("qualification") %></span>
                    </td>
                    <td>
                        <span style="font-family: monospace; font-weight: 700; color: var(--brand-navy);"><%= doc.get("licenseNumber") %></span><br>
                        <span style="font-size: 0.75rem; color: #64748b;"><%= doc.get("registrationAuthority") %></span>
                    </td>
                    <td>
                        <span><%= doc.get("experienceYears") %> Yrs</span><br>
                        <span style="font-weight: 700; color: #047857;">&#8377;<%= doc.get("fee") %></span>
                    </td>
                    <td>
                        <% String displayStat = ("ACTIVE".equalsIgnoreCase(vStat)) ? "APPROVED" : vStat; %><span class="status-pill <%= displayStat.toLowerCase() %>"><%= displayStat %></span>
                    </td>
                    <td>
                        <span class="docs-count-pill">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                            <%= docsCount %> Uploaded
                        </span>
                    </td>
                    <td style="text-align: right;">
                        <button type="button" class="btn-review-modal" onclick="openReviewModal(<%= docId %>)">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            Review &amp; Verify
                        </button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } else { %>
        <div style="padding: 3.5rem; text-align: center; color: #64748b;">
            <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="margin-bottom: 0.5rem; color: #94a3b8;"><circle cx="12" cy="12" r="10"></circle><line x1="8" y1="12" x2="16" y2="12"></line></svg>
            <p style="margin: 0; font-weight: 600;">No doctor registration records found in the database.</p>
        </div>
        <% } %>
    </div>

</div>

<!-- CLINICAL VERIFICATION & DOCUMENT REVIEW MODAL -->
<div class="modal-backdrop" id="reviewModalBackdrop" onclick="closeModalOnBackdrop(event)">
    <div class="modal-dialog">
        <div class="modal-header">
            <div class="modal-header-info">
                <h3 id="modalDocName">Dr. Review</h3>
                <span id="modalDocBadge" class="status-pill pending" style="margin-top: 4px;">PENDING</span>
            </div>
            <button type="button" class="modal-close-btn" onclick="closeReviewModal()">&times;</button>
        </div>

        <div class="modal-body">
            <!-- 1. DOCTOR CREDENTIALS -->
            <div>
                <div class="section-label">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                    Physician Registration &amp; Clinical Credentials
                </div>

                <div class="credentials-grid">
                    <div class="cred-item">
                        <label>Specialization</label>
                        <div id="modalSpecialization">-</div>
                    </div>
                    <div class="cred-item">
                        <label>Qualification / Degree</label>
                        <div id="modalQualification">-</div>
                    </div>
                    <div class="cred-item">
                        <label>Medical License No.</label>
                        <div id="modalLicenseNumber" style="font-family: monospace;">-</div>
                    </div>
                    <div class="cred-item">
                        <label>Registration Authority</label>
                        <div id="modalAuthority">-</div>
                    </div>
                    <div class="cred-item">
                        <label>Experience</label>
                        <div id="modalExperience">-</div>
                    </div>
                    <div class="cred-item">
                        <label>Consultation Fee</label>
                        <div id="modalFee" style="color: #047857;">-</div>
                    </div>
                    <div class="cred-item">
                        <label>Clinic Affiliation</label>
                        <div id="modalClinic">-</div>
                    </div>
                    <div class="cred-item">
                        <label>Consultation Mode</label>
                        <div id="modalConsultType">-</div>
                    </div>
                    <div class="cred-item">
                        <label>Direct Contact</label>
                        <div id="modalContact" style="font-size: 0.8rem;">-</div>
                    </div>
                </div>

                <div style="margin-top: 0.85rem; background: #f8fafc; border: 1px solid var(--border-color); border-radius: 8px; padding: 0.85rem 1rem;">
                    <label style="display: block; font-size: 0.7rem; font-weight: 700; text-transform: uppercase; color: var(--text-muted); margin-bottom: 0.2rem;">Doctor Professional Bio</label>
                    <p id="modalBio" style="margin: 0; font-size: 0.85rem; color: #334155; line-height: 1.5;">-</p>
                </div>
            </div>

            <!-- 2. UPLOADED CERTIFICATES & DOCUMENTS -->
            <div>
                <div class="section-label">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                    Submitted Verification Documents &amp; Certificates
                </div>

                <div class="documents-list-grid" id="modalDocumentsContainer">
                    <!-- Populated dynamically via JS -->
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <button type="button" class="btn-modal-close" onclick="closeReviewModal()">Close</button>

            <div class="modal-actions-right">
                <form action="<%= request.getContextPath() %>/admin/doctors" method="post" id="modalRejectForm" style="margin:0;">
                    <input type="hidden" name="action" value="reject">
                    <input type="hidden" name="doctorId" id="modalRejectDocId" value="">
                    <button type="submit" class="btn-modal-reject" onclick="return confirm('Are you sure you want to REJECT this physician application?');">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                        Reject Application
                    </button>
                </form>

                <form action="<%= request.getContextPath() %>/admin/doctors" method="post" id="modalApproveForm" style="margin:0;">
                    <input type="hidden" name="action" value="approve">
                    <input type="hidden" name="doctorId" id="modalApproveDocId" value="">
                    <button type="submit" class="btn-modal-approve" onclick="return confirm('Verify that all submitted certificates are valid. Approve and grant practicing privileges?');">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                        Approve &amp; Authorize Practice
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- CLIENT-SIDE DOCTORS STORE FOR INSTANT MODAL RENDER -->
<script>
    var doctorsData = {};
    <% if (doctors != null) {
        for (Map<String, Object> doc : doctors) {
            int id = (Integer) doc.get("doctorId");
            List<Map<String, Object>> docsList = (List<Map<String, Object>>) doc.get("documents");
    %>
    doctorsData[<%= id %>] = {
        doctorId: <%= id %>,
        name: "<%= ((String) doc.get("name")).replace("\"", "\\\"") %>",
        email: "<%= ((String) doc.get("email")).replace("\"", "\\\"") %>",
        phone: "<%= ((String) doc.get("phone")).replace("\"", "\\\"") %>",
        specialization: "<%= ((String) doc.get("specialization")).replace("\"", "\\\"") %>",
        qualification: "<%= ((String) doc.get("qualification")).replace("\"", "\\\"") %>",
        licenseNumber: "<%= ((String) doc.get("licenseNumber")).replace("\"", "\\\"") %>",
        registrationAuthority: "<%= ((String) doc.get("registrationAuthority")).replace("\"", "\\\"") %>",
        experienceYears: <%= doc.get("experienceYears") %>,
        fee: "<%= doc.get("fee") %>",
        clinicName: "<%= ((String) doc.get("clinicName")).replace("\"", "\\\"") %>",
        consultationType: "<%= ((String) doc.get("consultationType")).replace("\"", "\\\"") %>",
        bio: "<%= ((String) doc.get("bio")).replace("\"", "\\\"").replace("\n", " ").replace("\r", "") %>",
        verificationStatus: "<%= doc.get("verificationStatus") %>",
        accountStatus: "<%= doc.get("accountStatus") %>",
        documents: [
            <% if (docsList != null) {
                for (Map<String, Object> dItem : docsList) {
            %>
            {
                documentId: <%= dItem.get("documentId") %>,
                documentType: "<%= dItem.get("documentType") %>",
                fileName: "<%= ((String) dItem.get("fileName")).replace("\"", "\\\"") %>",
                filePath: "<%= dItem.get("filePath") %>",
                verificationStatus: "<%= dItem.get("verificationStatus") %>"
            },
            <%  }
            } %>
        ]
    };
    <%  }
    } %>

    function formatDocType(type) {
        if (!type) return "Document";
        if (type === "MEDICAL_REGISTRATION") return "Medical Council Registration";
        if (type === "MBBS_DEGREE") return "MBBS Degree / Qualification Certificate";
        if (type === "IDENTITY_PROOF") return "Government Identity Proof (Aadhaar / ID)";
        if (type === "ADDITIONAL_QUALIFICATION") return "Post-Grad / Additional Qualification";
        return type.replace(/_/g, ' ');
    }

    function openReviewModal(docId) {
        var doc = doctorsData[docId];
        if (!doc) return;

        document.getElementById('modalDocName').textContent = doc.name;
        var badge = document.getElementById('modalDocBadge');
        badge.textContent = doc.verificationStatus;
        badge.className = 'status-pill ' + (doc.verificationStatus ? doc.verificationStatus.toLowerCase() : 'pending');

        document.getElementById('modalSpecialization').textContent = doc.specialization;
        document.getElementById('modalQualification').textContent = doc.qualification;
        document.getElementById('modalLicenseNumber').textContent = doc.licenseNumber;
        document.getElementById('modalAuthority').textContent = doc.registrationAuthority || 'State Medical Council';
        document.getElementById('modalExperience').textContent = doc.experienceYears + ' Years';
        document.getElementById('modalFee').textContent = '₹' + doc.fee;
        document.getElementById('modalClinic').textContent = doc.clinicName;
        document.getElementById('modalConsultType').textContent = doc.consultationType;
        document.getElementById('modalContact').textContent = doc.email + ' • ' + doc.phone;
        document.getElementById('modalBio').textContent = doc.bio;

        document.getElementById('modalApproveDocId').value = doc.doctorId;
        document.getElementById('modalRejectDocId').value = doc.doctorId;

        // Populate documents
        var container = document.getElementById('modalDocumentsContainer');
        container.innerHTML = '';

        if (doc.documents && doc.documents.length > 0) {
            doc.documents.forEach(function(d) {
                var card = document.createElement('div');
                card.className = 'document-card';
                card.innerHTML = 
                    '<div class="doc-top-row">' +
                        '<div class="doc-icon-wrap">' +
                            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>' +
                        '</div>' +
                        '<div class="doc-name-type">' +
                            '<h4>' + formatDocType(d.documentType) + '</h4>' +
                            '<span>' + d.fileName + '</span>' +
                        '</div>' +
                    '</div>' +
                    '<div style="display:flex; justify-content:space-between; align-items:center; margin-top:0.4rem;">' +
                        '<span class="status-pill ' + (d.verificationStatus ? d.verificationStatus.toLowerCase() : 'pending') + '" style="font-size:0.65rem;">' + (d.verificationStatus || 'PENDING') + '</span>' +
                        '<a href="<%= request.getContextPath() %>/ViewDocumentServlet?id=' + d.documentId + '" target="_blank" class="btn-view-document">' +
                            '<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>' +
                            'Open Certificate &rarr;' +
                        '</a>' +
                    '</div>';
                container.appendChild(card);
            });
        } else {
            container.innerHTML = '<div style="grid-column: 1 / -1; padding: 1.5rem; text-align: center; color: #94a3b8; background: #f8fafc; border-radius: 8px;">No certificate files submitted by this doctor.</div>';
        }

        // Toggle buttons visibility based on status
        var approveBtn = document.querySelector('.btn-modal-approve');
        var rejectBtn = document.querySelector('.btn-modal-reject');
        if (doc.verificationStatus === 'APPROVED') {
            approveBtn.style.display = 'none';
            rejectBtn.style.display = 'inline-flex';
            rejectBtn.textContent = 'Suspend / Revoke License';
        } else {
            approveBtn.style.display = 'inline-flex';
            approveBtn.innerHTML = '<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> Approve & Authorize Practice';
            rejectBtn.style.display = 'inline-flex';
            rejectBtn.textContent = 'Reject Application';
        }

        document.getElementById('reviewModalBackdrop').classList.add('show');
    }

    function closeReviewModal() {
        document.getElementById('reviewModalBackdrop').classList.remove('show');
    }

    function closeModalOnBackdrop(e) {
        if (e.target.id === 'reviewModalBackdrop') {
            closeReviewModal();
        }
    }

    // FILTER TABS & SEARCH
    var currentFilter = 'ALL';

    function applyStatusFilter(status, btn) {
        currentFilter = status;
        document.querySelectorAll('.filter-tab').forEach(function(t) { t.classList.remove('active'); });
        btn.classList.add('active');
        filterDoctorsTable();
    }

    function filterDoctorsTable() {
        var query = document.getElementById('doctorSearchInput').value.toLowerCase().trim();
        var rows = document.querySelectorAll('.doctor-row');

        rows.forEach(function(row) {
            var rowStatus = row.getAttribute('data-status');
            var text = row.textContent.toLowerCase();

            var matchesFilter = (currentFilter === 'ALL') || 
                                (currentFilter === 'PENDING' && rowStatus === 'PENDING') ||
                                (currentFilter === 'APPROVED' && rowStatus === 'APPROVED') ||
                                (currentFilter === 'REJECTED' && (rowStatus === 'REJECTED' || rowStatus === 'SUSPENDED'));

            var matchesQuery = query === '' || text.indexOf(query) !== -1;

            if (matchesFilter && matchesQuery) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // AUTO-OPEN MODAL IF URL HAS ?reviewDocId=...
    window.addEventListener('DOMContentLoaded', function() {
        var params = new URLSearchParams(window.location.search);
        var reviewDocId = params.get('reviewDocId');
        if (reviewDocId && doctorsData[reviewDocId]) {
            openReviewModal(parseInt(reviewDocId));
        }
    });
</script>

</body>
</html>
