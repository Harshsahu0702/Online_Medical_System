<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="patient.model.Emergency" %>

<%
    request.setAttribute("pageTitle", "Emergency Assistance");
    request.setAttribute("pageDescription", "Request immediate emergency medical assistance and track your active requests.");

    String successMsg = (String) session.getAttribute("emergencySuccess");
    String errorMsg = (String) session.getAttribute("emergencyError");
    session.removeAttribute("emergencySuccess");
    session.removeAttribute("emergencyError");

    ArrayList<Emergency> emergencyList = (ArrayList<Emergency>) request.getAttribute("emergencyList");
    if (emergencyList == null) {
        String patientId = (String) session.getAttribute("patientId");
        Emergency em = new Emergency();
        emergencyList = em.getEmergencyRequestsByPatientId(patientId);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Emergency Assistance</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/emergency.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <!-- Immediate Call Alert Banner -->
            <section class="emergency-alert card" style="margin-bottom: 24px; border-left: 5px solid #dc2626;">
                <div class="card-body" style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 16px; padding: 18px 20px;">
                    <div style="display: flex; align-items: center; gap: 14px;">
                        <div class="emergency-alert-icon" style="background: #fee2e2; color: #dc2626; width: 44px; height: 44px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 22px; font-weight: bold; flex-shrink: 0;">
                            !
                        </div>
                        <div>
                            <h3 style="margin: 0 0 4px; color: #991b1b; font-size: 16px; font-weight: 700;">Experiencing a Life-Threatening Emergency?</h3>
                            <p style="margin: 0; color: #b91c1c; font-size: 13px;">If someone is unconscious, bleeding heavily, or having severe difficulty breathing, dial national emergency directly.</p>
                        </div>
                    </div>
                    <a href="tel:112" class="btn btn-danger" style="background: #dc2626; color: #fff; font-weight: 700; padding: 10px 22px; border-radius: 6px; text-decoration: none; border: none; cursor: pointer;">
                        Call 112
                    </a>
                </div>
            </section>

            <% if (successMsg != null) { %>
                <div style="padding: 14px 18px; margin-bottom: 24px; background: #ecfdf5; border: 1px solid #a7f3d0; border-radius: 8px; color: #065f46; font-size: 14px; font-weight: 500;">
                    ✓ <%= successMsg %>
                </div>
            <% } %>

            <% if (errorMsg != null) { %>
                <div style="padding: 14px 18px; margin-bottom: 24px; background: #fef2f2; border: 1px solid #fecaca; border-radius: 8px; color: #991b1b; font-size: 14px; font-weight: 500;">
                    ✕ <%= errorMsg %>
                </div>
            <% } %>

            <div class="emergency-request-layout">
                <!-- Request Emergency Form -->
                <section class="card emergency-request-card">
                    <div class="card-body" style="padding: 24px;">
                        <div style="margin-bottom: 20px; border-bottom: 1px solid var(--border-color); padding-bottom: 12px;">
                            <h2 class="section-title" style="margin: 0; font-size: 18px; color: var(--text-main);">Request Emergency Assistance</h2>
                            <p style="margin: 4px 0 0; color: var(--text-muted); font-size: 13px;">Fill out this quick form and our emergency dispatch team will be immediately notified.</p>
                        </div>

                        <form method="post" action="${pageContext.request.contextPath}/patient/emergency">
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 16px; margin-bottom: 16px;">
                                <div>
                                    <label for="emergencyType" style="display: block; font-size: 13px; font-weight: 600; color: var(--text-main); margin-bottom: 6px;">
                                        Emergency Type *
                                    </label>
                                    <select name="emergencyType" id="emergencyType" class="form-control" required style="width: 100%; padding: 10px 12px; border: 1px solid var(--border-color); border-radius: 6px; font-size: 13px;">
                                        <option value="">-- Select Emergency Type --</option>
                                        <option value="Cardiac / Chest Pain">Cardiac / Chest Pain</option>
                                        <option value="Accident / Trauma">Accident / Trauma</option>
                                        <option value="Severe Breathing Difficulty">Severe Breathing Difficulty</option>
                                        <option value="Stroke / Neurological">Stroke / Neurological</option>
                                        <option value="Severe Bleeding">Severe Bleeding</option>
                                        <option value="Severe Allergic Reaction">Severe Allergic Reaction</option>
                                        <option value="High Fever / Seizure">High Fever / Seizure</option>
                                        <option value="Other Medical Emergency">Other Medical Emergency</option>
                                    </select>
                                </div>

                                <div>
                                    <label for="severity" style="display: block; font-size: 13px; font-weight: 600; color: var(--text-main); margin-bottom: 6px;">
                                        Severity Level *
                                    </label>
                                    <select name="severity" id="severity" class="form-control" required style="width: 100%; padding: 10px 12px; border: 1px solid var(--border-color); border-radius: 6px; font-size: 13px;">
                                        <option value="CRITICAL">CRITICAL (Immediate Life Threat)</option>
                                        <option value="HIGH" selected>HIGH (Urgent Medical Attention)</option>
                                        <option value="MEDIUM">MEDIUM (Serious Condition)</option>
                                        <option value="LOW">LOW (Non-immediate)</option>
                                    </select>
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 16px; margin-bottom: 16px;">
                                <div>
                                    <label for="contactNumber" style="display: block; font-size: 13px; font-weight: 600; color: var(--text-main); margin-bottom: 6px;">
                                        Contact Phone Number *
                                    </label>
                                    <input type="tel" name="contactNumber" id="contactNumber" class="form-control" placeholder="e.g. +91 9876543210" required style="width: 100%; padding: 10px 12px; border: 1px solid var(--border-color); border-radius: 6px; font-size: 13px;">
                                </div>

                                <div>
                                    <label for="location" style="display: block; font-size: 13px; font-weight: 600; color: var(--text-main); margin-bottom: 6px;">
                                        Exact Location / Address *
                                    </label>
                                    <input type="text" name="location" id="location" class="form-control" placeholder="House/Flat No, Street, Landmark, City" required style="width: 100%; padding: 10px 12px; border: 1px solid var(--border-color); border-radius: 6px; font-size: 13px;">
                                </div>
                            </div>

                            <div style="margin-bottom: 20px;">
                                <label for="description" style="display: block; font-size: 13px; font-weight: 600; color: var(--text-main); margin-bottom: 6px;">
                                    Description of Emergency / Patient Condition *
                                </label>
                                <textarea name="description" id="description" rows="3" class="form-control" placeholder="Please describe patient symptoms, current state, or immediate needs..." required style="width: 100%; padding: 10px 12px; border: 1px solid var(--border-color); border-radius: 6px; font-size: 13px; resize: vertical;"></textarea>
                            </div>

                            <div style="display: flex; justify-content: flex-end;">
                                <button type="submit" class="btn btn-danger" style="background: #dc2626; color: #fff; font-weight: 600; padding: 12px 28px; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; box-shadow: 0 2px 4px rgba(220, 38, 38, 0.3);">
                                    Submit Emergency Request
                                </button>
                            </div>
                        </form>
                    </div>
                </section>

                <!-- Sidebar Guidelines -->
                <aside class="card emergency-sidebar-card" style="padding: 20px;">
                    <h3 class="emergency-sidebar-title" style="margin: 0 0 14px; font-size: 15px; color: var(--text-main); font-weight: 700;">Emergency Protocols</h3>
                    <div class="emergency-info-list" style="display: flex; flex-direction: column; gap: 14px;">
                        <div class="emergency-info-item" style="display: flex; gap: 10px; font-size: 13px; color: var(--text-muted); line-height: 1.5;">
                            <span style="color: #dc2626; font-weight: bold;">1.</span>
                            <span>Stay calm and stay on the phone once contacted by medical staff.</span>
                        </div>
                        <div class="emergency-info-item" style="display: flex; gap: 10px; font-size: 13px; color: var(--text-muted); line-height: 1.5;">
                            <span style="color: #dc2626; font-weight: bold;">2.</span>
                            <span>Do not move trauma or spinal injury victims unless there is immediate danger.</span>
                        </div>
                        <div class="emergency-info-item" style="display: flex; gap: 10px; font-size: 13px; color: var(--text-muted); line-height: 1.5;">
                            <span style="color: #dc2626; font-weight: bold;">3.</span>
                            <span>Keep your doorway accessible and keep your registered phone line clear.</span>
                        </div>
                    </div>
                </aside>
            </div>

            <!-- Emergency Requests List -->
            <section class="card" style="margin-top: 28px;">
                <div class="card-body" style="padding: 24px;">
                    <div style="margin-bottom: 20px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px;">
                        <div>
                            <h2 class="section-title" style="margin: 0; font-size: 18px; color: var(--text-main);">My Emergency Requests</h2>
                            <p style="margin: 4px 0 0; color: var(--text-muted); font-size: 13px;">
                                <%= (emergencyList != null) ? emergencyList.size() : 0 %> requests recorded
                            </p>
                        </div>
                    </div>

                    <% if (emergencyList == null || emergencyList.isEmpty()) { %>
                        <div style="padding: 40px 20px; text-align: center;">
                            <div style="width: 52px; height: 52px; margin: 0 auto 14px; border-radius: 50%; background: #f3f4f6; display: flex; align-items: center; justify-content: center; color: var(--text-muted);">
                                <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M12 2v20"/>
                                    <path d="M2 12h20"/>
                                </svg>
                            </div>
                            <h3 style="margin: 0 0 6px; font-size: 16px; color: var(--text-main);">No Emergency Requests Found</h3>
                            <p style="margin: 0; color: var(--text-muted); font-size: 13px;">You have not submitted any emergency medical requests yet.</p>
                        </div>
                    <% } else { %>
                        <div style="display: flex; flex-direction: column; gap: 14px;">
                            <% for (Emergency emItem : emergencyList) { 
                                String sev = emItem.getSeverity() != null ? emItem.getSeverity().toUpperCase() : "MEDIUM";
                                String sevBg = "#fef3c7";
                                String sevColor = "#b45309";
                                if ("CRITICAL".equals(sev)) {
                                    sevBg = "#fee2e2";
                                    sevColor = "#b91c1c";
                                } else if ("HIGH".equals(sev)) {
                                    sevBg = "#ffedd5";
                                    sevColor = "#c2410c";
                                } else if ("LOW".equals(sev)) {
                                    sevBg = "#ecfdf5";
                                    sevColor = "#047857";
                                }

                                String stat = emItem.getStatus() != null ? emItem.getStatus().toUpperCase() : "PENDING";
                                String statBg = "#fef3c7";
                                String statColor = "#92400e";
                                if ("RESOLVED".equals(stat)) {
                                    statBg = "#dcfce7";
                                    statColor = "#15803d";
                                } else if ("CANCELLED".equals(stat)) {
                                    statBg = "#f3f4f6";
                                    statColor = "#4b5563";
                                }
                            %>
                                <div class="card" 
                                     onclick="window.location.href='${pageContext.request.contextPath}/patient/emergency-details?emergencyId=<%= emItem.getEmergencyId() %>'" 
                                     style="border: 1px solid var(--border-color); border-radius: 8px; padding: 18px 20px; cursor: pointer; transition: all 0.2s ease; background: var(--bg-surface);">
                                    <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; margin-bottom: 12px; border-bottom: 1px solid var(--border-color-subtle, #f0f0f0); padding-bottom: 10px;">
                                        <div style="display: flex; align-items: center; gap: 10px;">
                                            <strong style="font-size: 15px; color: var(--text-main);">
                                                Request #EMG-<%= emItem.getEmergencyId() %>
                                            </strong>
                                            <span style="font-size: 11px; font-weight: 700; padding: 3px 8px; border-radius: 12px; background: <%= sevBg %>; color: <%= sevColor %>;">
                                                <%= sev %>
                                            </span>
                                            <span style="font-size: 11px; font-weight: 700; padding: 3px 8px; border-radius: 12px; background: <%= statBg %>; color: <%= statColor %>;">
                                                <%= stat %>
                                            </span>
                                        </div>
                                        <span style="font-size: 12px; color: var(--text-muted);">
                                            <%= emItem.getRequestedAt() != null ? emItem.getRequestedAt() : "" %>
                                        </span>
                                    </div>

                                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 12px; font-size: 13px; margin-bottom: 12px;">
                                        <div>
                                            <span style="display: block; font-size: 11px; color: var(--text-light); text-transform: uppercase; font-weight: 600; margin-bottom: 2px;">Type</span>
                                            <strong style="color: var(--text-main);"><%= emItem.getEmergencyType() != null ? emItem.getEmergencyType() : "General Emergency" %></strong>
                                        </div>
                                        <div>
                                            <span style="display: block; font-size: 11px; color: var(--text-light); text-transform: uppercase; font-weight: 600; margin-bottom: 2px;">Contact</span>
                                            <span style="color: var(--text-body);"><%= emItem.getContactNumber() != null ? emItem.getContactNumber() : "-" %></span>
                                        </div>
                                        <div>
                                            <span style="display: block; font-size: 11px; color: var(--text-light); text-transform: uppercase; font-weight: 600; margin-bottom: 2px;">Location</span>
                                            <span style="color: var(--text-body);"><%= emItem.getLocation() != null ? emItem.getLocation() : "-" %></span>
                                        </div>
                                    </div>

                                    <div style="display: flex; justify-content: flex-end;">
                                        <a href="${pageContext.request.contextPath}/patient/emergency-details?emergencyId=<%= emItem.getEmergencyId() %>" 
                                           class="btn btn-sm btn-outline" 
                                           style="font-size: 12px; padding: 6px 14px; text-decoration: none; border: 1px solid var(--border-color); border-radius: 4px; color: var(--primary);">
                                            View Details &rarr;
                                        </a>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } %>

                </div>
            </section>

        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>