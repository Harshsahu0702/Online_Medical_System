<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Doctor" %>
<%@ page import="model.doctor.DoctorDocument" %>
<%@ page import="model.doctor.Specialization" %>
<%@ page import="model.doctor.Clinic" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Profile - Online Medical System</title>
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    Doctor doctor = (Doctor) request.getAttribute("doctor");
    List<Specialization> specializations = (List<Specialization>) request.getAttribute("specializations");
    List<Clinic> clinics = (List<Clinic>) request.getAttribute("clinics");
    List<DoctorDocument> documents = (List<DoctorDocument>) request.getAttribute("documents");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");

    String successParam = request.getParameter("success");
    String errorParam = request.getParameter("error");
%>

<main class="app-container">

    <% if ("1".equals(successParam)) { %>
        <div class="alert alert-success">Profile updated successfully!</div>
    <% } else if ("1".equals(errorParam)) { %>
        <div class="alert alert-danger">Failed to update profile. Please try again.</div>
    <% } %>

    <div class="card">
        <div class="card-title">
            <span>Doctor Profile & Credentials</span>
            <span class="badge badge-accepted">Active Doctor</span>
        </div>

        <form action="<%= request.getContextPath() %>/DoctorProfileServlet" method="POST">
            
            <h4 style="color: #244b6b; margin-top: 10px; margin-bottom: 15px; border-bottom: 1px dashed #e2e8f0; padding-bottom: 6px;">Personal Information</h4>
            
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="name" class="form-control" value="<%= doctor != null ? doctor.getName() : "" %>" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Email Address (Login ID)</label>
                    <input type="email" class="form-control" value="<%= doctor != null ? doctor.getEmail() : "" %>" disabled style="background:#f1f5f9;">
                </div>
                <div class="form-group">
                    <label class="form-label">Phone Number</label>
                    <input type="text" name="phone" class="form-control" value="<%= (doctor != null && doctor.getPhone() != null) ? doctor.getPhone() : "" %>" required>
                </div>
            </div>

            <h4 style="color: #244b6b; margin-top: 20px; margin-bottom: 15px; border-bottom: 1px dashed #e2e8f0; padding-bottom: 6px;">Professional Details</h4>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Specialization</label>
                    <select name="specializationId" class="form-control" required>
                        <% if (specializations != null) { 
                            for (Specialization s : specializations) {
                                boolean selected = (doctor != null && doctor.getSpecializationId() == s.getSpecializationId());
                        %>
                            <option value="<%= s.getSpecializationId() %>" <%= selected ? "selected" : "" %>><%= s.getName() %></option>
                        <%  } 
                        } %>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Clinic / Hospital</label>
                    <select name="clinicId" class="form-control">
                        <option value="0">-- None / Independent --</option>
                        <% if (clinics != null) { 
                            for (Clinic c : clinics) {
                                boolean selected = (doctor != null && doctor.getClinicId() != null && doctor.getClinicId() == c.getClinicId());
                        %>
                            <option value="<%= c.getClinicId() %>" <%= selected ? "selected" : "" %>><%= c.getClinicName() %> (<%= c.getCity() %>)</option>
                        <%  } 
                        } %>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Consultation Type</label>
                    <select name="consultationType" class="form-control">
                        <option value="BOTH" <%= (doctor != null && "BOTH".equalsIgnoreCase(doctor.getConsultationType())) ? "selected" : "" %>>Both (Online & In-Clinic)</option>
                        <option value="ONLINE" <%= (doctor != null && "ONLINE".equalsIgnoreCase(doctor.getConsultationType())) ? "selected" : "" %>>Online Video Only</option>
                        <option value="OFFLINE" <%= (doctor != null && "OFFLINE".equalsIgnoreCase(doctor.getConsultationType())) ? "selected" : "" %>>In-Clinic Only</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Qualification</label>
                    <input type="text" name="qualification" class="form-control" value="<%= (doctor != null && doctor.getQualification() != null) ? doctor.getQualification() : "" %>" placeholder="e.g. MBBS, MD (General Medicine)" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Experience (Years)</label>
                    <input type="number" name="experience" class="form-control" value="<%= doctor != null ? doctor.getExperience() : 0 %>" min="0" max="60" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Consultation Fee (₹ / USD)</label>
                    <input type="number" step="0.01" name="consultationFee" class="form-control" value="<%= doctor != null ? doctor.getConsultationFee() : 0.0 %>" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">License / Registration Number</label>
                    <input type="text" name="licenseNumber" class="form-control" value="<%= (doctor != null && doctor.getLicenseNumber() != null) ? doctor.getLicenseNumber() : "" %>" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Registration Authority (Medical Council)</label>
                    <input type="text" name="registrationAuthority" class="form-control" value="<%= (doctor != null && doctor.getRegistrationAuthority() != null) ? doctor.getRegistrationAuthority() : "" %>">
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Doctor Bio / Summary</label>
                <textarea name="bio" class="form-control" rows="4" placeholder="Share your medical background, expertise, and patient approach..."><%= (doctor != null && doctor.getBio() != null) ? doctor.getBio() : "" %></textarea>
            </div>

            <div style="margin-top: 20px; text-align: right;">
                <button type="submit" class="btn btn-primary" style="padding: 10px 24px; font-size: 15px;">Save Profile Changes</button>
            </div>
        </form>
    </div>

    <!-- UPLOADED DOCUMENTS SECTION -->
    <div class="card" style="margin-top: 25px;">
        <div class="card-title">
            <span>Uploaded Verification Documents</span>
            <span class="badge" style="background:#e0f2fe; color:#0369a1;"><%= (documents != null) ? documents.size() : 0 %> Documents Uploaded</span>
        </div>

        <% 
            String docSuccess = request.getParameter("doc_success");
            String docError = request.getParameter("doc_error");
        %>
        <% if ("1".equals(docSuccess)) { %>
            <div class="alert alert-success" style="margin-bottom: 15px;">Document uploaded and saved successfully!</div>
        <% } else if (docError != null) { %>
            <div class="alert alert-danger" style="margin-bottom: 15px;">Failed to upload document (<%= docError %>). Please try with a valid PDF or Image file (under 10MB).</div>
        <% } %>

        <p style="color: #64748b; font-size: 13.5px; margin-bottom: 20px;">
            These credentials and certificates were submitted for medical council and administrative verification.
        </p>

        <% if (documents != null && !documents.isEmpty()) { %>
            <div style="overflow-x: auto;">
                <table class="data-table" style="width: 100%;">
                    <thead>
                        <tr>
                            <th style="width: 5%;">#</th>
                            <th style="width: 28%;">Document Type</th>
                            <th style="width: 25%;">File Name</th>
                            <th style="width: 18%;">Uploaded At</th>
                            <th style="width: 14%;">Verification Status</th>
                            <th style="width: 10%; text-align: center;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int docIdx = 1;
                            for (DoctorDocument doc : documents) {
                                String typeLabel = doc.getDocumentType();
                                if ("MEDICAL_REGISTRATION".equalsIgnoreCase(typeLabel)) {
                                    typeLabel = "Medical Registration Certificate";
                                } else if ("MBBS_DEGREE".equalsIgnoreCase(typeLabel)) {
                                    typeLabel = "MBBS / Basic Degree Certificate";
                                } else if ("IDENTITY_PROOF".equalsIgnoreCase(typeLabel)) {
                                    typeLabel = "Identity Proof (Govt ID)";
                                } else if ("ADDITIONAL_QUALIFICATION".equalsIgnoreCase(typeLabel)) {
                                    typeLabel = "Additional Qualification / MD / MS";
                                } else if (typeLabel != null) {
                                    typeLabel = typeLabel.replace("_", " ");
                                }

                                String status = doc.getVerificationStatus() != null ? doc.getVerificationStatus().toUpperCase() : "PENDING";
                                String badgeClass = "badge-pending";
                                String statusText = "Pending Review";

                                if ("VERIFIED".equalsIgnoreCase(status) || "APPROVED".equalsIgnoreCase(status)) {
                                    badgeClass = "badge-accepted";
                                    statusText = "Verified";
                                } else if ("REJECTED".equalsIgnoreCase(status)) {
                                    badgeClass = "badge-rejected";
                                    statusText = "Rejected";
                                }

                                String dateStr = doc.getUploadedAt() != null ? sdf.format(doc.getUploadedAt()) : "N/A";
                                String safeFileName = (doc.getFileName() != null ? doc.getFileName() : "Document").replace("'", "\\'");
                                String safeTypeLabel = typeLabel.replace("'", "\\'");
                        %>
                        <tr>
                            <td><strong><%= docIdx++ %></strong></td>
                            <td>
                                <span style="font-weight: 600; color: #1e293b;"><%= typeLabel %></span>
                                <div style="font-size: 11px; color: #94a3b8;"><%= doc.getDocumentType() %></div>
                            </td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 6px;">
                                    <span style="font-size: 15px;">📄</span>
                                    <span style="font-size: 13px; color: #334155; word-break: break-all;"><%= doc.getFileName() != null ? doc.getFileName() : "Document" %></span>
                                </div>
                            </td>
                            <td style="font-size: 12.5px; color: #64748b;"><%= dateStr %></td>
                            <td>
                                <span class="badge <%= badgeClass %>"><%= statusText %></span>
                            </td>
                            <td style="text-align: center;">
                                <button type="button" class="btn btn-primary" style="padding: 5px 14px; font-size: 12px; display: inline-flex; align-items: center; gap: 5px; cursor: pointer;" onclick="openDocModal(<%= doc.getDocumentId() %>, '<%= safeTypeLabel %>', '<%= safeFileName %>', '<%= statusText %>', '<%= badgeClass %>')">
                                    <span>👁️</span> View
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div style="text-align: center; padding: 30px; background: #f8fafc; border-radius: 8px; border: 1px dashed #cbd5e1; color: #64748b;">
                <p style="margin: 0; font-size: 14px;">No verification documents found for this profile.</p>
            </div>
        <% } %>

        <!-- UPLOAD / RE-UPLOAD FORM -->
        <div style="margin-top: 25px; padding-top: 20px; border-top: 1px dashed #e2e8f0;">
            <h5 style="color: #244b6b; margin: 0 0 12px 0; font-size: 14.5px; font-weight: 600;">Upload or Replace a Verification Document</h5>
            <form action="<%= request.getContextPath() %>/DoctorDocumentUploadServlet" method="POST" enctype="multipart/form-data" style="display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-end;">
                <div style="flex: 1; min-width: 220px;">
                    <label class="form-label" style="font-size: 12px;">Document Type</label>
                    <select name="documentType" id="uploadDocTypeSelect" class="form-control" required style="font-size: 13px;">
                        <option value="MEDICAL_REGISTRATION">Medical Registration Certificate</option>
                        <option value="MBBS_DEGREE">MBBS / Basic Degree Certificate</option>
                        <option value="IDENTITY_PROOF">Identity Proof (Govt ID)</option>
                        <option value="ADDITIONAL_QUALIFICATION">Additional Qualification / MD / MS</option>
                    </select>
                </div>
                <div style="flex: 1.5; min-width: 250px;">
                    <label class="form-label" style="font-size: 12px;">Select File (PDF, JPG, PNG)</label>
                    <input type="file" name="documentFile" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required style="padding: 6px 10px; font-size: 13px;">
                </div>
                <div>
                    <button type="submit" class="btn btn-primary" style="padding: 9px 18px; font-size: 13px; display: inline-flex; align-items: center; gap: 5px;">
                        <span>📤</span> Upload File
                    </button>
                </div>
            </form>
        </div>

    </div>

</main>

<!-- DOCUMENT PREVIEW MODAL -->
<div id="docPreviewModal" class="doc-modal-overlay" onclick="handleModalBackdropClick(event)">
    <div class="doc-modal-container">
        <div class="doc-modal-header">
            <div style="display: flex; align-items: center; gap: 10px;">
                <span style="font-size: 22px;">📄</span>
                <div>
                    <h3 id="modalDocTitle" style="margin: 0; font-size: 16px; color: #1e293b; font-weight: 700;">Document Preview</h3>
                    <div style="font-size: 12px; color: #64748b;" id="modalFileName">file.png</div>
                </div>
            </div>
            <div style="display: flex; align-items: center; gap: 12px;">
                <span id="modalStatusBadge" class="badge badge-pending">Pending Review</span>
                <button type="button" class="doc-modal-close" onclick="closeDocModal()">&times;</button>
            </div>
        </div>

        <div class="doc-modal-body" id="modalDocBody">
            <div style="color: #64748b; font-size: 14px;">Loading document preview...</div>
        </div>

        <div class="doc-modal-footer">
            <div style="font-size: 12px; color: #64748b;">
                Doctor Verification Document
            </div>
            <div style="display: flex; gap: 10px;">
                <a id="modalDownloadBtn" href="#" download class="btn" style="background: #e2e8f0; color: #334155; text-decoration: none; padding: 7px 14px; font-size: 13px; display: inline-flex; align-items: center; gap: 5px;">
                    <span>⬇️</span> Download
                </a>
                <button type="button" class="btn btn-primary" onclick="closeDocModal()" style="padding: 7px 18px; font-size: 13px;">
                    Close
                </button>
            </div>
        </div>
    </div>
</div>

<style>
.doc-modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background: rgba(15, 23, 42, 0.75);
    backdrop-filter: blur(4px);
    z-index: 10000;
    align-items: center;
    justify-content: center;
    padding: 20px;
    box-sizing: border-box;
}
.doc-modal-overlay.active {
    display: flex;
}
.doc-modal-container {
    background: #ffffff;
    border-radius: 12px;
    width: 100%;
    max-width: 900px;
    max-height: 90vh;
    display: flex;
    flex-direction: column;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.35);
    overflow: hidden;
    animation: docModalPop 0.2s cubic-bezier(0.16, 1, 0.3, 1);
}
@keyframes docModalPop {
    from { opacity: 0; transform: scale(0.95) translateY(10px); }
    to { opacity: 1; transform: scale(1) translateY(0); }
}
.doc-modal-header {
    padding: 16px 22px;
    border-bottom: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: #f8fafc;
}
.doc-modal-close {
    background: none;
    border: none;
    font-size: 28px;
    color: #94a3b8;
    cursor: pointer;
    line-height: 1;
    padding: 0 4px;
    transition: color 0.15s ease;
}
.doc-modal-close:hover {
    color: #0f172a;
}
.doc-modal-body {
    padding: 24px;
    overflow-y: auto;
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 400px;
    max-height: 70vh;
    background: #f1f5f9;
}
.doc-modal-body img {
    max-width: 100%;
    max-height: 65vh;
    object-fit: contain;
    border-radius: 8px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.12);
    background: #ffffff;
}
.doc-modal-body iframe {
    width: 100%;
    height: 65vh;
    border: 1px solid #cbd5e1;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    background: #ffffff;
}
.doc-modal-footer {
    padding: 14px 22px;
    border-top: 1px solid #e2e8f0;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #ffffff;
}
</style>

