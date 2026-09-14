<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session == null || session.getAttribute("doctorId") == null) {
        response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
        return;
    }

    String docName = (String) session.getAttribute("doctorName");
    String docSpec = (String) session.getAttribute("specializationName");

    if (docName == null) {
        docName = "Doctor";
    }

    if (docSpec == null) {
        docSpec = "General Physician";
    }

    String currentServlet = request.getServletPath();
%>

<style>

    * {
        box-sizing: border-box;
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
                     Roboto, "Helvetica Neue", Arial, sans-serif;
    }

    body {
        margin: 0;
        background-color: #f4f7fb;
        color: #2c3e50;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* =========================
       TOP NAVBAR
       ========================= */

    .top-navbar {
        background-color: #244b6b;
        color: white;
        padding: 12px 24px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .brand {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
        color: white;
        font-size: 20px;
        font-weight: bold;
    }

    .brand-icon {
        background: rgba(255, 255, 255, 0.15);
        padding: 6px 12px;
        border-radius: 8px;
        font-size: 18px;
    }

    /* =========================
       NAVIGATION LINKS
       ========================= */

    .nav-links {
        display: flex;
        align-items: center;
        gap: 16px;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .nav-links a {
        color: #ecf0f1;
        text-decoration: none;
        padding: 8px 14px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        transition: all 0.2s ease;
    }

    .nav-links a:hover,
    .nav-links a.active {
        background-color: rgba(255, 255, 255, 0.18);
        color: #ffffff;
    }

    /* =========================
       DOCTOR PROFILE
       ========================= */

    .user-profile-badge {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .doctor-tag {
        text-align: right;
    }

    .doctor-name-label {
        font-weight: bold;
        font-size: 14px;
    }

    .doctor-spec-label {
        font-size: 12px;
        opacity: 0.8;
    }

    /* =========================
       LOGOUT BUTTON
       ========================= */

    .btn-logout {
        background-color: #c0392b;
        color: white;
        padding: 7px 14px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
        transition: background 0.2s;
    }

    .btn-logout:hover {
        background-color: #e74c3c;
    }

    /* =========================
       MAIN LAYOUT
       ========================= */

    .app-container {
        max-width: 1200px;
        width: 95%;
        margin: 25px auto;
        flex: 1;
    }

    /* =========================
       CARD STYLES
       ========================= */

    .card {
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        padding: 24px;
        margin-bottom: 24px;
        border: 1px solid #e2e8f0;
    }

    .card-title {
        font-size: 18px;
        font-weight: bold;
        color: #244b6b;
        margin-top: 0;
        margin-bottom: 18px;
        border-bottom: 2px solid #eef2f7;
        padding-bottom: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    /* =========================
       STATS GRID
       ========================= */

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 18px;
        margin-bottom: 24px;
    }

    .stat-card {
        background: #ffffff;
        padding: 20px;
        border-radius: 10px;
        border-left: 5px solid #3498db;
        box-shadow: 0 3px 12px rgba(0, 0, 0, 0.04);
        border-top: 1px solid #e2e8f0;
        border-right: 1px solid #e2e8f0;
        border-bottom: 1px solid #e2e8f0;
    }

    .stat-card.accent {
        border-left-color: #2ecc71;
    }

    .stat-card.warning {
        border-left-color: #f39c12;
    }

    .stat-card.danger {
        border-left-color: #e74c3c;
    }

    .stat-value {
        font-size: 28px;
        font-weight: bold;
        color: #2c3e50;
        margin-top: 6px;
    }

    .stat-label {
        font-size: 13px;
        color: #7f8c8d;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    /* =========================
       TABLES
       ========================= */

    .data-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        font-size: 14px;
    }

    .data-table th,
    .data-table td {
        padding: 12px 14px;
        text-align: left;
        border-bottom: 1px solid #edf2f7;
    }

    .data-table th {
        background-color: #f8fafc;
        color: #475569;
        font-weight: 600;
    }

    .data-table tr:hover {
        background-color: #f8fafc;
    }

    /* =========================
       STATUS BADGES
       ========================= */

    .badge {
        display: inline-block;
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
    }

    .badge-pending {
        background: #fef3c7;
        color: #92400e;
    }

    .badge-accepted,
    .badge-active,
    .badge-completed {
        background: #d1fae5;
        color: #065f46;
    }

    .badge-ongoing {
        background: #e0e7ff;
        color: #3730a3;
    }

    .badge-rejected,
    .badge-cancelled {
        background: #fee2e2;
        color: #991b1b;
    }

    /* =========================
       BUTTONS
       ========================= */

    .btn {
        display: inline-block;
        padding: 8px 16px;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
        border: none;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .btn-primary {
        background: #3498db;
        color: white;
    }

    .btn-primary:hover {
        background: #2980b9;
    }

    .btn-success {
        background: #2ecc71;
        color: white;
    }

    .btn-success:hover {
        background: #27ae60;
    }

    .btn-danger {
        background: #e74c3c;
        color: white;
    }

    .btn-danger:hover {
        background: #c0392b;
    }

    .btn-secondary {
        background: #64748b;
        color: white;
    }

    .btn-secondary:hover {
        background: #475569;
    }

    .btn-sm {
        padding: 5px 10px;
        font-size: 12px;
    }

    /* =========================
       ALERTS
       ========================= */

    .alert {
        padding: 14px 18px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-size: 14px;
    }

    .alert-success {
        background: #dcfce7;
        color: #166534;
        border: 1px solid #bbf7d0;
    }

    .alert-danger {
        background: #fee2e2;
        color: #991b1b;
        border: 1px solid #fecaca;
    }

    .alert-info {
        background: #e0f2fe;
        color: #075985;
        border: 1px solid #bae6fd;
    }

    /* =========================
       FORMS
       ========================= */

    .form-group {
        margin-bottom: 16px;
    }

    .form-label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        font-size: 13px;
        color: #334155;
    }

    .form-control {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
        background: white;
    }

    .form-control:focus {
        border-color: #3498db;
        outline: none;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
    }

    .form-row {
        display: flex;
        gap: 16px;
    }

    .form-row .form-group {
        flex: 1;
    }

    /* =========================
       RESPONSIVE
       ========================= */

    @media (max-width: 1100px) {

        .top-navbar {
            flex-wrap: wrap;
            gap: 12px;
        }

        .nav-links {
            flex-wrap: wrap;
            justify-content: center;
        }
    }

    @media (max-width: 768px) {

        .top-navbar {
            flex-direction: column;
            align-items: stretch;
            text-align: center;
        }

        .brand {
            justify-content: center;
        }

        .nav-links {
            justify-content: center;
            gap: 5px;
        }

        .user-profile-badge {
            justify-content: center;
        }

        .doctor-tag {
            text-align: center;
        }

        .form-row {
            flex-direction: column;
            gap: 0;
        }
    }

</style>


<header class="top-navbar">

    <a href="<%= request.getContextPath() %>/DoctorDashboardServlet"
       class="brand">

        <span class="brand-icon">⚕</span>

        <span>Doctor Portal</span>

    </a>


    <ul class="nav-links">

        <li>
            <a href="<%= request.getContextPath() %>/DoctorDashboardServlet">
                Dashboard
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/DoctorProfileServlet">
                Profile
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/DoctorAvailabilityServlet">
                Availability
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/DoctorAppointmentServlet">
                Appointments
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/DoctorPatientServlet">
                Patients
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/DoctorConsultationServlet">
                Consultations
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet">
                Prescriptions
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/DoctorNotificationServlet">
                Notifications
            </a>
        </li>

    </ul>


    <div class="user-profile-badge">

        <div class="doctor-tag">

            <div class="doctor-name-label">
                Dr. <%= docName %>
            </div>

            <div class="doctor-spec-label">
                <%= docSpec %>
            </div>

        </div>

        <a href="<%= request.getContextPath() %>/DoctorLogoutServlet"
           class="btn-logout">
            Logout
        </a>

    </div>

</header>