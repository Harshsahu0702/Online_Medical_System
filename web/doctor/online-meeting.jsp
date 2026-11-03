<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="doctor.model.Consultation" %>
<%@ page import="doctor.model.Patient" %>
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
    String linkUpdatedParam = request.getParameter("linkUpdated");
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

    <% if ("1".equals(linkUpdatedParam)) { %>
        <div class="alert alert-success">Meeting link saved and updated successfully!</div>
    <% } %>

    <% if (consultation != null) { %>

        <div style="display: grid; grid-template-columns: 1.2fr 1fr; gap: 24px;">
            
            <!-- LEFT PANEL: ONLINE MEETING CONTROLS -->
            <div class="card">
                <div class="card-title">
                    <span>Consultation Meeting #<%= consultation.getConsultationId() %></span>
                    <span class="badge" style="background:#e0f2fe; color:#0369a1;"><%= consultation.getAppointmentType() != null ? consultation.getAppointmentType() : "Online Video" %></span>
                </div>

                <!-- GOOGLE MEET MANAGEMENT -->
                <div style="background: #f8fafc; border: 1.5px solid #cbd5e1; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
                    <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 14px; flex-wrap: wrap; gap: 8px;">
                        <span style="font-size: 14px; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 6px;">
                            📹 Google Meet Video Consultation
                        </span>
                        <a href="https://meet.google.com/new" target="_blank" class="btn btn-primary btn-sm" style="background: #1a73e8; border-color: #1a73e8; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px;">
                            + Create Google Meet
                        </a>
                    </div>

                    <% 
                        String curLink = consultation.getMeetingLink();
                        boolean hasLink = (curLink != null && !curLink.trim().isEmpty());
                    %>

                    <% if (hasLink) { %>
                        <div style="background: #ffffff; border: 1px solid #93c5fd; border-radius: 8px; padding: 14px; margin-bottom: 16px;">
                            <div style="font-size: 11px; text-transform: uppercase; font-weight: 700; color: #1e40af; margin-bottom: 4px;">Saved Meeting Link:</div>
                            <div style="font-family: monospace; font-size: 13px; color: #1e293b; word-break: break-all; margin-bottom: 10px;">
                                <%= curLink %>
                            </div>
                            <a href="<%= curLink %>" target="_blank" class="btn btn-success" style="padding: 8px 18px; font-size: 13px; font-weight: 700; text-decoration: none; display: inline-flex; align-items: center; gap: 6px;">
                                🚀 Join Meeting
                            </a>
                        </div>
                    <% } else { %>
                        <div style="background: #fffbeb; border: 1px solid #fde68a; border-radius: 8px; padding: 12px; margin-bottom: 16px; font-size: 13px; color: #92400e;">
                            ⚠️ No meeting link set yet. Click <strong>+ Create Google Meet</strong> above to create a meeting, then paste the link below and click <strong>Save Link</strong>.
                        </div>
                    <% } %>

                    <form action="<%= request.getContextPath() %>/DoctorConsultationServlet" method="GET" style="margin: 0;">
                        <input type="hidden" name="action" value="updateLink">
                        <input type="hidden" name="id" value="<%= consultation.getConsultationId() %>">
                        <label style="display: block; font-size: 12px; font-weight: 600; color: #475569; margin-bottom: 6px;">
                            <%= hasLink ? "Update / Change Meeting Link:" : "Enter Meeting Link:" %>
                        </label>
                        <div style="display: flex; gap: 8px;">
                            <input type="url" name="meetingLink" class="form-control" placeholder="https://meet.google.com/xxx-yyyy-zzz" value="<%= hasLink ? curLink : "" %>" required style="font-size: 13px;">
                            <button type="submit" class="btn btn-primary btn-sm" style="white-space: nowrap; padding: 0 16px;">Save Link</button>
                        </div>
                    </form>
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
