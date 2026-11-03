<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OmniHealth - Unified Medical &amp; Healthcare Portal</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-emerald: #059669;
            --primary-light: #10b981;
            --primary-dark: #047857;
            --primary-soft: #ecfdf5;
            --primary-border: #a7f3d0;
            --primary-glow: rgba(16, 185, 129, 0.25);

            --accent-teal: #0d9488;
            --accent-cyan: #0284c7;
            --accent-rose: #e11d48;

            --bg-page: #f8fafc;
            --bg-white: #ffffff;
            --text-heading: #0f172a;
            --text-body: #475569;
            --text-muted: #94a3b8;
            --border-subtle: #e2e8f0;
            --shadow-subtle: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            --shadow-card: 0 20px 40px -15px rgba(5, 150, 105, 0.12), 0 0 0 1px rgba(16, 185, 129, 0.12);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #f0fdf4 0%, #f8fafc 50%, #ecfdf5 100%);
            color: var(--text-heading);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            position: relative;
        }

        /* Ambient Medical Background Blobs */
        .ambient-blob {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.6;
            pointer-events: none;
            z-index: 0;
        }
        .blob-1 {
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(16, 185, 129, 0.22) 0%, rgba(240, 253, 244, 0) 70%);
            top: -150px;
            left: -150px;
        }
        .blob-2 {
            width: 450px;
            height: 450px;
            background: radial-gradient(circle, rgba(13, 148, 136, 0.18) 0%, rgba(240, 253, 244, 0) 70%);
            bottom: -150px;
            right: -100px;
        }

        /* HEADER */
        .top-navbar {
            position: relative;
            z-index: 50;
            padding: 1.1rem 3rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid rgba(16, 185, 129, 0.15);
        }

        .brand-box {
            display: flex;
            align-items: center;
            gap: 0.85rem;
            text-decoration: none;
            color: var(--text-heading);
        }

        .brand-cross-icon {
            width: 42px;
            height: 42px;
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            box-shadow: 0 8px 16px -4px rgba(5, 150, 105, 0.35);
        }

        .brand-title {
            font-family: 'Outfit', sans-serif;
            font-size: 1.45rem;
            font-weight: 800;
            letter-spacing: -0.025em;
            color: #064e3b;
            line-height: 1.1;
        }

        .brand-subtitle {
            font-size: 0.725rem;
            color: #059669;
            font-weight: 700;
            letter-spacing: 0.06em;
            text-transform: uppercase;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .system-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: #dcfce7;
            border: 1px solid #86efac;
            color: #166534;
            padding: 0.4rem 0.95rem;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .pulse-indicator {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #16a34a;
            box-shadow: 0 0 0 0 rgba(22, 163, 74, 0.7);
            animation: pulse-ring 1.8s infinite;
        }

        @keyframes pulse-ring {
            0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(22, 163, 74, 0.7); }
            70% { transform: scale(1.1); box-shadow: 0 0 0 6px rgba(22, 163, 74, 0); }
            100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(22, 163, 74, 0); }
        }

        .sos-nav-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: #ffe4e6;
            color: #e11d48;
            border: 1px solid #fecdd3;
            padding: 0.45rem 1rem;
            border-radius: 9999px;
            text-decoration: none;
            font-size: 0.825rem;
            font-weight: 700;
            transition: all 0.2s;
        }

        .sos-nav-link:hover {
            background: #e11d48;
            color: white;
        }

        /* MAIN HERO SPLIT WRAPPER */
        .split-hero-container {
            position: relative;
            z-index: 10;
            flex: 1;
            max-width: 1320px;
            width: 100%;
            margin: 0 auto;
            padding: 2.5rem 3rem;
            display: grid;
            grid-template-columns: 1.15fr 1fr;
            gap: 3.5rem;
            align-items: center;
        }

        @media (max-width: 1024px) {
            .split-hero-container {
                grid-template-columns: 1fr;
                gap: 2.5rem;
                padding: 2rem 1.5rem;
            }
        }

        /* LEFT COLUMN: OMNIHEALTH BRANDING & FEATURES */
        .left-content {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .badge-verified {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
            padding: 0.4rem 1rem;
            border-radius: 9999px;
            font-size: 0.825rem;
            font-weight: 700;
            width: fit-content;
        }

        .hero-heading {
            font-family: 'Outfit', sans-serif;
            font-size: clamp(2.5rem, 4.2vw, 3.8rem);
            font-weight: 900;
            line-height: 1.12;
            letter-spacing: -0.03em;
            color: #064e3b;
        }

        .hero-heading span {
            color: #059669;
            background: linear-gradient(135deg, #059669 0%, #0d9488 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero-description {
            font-size: 1.05rem;
            color: var(--text-body);
            line-height: 1.65;
            max-width: 540px;
        }

        /* 4 Key Feature Badges Grid */
        .features-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.1rem;
            margin-top: 0.5rem;
        }

        @media (max-width: 640px) {
            .features-grid {
                grid-template-columns: 1fr;
            }
        }

        .feature-card-item {
            background: var(--bg-white);
            border: 1px solid rgba(16, 185, 129, 0.15);
            border-radius: 16px;
            padding: 1.15rem;
            display: flex;
            align-items: flex-start;
            gap: 0.85rem;
            box-shadow: 0 4px 12px -2px rgba(5, 150, 105, 0.05);
            transition: all 0.25s ease;
        }

        .feature-card-item:hover {
            transform: translateY(-3px);
            border-color: #10b981;
            box-shadow: 0 10px 20px -3px rgba(5, 150, 105, 0.1);
        }

        .feat-icon-box {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: #ecfdf5;
            color: #059669;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .feat-info h4 {
            font-family: 'Outfit', sans-serif;
            font-size: 0.95rem;
            font-weight: 700;
            color: #064e3b;
            margin-bottom: 0.2rem;
        }

        .feat-info p {
            font-size: 0.8rem;
            color: var(--text-muted);
            line-height: 1.4;
        }

        /* College Project Pill */
        .college-tag-bar {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.825rem;
            color: #047857;
            padding-top: 0.5rem;
            font-weight: 600;
        }

        /* RIGHT COLUMN: GORGEOUS MEDICAL LOGIN CARD */
        .right-content {
            display: flex;
            justify-content: center;
        }

        .unified-login-card {
            background: var(--bg-white);
            border: 1px solid rgba(16, 185, 129, 0.2);
            border-radius: 26px;
            padding: 2.25rem 2.25rem 2rem 2.25rem;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 25px 50px -12px rgba(5, 150, 105, 0.15), 0 0 0 1px rgba(16, 185, 129, 0.1);
            position: relative;
        }

        .card-header-area {
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .login-card-title {
            font-family: 'Outfit', sans-serif;
            font-size: 1.6rem;
            font-weight: 800;
            color: #064e3b;
            letter-spacing: -0.02em;
        }

        .login-card-subtitle {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }

        /* ROLE SELECTOR CHIPS / TABS */
        .role-pill-selector {
            display: flex;
            background: #f1f5f9;
            padding: 0.35rem;
            border-radius: 14px;
            gap: 0.3rem;
            margin-bottom: 1.75rem;
        }

        .role-pill-btn {
            flex: 1;
            padding: 0.55rem 0.4rem;
            border-radius: 10px;
            border: none;
            background: transparent;
            font-family: inherit;
            font-size: 0.825rem;
            font-weight: 700;
            color: #64748b;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.35rem;
            transition: all 0.2s ease;
        }

        .role-pill-btn:hover {
            color: #064e3b;
        }

        .role-pill-btn.active {
            background: var(--bg-white);
            color: #059669;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        /* FORM CONTROLS */
        .form-group-item {
            margin-bottom: 1.15rem;
        }

        .form-label-text {
            display: block;
            font-size: 0.825rem;
            font-weight: 700;
            color: #334155;
            margin-bottom: 0.4rem;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            color: #94a3b8;
            pointer-events: none;
            display: flex;
            align-items: center;
        }

        .custom-input {
            width: 100%;
            padding: 0.85rem 1rem 0.85rem 2.85rem;
            border: 1.5px solid var(--border-subtle);
            border-radius: 12px;
            font-size: 0.925rem;
            font-family: inherit;
            color: var(--text-heading);
            background: #ffffff;
            outline: none;
            transition: all 0.2s ease;
        }

        .custom-input:focus {
            border-color: #059669;
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
        }

        .btn-green-submit {
            width: 100%;
            padding: 0.95rem;
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-family: inherit;
            font-size: 0.975rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 6px 18px -2px rgba(5, 150, 105, 0.35);
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            margin-top: 0.25rem;
        }

        .btn-green-submit:hover {
            background: linear-gradient(135deg, #047857 0%, #059669 100%);
            transform: translateY(-2px);
            box-shadow: 0 10px 22px -2px rgba(5, 150, 105, 0.4);
        }

        /* 1-CLICK DEMO VIVA BOX */
        .viva-demo-box {
            margin-top: 1.35rem;
            background: #f0fdf4;
            border: 1px dashed #86efac;
            border-radius: 14px;
            padding: 1rem 1.15rem;
        }

        .demo-top-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 0.45rem;
        }

        .demo-label {
            font-size: 0.775rem;
            font-weight: 800;
            color: #166534;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .demo-badge-active {
            background: #dcfce7;
            color: #15803d;
            font-size: 0.725rem;
            font-weight: 700;
            padding: 0.15rem 0.5rem;
            border-radius: 9999px;
        }

        .demo-creds-text {
            font-family: monospace;
            font-size: 0.8rem;
            color: #334155;
            line-height: 1.45;
        }

        .btn-autofill-action {
            margin-top: 0.75rem;
            width: 100%;
            padding: 0.6rem;
            background: #ffffff;
            border: 1.5px solid #a7f3d0;
            color: #047857;
            border-radius: 10px;
            font-size: 0.825rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
            transition: all 0.2s;
        }

        .btn-autofill-action:hover {
            background: #ecfdf5;
            border-color: #059669;
            color: #064e3b;
        }

        /* ROLE SPECIFIC PANELS */
        .auth-panel {
            display: none;
        }
        .auth-panel.show {
            display: block;
            animation: fadeIn 0.25s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(4px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .bottom-action-links {
            margin-top: 1.25rem;
            display: flex;
            justify-content: space-between;
            font-size: 0.825rem;
        }

        .bottom-action-links a {
            color: #059669;
            text-decoration: none;
            font-weight: 600;
        }

        .bottom-action-links a:hover {
            text-decoration: underline;
        }

        /* FOOTER STRIP */
        .bottom-strip {
            position: relative;
            z-index: 10;
            text-align: center;
            padding: 1.25rem 2rem;
            font-size: 0.825rem;
            color: var(--text-muted);
            border-top: 1px solid rgba(16, 185, 129, 0.12);
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body>

<div class="ambient-blob blob-1"></div>
<div class="ambient-blob blob-2"></div>

<!-- TOP NAVBAR -->
<nav class="top-navbar">
    <a href="<%= request.getContextPath() %>/MainLogin.jsp" class="brand-box">
        <div class="brand-cross-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M4.8 2.3A.3.3 0 1 0 5 2H4a2 2 0 0 0-2 2v5a6 6 0 0 0 6 6v0a6 6 0 0 0 6-6V4a2 2 0 0 0-2-2h-1a.2.2 0 1 0 .3.3"></path>
                <path d="M8 15v1a6 6 0 0 0 6 6v0a6 6 0 0 0 6-6v-4"></path>
                <circle cx="20" cy="10" r="2"></circle>
            </svg>
        </div>
        <div>
            <div class="brand-title">OmniHealth</div>
            <div class="brand-subtitle">Integrated Healthcare System</div>
        </div>
    </a>

    <div class="nav-right">
        <div class="system-pill">
            <span class="pulse-indicator"></span>
            All 5 Health Portals Online
        </div>
        <a href="<%= request.getContextPath() %>/emergency/emergency.jsp" class="sos-nav-link">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
            Emergency SOS
        </a>
    </div>
</nav>

<!-- MAIN SINGLE-PAGE SPLIT VIEW -->
<main class="split-hero-container">

    <!-- LEFT SIDE: OMNIHEALTH PRESENTATION & MEDICAL FEATURES -->
    <section class="left-content">
        <h1 class="hero-heading" style="margin-top: 0.5rem;">
            Modern Healthcare, <br>
            <span>Simpler &amp; Faster.</span>
        </h1>

        <p class="hero-description">
            A single, unified hospital management ecosystem connecting Licensed Doctors, Registered Patients, Active Pharmacy Inventories, and Rapid SOS Emergency Ambulances.
        </p>

        <!-- 4 MEDICAL FEATURE ICONS (GREEN/WHITE THEME) -->
        <div class="features-grid">
            
            <div class="feature-card-item">
                <div class="feat-icon-box">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4.8 2.3A.3.3 0 1 0 5 2H4a2 2 0 0 0-2 2v5a6 6 0 0 0 6 6v0a6 6 0 0 0 6-6V4a2 2 0 0 0-2-2h-1a.2.2 0 1 0 .3.3"></path><path d="M8 15v1a6 6 0 0 0 6 6v0a6 6 0 0 0 6-6v-4"></path><circle cx="20" cy="10" r="2"></circle></svg>
                </div>
                <div class="feat-info">
                    <h4>Doctor Consultations</h4>
                    <p>Clinical scheduling, patient history &amp; digital e-prescriptions.</p>
                </div>
            </div>

            <div class="feature-card-item">
                <div class="feat-icon-box">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"></path><path d="m8.5 8.5 7 7"></path></svg>
                </div>
                <div class="feat-info">
                    <h4>Smart Pharmacy</h4>
                    <p>Live inventory, automated stock deduction &amp; order fulfillment.</p>
                </div>
            </div>

            <div class="feature-card-item">
                <div class="feat-icon-box">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                </div>
                <div class="feat-info">
                    <h4>Patient Care Suite</h4>
                    <p>Book specialists, view prescriptions &amp; order home delivery.</p>
                </div>
            </div>

            <div class="feature-card-item">
                <div class="feat-icon-box" style="background: #ffe4e6; color: #e11d48;">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                </div>
                <div class="feat-info">
                    <h4>Instant SOS Dispatch</h4>
                    <p>Zero-delay GPS ambulance triage dispatching without login barrier.</p>
                </div>
            </div>

        </div>

    </section>

    <!-- RIGHT SIDE: CLEAN, BEAUTIFUL GREEN & WHITE LOGIN CARD -->
    <section class="right-content">
        <div class="unified-login-card">

            <div class="card-header-area">
                <h2 class="login-card-title">Access Healthcare Portal</h2>
                <p class="login-card-subtitle">Select your role to sign in to your dashboard</p>
            </div>

            <!-- ROLE PILLS SWITCHER -->
            <div class="role-pill-selector">
                <button type="button" class="role-pill-btn active" onclick="selectRole('doctor', this)">
                    👨‍⚕️ Doctor
                </button>
                <button type="button" class="role-pill-btn" onclick="selectRole('pharmacy', this)">
                    💊 Pharmacy
                </button>
                <button type="button" class="role-pill-btn" onclick="selectRole('patient', this)">
                    🧑 Patient
                </button>
                <button type="button" class="role-pill-btn" onclick="selectRole('admin', this)">
                    🛡️ Admin
                </button>
            </div>

            <!-- ==============================================
                 1. DOCTOR LOGIN PANEL
                 ============================================== -->
            <div class="auth-panel show" id="panel-doctor">
                <form action="<%= request.getContextPath() %>/DoctorLoginServlet" method="post" id="formDoctor">
                    <div class="form-group-item">
                        <label class="form-label-text">Doctor Email</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                            </span>
                            <input type="email" name="email" id="inputDocEmail" class="custom-input" placeholder="doctor@hospital.com" required>
                        </div>
                    </div>

                    <div class="form-group-item">
                        <label class="form-label-text">Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            </span>
                            <input type="password" name="password" id="inputDocPass" class="custom-input" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-green-submit">
                        Sign In as Doctor &rarr;
                    </button>
                </form>

                <!-- 1-Click Fill -->
                <div class="viva-demo-box">
                    <div class="demo-top-row">
                        <span class="demo-label">👨‍⚕️ Demo Doctor Account:</span>
                        <span class="demo-badge-active">Verified</span>
                    </div>
                    <div class="demo-creds-text">
                        harshsahu10072006@gmail.com &bull; harsh123
                    </div>
                    <button type="button" class="btn-autofill-action" onclick="autofill('inputDocEmail','harshsahu10072006@gmail.com','inputDocPass','harsh123','formDoctor')">
                        ⚡ 1-Click Fill &amp; Sign In
                    </button>
                </div>

                <div class="bottom-action-links">
                    <a href="<%= request.getContextPath() %>/DoctorRegisterServlet">Apply for Doctor License</a>
                    <a href="<%= request.getContextPath() %>/DoctorLoginServlet">Direct Doctor Gate</a>
                </div>
            </div>

            <!-- ==============================================
                 2. PHARMACY PANEL
                 ============================================== -->
            <div class="auth-panel" id="panel-pharmacy">
                <form action="<%= request.getContextPath() %>/PharmacyLoginServlet" method="post" id="formPharmacy">
                    <div class="form-group-item">
                        <label class="form-label-text">Pharmacy Email</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"></path><path d="m8.5 8.5 7 7"></path></svg>
                            </span>
                            <input type="email" name="email" id="inputPharmEmail" class="custom-input" placeholder="pharmacare@omnihealth.com" required>
                        </div>
                    </div>

                    <div class="form-group-item">
                        <label class="form-label-text">Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            </span>
                            <input type="password" name="password" id="inputPharmPass" class="custom-input" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-green-submit">
                        Sign In as Pharmacy &rarr;
                    </button>
                </form>

                <!-- 1-Click Fill -->
                <div class="viva-demo-box">
                    <div class="demo-top-row">
                        <span class="demo-label">💊 Demo Pharmacy Account:</span>
                        <span class="demo-badge-active">Verified</span>
                    </div>
                    <div class="demo-creds-text">
                        pharmacare@omnihealth.com &bull; admin123
                    </div>
                    <button type="button" class="btn-autofill-action" onclick="autofill('inputPharmEmail','pharmacare@omnihealth.com','inputPharmPass','admin123','formPharmacy')">
                        ⚡ 1-Click Fill &amp; Sign In
                    </button>
                </div>

                <div class="bottom-action-links">
                    <a href="<%= request.getContextPath() %>/pharmacy/login.jsp">Direct Pharmacy Gate</a>
                    <a href="<%= request.getContextPath() %>/patient/medicines">Browse Medicine Catalog</a>
                </div>
            </div>

            <!-- ==============================================
                 3. PATIENT LOGIN PANEL
                 ============================================== -->
            <div class="auth-panel" id="panel-patient">
                <form action="<%= request.getContextPath() %>/patient/login" method="post" id="formPatient">
                    <div class="form-group-item">
                        <label class="form-label-text">Patient Email</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                            </span>
                            <input type="email" name="email" id="inputPatEmail" class="custom-input" placeholder="nikhil@gmail.com" required>
                        </div>
                    </div>

                    <div class="form-group-item">
                        <label class="form-label-text">Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            </span>
                            <input type="password" name="password" id="inputPatPass" class="custom-input" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-green-submit">
                        Sign In as Patient &rarr;
                    </button>
                </form>

                <div class="viva-demo-box">
                    <div class="demo-top-row">
                        <span class="demo-label">🧑 Demo Patient Account:</span>
                        <span class="demo-badge-active">Verified</span>
                    </div>
                    <div class="demo-creds-text">
                        nikhil@gmail.com &bull; nikhil
                    </div>
                    <button type="button" class="btn-autofill-action" onclick="autofill('inputPatEmail','nikhil@gmail.com','inputPatPass','nikhil','formPatient')">
                        ⚡ 1-Click Fill &amp; Sign In
                    </button>
                </div>

                <div class="bottom-action-links">
                    <a href="<%= request.getContextPath() %>/patient/Signup.jsp">New Patient? Register Here</a>
                    <a href="<%= request.getContextPath() %>/patient/medicines">Browse Medicines</a>
                </div>
            </div>

            <!-- ==============================================
                 4. ADMIN LOGIN PANEL
                 ============================================== -->
            <div class="auth-panel" id="panel-admin">
                <form action="<%= request.getContextPath() %>/AdminLoginServlet" method="post" id="formAdmin">
                    <div class="form-group-item">
                        <label class="form-label-text">Administrator Email</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                            </span>
                            <input type="email" name="email" id="inputAdmEmail" class="custom-input" placeholder="admin@omnihealth.com" required>
                        </div>
                    </div>

                    <div class="form-group-item">
                        <label class="form-label-text">Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            </span>
                            <input type="password" name="password" id="inputAdmPass" class="custom-input" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-green-submit" style="background: linear-gradient(135deg, #0f172a 0%, #334155 100%);">
                        Enter Admin Console &rarr;
                    </button>
                </form>

                <div class="viva-demo-box" style="background: #f8fafc; border-color: #cbd5e1;">
                    <div class="demo-top-row">
                        <span class="demo-label" style="color: #334155;">🛡️ Demo Admin Account:</span>
                        <span class="demo-badge-active" style="background:#e2e8f0; color:#334155;">Verified</span>
                    </div>
                    <div class="demo-creds-text">
                        admin@omnihealth.com &bull; admin123
                    </div>
                    <button type="button" class="btn-autofill-action" onclick="autofill('inputAdmEmail','admin@omnihealth.com','inputAdmPass','admin123','formAdmin')">
                        ⚡ 1-Click Fill &amp; Sign In
                    </button>
                </div>

                <div class="bottom-action-links">
                    <a href="<%= request.getContextPath() %>/admin/doctors">Doctor License Queue</a>
                    <a href="<%= request.getContextPath() %>/admin/emergencies">Live Emergency Radar</a>
                </div>
            </div>

        </div>
    </section>

</main>

<!-- BOTTOM STRIP -->
<footer class="bottom-strip">
    &copy; 2026 OmniHealth Unified Medical System &bull; All Rights Reserved
</footer>

<!-- INTERACTIVE SCRIPTS -->
<script>
    function selectRole(role, btn) {
        // Toggle pill buttons
        document.querySelectorAll('.role-pill-btn').forEach(b => {
            b.classList.remove('active');
        });
        btn.classList.add('active');

        // Toggle auth panels
        document.querySelectorAll('.auth-panel').forEach(p => {
            p.classList.remove('show');
        });
        const target = document.getElementById('panel-' + role);
        if (target) {
            target.classList.add('show');
        }
    }

    function autofill(emailId, emailVal, passId, passVal, formId) {
        document.getElementById(emailId).value = emailVal;
        document.getElementById(passId).value = passVal;
        document.getElementById(formId).submit();
    }

    window.addEventListener('DOMContentLoaded', function() {
        var params = new URLSearchParams(window.location.search);
        var role = params.get('role');
        if (role) {
            var btn = document.querySelector(".role-pill-btn[onclick*=\"'" + role + "'\"]");
            if (btn) selectRole(role, btn);
        }
    });
</script>

</body>
</html>