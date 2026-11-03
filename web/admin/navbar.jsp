<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String currentUri = request.getRequestURI();
    String activeNav = "";
    if (currentUri.contains("doctor")) activeNav = "doctors";
    else if (currentUri.contains("patient")) activeNav = "patients";
    else if (currentUri.contains("pharmacie") || currentUri.contains("pharmacy")) activeNav = "pharmacies";
    else if (currentUri.contains("emergenc")) activeNav = "emergencies";
    else activeNav = "dashboard";
%>

<style>
    :root {
        --admin-primary: #4f46e5;
        --admin-primary-hover: #4338ca;
        --admin-dark: #0f172a;
        --admin-slate: #334155;
        --admin-border: #e2e8f0;
    }

    * { box-sizing: border-box; }

    .admin-navbar {
        background: #0f172a;
        color: white;
        padding: 0.85rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 1000;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .admin-brand {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        text-decoration: none;
        color: white;
        font-weight: 800;
        font-size: 1.25rem;
        letter-spacing: -0.02em;
    }

    .admin-badge-icon {
        width: 38px;
        height: 38px;
        background: linear-gradient(135deg, #6366f1 0%, #4338ca 100%);
        color: white;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 800;
        font-size: 1.15rem;
        box-shadow: 0 4px 6px -1px rgba(99, 102, 241, 0.3);
    }

    .admin-nav-links {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .admin-nav-item a {
        display: flex;
        align-items: center;
        gap: 0.45rem;
        padding: 0.5rem 0.9rem;
        text-decoration: none;
        color: #94a3b8;
        font-weight: 600;
        font-size: 0.875rem;
        border-radius: 8px;
        transition: all 0.2s;
    }

    .admin-nav-item a:hover {
        color: white;
        background: rgba(255, 255, 255, 0.1);
    }

    .admin-nav-item a.active {
        color: white;
        background: #4f46e5;
    }

    .admin-nav-actions {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .btn-admin-logout {
        background: rgba(239, 68, 68, 0.15);
        color: #fca5a5;
        border: 1px solid rgba(239, 68, 68, 0.3);
        padding: 0.45rem 0.9rem;
        border-radius: 6px;
        font-size: 0.825rem;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.15s;
    }

    .btn-admin-logout:hover {
        background: #ef4444;
        color: white;
    }

    .btn-portal-switch {
        background: rgba(255, 255, 255, 0.1);
        color: #cbd5e1;
        padding: 0.45rem 0.9rem;
        border-radius: 6px;
        font-size: 0.825rem;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.15s;
    }

    .btn-portal-switch:hover {
        background: rgba(255, 255, 255, 0.2);
        color: white;
    }
</style>

<nav class="admin-navbar">
    <a href="<%= request.getContextPath() %>/AdminDashboardServlet" class="admin-brand">
        <div class="admin-badge-icon">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
        </div>
        <div>
            <div>OmniHealth Admin</div>
            <div style="font-size: 0.7rem; font-weight: 500; color: #94a3b8;">Super Administrator Command Center</div>
        </div>
    </a>

    <ul class="admin-nav-links">
        <li class="admin-nav-item">
            <a href="<%= request.getContextPath() %>/AdminDashboardServlet" class="<%= "dashboard".equals(activeNav) ? "active" : "" %>">
                Dashboard
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="<%= request.getContextPath() %>/admin/doctors" class="<%= "doctors".equals(activeNav) ? "active" : "" %>">
                Doctors & Verification
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="<%= request.getContextPath() %>/admin/patients" class="<%= "patients".equals(activeNav) ? "active" : "" %>">
                Patients Registry
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="<%= request.getContextPath() %>/admin/pharmacies" class="<%= "pharmacies".equals(activeNav) ? "active" : "" %>">
                Pharmacies & Stock
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="<%= request.getContextPath() %>/admin/emergencies" class="<%= "emergencies".equals(activeNav) ? "active" : "" %>">
                Emergency Dispatch
            </a>
        </li>
    </ul>

    <div class="admin-nav-actions">
        <a href="<%= request.getContextPath() %>/MainLogin.jsp" class="btn-portal-switch">
            Public Portals
        </a>
        <a href="<%= request.getContextPath() %>/AdminLogoutServlet" class="btn-admin-logout">
            Sign Out
        </a>
    </div>
</nav>
