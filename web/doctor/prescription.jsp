<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Medicine" %>
<%@ page import="model.doctor.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Prescription - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<Medicine> medicines = (List<Medicine>) request.getAttribute("medicines");
    List<Patient> allPatients = (List<Patient>) request.getAttribute("allPatients");
    Patient selectedPatient = (Patient) request.getAttribute("patient");
    String consultationId = (String) request.getAttribute("consultationId");

    String errorParam = request.getParameter("error");
%>

<main class="app-container">

    <div style="margin-bottom: 18px; display: flex; justify-content: space-between; align-items: center;">
        <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet" class="btn btn-secondary btn-sm">← Back to Prescription History</a>
    </div>

    <% if ("1".equals(errorParam)) { %>
        <div class="alert alert-danger">Error saving prescription. Please check the inputs and try again.</div>
    <% } %>

    <div class="card">
        <div class="card-title">
            <span>Create New Prescription</span>
            <span style="font-size: 13px; font-weight: normal; color: #64748b;">
                Add clinical diagnosis, advice, and pharmacy items
            </span>
        </div>

        <form action="<%= request.getContextPath() %>/DoctorPrescriptionServlet" method="POST" id="prescriptionForm">
            
            <input type="hidden" name="consultationId" value="<%= consultationId != null ? consultationId : "0" %>">

            <!-- PATIENT & DATE -->
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Select Patient</label>
                    <% if (selectedPatient != null) { %>
                        <input type="hidden" name="patientId" value="<%= selectedPatient.getPatientId() %>">
                        <input type="text" class="form-control" value="<%= selectedPatient.getName() %> (Phone: <%= selectedPatient.getPhone() != null ? selectedPatient.getPhone() : "N/A" %>)" readonly style="background:#f1f5f9; font-weight: 600;">
                    <% } else { %>
                        <select name="patientId" class="form-control" required>
                            <option value="">-- Choose Patient --</option>
                            <% if (allPatients != null) { 
                                for (Patient p : allPatients) { %>
                                    <option value="<%= p.getPatientId() %>"><%= p.getName() %> (<%= p.getPhone() != null ? p.getPhone() : p.getEmail() %>)</option>
                            <%  } 
                            } %>
                        </select>
                    <% } %>
                </div>

                <div class="form-group">
                    <label class="form-label">Prescription Date</label>
                    <input type="date" name="prescriptionDate" class="form-control" id="prescDate" required>
                </div>
            </div>

            <!-- DIAGNOSIS & ADVICE -->
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Diagnosis / Clinical Findings</label>
                    <textarea name="diagnosis" class="form-control" rows="3" placeholder="e.g. Acute Bronchitis, Hypertension Stage 1, Seasonal Allergic Rhinitis" required></textarea>
                </div>
                <div class="form-group">
                    <label class="form-label">Advice / Dietary Recommendations</label>
                    <textarea name="advice" class="form-control" rows="3" placeholder="e.g. Drink plenty of fluids, rest for 3 days, avoid cold drinks"></textarea>
                </div>
            </div>

            <!-- MEDICINES LIST -->
            <div style="margin-top: 25px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
                    <h4 style="margin: 0; color: #244b6b;">Prescribed Medicines & Dosages</h4>
                    <button type="button" class="btn btn-primary btn-sm" onclick="addMedicineRow()">+ Add Medicine</button>
                </div>

                <table class="data-table" id="medicineTable">
                    <thead>
                        <tr>
                            <th style="width: 28%;">Medicine Name</th>
                            <th style="width: 16%;">Dosage</th>
                            <th style="width: 18%;">Frequency</th>
                            <th style="width: 15%;">Duration</th>
                            <th style="width: 18%;">Instructions</th>
                            <th style="width: 5%;"></th>
                        </tr>
                    </thead>
                    <tbody id="medicineTableBody">
                        <!-- Dynamic rows will be inserted here -->
                    </tbody>
                </table>
            </div>

            <div style="margin-top: 30px; text-align: right; border-top: 1px solid #e2e8f0; padding-top: 20px;">
                <button type="submit" class="btn btn-success" style="padding: 12px 30px; font-size: 15px;">💾 Save & Issue Prescription</button>
            </div>
        </form>
    </div>

</main>

<script>
    // Set default date to today
    document.getElementById('prescDate').value = new Date().toISOString().split('T')[0];

    // Medicines list options from server
    var medicineOptions = `
        <option value="">-- Select Medicine --</option>
        <% if (medicines != null) { 
            for (Medicine m : medicines) { %>
                <option value="<%= m.getMedicineId() %>"><%= m.getMedicineName() %> <%= m.getGenericName() != null ? ("(" + m.getGenericName() + ")") : "" %> - ₹<%= m.getPrice() %></option>
        <%  } 
        } %>
    `;

    function addMedicineRow() {
        var tbody = document.getElementById('medicineTableBody');
        var tr = document.createElement('tr');
        tr.innerHTML = `
            <td>
                <select name="medicineId[]" class="form-control" required style="font-size: 13px;">
                    ` + medicineOptions + `
                </select>
            </td>
            <td>
                <input type="text" name="dosage[]" class="form-control" placeholder="e.g. 500mg" required style="font-size: 13px;">
            </td>
            <td>
                <input type="text" name="frequency[]" class="form-control" placeholder="e.g. 1-0-1 / Twice daily" required style="font-size: 13px;">
            </td>
            <td>
                <input type="text" name="duration[]" class="form-control" placeholder="e.g. 5 days" required style="font-size: 13px;">
            </td>
            <td>
                <input type="text" name="instructions[]" class="form-control" placeholder="e.g. After meals" style="font-size: 13px;">
            </td>
            <td style="text-align: center;">
                <button type="button" class="btn btn-danger btn-sm" onclick="removeMedicineRow(this)" title="Remove">✕</button>
            </td>
        `;
        tbody.appendChild(tr);
    }

    function removeMedicineRow(btn) {
        var row = btn.closest('tr');
        var tbody = document.getElementById('medicineTableBody');
        if (tbody.children.length > 1) {
            row.remove();
        } else {
            alert('A prescription must contain at least one medicine item.');
        }
    }

    // Add first row on load
    window.onload = function() {
        addMedicineRow();
    };
</script>

</body>
</html>
