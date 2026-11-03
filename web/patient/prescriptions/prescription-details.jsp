<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="patient.model.Prescriptions" %>
<%@ page import="pharmacy.dao.PharmacyDAO" %>
<%@ page import="pharmacy.model.Pharmacy" %>
<%@ page import="patient.dao.PatientDAO" %>
<%@ page import="patient.model.Patient" %>

<%
    request.setAttribute("pageTitle", "Prescription Details");
    request.setAttribute("pageDescription", "Review prescription information, diagnosis, and doctor advice.");

    Prescriptions prescriptionDetail = (Prescriptions) request.getAttribute("prescriptionDetail");
    if (prescriptionDetail == null) {
        String idParam = request.getParameter("prescriptionId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int prescriptionId = Integer.parseInt(idParam.trim());
                Prescriptions prModel = new Prescriptions();
                prescriptionDetail = prModel.getPrescriptionByPrescriptionId(prescriptionId);
            } catch (Exception e) {
                // Ignore parse exception
            }
        }
    }

    String patientId = (String) session.getAttribute("patientId");
    String patientAddress = "";
    if (patientId != null) {
        try {
            PatientDAO pDao = new PatientDAO();
            Patient currentPatient = pDao.getPatientById(patientId);
            if (currentPatient != null && currentPatient.getAddress() != null) {
                patientAddress = currentPatient.getAddress().trim();
            }
        } catch (Exception ignore) {}
    }

    PharmacyDAO pharmacyDAO = new PharmacyDAO();
    java.util.List<Pharmacy> pharmacyList = null;
    try {
        pharmacyList = pharmacyDAO.getAllPharmacies();
    } catch (Exception ignore) {}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Prescription Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/prescriptions.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <% if (prescriptionDetail == null) { %>
                <section class="card">
                    <div class="card-body" style="padding: 40px; text-align: center;">
                        <h3 class="section-title">Prescription Not Found</h3>
                        <p style="color: var(--text-muted); margin: 10px 0 20px;">
                            The requested prescription details could not be found.
                        </p>
                        <a href="${pageContext.request.contextPath}/patient/prescriptions" class="btn btn-primary">
                            Back to Prescriptions
                        </a>
                    </div>
                </section>
            <% } else { 
                String rxId = request.getParameter("prescriptionId");
                if (rxId == null || rxId.trim().isEmpty()) {
                    rxId = String.valueOf(prescriptionDetail.getPrescriptionId());
                }
            %>

                <section class="card prescription-details-card">
                    <div class="card-body">
                        <!-- Prescription Header -->
                        <div class="prescription-details-header">
                            <div>
                                <span class="prescription-status active" style="margin-bottom: 8px;">Active</span>
                                <h2 class="section-title">Prescription #RX-<%= rxId %></h2>
                                <p style="color: var(--text-muted); font-size: 13px; margin: 4px 0 0;">
                                    Issued on <%= prescriptionDetail.getPrescriptionDate() != null ? prescriptionDetail.getPrescriptionDate() : "-" %>
                                </p>
                            </div>
                        </div>

                        <div class="prescription-details-content">
                            <!-- Consultation Details Meta -->
                            <div class="prescription-section">
                                <h3 class="prescription-section-title">Details</h3>
                                <div class="prescription-meta">
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Doctor Name</span>
                                        <span class="prescription-meta-value">Dr. <%= prescriptionDetail.getDoctorName() != null ? prescriptionDetail.getDoctorName() : "-" %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Doctor ID</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getDoctorId() %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Patient Name</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getPatientName() != null ? prescriptionDetail.getPatientName() : "-" %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Patient ID</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getPatientId() != null ? prescriptionDetail.getPatientId() : "-" %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Consultation ID</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getConsultationId() %></span>
                                    </div>
                                    <div class="prescription-meta-item">
                                        <span class="prescription-meta-label">Date</span>
                                        <span class="prescription-meta-value"><%= prescriptionDetail.getPrescriptionDate() != null ? prescriptionDetail.getPrescriptionDate() : "-" %></span>
                                    </div>
                                </div>
                            </div>

                            <!-- Diagnosis -->
                            <div class="prescription-section">
                                <h3 class="prescription-section-title">Diagnosis</h3>
                                <div class="prescription-instructions">
                                    <%= prescriptionDetail.getDiagnosis() != null && !prescriptionDetail.getDiagnosis().trim().isEmpty() ? prescriptionDetail.getDiagnosis() : "No diagnosis specified." %>
                                </div>
                            </div>

                            <!-- Advice -->
                            <div class="prescription-section">
                                <h3 class="prescription-section-title">Doctor's Advice</h3>
                                <div class="prescription-instructions">
                                    <%= prescriptionDetail.getAdvice() != null && !prescriptionDetail.getAdvice().trim().isEmpty() ? prescriptionDetail.getAdvice() : "No advice recorded." %>
                                </div>
                            </div>

                            <!-- Prescribed Medicines Table -->
                            <div class="prescription-section" style="margin-top: 24px;">
                                <h3 class="prescription-section-title" style="display: flex; justify-content: space-between; align-items: center;">
                                    <span>Prescribed Medicines (<%= prescriptionDetail.getItems() != null ? prescriptionDetail.getItems().size() : 0 %>)</span>
                                </h3>

                                <% if (prescriptionDetail.getItems() == null || prescriptionDetail.getItems().isEmpty()) { %>
                                    <p style="color: var(--text-muted); font-size: 14px; background: #f8fafc; padding: 14px; border-radius: 8px;">
                                        No specific medicines listed in this prescription header.
                                    </p>
                                <% } else { %>
                                    <div style="overflow-x: auto; margin-top: 12px; border: 1px solid #e2e8f0; border-radius: 8px;">
                                        <table style="width: 100%; border-collapse: collapse; font-size: 14px; text-align: left;">
                                            <thead>
                                                <tr style="background: #f1f5f9; color: #475569; border-bottom: 1px solid #e2e8f0;">
                                                    <th style="padding: 12px 16px;">Medicine</th>
                                                    <th style="padding: 12px 16px;">Dosage</th>
                                                    <th style="padding: 12px 16px;">Frequency</th>
                                                    <th style="padding: 12px 16px;">Duration</th>
                                                    <th style="padding: 12px 16px;">Special Instructions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (java.util.Map<String, Object> item : prescriptionDetail.getItems()) { %>
                                                    <tr style="border-bottom: 1px solid #f1f5f9;">
                                                        <td style="padding: 12px 16px; font-weight: 600; color: #1e293b;">
                                                            <%= item.get("medicineName") != null ? item.get("medicineName") : "Prescribed Medication" %>
                                                        </td>
                                                        <td style="padding: 12px 16px; color: #0284c7; font-weight: 500;">
                                                            <%= item.get("dosage") != null && !item.get("dosage").toString().trim().isEmpty() ? item.get("dosage") : "As advised" %>
                                                        </td>
                                                        <td style="padding: 12px 16px; color: #334155;">
                                                            <%= item.get("frequency") != null && !item.get("frequency").toString().trim().isEmpty() ? item.get("frequency") : "Standard" %>
                                                        </td>
                                                        <td style="padding: 12px 16px; color: #334155;">
                                                            <%= item.get("duration") != null && !item.get("duration").toString().trim().isEmpty() ? item.get("duration") : "Course" %>
                                                        </td>
                                                        <td style="padding: 12px 16px; color: #64748b; font-size: 13px;">
                                                            <%= item.get("instructions") != null && !item.get("instructions").toString().trim().isEmpty() ? item.get("instructions") : "Take with water" %>
                                                        </td>
                                                    </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                <% } %>
                            </div>

                            <!-- Send Prescription to Pharmacy Section -->
                            <div class="prescription-section" style="margin-top: 28px; background: #f0fdf4; border: 1.5px solid #86efac; border-radius: 12px; padding: 22px;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 16px; margin-bottom: 14px;">
                                    <div>
                                        <h3 style="margin: 0 0 6px 0; color: #166534; font-size: 17px; font-weight: 700; display: flex; align-items: center; gap: 8px;">
                                            <span>📦 Order Medicines from Pharmacy</span>
                                        </h3>
                                        <p style="margin: 0; color: #15803d; font-size: 13px;">
                                            Select your preferred local pharmacy near your address to fulfill your prescription medicines and arrange delivery.
                                        </p>
                                    </div>
                                </div>

                                <form action="${pageContext.request.contextPath}/patient/order-prescription" method="POST" style="margin: 0;">
                                    <input type="hidden" name="prescriptionId" value="<%= rxId %>">

                                    <!-- Pharmacy Dropdown -->
                                    <div class="form-group" style="margin-bottom: 16px;">
                                        <label for="pharmacySelect" style="display: flex; justify-content: space-between; font-size: 13px; font-weight: 700; color: #166534; margin-bottom: 6px;">
                                            <span>🏥 Choose Pharmacy Near You:</span>
                                            <% if (!patientAddress.isEmpty()) { %>
                                                <span style="font-weight: 500; font-size: 11px; color: #047857;">Your Address: <%= patientAddress %></span>
                                            <% } %>
                                        </label>
                                        <select name="pharmacyId" id="pharmacySelect" class="form-control" required onchange="updatePharmacyCard(this)"
                                                style="background: white; border: 1.5px solid #86efac; padding: 11px 14px; border-radius: 8px; width: 100%; font-size: 14px; color: #0f172a; font-weight: 600; cursor: pointer;">
                                            <% 
                                                boolean anySelected = false;
                                                if (pharmacyList != null && !pharmacyList.isEmpty()) {
                                                    for (int i = 0; i < pharmacyList.size(); i++) {
                                                        Pharmacy ph = pharmacyList.get(i);
                                                        boolean isNearby = false;
                                                        if (!patientAddress.isEmpty() && ph.getAddress() != null) {
                                                            String[] parts = patientAddress.toLowerCase().split("[,\\s]+");
                                                            for (String part : parts) {
                                                                if (part.length() > 3 && ph.getAddress().toLowerCase().contains(part)) {
                                                                    isNearby = true;
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                        String optSelected = (!anySelected && (isNearby || i == 0)) ? "selected" : "";
                                                        if (!optSelected.isEmpty()) anySelected = true;
                                            %>
                                                <option value="<%= ph.getPharmacyId() %>"
                                                        data-name="<%= ph.getPharmacyName() %>"
                                                        data-address="<%= ph.getAddress() != null ? ph.getAddress() : "City Center" %>"
                                                        data-phone="<%= ph.getPhone() != null ? ph.getPhone() : "+91 98765 43210" %>"
                                                        data-email="<%= ph.getEmail() != null ? ph.getEmail() : "pharmacy@omnihealth.com" %>"
                                                        data-license="<%= ph.getLicenseNumber() != null ? ph.getLicenseNumber() : "PHARM-LIC" %>"
                                                        <%= optSelected %>>
                                                    <%= ph.getPharmacyName() %> — <%= ph.getAddress() != null ? ph.getAddress() : "Main Branch" %> <%= isNearby ? "⭐ (Nearest Pharmacy)" : "" %>
                                                </option>
                                            <%      }
                                                } else { %>
                                                <option value="1" data-name="Central Health & Care Pharmacy" data-address="42 Medical Enclave, Health City, Sector 5" data-phone="+91 98765 43210" data-email="pharmacare@omnihealth.com" data-license="PHARM-DL-2026-9812">
                                                    Central Health & Care Pharmacy — 42 Medical Enclave, Sector 5 (Main Branch)
                                                </option>
                                            <% } %>
                                        </select>
                                    </div>

                                    <!-- Selected Pharmacy Details Badge -->
                                    <div id="selectedPharmBadge" style="background: #ffffff; border: 1.5px solid #bbf7d0; border-radius: 8px; padding: 12px 16px; margin-bottom: 16px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px;">
                                        <div>
                                            <div id="spName" style="font-weight: 700; color: #166534; font-size: 14px;">Central Health & Care Pharmacy</div>
                                            <div id="spAddress" style="color: #64748b; font-size: 12px; margin-top: 2px;">42 Medical Enclave, Health City, Sector 5</div>
                                        </div>
                                        <div style="display: flex; gap: 10px; align-items: center;">
                                            <span id="spPhone" style="font-size: 12px; color: #047857; background: #ecfdf5; padding: 4px 10px; border-radius: 6px; font-weight: 600;">📞 +91 98765 43210</span>
                                        </div>
                                    </div>

                                    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 14px; align-items: flex-end;">
                                        <div>
                                            <label style="display: block; font-size: 12px; font-weight: 600; color: #166534; margin-bottom: 6px;">
                                                Delivery / Residential Address
                                            </label>
                                            <input type="text" name="deliveryAddress" required 
                                                   value="<%= !patientAddress.isEmpty() ? patientAddress : "" %>"
                                                   placeholder="Enter your home address for medicine delivery..." 
                                                   class="form-control" style="background: white; border: 1.5px solid #86efac; padding: 11px 14px; border-radius: 8px; width: 100%; box-sizing: border-box; font-size: 13px;">
                                        </div>
                                        <div>
                                            <button type="submit" class="btn btn-primary" style="background: #16a34a; border-color: #16a34a; width: 100%; padding: 11px 18px; font-weight: 700; cursor: pointer; border-radius: 8px;">
                                                Send Request to Pharmacy →
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <script>
                            function updatePharmacyCard(selectEl) {
                                var opt = selectEl.options[selectEl.selectedIndex];
                                if (!opt) return;
                                var name = opt.getAttribute('data-name');
                                var address = opt.getAttribute('data-address');
                                var phone = opt.getAttribute('data-phone');
                                if (document.getElementById('spName')) document.getElementById('spName').textContent = name;
                                if (document.getElementById('spAddress')) document.getElementById('spAddress').textContent = address;
                                if (document.getElementById('spPhone')) document.getElementById('spPhone').textContent = '📞 ' + phone;
                            }
                            // Initial call on load
                            document.addEventListener('DOMContentLoaded', function() {
                                var el = document.getElementById('pharmacySelect');
                                if (el) updatePharmacyCard(el);
                            });
                            </script>

                            <!-- Actions -->
                            <div class="prescription-detail-actions" style="margin-top: 24px; display: flex; gap: 12px;">
                                <a href="${pageContext.request.contextPath}/patient/prescriptions" class="btn btn-secondary">
                                    &larr; Back to Prescriptions
                                </a>
                                <a href="${pageContext.request.contextPath}/patient/orders" class="btn btn-secondary" style="margin-left: 8px;">
                                    View My Pharmacy Orders
                                </a>
                            </div>
                        </div>
                    </div>
                </section>

            <% } %>

        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>