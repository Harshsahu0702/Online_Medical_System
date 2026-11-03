<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String footerCtx = request.getContextPath();
    int currentYear = java.time.Year.now().getValue();
%>
<style>
    .patient-footer {
        margin-top: auto;
        margin-left: 24px;
        margin-right: 24px;
        margin-bottom: 24px;
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
        border: 1px solid #334155;
        border-radius: 16px;
        color: #e2e8f0;
        font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.35);
        overflow: hidden;
    }

    .patient-footer-inner {
        padding: 32px 32px 20px 32px;
    }

    .patient-footer-top {
        display: grid;
        grid-template-columns: 1.5fr 1.3fr 1.2fr;
        gap: 32px;
        align-items: start;
    }

    .patient-footer-brand {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .patient-footer-logo-wrap {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .patient-footer-logo-icon {
        width: 38px;
        height: 38px;
        border-radius: 10px;
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        font-weight: 700;
        box-shadow: 0 4px 10px rgba(2, 132, 199, 0.4);
    }

    .patient-footer-logo-title {
        font-size: 18px;
        font-weight: 800;
        color: #ffffff;
        letter-spacing: -0.02em;
    }

    .patient-footer-tagline {
        font-size: 13px;
        color: #94a3b8;
        line-height: 1.6;
        margin: 0;
        max-width: 320px;
    }

    .patient-footer-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: rgba(16, 185, 129, 0.12);
        color: #34d399;
        border: 1px solid rgba(16, 185, 129, 0.25);
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        width: fit-content;
    }

    .patient-footer-col-title {
        display: block;
        font-size: 12px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        color: #38bdf8;
        margin-bottom: 14px;
    }

    .patient-footer-links {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px 16px;
    }

    .patient-footer-links a {
        color: #cbd5e1;
        text-decoration: none;
        font-size: 13px;
        font-weight: 500;
        transition: all 0.15s ease;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .patient-footer-links a:hover {
        color: #38bdf8;
        transform: translateX(2px);
    }

    .patient-footer-emergency-box {
        background: rgba(15, 23, 42, 0.6);
        border: 1px solid rgba(239, 68, 68, 0.25);
        border-radius: 12px;
        padding: 16px;
    }

    .patient-footer-sos-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: #ffffff !important;
        padding: 10px 16px;
        border-radius: 8px;
        font-size: 13px;
        font-weight: 700;
        text-decoration: none !important;
        transition: all 0.2s ease;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.35);
        width: 100%;
        text-align: center;
        margin-top: 8px;
    }

    .patient-footer-sos-btn:hover {
        background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
        box-shadow: 0 6px 16px rgba(239, 68, 68, 0.5);
        transform: translateY(-1px);
    }

    .patient-footer-bottom {
        border-top: 1px solid rgba(255, 255, 255, 0.08);
        padding-top: 20px;
        margin-top: 24px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 12px;
        font-size: 12px;
        color: #94a3b8;
    }

    .patient-footer-meta {
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .patient-footer-meta span {
        color: #64748b;
    }

    @media (max-width: 900px) {
        .patient-footer {
            margin: 24px 16px 16px 16px;
        }
        .patient-footer-inner {
            padding: 20px 18px 16px 18px;
        }
        .patient-footer-top {
            grid-template-columns: 1fr;
            gap: 22px;
        }
        .patient-footer-bottom {
            flex-direction: column;
            align-items: flex-start;
            gap: 8px;
        }
    }
</style>

<footer class="patient-footer">
    <div class="patient-footer-inner">
        <div class="patient-footer-top">
            <!-- Brand & Tagline -->
            <div class="patient-footer-brand">
                <div class="patient-footer-logo-wrap">
                    <span class="patient-footer-logo-icon">&#9877;</span>
                    <span class="patient-footer-logo-title">OmniHealth MediCore</span>
                </div>
                <p class="patient-footer-tagline">
                    Unified Patient Telehealth, Doctor Consultations &amp; Digital Pharmacy Delivery Network.
                </p>
                <div class="patient-footer-badge">
                    <span>&#128274;</span> HIPAA &amp; ISO 27001 Certified System
                </div>
            </div>

            <!-- Quick Links -->
            <div class="patient-footer-links-group">
                <span class="patient-footer-col-title">Portal Quick Navigation</span>
                <div class="patient-footer-links">
                    <a href="<%= footerCtx %>/patient/dashboard">&#8250; Dashboard</a>
                    <a href="<%= footerCtx %>/patient/appointments/appointments.jsp">&#8250; Appointments</a>
                    <a href="<%= footerCtx %>/patient/doctors/find-doctor.jsp">&#8250; Find Doctors</a>
                    <a href="<%= footerCtx %>/patient/prescriptions">&#8250; Prescriptions</a>
                    <a href="<%= footerCtx %>/patient/orders">&#8250; Pharmacy Orders</a>
                    <a href="<%= footerCtx %>/patient/profile">&#8250; Patient Profile</a>
                </div>
            </div>

            <!-- 24/7 SOS Box -->
            <div class="patient-footer-emergency-box">
                <span class="patient-footer-col-title" style="color: #f87171;">&#128680; 24/7 Emergency SOS</span>
                <p style="font-size: 12px; color: #94a3b8; margin: 4px 0 10px; line-height: 1.5;">
                    Immediate trauma triage and instant ambulance dispatch available nationwide.
                </p>
                <a href="<%= footerCtx %>/patient/emergency/emergency.jsp" class="patient-footer-sos-btn">
                    &#128680; Open SOS Emergency Portal
                </a>
            </div>
        </div>

        <div class="patient-footer-bottom">
            <div class="patient-footer-copy">
                &copy; <%= currentYear %> OmniHealth MediCore. All rights reserved.
            </div>
            <div class="patient-footer-meta">
                <span>Verified Pharmacies</span>
                <span>&bull;</span>
                <span>Encrypted Telehealth</span>
                <span>&bull;</span>
                <span>Secure Patient Records</span>
            </div>
        </div>
    </div>
</footer>
