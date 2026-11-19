<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OmniHealth - Integrated Hospital &amp; Medical Care Portal</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --brand-navy: #0b1e33;
            --brand-navy-light: #162f4d;
            --brand-teal: #088395;
            --brand-teal-hover: #0a6f7e;
            --brand-cyan: #059669;
            --brand-surface: #ffffff;
            --brand-bg: #f4f7fb;

            --text-primary: #0f172a;
            --text-secondary: #475569;
            --text-muted: #64748b;
            --text-light: #94a3b8;

            --border-color: #e2e8f0;
            --border-focus: #088395;
            --card-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.08), 0 8px 10px -6px rgba(15, 23, 42, 0.04);
            --subtle-shadow: 0 2px 4px rgba(15, 23, 42, 0.04);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: var(--brand-bg);
            background-image: 
                radial-gradient(at 0% 0%, rgba(8, 131, 149, 0.05) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(5, 150, 105, 0.04) 0px, transparent 50%);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* TOP HOSPITAL NAVBAR */
        .portal-header {
            background: #ffffff;
            border-bottom: 1px solid var(--border-color);
            padding: 0.9rem 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .brand-container {
            display: flex;
            align-items: center;
            gap: 0.85rem;
            text-decoration: none;
            color: var(--brand-navy);
        }

        .hospital-emblem {
            width: 44px;
            height: 44px;
            background: linear-gradient(135deg, #0b1e33 0%, #088395 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            box-shadow: 0 4px 10px rgba(8, 131, 149, 0.25);
        }

        .brand-text h1 {
            font-size: 1.35rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            color: var(--brand-navy);
            line-height: 1.1;
        }

        .brand-text p {
            font-size: 0.725rem;
            color: var(--brand-teal);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-top: 1px;
        }

        .header-meta {
            display: flex;
            align-items: center;
            gap: 1.25rem;
        }

        .accreditation-tag {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            padding: 0.4rem 0.85rem;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-secondary);
        }

        .accreditation-tag svg {
            color: var(--brand-teal);
        }

        .emergency-sos-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
            background: #dc2626;
            color: #ffffff;
            padding: 0.48rem 1.1rem;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.825rem;
            font-weight: 700;
            letter-spacing: 0.02em;
            transition: background 0.15s ease;
            box-shadow: 0 2px 8px rgba(220, 38, 38, 0.25);
        }

        .emergency-sos-btn:hover {
            background: #b91c1c;
        }

        /* MAIN CONTENT LAYOUT */
        .portal-main {
            flex: 1;
            max-width: 1280px;
            width: 100%;
            margin: 0 auto;
            padding: 2.75rem 2rem;
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 3.5rem;
            align-items: center;
        }

        @media (max-width: 992px) {
            .portal-main {
                grid-template-columns: 1fr;
                gap: 2.5rem;
                padding: 1.75rem 1.25rem;
            }
            .portal-header {
                padding: 0.8rem 1.25rem;
            }
            .accreditation-tag {
                display: none;
            }
        }

        /* LEFT COLUMN: FORMAL CLINICAL OVERVIEW */
        .overview-pane {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .overview-header-tag {
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
            background: rgba(8, 131, 149, 0.08);
            color: var(--brand-teal);
            border: 1px solid rgba(8, 131, 149, 0.2);
            padding: 0.35rem 0.85rem;
            border-radius: 4px;
            font-size: 0.775rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            width: fit-content;
        }

        .overview-title {
            font-size: clamp(2rem, 3.2vw, 2.75rem);
            font-weight: 800;
            line-height: 1.2;
            color: var(--brand-navy);
            letter-spacing: -0.025em;
        }

        .overview-title span {
            color: var(--brand-teal);
        }

        .overview-desc {
            font-size: 1rem;
            color: var(--text-secondary);
            line-height: 1.6;
            max-width: 520px;
        }

        /* CLINICAL SERVICES GRID */
        .services-matrix {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-top: 0.5rem;
        }

        @media (max-width: 600px) {
            .services-matrix {
                grid-template-columns: 1fr;
            }
        }

        .service-card {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.15rem 1.2rem;
            display: flex;
            align-items: flex-start;
            gap: 0.85rem;
            box-shadow: var(--subtle-shadow);
            transition: all 0.2s ease;
        }

        .service-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 6px 16px rgba(15, 23, 42, 0.06);
            transform: translateY(-2px);
        }

        .service-icon-box {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: #f1f5f9;
            color: var(--brand-navy);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            border: 1px solid #e2e8f0;
        }

        .service-details h4 {
            font-size: 0.925rem;
            font-weight: 700;
            color: var(--brand-navy);
            margin-bottom: 0.2rem;
        }

        .service-details p {
            font-size: 0.8rem;
            color: var(--text-muted);
            line-height: 1.45;
        }

        /* CLINICAL TRUST BAR */
        .trust-metrics-strip {
            display: flex;
            align-items: center;
            gap: 2rem;
            padding-top: 0.5rem;
            border-top: 1px solid var(--border-color);
            margin-top: 0.5rem;
        }

        .metric-unit {
            display: flex;
            flex-direction: column;
        }

        .metric-unit strong {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--brand-navy);
            line-height: 1;
        }

        .metric-unit span {
            font-size: 0.725rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.04em;
            margin-top: 0.25rem;
            font-weight: 600;
        }

        /* RIGHT COLUMN: AUTHENTICATION CONTAINER */
        .login-card-container {
            display: flex;
            justify-content: center;
        }

        .auth-card {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: 16px;
            padding: 2.2rem 2.2rem 2rem 2.2rem;
            width: 100%;
            max-width: 460px;
            box-shadow: var(--card-shadow);
        }

        .auth-card-header {
            margin-bottom: 1.5rem;
        }

        .auth-title {
            font-size: 1.45rem;
            font-weight: 800;
            color: var(--brand-navy);
            letter-spacing: -0.02em;
        }

        .auth-subtitle {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }

        /* PROFESSIONAL ROLE SEGMENT CONTROLLER */
        .role-tabs-bar {
            display: flex;
            background: #f1f5f9;
            padding: 0.35rem;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            gap: 0.25rem;
            margin-bottom: 1.75rem;
        }

        .role-tab-btn {
            flex: 1;
            padding: 0.6rem 0.4rem;
            border-radius: 7px;
            border: none;
            background: transparent;
            font-family: inherit;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--text-muted);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.45rem;
            white-space: nowrap;
            transition: all 0.15s ease;
        }

        .role-tab-btn svg {
            width: 15px;
            height: 15px;
            flex-shrink: 0;
            stroke-width: 2.2;
        }

        .role-tab-btn:hover {
            color: var(--brand-navy);
        }

        .role-tab-btn.active {
            background: #ffffff;
            color: var(--brand-navy);
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.08);
            border: 1px solid #e2e8f0;
        }

        .role-tab-btn.active svg {
            color: var(--brand-teal);
        }

        /* FORM CONTROLS */
        .form-group {
            margin-bottom: 1.15rem;
        }

        .form-label {
            display: block;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--brand-navy);
            margin-bottom: 0.4rem;
        }

        .input-box {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon-left {
            position: absolute;
            left: 0.95rem;
            color: var(--text-light);
            display: flex;
            align-items: center;
            pointer-events: none;
        }

        .form-input {
            width: 100%;
            padding: 0.78rem 1rem 0.78rem 2.65rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 0.9rem;
            font-family: inherit;
            color: var(--text-primary);
            background: #ffffff;
            outline: none;
            transition: all 0.15s ease;
        }

        .form-input:focus {
            border-color: var(--border-focus);
            box-shadow: 0 0 0 3px rgba(8, 131, 149, 0.12);
        }

        .toggle-password-btn {
            position: absolute;
            right: 0.9rem;
            background: none;
            border: none;
            color: var(--text-light);
            cursor: pointer;
            display: flex;
            align-items: center;
            padding: 0.2rem;
        }

        .toggle-password-btn:hover {
            color: var(--text-secondary);
        }

        .btn-submit-login {
            width: 100%;
            padding: 0.85rem;
            background: var(--brand-navy);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-family: inherit;
            font-size: 0.925rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(11, 30, 51, 0.2);
            transition: all 0.15s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }

        .btn-submit-login:hover {
            background: #14355a;
        }

        /* ROLE SPECIFIC PANELS */
        .auth-panel {
            display: none;
        }
        .auth-panel.show {
            display: block;
            animation: fadeIn 0.2s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(3px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* CLEAN ACCREDITED DEMO TEST HELPER */
        .test-credential-helper {
            margin-top: 1.35rem;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 0.85rem 1rem;
        }

        .test-cred-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 0.35rem;
        }

        .test-cred-title {
            font-size: 0.725rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }

        .test-cred-text {
            font-family: 'Inter', monospace;
            font-size: 0.8rem;
            color: var(--brand-navy);
            font-weight: 600;
            letter-spacing: -0.01em;
        }

        .btn-quick-fill {
            margin-top: 0.55rem;
            width: 100%;
            padding: 0.5rem;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            color: var(--brand-navy);
            border-radius: 6px;
            font-size: 0.775rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
            transition: all 0.15s;
        }

        .btn-quick-fill:hover {
            background: #f1f5f9;
            border-color: #94a3b8;
        }

        /* CARD FOOTER LINKS */
        .card-footer-links {
            margin-top: 1.35rem;
            padding-top: 1.15rem;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            font-size: 0.8rem;
        }

        .card-footer-links a {
            color: var(--brand-teal);
            text-decoration: none;
            font-weight: 600;
        }

        .card-footer-links a:hover {
            text-decoration: underline;
        }

        /* BOTTOM ACCREDITATION FOOTER */
        .portal-footer {
            background: #ffffff;
            border-top: 1px solid var(--border-color);
            padding: 1.15rem 2rem;
            text-align: center;
            font-size: 0.8rem;
            color: var(--text-muted);
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1280px;
            width: 100%;
            margin: 0 auto;
        }

        @media (max-width: 768px) {
            .portal-footer {
                flex-direction: column;
                gap: 0.5rem;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<!-- TOP HOSPITAL PORTAL NAVIGATION -->
<header class="portal-header">
    <a href="<%= request.getContextPath() %>/MainLogin.jsp" class="brand-container">
        <div class="hospital-emblem">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <path d="M12 6v12m-6-6h12"></path>
            </svg>
        </div>
        <div class="brand-text">
            <h1>OmniHealth</h1>
            <p>Integrated Clinical Healthcare System</p>
        </div>
    </a>

    <div class="header-meta">
        <a href="<%= request.getContextPath() %>/emergency/emergency.jsp" class="emergency-sos-btn">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
            </svg>
            Emergency SOS (24/7)
        </a>
    </div>
</header>

<!-- MAIN WORKSPACE -->
<main class="portal-main">

    <!-- LEFT COLUMN: CLINICAL SYSTEM PRESENTATION -->
    <section class="overview-pane">
        <div class="overview-header-tag">
            Centralized Hospital Management
        </div>

        <h2 class="overview-title">
            Enterprise Medical Care, <br>
            <span>Connected &amp; Secure.</span>
        </h2>

        <p class="overview-desc">
            A unified clinical infrastructure connecting licensed doctors, pharmacy distribution, registered patient electronic health records (EHR), and emergency ambulance dispatch.
        </p>

        <!-- 4 CLINICAL SERVICE UNITS -->
        <div class="services-matrix">
            
            <div class="service-card">
                <div class="service-icon-box">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                        <path d="M4.8 2.3A.3.3 0 1 0 5 2H4a2 2 0 0 0-2 2v5a6 6 0 0 0 6 6v0a6 6 0 0 0 6-6V4a2 2 0 0 0-2-2h-1a.2.2 0 1 0 .3.3"></path>
                        <path d="M8 15v1a6 6 0 0 0 6 6v0a6 6 0 0 0 6-6v-4"></path>
                        <circle cx="20" cy="10" r="2"></circle>
                    </svg>
                </div>
                <div class="service-details">
                    <h4>Clinical Consultations</h4>
                    <p>Doctor scheduling, clinical notes, and digital e-prescriptions.</p>
                </div>
            </div>

            <div class="service-card">
                <div class="service-icon-box">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                        <path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"></path>
                        <path d="m8.5 8.5 7 7"></path>
                    </svg>
                </div>
                <div class="service-details">
                    <h4>Pharmacy Inventory</h4>
                    <p>Live formulation tracking, batch control &amp; automatic deduction.</p>
                </div>
            </div>

            <div class="service-card">
                <div class="service-icon-box">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                        <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                </div>
                <div class="service-details">
                    <h4>Patient Care Suite</h4>
                    <p>Specialist slot booking, longitudinal records &amp; doorstep delivery.</p>
                </div>
            </div>

            <div class="service-card">
                <div class="service-icon-box" style="background: #fef2f2; color: #dc2626; border-color: #fecaca;">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                    </svg>
                </div>
                <div class="service-details">
                    <h4>Emergency Response</h4>
                    <p>Zero-barrier SOS dispatch with live GPS ambulance telemetry.</p>
                </div>
            </div>

        </div>

    </section>

    <!-- RIGHT COLUMN: STRUCTURED CLINICAL AUTHENTICATION CARD -->
    <section class="login-card-container">
        <div class="auth-card">

            <div class="auth-card-header">
                <h3 class="auth-title">Hospital Portal Sign In</h3>
                <p class="auth-subtitle">Select your authorized department to access the system</p>
            </div>

            <!-- ROLE SEGMENT TABS (Icon + Text strictly on one horizontal line) -->
            <div class="role-tabs-bar">
                <button type="button" class="role-tab-btn active" onclick="selectRole('doctor', this)">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                        <path d="M4.8 2.3A.3.3 0 1 0 5 2H4a2 2 0 0 0-2 2v5a6 6 0 0 0 6 6v0a6 6 0 0 0 6-6V4a2 2 0 0 0-2-2h-1a.2.2 0 1 0 .3.3"></path>
                        <path d="M8 15v1a6 6 0 0 0 6 6v0a6 6 0 0 0 6-6v-4"></path>
                        <circle cx="20" cy="10" r="2"></circle>
                    </svg>
                    <span>Doctor</span>
                </button>
                <button type="button" class="role-tab-btn" onclick="selectRole('pharmacy', this)">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                        <path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"></path>
                        <path d="m8.5 8.5 7 7"></path>
                    </svg>
                    <span>Pharmacy</span>
                </button>
                <button type="button" class="role-tab-btn" onclick="selectRole('patient', this)">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                        <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                    <span>Patient</span>
                </button>
                <button type="button" class="role-tab-btn" onclick="selectRole('admin', this)">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                    </svg>
                    <span>Admin</span>
                </button>
            </div>

            <!-- ==============================================
                 1. DOCTOR LOGIN PANEL
                 ============================================== -->
            <div class="auth-panel show" id="panel-doctor">
                <form action="<%= request.getContextPath() %>/DoctorLoginServlet" method="post" id="formDoctor">
                    <div class="form-group">
                        <label class="form-label" for="inputDocEmail">Doctor Email / ID</label>
                        <div class="input-box">
                            <span class="input-icon-left">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                            </span>
                            <input type="email" name="email" id="inputDocEmail" class="form-input" placeholder="doctor@hospital.com" required autocomplete="email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="inputDocPass">Password</label>
                        <div class="input-box">
                            <span class="input-icon-left">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            </span>
                            <input type="password" name="password" id="inputDocPass" class="form-input" placeholder="••••••••" required autocomplete="current-password">
                            <button type="button" class="toggle-password-btn" onclick="togglePass('inputDocPass', this)" title="Show/Hide Password">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit-login">
                        Sign In as Doctor &rarr;
                    </button>
                </form>

                <div class="test-credential-helper">
                    <div class="test-cred-header">
                        <span class="test-cred-title">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                            Clinical Assessment Account
                        </span>
                    </div>
                    <div class="test-cred-text">
                        harshsahu10072006@gmail.com &bull; harsh123
                    </div>
                    <button type="button" class="btn-quick-fill" onclick="autofill('inputDocEmail','harshsahu10072006@gmail.com','inputDocPass','harsh123','formDoctor')">
                        Auto-fill Doctor Credentials
                    </button>
                </div>

                <div class="card-footer-links">
                    <a href="<%= request.getContextPath() %>/DoctorRegisterServlet">Apply for Medical License</a>
                    <a href="<%= request.getContextPath() %>/DoctorLoginServlet">Direct Gateway</a>
                </div>
            </div>

            <!-- ==============================================
                 2. PHARMACY PANEL
                 ============================================== -->
            <div class="auth-panel" id="panel-pharmacy">
                <form action="<%= request.getContextPath() %>/PharmacyLoginServlet" method="post" id="formPharmacy">
                    <div class="form-group">
                        <label class="form-label" for="inputPharmEmail">Pharmacy Desk Email</label>
                        <div class="input-box">
                            <span class="input-icon-left">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"></path><path d="m8.5 8.5 7 7"></path></svg>
                            </span>
                            <input type="email" name="email" id="inputPharmEmail" class="form-input" placeholder="pharmacare@omnihealth.com" required autocomplete="email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="inputPharmPass">Password</label>
                        <div class="input-box">
                            <span class="input-icon-left">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            </span>
                            <input type="password" name="password" id="inputPharmPass" class="form-input" placeholder="••••••••" required autocomplete="current-password">
                            <button type="button" class="toggle-password-btn" onclick="togglePass('inputPharmPass', this)" title="Show/Hide Password">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit-login">
                        Sign In as Pharmacy &rarr;
                    </button>
                </form>

                <div class="test-credential-helper">
                    <div class="test-cred-header">
                        <span class="test-cred-title">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                            Pharmacy Assessment Account
                        </span>
                    </div>
                    <div class="test-cred-text">
                        pharmacare@omnihealth.com &bull; admin123
                    </div>
                    <button type="button" class="btn-quick-fill" onclick="autofill('inputPharmEmail','pharmacare@omnihealth.com','inputPharmPass','admin123','formPharmacy')">
                        Auto-fill Pharmacy Credentials
                    </button>
                </div>

                <div class="card-footer-links">
                    <a href="<%= request.getContextPath() %>/pharmacy/login.jsp">Direct Pharmacy Desk</a>
                    <a href="<%= request.getContextPath() %>/patient/medicines">Medicine Catalog</a>
                </div>
            </div>

            <!-- ==============================================
                 3. PATIENT LOGIN PANEL
                 ============================================== -->
            <div class="auth-panel" id="panel-patient">
                <form action="<%= request.getContextPath() %>/patient/login" method="post" id="formPatient">
                    <div class="form-group">
                        <label class="form-label" for="inputPatEmail">Patient Registered Email</label>
                        <div class="input-box">
                            <span class="input-icon-left">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                            </span>
                            <input type="email" name="email" id="inputPatEmail" class="form-input" placeholder="nikhil@gmail.com" required autocomplete="email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="inputPatPass">Password</label>
                        <div class="input-box">
                            <span class="input-icon-left">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            </span>
                            <input type="password" name="password" id="inputPatPass" class="form-input" placeholder="••••••••" required autocomplete="current-password">
                            <button type="button" class="toggle-password-btn" onclick="togglePass('inputPatPass', this)" title="Show/Hide Password">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit-login">
                        Sign In as Patient &rarr;
                    </button>
                </form>

                <div class="test-credential-helper">
                    <div class="test-cred-header">
                        <span class="test-cred-title">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                            Patient Assessment Account
                        </span>
                    </div>
                    <div class="test-cred-text">
                        nikhil@gmail.com &bull; nikhil
                    </div>
                    <button type="button" class="btn-quick-fill" onclick="autofill('inputPatEmail','nikhil@gmail.com','inputPatPass','nikhil','formPatient')">
                        Auto-fill Patient Credentials
                    </button>
                </div>

                <div class="card-footer-links">
                    <a href="<%= request.getContextPath() %>/patient/Signup.jsp">New Patient? Register</a>
                    <a href="<%= request.getContextPath() %>/patient/medicines">Explore Catalog</a>
                </div>
            </div>

            <!-- ==============================================
                 4. ADMIN LOGIN PANEL
                 ============================================== -->
            <div class="auth-panel" id="panel-admin">
                <form action="<%= request.getContextPath() %>/AdminLoginServlet" method="post" id="formAdmin">
                    <div class="form-group">
                        <label class="form-label" for="inputAdmEmail">System Administrator Email</label>
                        <div class="input-box">
                            <span class="input-icon-left">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                            </span>
                            <input type="email" name="email" id="inputAdmEmail" class="form-input" placeholder="admin@omnihealth.com" required autocomplete="email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="inputAdmPass">Password</label>
                        <div class="input-box">
                            <span class="input-icon-left">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            </span>
                            <input type="password" name="password" id="inputAdmPass" class="form-input" placeholder="••••••••" required autocomplete="current-password">
                            <button type="button" class="toggle-password-btn" onclick="togglePass('inputAdmPass', this)" title="Show/Hide Password">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit-login">
                        Enter Admin Console &rarr;
                    </button>
                </form>

                <div class="test-credential-helper">
                    <div class="test-cred-header">
                        <span class="test-cred-title">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                            Administrator Account
                        </span>
                    </div>
                    <div class="test-cred-text">
                        admin@omnihealth.com &bull; admin123
                    </div>
                    <button type="button" class="btn-quick-fill" onclick="autofill('inputAdmEmail','admin@omnihealth.com','inputAdmPass','admin123','formAdmin')">
                        Auto-fill Admin Credentials
                    </button>
                </div>

                <div class="card-footer-links">
                    <a href="<%= request.getContextPath() %>/admin/doctors">License Approval Queue</a>
                    <a href="<%= request.getContextPath() %>/admin/emergencies">Emergency Radar</a>
                </div>
            </div>

        </div>
    </section>

</main>

<!-- BOTTOM CLINICAL FOOTER -->
<footer class="portal-footer">
    <div>
        &copy; 2026 OmniHealth Unified Healthcare Information System. All Rights Reserved.
    </div>
    <div>
        Certified Medical Informatics Infrastructure &bull; ISO 27001 &amp; HIPAA Compliant
    </div>
</footer>

<!-- SCRIPT LOGIC -->
<script>
    function selectRole(role, btn) {
        document.querySelectorAll('.role-tab-btn').forEach(function(b) {
            b.classList.remove('active');
        });
        btn.classList.add('active');

        document.querySelectorAll('.auth-panel').forEach(function(p) {
            p.classList.remove('show');
        });
        var target = document.getElementById('panel-' + role);
        if (target) {
            target.classList.add('show');
        }
    }

    function autofill(emailId, emailVal, passId, passVal, formId) {
        document.getElementById(emailId).value = emailVal;
        document.getElementById(passId).value = passVal;
        document.getElementById(formId).submit();
    }

    function togglePass(inputId, btn) {
        var input = document.getElementById(inputId);
        if (input.type === 'password') {
            input.type = 'text';
            btn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>';
        } else {
            input.type = 'password';
            btn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>';
        }
    }

    window.addEventListener('DOMContentLoaded', function() {
        var params = new URLSearchParams(window.location.search);
        var role = params.get('role');
        if (role) {
            var btn = document.querySelector(".role-tab-btn[onclick*=\"'" + role + "'\"]");
            if (btn) selectRole(role, btn);
        }
    });
</script>

</body>
</html>