<script>
function openDocModal(docId, docTitle, fileName, statusText, badgeClass) {
    document.getElementById('modalDocTitle').innerText = docTitle;
    document.getElementById('modalFileName').innerText = fileName;

    var badgeElem = document.getElementById('modalStatusBadge');
    badgeElem.className = 'badge ' + badgeClass;
    badgeElem.innerText = statusText;

    var viewUrl = '<%= request.getContextPath() %>/ViewDocumentServlet?id=' + docId;
    document.getElementById('modalDownloadBtn').href = viewUrl;

    var modalBody = document.getElementById('modalDocBody');
    modalBody.innerHTML = '<div style="color: #64748b; font-size: 14px; display:flex; align-items:center; gap:8px;"><span>⏳</span> Loading document...</div>';

    var lower = (fileName || '').toLowerCase();
    var isPdf = lower.endsWith('.pdf');

    if (isPdf) {
        modalBody.innerHTML = '<iframe src="' + viewUrl + '" title="' + docTitle + '"></iframe>';
    } else {
        var img = new Image();
        img.src = viewUrl;
        img.alt = docTitle;
        img.onload = function() {
            modalBody.innerHTML = '';
            modalBody.appendChild(img);
        };
        img.onerror = function() {
            modalBody.innerHTML = '<div style="text-align:center; padding:30px; background:#fff; border-radius:10px; border:1px dashed #cbd5e1; max-width:480px; box-shadow:0 4px 12px rgba(0,0,0,0.05);">' +
                '<span style="font-size:38px;">⚠️</span>' +
                '<h4 style="margin:10px 0 6px 0; color:#1e293b; font-size:16px;">Physical File Not Found on Disk</h4>' +
                '<p style="color:#64748b; font-size:13px; line-height:1.5; margin:0 0 16px 0;">This document was uploaded previously, but the temporary local server file was cleared during NetBeans Clean & Build.<br>You can re-upload this document using the form on the profile page.</p>' +
                '<button type="button" class="btn btn-primary" onclick="closeDocModal(); document.getElementById(\'uploadDocTypeSelect\').scrollIntoView({behavior:\'smooth\'});" style="font-size:13px; padding:7px 16px;">Go to Upload Form</button>' +
                '</div>';
        };
    }

    document.getElementById('docPreviewModal').classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeDocModal() {
    document.getElementById('docPreviewModal').classList.remove('active');
    document.getElementById('modalDocBody').innerHTML = '';
    document.body.style.overflow = '';
}

function handleModalBackdropClick(e) {
    if (e.target && e.target.id === 'docPreviewModal') {
        closeDocModal();
    }
}

document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        closeDocModal();
    }
});
</script>

</body>
</html>
