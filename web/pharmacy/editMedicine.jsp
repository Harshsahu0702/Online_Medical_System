<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="pharmacy.model.Medicine" %>

<%
    Medicine medicine = (Medicine) request.getAttribute("medicine");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Medicine - PharmaCare Pro</title>
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
            max-width: 780px;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .card {
            background: white;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            padding: 2.25rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            border-bottom: 1px solid #f1f5f9;
            padding-bottom: 1.25rem;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 800;
            margin: 0;
            color: #0f172a;
            letter-spacing: -0.02em;
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

        .form-input, .form-select, .form-textarea {
            padding: 0.7rem 0.85rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 0.95rem;
            font-family: inherit;
            outline: none;
            transition: all 0.15s;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
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
        <% if (medicine != null) { %>
        <div class="card-header">
            <div>
                <h1 class="card-title">Edit Medicine Details</h1>
                <span style="font-size: 0.85rem; color: #64748b;">Batch ID #<%= medicine.getMedicineId() %> &bull; <%= medicine.getMedicineName() %></span>
            </div>
            <a href="<%= request.getContextPath() %>/MedicineServlet" class="btn-cancel" style="padding: 0.45rem 0.9rem; font-size: 0.825rem;">
                &larr; Back to Catalog
            </a>
        </div>

        <form action="<%= request.getContextPath() %>/MedicineServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="medicineId" value="<%= medicine.getMedicineId() %>">

            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Medicine Brand Name *</label>
                    <input type="text" name="medicineName" class="form-input" value="<%= medicine.getMedicineName() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Generic Salt / Formula *</label>
                    <input type="text" name="genericName" class="form-input" value="<%= medicine.getGenericName() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Category *</label>
                    <input type="text" name="category" class="form-input" value="<%= medicine.getCategory() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Unit Price (&#8377;) *</label>
                    <input type="number" step="0.01" min="0" name="price" class="form-input" value="<%= medicine.getPrice() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Stock Units on Hand *</label>
                    <input type="number" min="0" name="stock" class="form-input" value="<%= medicine.getStock() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Expiry Date *</label>
                    <input type="date" name="expiryDate" class="form-input" value="<%= medicine.getExpiryDate() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Manufacturer *</label>
                    <input type="text" name="manufacturer" class="form-input" value="<%= medicine.getManufacturer() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Inventory Status *</label>
                    <select name="status" class="form-select">
                        <option value="AVAILABLE" <%= "AVAILABLE".equalsIgnoreCase(medicine.getStatus()) ? "selected" : "" %>>AVAILABLE</option>
                        <option value="UNAVAILABLE" <%= "UNAVAILABLE".equalsIgnoreCase(medicine.getStatus()) ? "selected" : "" %>>UNAVAILABLE</option>
                    </select>
                </div>

                <div class="form-group full">
                    <label class="form-label">Clinical / Dosage Notes</label>
                    <textarea name="description" class="form-textarea" rows="3"><%= medicine.getDescription() != null ? medicine.getDescription() : "" %></textarea>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-submit">
                    Save Changes
                </button>
                <a href="<%= request.getContextPath() %>/MedicineServlet" class="btn-cancel">
                    Cancel
                </a>
            </div>
        </form>
        <% } else { %>
        <div style="text-align: center; padding: 3rem;">
            <p style="font-size: 1.1rem; color: #e11d48; font-weight: 700;">Medicine Record Not Found</p>
            <p style="color: #64748b;">The requested medicine ID does not exist or has been removed.</p>
            <a href="<%= request.getContextPath() %>/MedicineServlet" class="btn-submit" style="display: inline-block; text-decoration: none;">
                Return to Medicines
            </a>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
