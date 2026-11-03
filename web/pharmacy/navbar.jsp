<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String currentUri = request.getRequestURI();
    String activeNav = "";
    if (currentUri.contains("medicines") || currentUri.contains("Medicine")) {
        activeNav = "medicines";
    } else if (currentUri.contains("order") || currentUri.contains("Order")) {
        activeNav = "orders";
    } else if (currentUri.contains("profile") || currentUri.contains("Profile")) {
        activeNav = "profile";
    } else {
        activeNav = "dashboard";
    }
%>

<style>
    :root {
        --pharm-primary: #059669;
        --pharm-primary-hover: #047857;
        --pharm-primary-light: #ecfdf5;
        --pharm-accent: #0284c7;
        --pharm-dark: #0f172a;
        --pharm-slate: #334155;
        --pharm-muted: #64748b;
        --pharm-border: #e2e8f0;
        --pharm-card-bg: #ffffff;
        --pharm-bg: #f8fafc;
        --pharm-danger: #ef4444;
        --pharm-warning: #f59e0b;
        --pharm-success: #10b981;
    }

    * {
        box-sizing: border-box;
    }

    .pharm-navbar {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(12px);
        border-bottom: 1px solid var(--pharm-border);
        position: sticky;
        top: 0;
        z-index: 1000;
        padding: 0.75rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
    }

    .pharm-brand {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        text-decoration: none;
        color: var(--pharm-dark);
        font-weight: 700;
        font-size: 1.25rem;
        letter-spacing: -0.02em;
    }

    .pharm-logo-icon {
        width: 38px;
        height: 38px;
        background: linear-gradient(135deg, #10b981 0%, #047857 100%);
        color: white;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 800;
        font-size: 1.2rem;
        box-shadow: 0 4px 6px -1px rgba(16, 185, 129, 0.3);
    }

    .pharm-nav-links {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .pharm-nav-item a {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.55rem 1rem;
        text-decoration: none;
        color: var(--pharm-slate);
        font-weight: 500;
        font-size: 0.925rem;
        border-radius: 8px;
        transition: all 0.2s ease;
    }

    .pharm-nav-item a:hover {
        color: var(--pharm-primary);
        background: var(--pharm-primary-light);
    }

    .pharm-nav-item a.active {
        color: var(--pharm-primary);
        background: var(--pharm-primary-light);
        font-weight: 600;
    }

    .pharm-nav-actions {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .pharm-portal-switcher {
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        padding: 0.45rem 0.85rem;
        font-size: 0.825rem;
        font-weight: 600;
        color: #475569;
        background: #f1f5f9;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        text-decoration: none;
        transition: background 0.15s;
    }

    .pharm-portal-switcher:hover {
        background: #e2e8f0;
        color: #0f172a;
    }

    .pharm-badge-dot {
        width: 8px;
        height: 8px;
        background: var(--pharm-success);
        border-radius: 50%;
        display: inline-block;
    }
</style>

<nav class="pharm-navbar">
    <a href="<%= request.getContextPath() %>/PharmacyDashboardServlet" class="pharm-brand">
        <div class="pharm-logo-icon">Rx</div>
        <div>
            <div>PharmaCare Pro</div>
            <div style="font-size: 0.725rem; font-weight: 500; color: var(--pharm-muted);">Pharmacy Management Suite</div>
        </div>
    </a>

    <ul class="pharm-nav-links">
        <li class="pharm-nav-item">
            <a href="<%= request.getContextPath() %>/PharmacyDashboardServlet" class="<%= "dashboard".equals(activeNav) ? "active" : "" %>">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
                Dashboard
            </a>
        </li>
        <li class="pharm-nav-item">
            <a href="<%= request.getContextPath() %>/MedicineServlet" class="<%= "medicines".equals(activeNav) ? "active" : "" %>">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"></path><path d="m8.5 8.5 7 7"></path></svg>
                Medicine Inventory
            </a>
        </li>
        <li class="pharm-nav-item">
            <a href="<%= request.getContextPath() %>/OrderServlet" class="<%= "orders".equals(activeNav) ? "active" : "" %>">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"></path><path d="M3 6h18"></path><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
                Orders Fulfillment
            </a>
        </li>
        <li class="pharm-nav-item">
            <a href="<%= request.getContextPath() %>/PharmacyServlet" class="<%= "profile".equals(activeNav) ? "active" : "" %>">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                Pharmacy Profile
            </a>
        </li>
    </ul>

    <div class="pharm-nav-actions">
        <%
            String activePharmName = (String) session.getAttribute("pharmacyName");
            if (activePharmName == null || activePharmName.trim().isEmpty()) {
                activePharmName = "Central Care Pharmacy";
            }
        %>
        <span style="font-size: 0.8rem; color: #047857; background: #ecfdf5; padding: 4px 10px; border-radius: 20px; border: 1px solid #a7f3d0; display: flex; align-items: center; gap: 0.4rem; font-weight: 600;">
            <span class="pharm-badge-dot"></span> <%= activePharmName %>
        </span>
        <a href="<%= request.getContextPath() %>/PharmacyLogoutServlet" class="pharm-portal-switcher" style="color: #b91c1c; border-color: #fecaca; background: #fef2f2;" title="Sign out of Pharmacy Portal">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
            Sign Out
        </a>
        <a href="<%= request.getContextPath() %>/MainLogin.jsp" class="pharm-portal-switcher">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
            Switch Portal
        </a>
    </div>
</nav>