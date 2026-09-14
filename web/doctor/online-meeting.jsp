<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.doctor.Consultation" %>
<%@ page import="model.doctor.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Meeting Dashboard - Doctor Portal</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    Consultation consultation = (Consultation) request.getAttribute("consultation");
    Patient patient = (Patient) request.getAttribute("patient");
    String savedParam = request.getParameter("saved");
%>

<main class="app-container">

    <div style="margin-bottom: 18px; display: flex; justify-content: space-between; align-items: center;">
        <a href="<%= request.getContextPath() %>/DoctorConsultationServlet" class="btn btn-secondary btn-sm">← Back to Consultations</a>
        <% if (consultation != null) { %>
            <div style="font-size: 14px; font-weight: 600;">
                Status: 
                <% if ("ONGOING".equalsIgnoreCase(consultation.getConsultationStatus())) { %>
                    <span class="badge badge-ongoing">Session Ongoing</span>
                <% } else if ("COMPLETED".equalsIgnoreCase(consultation.getConsultationStatus())) { %>
                    <span class="badge badge-completed">Session Completed</span>
                <% } else { %>
                    <span class="badge badge-pending">Scheduled</span>
                <% } %>
            </div>
        <% } %>
    </div>

    <% if ("1".equals(savedParam)) { %>
        <div class="alert alert-success">Consultation notes saved successfully!</div>
    <% } %>

    <% if (consultation != null) { %>

        <div style="display: grid; grid-template-columns: 1.2fr 1fr; gap: 24px;">
            
            <!-- LEFT PANEL: ONLINE MEETING CONTROLS -->
            <div class="card">
                <div class="card-title">
                    <span>Online Consultation Room #<%= consultation.getConsultationId() %></span>
                    <span class="badge" style="background:#e0f2fe; color:#0369a1;"><%= consultation.getAppointmentType() != null ? consultation.getAppointmentType() : "Online Video" %></span>
                </div>

                <div style="background: #1e293b; color: white; border-radius: 8px; padding: 24px; text-align: center; margin-bottom: 20px;">
                    <div style="font-size: 44px; margin-bottom: 10px;">📹</div>
                    <h3 style="margin: 0 0 8px 0; color: white; font-size: 18px;">Live Video Telehealth Session</h3>
                    <p style="margin: 0 0 16px 0; font-size: 13px; color: #94a3b8;">
                        Direct encrypted meeting room link for Doctor and Patient.
                    </p>

                    <div style="background: rgba(255,255,255,0.1); padding: 10px; border-radius: 6px; font-family: monospace; font-size: 12px; margin-bottom: 18px; word-break: break-all;">
                        <%= consultation.getMeetingLink() != null ? consultation.getMeetingLink() : "Link pending generation" %>
                    </div>

                    <div style="display: flex; justify-content: center; gap: 12px; flex-wrap: wrap;">
                        <% if (consultation.getMeetingLink() != null) { %>
                            <a href="<%= consultation.getMeetingLink() %>" target="_blank" class="btn btn-success" style="padding: 10px 22px; font-size: 14px;">
                                🚀 Join / Launch Video Meeting
                            </a>
                        <% } %>
                    </div>
                </div>

                <!-- END CONSULTATION BUTTON -->
                <% if (!"COMPLETED".equalsIgnoreCase(consultation.getConsultationStatus())) { %>
                    <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: 18px;">
                        <h4 style="margin: 0 0 8px 0; color: #334155; font-size: 15px;">Complete Consultation</h4>
                        <p style="margin: 0 0 14px 0; font-size: 13px; color: #64748b;">
                            Ending the session will mark the appointment as completed and proceed directly to writing the patient's prescription.
                        </p>
                        <form action="<%= request.getContextPath() %>/DoctorConsultationServlet" method="GET">
                            <input type="hidden" name="action" value="end">
                            <input type="hidden" name="id" value="<%= consultation.getConsultationId() %>">
                            <button type="submit" class="btn btn-danger" style="width: 100%; padding: 10px;" onclick="return confirm('Are you sure you want to end this consultation and create prescription?');">
                                ⏹ End Consultation & Create Prescription
                            </button>
                        </form>
                    </div>
                <% } else { %>
                    <div class="alert alert-info">
                        This consultation is already completed. 
                        <a href="<%= request.getContextPath() %>/DoctorPrescriptionServlet?action=new&consultationId=<%= consultation.getConsultationId() %>&patientId=<%= consultation.getPatientId() %>" style="color: #075985; font-weight: bold; margin-left: 6px;">
                            Write / Update Prescription →
                        </a>
                    </div>
                <% } %>
            </div>

            <!-- RIGHT PANEL: PATIENT & NOTES -->
            <div>
                <!-- PATIENT INFO MINI CARD -->
                <div class="card" style="margin-bottom: 20px;">
                    <div class="card-title">
                        <span>Patient Information</span>
                        <a href="<%= request.getContextPath() %>/DoctorPatientServlet?action=view&id=<%= consultation.getPatientId() %>" target="_blank" class="btn btn-secondary btn-sm">Full Record</a>
                    </div>
                    <div style="font-size: 14px; display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                        <div>
                            <strong style="color: #64748b; font-size: 12px; display: block;">NAME</strong>
                            <span style="font-weight: 600;"><%= consultation.getPatientName() %></span>
                        </div>
                        <div>
                            <strong style="color: #64748b; font-size: 12px; display: block;">BLOOD GROUP</strong>
                            <span><%= patient != null && patient.getBloodGroup() != null ? patient.getBloodGroup() : "N/A" %></span>
                        </div>
                        <div>
                            <strong style="color: #64748b; font-size: 12px; display: block;">GENDER / DOB</strong>
                            <span><%= patient != null && patient.getGender() != null ? patient.getGender() : "" %> (<%= patient != null && patient.getDob() != null ? patient.getDob() : "N/A" %>)</span>
                        </div>
                        <div>
                            <strong style="color: #64748b; font-size: 12px; display: block;">PHONE</strong>
                            <span><%= patient != null && patient.getPhone() != null ? patient.getPhone() : "N/A" %></span>
                        </div>
                    </div>
                </div>

                <!-- CLINICAL NOTES FORM -->
                <div class="card">
                    <div class="card-title">
                        <span>Consultation Notes</span>
                    </div>

                    <form action="<%= request.getContextPath() %>/DoctorConsultationServlet" method="POST">
                        <input type="hidden" name="action" value="saveNotes">
                        <input type="hidden" name="consultationId" value="<%= consultation.getConsultationId() %>">

                        <div class="form-group">
                            <label class="form-label">Doctor's Observations & Chief Complaints</label>
                            <textarea name="notes" class="form-control" rows="8" placeholder="Record patient symptoms, vital signs, clinical findings, and tentative diagnosis during the meeting..." required><%= consultation.getNotes() != null ? consultation.getNotes() : "" %></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%;">💾 Save Notes</button>
                    </form>
                </div>
            </div>

        </div>

    <% } else { %>
        <div class="alert alert-danger">Consultation session not found.</div>
    <% } %>

</main>

</body>
</html>
