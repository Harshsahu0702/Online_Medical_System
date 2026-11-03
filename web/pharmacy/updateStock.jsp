<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="pharmacy.dao.MedicineDAO" %>
<%@ page import="pharmacy.model.Medicine" %>

<%
    String idParam = request.getParameter("id");
    int medicineId = 0;
    Medicine medicine = null;
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            medicineId = Integer.parseInt(idParam.trim());
            MedicineDAO dao = new MedicineDAO();
            medicine = dao.getMedicineById(medicineId);
        } catch (Exception ignore) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Medicine Stock - PharmaCare Pro</title>
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
            max-width: 520px;
            margin: 4rem auto;
            padding: 0 1.5rem;
        }

        .card {
            background: white;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            padding: 2.25rem;
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 800;
            margin: 0 0 0.5rem 0;
        }

        .card-subtitle {
            font-size: 0.9rem;
            color: #64748b;
            margin: 0 0 1.75rem 0;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #475569;
            margin-bottom: 0.5rem;
        }

        .form-input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            font-family: inherit;
            box-sizing: border-box;
            outline: none;
            transition: all 0.15s;
        }

        .form-input:focus {
            border-color: #059669;
            box-shadow: 0 0 0 3px rgba(5, 150, 105, 0.15);
        }

        .actions {
            display: flex;
            gap: 0.75rem;
            margin-top: 1.75rem;
        }

        .btn-submit {
            background: #059669;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            border: none;
            cursor: pointer;
            flex: 1;
            transition: background 0.15s;
        }

        .btn-submit:hover {
            background: #047857;
        }

        .btn-cancel {
            background: #f1f5f9;
            color: #475569;
            padding: 0.75rem 1.25rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
            border: 1px solid #cbd5e1;
            text-align: center;
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
        <h1 class="card-title">Adjust Medicine Stock</h1>
        <p class="card-subtitle">
            <%= medicine != null ? "Updating stock for: <strong>" + medicine.getMedicineName() + "</strong>" : "Set current stock count on shelves" %>
        </p>

        <form action="<%= request.getContextPath() %>/MedicineServlet" method="post">
            <input type="hidden" name="action" value="updateStock">
            <input type="hidden" name="medicineId" value="<%= medicineId %>">

            <div class="form-group">
                <label class="form-label">Available Physical Stock (Units) *</label>
                <input type="number" name="stock" class="form-input" min="0" value="<%= medicine != null ? medicine.getStock() : "" %>" required autofocus>
            </div>

            <div class="actions">
                <button type="submit" class="btn-submit">
                    Update Stock Count
                </button>
                <a href="<%= request.getContextPath() %>/MedicineServlet" class="btn-cancel">
                    Cancel
                </a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
