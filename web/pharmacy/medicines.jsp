<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pharmacy.model.Medicine" %>

<%
    List<Medicine> medicines = (List<Medicine>) request.getAttribute("medicines");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Catalog & Inventory - PharmaCare Pro</title>
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
            max-width: 1280px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            margin: 0;
            letter-spacing: -0.025em;
        }

        .page-subtitle {
            margin: 0.25rem 0 0 0;
            color: #64748b;
            font-size: 0.925rem;
        }

        .header-actions {
            display: flex;
            gap: 0.75rem;
        }

        .btn-primary {
            background: #059669;
            color: white;
            padding: 0.65rem 1.25rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
            cursor: pointer;
            transition: background 0.15s;
        }

        .btn-primary:hover {
            background: #047857;
        }

        /* SEARCH & FILTER BAR */
        .controls-card {
            background: white;
            padding: 1.25rem 1.5rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .search-container {
            position: relative;
            flex: 1;
            min-width: 280px;
            max-width: 480px;
        }

        .search-input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .search-icon {
            position: absolute;
            left: 12px;
            color: #94a3b8;
            pointer-events: none;
        }

        .search-box {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.6rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 0.95rem;
            font-family: inherit;
            outline: none;
            transition: all 0.2s;
        }

        .search-box:focus {
            border-color: #059669;
            box-shadow: 0 0 0 3px rgba(5, 150, 105, 0.15);
        }

        /* AUTOCOMPLETE DROPDOWN */
        #suggestions {
            position: absolute;
            top: calc(100% + 6px);
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            z-index: 1050;
            max-height: 320px;
            overflow-y: auto;
            display: none;
        }

        .suggestion {
            padding: 0.75rem 1rem;
            cursor: pointer;
            border-bottom: 1px solid #f1f5f9;
            transition: background 0.15s;
        }

        .suggestion:last-child {
            border-bottom: none;
        }

        .suggestion:hover {
            background-color: #ecfdf5;
        }

        .sugg-name {
            font-weight: 600;
            color: #0f172a;
            font-size: 0.9rem;
        }

        .sugg-meta {
            font-size: 0.775rem;
            color: #64748b;
            margin-top: 2px;
        }

        .empty-suggestion {
            color: #94a3b8;
            font-size: 0.85rem;
            text-align: center;
            cursor: default;
        }

        /* TABLE */
        .table-card {
            background: white;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-bottom: 2.5rem;
        }

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
            padding: 0.95rem 1.25rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table td {
            padding: 0.95rem 1.25rem;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
            vertical-align: middle;
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

        .status-pill.available { background: #d1fae5; color: #047857; }
        .status-pill.out-of-stock { background: #fee2e2; color: #b91c1c; }
        .status-pill.expired { background: #fee2e2; color: #991b1b; }
        .status-pill.unavailable { background: #f1f5f9; color: #475569; }

        .btn-action {
            display: inline-flex;
            align-items: center;
            padding: 0.4rem 0.7rem;
            font-size: 0.8rem;
            font-weight: 600;
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.15s;
            border: 1px solid transparent;
        }

        .btn-edit {
            background: #f0fdf4;
            color: #166534;
            border-color: #bbf7d0;
        }
        .btn-edit:hover { background: #dcfce7; }

        .btn-view {
            background: #eff6ff;
            color: #1e40af;
            border-color: #bfdbfe;
        }
        .btn-view:hover { background: #dbeafe; }

        .btn-stock {
            background: #fffbeb;
            color: #92400e;
            border-color: #fde68a;
        }
        .btn-stock:hover { background: #fef3c7; }

        .btn-delete {
            background: #fff1f2;
            color: #be123c;
            border-color: #fecdd3;
        }
        .btn-delete:hover { background: #ffe4e6; }

        /* ADD MEDICINE FORM CARD */
        .form-card {
            background: white;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            padding: 2rem;
            margin-bottom: 3rem;
        }

        .form-title {
            font-size: 1.3rem;
            font-weight: 800;
            margin: 0 0 1.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 1.25rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-size: 0.825rem;
            font-weight: 600;
            color: #475569;
            margin-bottom: 0.4rem;
        }

        .form-input, .form-select, .form-textarea {
            padding: 0.65rem 0.85rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 0.925rem;
            font-family: inherit;
            outline: none;
            transition: all 0.15s;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            border-color: #059669;
            box-shadow: 0 0 0 3px rgba(5, 150, 105, 0.15);
        }
    </style>
</head>
<body>

<jsp:include page="/pharmacy/navbar.jsp" />

<div class="container">

    <div class="page-header">
        <div>
            <h1 class="page-title">Medicine Catalog & Inventory</h1>
            <p class="page-subtitle">Search, track stock, configure pricing, and manage prescription medications</p>
        </div>
        <div class="header-actions">
            <a href="#addMedicineSection" class="btn-primary">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 5v14M5 12h14"></path></svg>
                Add New Medicine
            </a>
        </div>
    </div>

    <!-- SEARCH BAR -->
    <div class="controls-card">
        <div class="search-container">
            <div class="search-input-wrapper">
                <svg class="search-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                <input type="text" id="medicineSearch" class="search-box" placeholder="Search medicine, generic salt or category..." autocomplete="off">
            </div>
            <div id="suggestions"></div>
        </div>

        <div style="font-size: 0.875rem; color: #64748b;">
            Total items listed: <strong style="color: #0f172a;"><%= medicines != null ? medicines.size() : 0 %></strong>
        </div>
    </div>

    <!-- MEDICINES TABLE -->
    <div class="table-card">
        <table class="data-table" id="medicineCatalogTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Medicine & Generic</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Expiry Date</th>
                    <th>Manufacturer</th>
                    <th>Status</th>
                    <th style="text-align: right;">Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (medicines != null && !medicines.isEmpty()) {
                    for (Medicine m : medicines) {
                        String avail = m.getAvailabilityStatus();
                        String availClass = avail.toLowerCase().replace('_', '-');
                %>
                <tr>
                    <td><span style="font-weight: 700; color: #64748b;">#<%= m.getMedicineId() %></span></td>
                    <td>
                        <strong><%= m.getMedicineName() %></strong><br>
                        <span style="font-size: 0.775rem; color: #64748b;"><%= m.getGenericName() %></span>
                    </td>
                    <td><%= m.getCategory() %></td>
                    <td><strong style="color: #047857;">&#8377;<%= String.format("%.2f", m.getPrice()) %></strong></td>
                    <td>
                        <strong style="color: <%= m.getStock() <= 0 ? "#b91c1c" : (m.getStock() < 10 ? "#d97706" : "#0f172a") %>;">
                            <%= m.getStock() %>
                        </strong>
                    </td>
                    <td><%= m.getExpiryDate() != null ? m.getExpiryDate() : "N/A" %></td>
                    <td><%= m.getManufacturer() %></td>
                    <td>
                        <span class="status-pill <%= availClass %>"><%= avail %></span>
                    </td>
                    <td style="text-align: right; white-space: nowrap;">
                        <a href="<%= request.getContextPath() %>/MedicineServlet?action=view&id=<%= m.getMedicineId() %>" class="btn-action btn-view" title="View Details">
                            View
                        </a>
                        <a href="<%= request.getContextPath() %>/MedicineServlet?action=edit&id=<%= m.getMedicineId() %>" class="btn-action btn-edit" title="Edit Medicine">
                            Edit
                        </a>
                        <a href="<%= request.getContextPath() %>/updateStock.jsp?id=<%= m.getMedicineId() %>" class="btn-action btn-stock" title="Quick Stock">
                            Stock
                        </a>
                        <a href="<%= request.getContextPath() %>/MedicineServlet?action=delete&id=<%= m.getMedicineId() %>" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to permanently delete \'<%= m.getMedicineName() %>\'?');" title="Delete">
                            Delete
                        </a>
                    </td>
                </tr>
                <% }
                } else { %>
                <tr>
                    <td colspan="9" style="text-align: center; padding: 3rem; color: #64748b;">
                        <p style="font-size: 1rem; font-weight: 600; margin: 0 0 0.5rem 0;">No medicines found in the pharmacy catalog.</p>
                        <span>Add your first medicine below to make it available for patient orders and prescriptions.</span>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- ADD MEDICINE SECTION -->
    <div class="form-card" id="addMedicineSection">
        <h2 class="form-title">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="16"></line><line x1="8" y1="12" x2="16" y2="12"></line></svg>
            Add New Medicine to Catalog
        </h2>

        <form action="<%= request.getContextPath() %>/MedicineServlet" method="post">
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Brand Name *</label>
                    <input type="text" name="medicineName" class="form-input" placeholder="e.g. Paracetamol 650mg" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Generic Salt / Formula *</label>
                    <input type="text" name="genericName" class="form-input" placeholder="e.g. Acetaminophen" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Category *</label>
                    <input type="text" name="category" class="form-input" placeholder="e.g. Analgesics, Antibiotics, Cardiac" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Price per Unit (&#8377;) *</label>
                    <input type="number" step="0.01" min="0" name="price" class="form-input" placeholder="0.00" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Initial Stock Quantity *</label>
                    <input type="number" min="0" name="stock" class="form-input" placeholder="100" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Batch Expiration Date *</label>
                    <input type="date" name="expiryDate" class="form-input" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Pharmaceutical Manufacturer *</label>
                    <input type="text" name="manufacturer" class="form-input" placeholder="e.g. Sun Pharma, Cipla, Pfizer" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Status *</label>
                    <select name="status" class="form-select">
                        <option value="AVAILABLE" selected>AVAILABLE (In-stock for dispatch)</option>
                        <option value="UNAVAILABLE">UNAVAILABLE (Paused / Discontinued)</option>
                    </select>
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 1.5rem;">
                <label class="form-label">Dosage & Usage Notes (Optional)</label>
                <textarea name="description" class="form-textarea" rows="2" placeholder="Storage instructions, dosage guidelines, precautions..."></textarea>
            </div>

            <button type="submit" class="btn-primary" style="padding: 0.75rem 1.75rem; font-size: 0.95rem;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                Save & List Medicine
            </button>
        </form>
    </div>

</div>

<!-- AUTOCOMPLETE SCRIPT -->
<script>
    const searchBox = document.getElementById("medicineSearch");
    const suggestionsBox = document.getElementById("suggestions");
    let debounceTimer;

    searchBox.addEventListener("input", function () {
        clearTimeout(debounceTimer);
        const keyword = searchBox.value.trim();

        if (keyword.length === 0) {
            suggestionsBox.style.display = "none";
            suggestionsBox.innerHTML = "";
            filterTableRows("");
            return;
        }

        filterTableRows(keyword);

        debounceTimer = setTimeout(() => {
            fetch("<%= request.getContextPath() %>/MedicineServlet?action=suggest&keyword=" + encodeURIComponent(keyword))
                .then(response => response.text())
                .then(html => {
                    suggestionsBox.innerHTML = html;
                    suggestionsBox.style.display = "block";
                })
                .catch(err => {
                    console.error("Autocomplete search error:", err);
                });
        }, 200);
    });

    document.addEventListener("click", function(e) {
        if (!searchBox.contains(e.target) && !suggestionsBox.contains(e.target)) {
            suggestionsBox.style.display = "none";
        }
    });

    function selectMedicine(medicineId) {
        window.location.href = "<%= request.getContextPath() %>/MedicineServlet?action=view&id=" + medicineId;
    }

    function filterTableRows(keyword) {
        const rows = document.querySelectorAll("#medicineCatalogTable tbody tr");
        const lowerKey = keyword.toLowerCase();
        rows.forEach(row => {
            const text = row.innerText.toLowerCase();
            if (lowerKey === "" || text.includes(lowerKey)) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }
</script>

</body>
</html>
