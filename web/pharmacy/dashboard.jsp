<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pharmacy.model.Pharmacy" %>
<%@ page import="pharmacy.model.Medicine" %>
<%@ page import="pharmacy.model.Order" %>

<%
    Pharmacy pharmacy = (Pharmacy) request.getAttribute("pharmacy");
    if (pharmacy == null) {
        pharmacy = new pharmacy.model.Pharmacy(1, "Central Health & Care Pharmacy", "contact@centralhealth.com", "+91 98765 43210", "Sector 5, Medical Enclave", "PHARM-DL-2026-9812");
    }

    Integer totalMedicines = (Integer) request.getAttribute("totalMedicines");
    if (totalMedicines == null) totalMedicines = 0;

    Integer lowStockCount = (Integer) request.getAttribute("lowStockCount");
    if (lowStockCount == null) lowStockCount = 0;

    Integer pendingOrders = (Integer) request.getAttribute("pendingOrders");
    if (pendingOrders == null) pendingOrders = 0;

    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    if (totalRevenue == null) totalRevenue = 0.0;

    List<Order> recentOrders = (List<Order>) request.getAttribute("recentOrders");
    List<Medicine> medicines = (List<Medicine>) request.getAttribute("medicines");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy Executive Dashboard - PharmaCare Pro</title>
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

        .dashboard-container {
            max-width: 1280px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .welcome-hero {
            background: linear-gradient(135deg, #064e3b 0%, #065f46 50%, #047857 100%);
            border-radius: 16px;
            padding: 2.25rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            box-shadow: 0 10px 15px -3px rgba(6, 78, 59, 0.2);
            position: relative;
            overflow: hidden;
        }

        .welcome-hero::after {
            content: "";
            position: absolute;
            right: -60px;
            bottom: -60px;
            width: 240px;
            height: 240px;
            background: radial-gradient(circle, rgba(16, 185, 129, 0.3) 0%, rgba(255, 255, 255, 0) 70%);
            border-radius: 50%;
        }

        .hero-title {
            font-size: 1.85rem;
            font-weight: 800;
            margin: 0 0 0.5rem 0;
            letter-spacing: -0.025em;
        }

        .hero-subtitle {
            margin: 0;
            color: #a7f3d0;
            font-size: 0.95rem;
            font-weight: 500;
        }

        .hero-badges {
            display: flex;
            gap: 0.75rem;
            margin-top: 1rem;
        }

        .hero-badge {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(8px);
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            color: #ecfdf5;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .hero-actions {
            display: flex;
            gap: 0.75rem;
            position: relative;
            z-index: 2;
        }

        .btn-hero-primary {
            background: #ffffff;
            color: #065f46;
            padding: 0.75rem 1.4rem;
            border-radius: 10px;
            font-weight: 700;
            text-decoration: none;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-hero-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.15);
            background: #f0fdf4;
        }

        .btn-hero-secondary {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            padding: 0.75rem 1.25rem;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            backdrop-filter: blur(8px);
            transition: all 0.2s;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .btn-hero-secondary:hover {
            background: rgba(255, 255, 255, 0.25);
        }

        /* STATS GRID */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.25rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            position: relative;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08);
        }

        .stat-icon {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .stat-icon.emerald { background: #d1fae5; color: #059669; }
        .stat-icon.amber { background: #fef3c7; color: #d97706; }
        .stat-icon.blue { background: #e0f2fe; color: #0284c7; }
        .stat-icon.rose { background: #ffe4e6; color: #e11d48; }

        .stat-label {
            font-size: 0.85rem;
            color: #64748b;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .stat-value {
            font-size: 1.85rem;
            font-weight: 800;
            color: #0f172a;
            margin-top: 0.35rem;
        }

        .stat-footer {
            margin-top: 0.75rem;
            font-size: 0.8rem;
            color: #64748b;
        }

        /* 2-COLUMN SECTION */
        .dashboard-columns {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
        }

        @media (max-width: 992px) {
            .dashboard-columns {
                grid-template-columns: 1fr;
            }
        }

        .content-card {
            background: #ffffff;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .card-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-title {
            font-size: 1.1rem;
            font-weight: 700;
            margin: 0;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-link {
            font-size: 0.85rem;
            color: #059669;
            font-weight: 600;
            text-decoration: none;
        }

        .card-link:hover {
            text-decoration: underline;
        }

        /* TABLE */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.9rem;
        }

        .data-table th {
            background: #f8fafc;
            color: #475569;
            font-weight: 600;
            padding: 0.85rem 1.25rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table td {
            padding: 0.9rem 1.25rem;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tr:hover td {
            background: #f8fafc;
        }

        .status-pill {
            display: inline-block;
            padding: 0.25rem 0.65rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.025em;
        }

        .status-pill.pending { background: #fef3c7; color: #b45309; }
        .status-pill.accepted { background: #e0f2fe; color: #0369a1; }
        .status-pill.processing { background: #f3e8ff; color: #7e22ce; }
        .status-pill.shipped { background: #fed7aa; color: #c2410c; }
        .status-pill.delivered { background: #d1fae5; color: #047857; }
        .status-pill.out-of-stock { background: #fee2e2; color: #b91c1c; }
        .status-pill.low-stock { background: #fef3c7; color: #b45309; }
        .status-pill.available { background: #d1fae5; color: #047857; }

        .btn-sm {
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.15s;
        }

        .btn-sm-primary {
            background: #059669;
            color: white;
            border: 1px solid #059669;
        }

        .btn-sm-primary:hover {
            background: #047857;
        }

        .btn-sm-outline {
            background: white;
            color: #475569;
            border: 1px solid #cbd5e1;
        }

        .btn-sm-outline:hover {
            background: #f8fafc;
            color: #0f172a;
        }

        .quick-nav-list {
            padding: 1rem 1.5rem;
            list-style: none;
            margin: 0;
        }

        .quick-nav-item {
            margin-bottom: 0.75rem;
        }

        .quick-nav-item a {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.85rem 1rem;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            text-decoration: none;
            color: #1e293b;
            font-weight: 600;
            transition: all 0.2s;
        }

        .quick-nav-item a:hover {
            background: #ecfdf5;
            border-color: #a7f3d0;
            color: #065f46;
            transform: translateX(3px);
        }
    </style>
</head>
<body>

<jsp:include page="/pharmacy/navbar.jsp" />

<div class="dashboard-container">

    <!-- WELCOME HERO -->
    <div class="welcome-hero">
        <div>
            <h1 class="hero-title"><%= pharmacy.getPharmacyName() %></h1>
            <p class="hero-subtitle">Pharmacy Operations & Prescription Fulfillment Command Center</p>
            <div class="hero-badges">
                <span class="hero-badge">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                    License: <%= pharmacy.getLicenseNumber() != null ? pharmacy.getLicenseNumber() : "Verified Pharmacy" %>
                </span>
                <span class="hero-badge">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                    <%= pharmacy.getPhone() != null ? pharmacy.getPhone() : "Support Active" %>
                </span>
            </div>
        </div>
        <div class="hero-actions">
            <a href="<%= request.getContextPath() %>/MedicineServlet" class="btn-hero-primary">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 5v14M5 12h14"></path></svg>
                Manage Inventory
            </a>
            <a href="<%= request.getContextPath() %>/OrderServlet" class="btn-hero-secondary">
                View Orders
            </a>
        </div>
    </div>

    <!-- STATS KPI GRID -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon emerald">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"></path><path d="m8.5 8.5 7 7"></path></svg>
            </div>
            <div class="stat-label">Total Medicines</div>
            <div class="stat-value"><%= totalMedicines %></div>
            <div class="stat-footer">Items listed in active catalog</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon amber">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path><line x1="12" y1="9" x2="12" y2="13"></line><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
            </div>
            <div class="stat-label">Low Stock Alerts</div>
            <div class="stat-value"><%= lowStockCount %></div>
            <div class="stat-footer">Batches with &lt; 10 units remaining</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon rose">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
            </div>
            <div class="stat-label">Pending Orders</div>
            <div class="stat-value"><%= pendingOrders %></div>
            <div class="stat-footer">Awaiting pharmacist review & acceptance</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon blue">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
            </div>
            <div class="stat-label">Fulfilled Revenue</div>
            <div class="stat-value">&#8377;<%= String.format("%.2f", totalRevenue) %></div>
            <div class="stat-footer">Total delivered orders revenue</div>
        </div>
    </div>

    <!-- 2-COLUMN MAIN CONTENT -->
    <div class="dashboard-columns">

        <!-- COLUMN 1: RECENT ORDERS -->
        <div>
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"></path><path d="M3 6h18"></path><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
                        Recent Patient Orders
                    </h2>
                    <a href="<%= request.getContextPath() %>/OrderServlet" class="card-link">View All Orders &rarr;</a>
                </div>

                <% if (recentOrders != null && !recentOrders.isEmpty()) { %>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Patient</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Order Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order o : recentOrders) {
                            String st = o.getStatus() != null ? o.getStatus().toLowerCase() : "pending";
                        %>
                        <tr>
                            <td><strong>#<%= o.getOrderId() %></strong></td>
                            <td><%= o.getPatientName() %></td>
                            <td><strong>&#8377;<%= String.format("%.2f", o.getTotalAmount()) %></strong></td>
                            <td>
                                <span class="status-pill <%= st %>"><%= o.getStatus() %></span>
                            </td>
                            <td><%= o.getOrderDate() != null ? o.getOrderDate() : "Today" %></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/OrderServlet?action=details&orderId=<%= o.getOrderId() %>" class="btn-sm btn-sm-outline">
                                    Details
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div style="padding: 2.5rem; text-align: center; color: #64748b;">
                    <p style="margin: 0 0 0.5rem 0; font-weight: 600;">No customer orders found yet.</p>
                    <span style="font-size: 0.85rem;">Orders placed by patients in the patient portal will appear here immediately.</span>
                </div>
                <% } %>
            </div>

            <!-- LOW STOCK MEDICINE WATCHLIST -->
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path><line x1="12" y1="9" x2="12" y2="13"></line><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
                        Inventory Stock Watchlist
                    </h2>
                    <a href="<%= request.getContextPath() %>/MedicineServlet" class="card-link">Full Catalog &rarr;</a>
                </div>

                <%
                    boolean hasLowStock = false;
                    if (medicines != null) {
                        for (Medicine m : medicines) {
                            if (m.getStock() < 15) {
                                hasLowStock = true;
                                break;
                            }
                        }
                    }
                %>

                <% if (medicines != null && hasLowStock) { %>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Medicine</th>
                            <th>Category</th>
                            <th>Stock Level</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Medicine m : medicines) {
                            if (m.getStock() < 15) {
                                String avail = m.getAvailabilityStatus();
                        %>
                        <tr>
                            <td>
                                <strong><%= m.getMedicineName() %></strong><br>
                                <span style="font-size: 0.775rem; color: #64748b;"><%= m.getGenericName() %></span>
                            </td>
                            <td><%= m.getCategory() %></td>
                            <td>
                                <strong style="color: <%= m.getStock() <= 0 ? "#e11d48" : "#d97706" %>;">
                                    <%= m.getStock() %> units
                                </strong>
                            </td>
                            <td>
                                <span class="status-pill <%= avail.toLowerCase().replace('_', '-') %>"><%= avail %></span>
                            </td>
                            <td>
                                <a href="<%= request.getContextPath() %>/updateStock.jsp?id=<%= m.getMedicineId() %>" class="btn-sm btn-sm-primary">
                                    Restock
                                </a>
                            </td>
                        </tr>
                        <%  }
                        } %>
                    </tbody>
                </table>
                <% } else { %>
                <div style="padding: 2.5rem; text-align: center; color: #64748b;">
                    <p style="margin: 0; font-weight: 600; color: #059669;">All medicine stocks are at healthy operating levels!</p>
                </div>
                <% } %>
            </div>
        </div>

        <!-- COLUMN 2: QUICK ACTIONS & PHARMACY PROFILE -->
        <div>
            <!-- QUICK SHORTCUTS -->
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Quick Actions</h2>
                </div>
                <ul class="quick-nav-list">
                    <li class="quick-nav-item">
                        <a href="<%= request.getContextPath() %>/MedicineServlet#addMedicineSection">
                            <span>Add New Medicine</span>
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </a>
                    </li>
                    <li class="quick-nav-item">
                        <a href="<%= request.getContextPath() %>/OrderServlet">
                            <span>Process Pending Orders</span>
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </a>
                    </li>
                    <li class="quick-nav-item">
                        <a href="<%= request.getContextPath() %>/PharmacyServlet">
                            <span>Edit Pharmacy Information</span>
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </a>
                    </li>
                    <li class="quick-nav-item">
                        <a href="<%= request.getContextPath() %>/patient/medicines" target="_blank">
                            <span>View Patient Medicine Store</span>
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- PHARMACY DETAILS SUMMARY -->
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title">Pharmacy Info</h2>
                    <a href="<%= request.getContextPath() %>/PharmacyServlet" class="card-link">Edit</a>
                </div>
                <div style="padding: 1.5rem; font-size: 0.9rem;">
                    <div style="margin-bottom: 0.85rem;">
                        <span style="color: #64748b; display: block; font-size: 0.775rem; text-transform: uppercase; font-weight: 700;">Pharmacy Name</span>
                        <strong><%= pharmacy.getPharmacyName() %></strong>
                    </div>
                    <div style="margin-bottom: 0.85rem;">
                        <span style="color: #64748b; display: block; font-size: 0.775rem; text-transform: uppercase; font-weight: 700;">Official Email</span>
                        <span><%= pharmacy.getEmail() != null ? pharmacy.getEmail() : "N/A" %></span>
                    </div>
                    <div style="margin-bottom: 0.85rem;">
                        <span style="color: #64748b; display: block; font-size: 0.775rem; text-transform: uppercase; font-weight: 700;">Phone Hotline</span>
                        <span><%= pharmacy.getPhone() != null ? pharmacy.getPhone() : "N/A" %></span>
                    </div>
                    <div style="margin-bottom: 0.85rem;">
                        <span style="color: #64748b; display: block; font-size: 0.775rem; text-transform: uppercase; font-weight: 700;">Location / Address</span>
                        <span><%= pharmacy.getAddress() != null ? pharmacy.getAddress() : "N/A" %></span>
                    </div>
                    <div>
                        <span style="color: #64748b; display: block; font-size: 0.775rem; text-transform: uppercase; font-weight: 700;">License Identifier</span>
                        <span style="font-family: monospace; font-weight: 600; color: #047857;"><%= pharmacy.getLicenseNumber() != null ? pharmacy.getLicenseNumber() : "N/A" %></span>
                    </div>
                </div>
            </div>

        </div>

    </div>

</div>

</body>
</html>
