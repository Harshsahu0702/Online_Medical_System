<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="pharmacy.model.Pharmacy" %>

<%
    Pharmacy pharmacy = (Pharmacy) request.getAttribute("pharmacy");
    if (pharmacy == null) {
        pharmacy = new Pharmacy();
        pharmacy.setPharmacyId(1);
    }
    String profileMessage = (String) session.getAttribute("profileMessage");
    String profileMessageType = (String) session.getAttribute("profileMessageType");
    if (profileMessage != null) {
        session.removeAttribute("profileMessage");
        session.removeAttribute("profileMessageType");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy Profile & Credentials - PharmaCare Pro</title>
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
            max-width: 760px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .card {
            background: white;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            padding: 2.25rem;
        }

        .card-header {
            margin-bottom: 2rem;
            border-bottom: 1px solid #f1f5f9;
            padding-bottom: 1.25rem;
        }

        .card-title {
            font-size: 1.6rem;
            font-weight: 800;
            margin: 0 0 0.4rem 0;
            letter-spacing: -0.02em;
        }

        .card-subtitle {
            margin: 0;
            color: #64748b;
            font-size: 0.925rem;
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            font-size: 0.925rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-danger {
            background: #fff1f2;
            color: #9f1239;
            border: 1px solid #fecdd3;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 640px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #475569;
            margin-bottom: 0.4rem;
        }

        .form-input, .form-textarea {
            padding: 0.75rem 0.85rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 0.95rem;
            font-family: inherit;
            outline: none;
            transition: all 0.15s;
        }

        .form-input:focus, .form-textarea:focus {
            border-color: #059669;
            box-shadow: 0 0 0 3px rgba(5, 150, 105, 0.15);
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.25rem;
            border-top: 1px solid #f1f5f9;
        }

        .btn-submit {
            background: #059669;
            color: white;
            padding: 0.75rem 1.75rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            border: none;
            cursor: pointer;
            transition: background 0.15s;
        }

        .btn-submit:hover {
            background: #047857;
        }

        .btn-cancel {
            background: #f1f5f9;
            color: #475569;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
            border: 1px solid #cbd5e1;
            transition: all 0.15s;
        }

        .btn-cancel:hover {
            background: #e2e8f0;
            color: #0f172a;
        }
    </style>
</head>
<body>

<jsp:include page="/pharmacy/navbar.jsp" />

<div class="container">

    <div class="card">
        <div class="card-header">
            <h1 class="card-title">Pharmacy Profile & Regulatory Information</h1>
            <p class="card-subtitle">Manage official pharmacy branding, contact coordinates, and registered pharmaceutical license numbers</p>
        </div>

        <% if (profileMessage != null) { %>
        <div class="alert <%= "danger".equals(profileMessageType) ? "alert-danger" : "alert-success" %>">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 14 14"></polyline></svg>
            <%= profileMessage %>
        </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/PharmacyServlet" method="post">
            <input type="hidden" name="pharmacyId" value="<%= pharmacy.getPharmacyId() %>">

            <div class="form-grid">
                <div class="form-group full">
                    <label class="form-label">Pharmacy Legal / Commercial Name *</label>
                    <input type="text" name="pharmacyName" class="form-input" value="<%= pharmacy.getPharmacyName() != null ? pharmacy.getPharmacyName() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Contact Email Address *</label>
                    <input type="email" name="email" class="form-input" value="<%= pharmacy.getEmail() != null ? pharmacy.getEmail() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Customer Hotline / Phone *</label>
                    <input type="text" name="phone" class="form-input" value="<%= pharmacy.getPhone() != null ? pharmacy.getPhone() : "" %>" required>
                </div>

                <div class="form-group full">
                    <label class="form-label">Physical Dispensary Address *</label>
                    <textarea name="address" class="form-textarea" rows="3" required><%= pharmacy.getAddress() != null ? pharmacy.getAddress() : "" %></textarea>
                </div>

                <div class="form-group full">
                    <label class="form-label">Government Drug License Number *</label>
                    <input type="text" name="licenseNumber" class="form-input" style="font-family: monospace;" value="<%= pharmacy.getLicenseNumber() != null ? pharmacy.getLicenseNumber() : "" %>" required>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-submit">
                    Save Profile Changes
                </button>
                <a href="<%= request.getContextPath() %>/PharmacyDashboardServlet" class="btn-cancel">
                    Return to Dashboard
                </a>
            </div>
        </form>
    </div>

</div>

</body>
</html>
