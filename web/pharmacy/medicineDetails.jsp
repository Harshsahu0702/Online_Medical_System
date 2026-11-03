<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="pharmacy.model.Medicine" %>

<%
    Medicine medicine = (Medicine) request.getAttribute("selectedMedicine");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Specifications - PharmaCare Pro</title>
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
            max-width: 800px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .card {
            background: white;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .card-hero {
            background: linear-gradient(135deg, #065f46 0%, #047857 100%);
            padding: 2.5rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .med-title {
            font-size: 1.85rem;
            font-weight: 800;
            margin: 0 0 0.4rem 0;
            letter-spacing: -0.025em;
        }

        .med-generic {
            font-size: 1.05rem;
            color: #a7f3d0;
            margin: 0;
            font-weight: 500;
        }

        .price-tag {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(8px);
            padding: 0.6rem 1.25rem;
            border-radius: 12px;
            text-align: right;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .price-label {
            font-size: 0.725rem;
            text-transform: uppercase;
            font-weight: 700;
            color: #d1fae5;
            letter-spacing: 0.05em;
        }

        .price-value {
            font-size: 1.6rem;
            font-weight: 800;
            color: white;
        }

        .card-body {
            padding: 2.25rem;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.75rem;
            margin-bottom: 2rem;
        }

        @media (max-width: 600px) {
            .details-grid {
                grid-template-columns: 1fr;
            }
        }

        .detail-item {
            display: flex;
            flex-direction: column;
        }

        .detail-label {
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #64748b;
            letter-spacing: 0.05em;
            margin-bottom: 0.35rem;
        }

        .detail-value {
            font-size: 1.05rem;
            font-weight: 600;
            color: #1e293b;
        }

        .status-pill {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .status-pill.available { background: #d1fae5; color: #047857; }
        .status-pill.out-of-stock { background: #fee2e2; color: #b91c1c; }
        .status-pill.expired { background: #fee2e2; color: #991b1b; }

        .card-actions {
            display: flex;
            gap: 1rem;
            padding-top: 1.5rem;
            border-top: 1px solid #f1f5f9;
        }

        .btn {
            padding: 0.75rem 1.4rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.925rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.15s;
        }

        .btn-primary {
            background: #059669;
            color: white;
        }
        .btn-primary:hover { background: #047857; }

        .btn-secondary {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
        }
        .btn-secondary:hover { background: #e2e8f0; color: #0f172a; }
    </style>
</head>
<body>

<jsp:include page="/pharmacy/navbar.jsp" />

<div class="container">
    <div class="card">
        <% if (medicine != null) {
            String avail = medicine.getAvailabilityStatus();
            String availClass = avail.toLowerCase().replace('_', '-');
        %>
        <div class="card-hero">
            <div>
                <h1 class="med-title"><%= medicine.getMedicineName() %></h1>
                <p class="med-generic"><%= medicine.getGenericName() %></p>
            </div>
            <div class="price-tag">
                <div class="price-label">Retail Price</div>
                <div class="price-value">&#8377;<%= String.format("%.2f", medicine.getPrice()) %></div>
            </div>
        </div>

        <div class="card-body">
            <div class="details-grid">
                <div class="detail-item">
                    <span class="detail-label">Therapeutic Category</span>
                    <span class="detail-value"><%= medicine.getCategory() %></span>
                </div>

                <div class="detail-item">
                    <span class="detail-label">Stock on Hand</span>
                    <span class="detail-value" style="color: <%= medicine.getStock() <= 0 ? "#b91c1c" : (medicine.getStock() < 10 ? "#d97706" : "#047857") %>;">
                        <%= medicine.getStock() %> Units Available
                    </span>
                </div>

                <div class="detail-item">
                    <span class="detail-label">Current Availability</span>
                    <div><span class="status-pill <%= availClass %>"><%= avail %></span></div>
                </div>

                <div class="detail-item">
                    <span class="detail-label">Batch Expiration Date</span>
                    <span class="detail-value"><%= medicine.getExpiryDate() != null ? medicine.getExpiryDate() : "N/A" %></span>
                </div>

                <div class="detail-item">
                    <span class="detail-label">Manufacturer</span>
                    <span class="detail-value"><%= medicine.getManufacturer() %></span>
                </div>

                <div class="detail-item">
                    <span class="detail-label">Internal Item ID</span>
                    <span class="detail-value" style="font-family: monospace;">#<%= medicine.getMedicineId() %></span>
                </div>

                <% if (medicine.getDescription() != null && !medicine.getDescription().isEmpty()) { %>
                <div class="detail-item" style="grid-column: 1 / -1;">
                    <span class="detail-label">Usage Notes & Clinical Info</span>
                    <span class="detail-value" style="font-size: 0.95rem; font-weight: 500; color: #475569;"><%= medicine.getDescription() %></span>
                </div>
                <% } %>
            </div>

            <div class="card-actions">
                <a href="<%= request.getContextPath() %>/MedicineServlet?action=edit&id=<%= medicine.getMedicineId() %>" class="btn btn-primary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                    Edit Medicine
                </a>
                <a href="<%= request.getContextPath() %>/updateStock.jsp?id=<%= medicine.getMedicineId() %>" class="btn btn-secondary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                    Update Stock
                </a>
                <a href="<%= request.getContextPath() %>/MedicineServlet" class="btn btn-secondary">
                    &larr; Back to Catalog
                </a>
            </div>
        </div>
        <% } else { %>
        <div style="text-align: center; padding: 4rem;">
            <p style="font-size: 1.1rem; color: #e11d48; font-weight: 700;">Medicine Not Found</p>
            <p style="color: #64748b;">The requested medicine could not be loaded.</p>
            <a href="<%= request.getContextPath() %>/MedicineServlet" class="btn btn-primary" style="display: inline-flex; margin-top: 1rem;">
                Return to Medicines
            </a>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
