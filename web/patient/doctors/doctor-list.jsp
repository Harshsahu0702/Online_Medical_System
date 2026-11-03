<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.ArrayList" %>
        <%@ page import="java.util.List" %>
            <%@ page import="java.util.Map" %>
                <%@ page import="java.util.LinkedHashMap" %>
                    <%@ page import="patient.model.DoctorAvailability" %>

                        <%! // Helper method for initials (e.g., "Harsh sahu" -> "HS")
                            public String getInitials(String name) {
                            if (name == null || name.trim().isEmpty()) return "DR";
                            String clean = name.trim().replaceFirst("(?i)^dr\\.?\\s*", "");
                            String[] parts = clean.split("\\s+");
                            if (parts.length >= 2 && !parts[0].isEmpty() && !parts[1].isEmpty()) {
                            return ("" + parts[0].charAt(0) + parts[1].charAt(0)).toUpperCase();
                            } else if (clean.length() > 0) {
                            return clean.substring(0, Math.min(2, clean.length())).toUpperCase();
                            }
                            return "DR";
                            }

                            // Helper method for 12-hour AM/PM time formatting
                            public String formatTime(String timeStr) {
                            if (timeStr == null || timeStr.trim().isEmpty()) return "--:--";
                            try {
                            java.text.SimpleDateFormat sdf24 = new java.text.SimpleDateFormat("HH:mm:ss");
                            java.text.SimpleDateFormat sdf12 = new java.text.SimpleDateFormat("hh:mm a");
                            return sdf12.format(sdf24.parse(timeStr.trim()));
                            } catch(Exception e) {
                            try {
                            java.text.SimpleDateFormat sdf24Short = new java.text.SimpleDateFormat("HH:mm");
                            java.text.SimpleDateFormat sdf12 = new java.text.SimpleDateFormat("hh:mm a");
                            return sdf12.format(sdf24Short.parse(timeStr.trim()));
                            } catch(Exception e2) {
                            return timeStr;
                            }
                            }
                            }
                            %>

<% 
    ArrayList<DoctorAvailability> doctorList = (ArrayList<DoctorAvailability>) request.getAttribute("doctorList");

    // Grouping slots by doctor so each doctor card appears once with all days and timings combined
    Map<String, List<DoctorAvailability>> groupedDoctors = new LinkedHashMap<String, List<DoctorAvailability>>();
    if (doctorList != null) {
                                            for (DoctorAvailability da : doctorList) {
                                            String key = (da.getDoctorName() != null ? da.getDoctorName().trim() :
                                            "Doctor")
                                            + "___"
                                            + (da.getClinicName() != null ? da.getClinicName().trim() : "");
                                            if (!groupedDoctors.containsKey(key)) {
                                            groupedDoctors.put(key, new ArrayList<DoctorAvailability>());
                                                }
                                                groupedDoctors.get(key).add(da);
                                                }
                                                }
                                                %>

                                                <!-- Doctor Grid Container -->
                                                <div class="doctor-grid doc-results-grid" id="doctorGridContainer"
                                                    aria-label="Doctor list">
                                                    <% if (!groupedDoctors.isEmpty()) { for (Map.Entry<String,
                                                        List<DoctorAvailability>> entry : groupedDoctors.entrySet()) {
                                                        List<DoctorAvailability> slots = entry.getValue();
                                                            DoctorAvailability doctor = slots.get(0);

                                                            String rawName = doctor.getDoctorName();
                                                            String displayName = (rawName != null &&
                                                            !rawName.trim().isEmpty())
                                                            ? (rawName.trim().toLowerCase().startsWith("dr") ?
                                                            rawName.trim() : "Dr. " + rawName.trim())
                                                            : "Dr. Specialist";

                                                            String initials = getInitials(displayName);
                                                            String spec = (doctor.getSpecialization() != null &&
                                                            !doctor.getSpecialization().trim().isEmpty())
                                                            ? doctor.getSpecialization().trim()
                                                            : "General";

                                                            String clinic = (doctor.getClinicName() != null &&
                                                            !doctor.getClinicName().trim().isEmpty())
                                                            ? doctor.getClinicName().trim()
                                                            : "Medical Center";

                                                            int exp = doctor.getDoctorExperience();
                                                            String qual = (doctor.getDoctorQualification() != null &&
                                                            !doctor.getDoctorQualification().trim().isEmpty())
                                                            ? doctor.getDoctorQualification().trim()
                                                            : "MBBS";

                                                            float fee = doctor.getConsultationFee();
                                                            String feeDisplay = fee > 0 ? ("₹ " + ((fee == (long)fee) ?
                                                            String.format("%d", (long)fee) : String.format("%.2f",
                                                            fee))) : "Free";
                                                            %>
                                                            <article class="doctor-card doc-unified-card">
                                                                <!-- 1. TOP BLOCK: Doctor Identity, Clinic & Credentials -->
                                                                <div class="doc-card-top-section">
                                                                    <div class="doc-header-row">
                                                                        <div class="doc-avatar-box">
                                                                            <span class="doc-avatar-text">
                                                                                <%= initials %>
                                                                            </span>
                                                                            <span class="doc-live-dot"
                                                                                title="Available"></span>
                                                                        </div>
                                                                        <div class="doc-main-details">
                                                                            <div class="doc-title-row">
                                                                                <h3 class="doc-doctor-name">
                                                                                    <%= displayName %>
                                                                                </h3>
                                                                                <span
                                                                                    class="doctor-spec doc-specialty-pill">
                                                                                    <%= spec %> · <%= clinic %>
                                                                                </span>
                                                                            </div>
                                                                            <div class="doc-sub-credentials">
                                                                                <span class="doc-meta-item">Experience:
                                                                                    <strong>
                                                                                        <%= exp %> yrs
                                                                                    </strong></span>
                                                                                <span class="doc-divider">|</span>
                                                                                <span class="doc-meta-item">Degree:
                                                                                    <strong>
                                                                                        <%= qual %>
                                                                                    </strong></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- 2. MIDDLE BLOCK: Schedule & Consultation Slots Table -->
                                                                <div class="doc-slots-section">
                                                                    <div class="doc-slots-header">
                                                                        <span>SCHEDULE &amp; CONSULTATION SLOTS:</span>
                                                                    </div>

                                                                    <div class="doc-slots-list">
                                                                        <% for (DoctorAvailability slot : slots) {
                                                                            String day=slot.getDay() !=null ?
                                                                            slot.getDay() : "Available" ; String
                                                                            timeFormatted=formatTime(slot.getStartTime())
                                                                            + " – " + formatTime(slot.getEndTime());
                                                                            String type=slot.getConsultationType()
                                                                            !=null ? slot.getConsultationType() : "Both"
                                                                            ; String typeClass="type-both" ; if
                                                                            (type.equalsIgnoreCase("online")) {
                                                                            typeClass="type-online" ; } else if
                                                                            (type.equalsIgnoreCase("offline") ||
                                                                            type.equalsIgnoreCase("in-person")) {
                                                                            typeClass="type-offline" ; } %>
                                                                            <div class="doc-slot-row">
                                                                                <!-- Column 1: Day -->
                                                                                <div class="slot-col slot-day">
                                                                                    <svg width="13" height="13"
                                                                                        viewBox="0 0 24 24" fill="none"
                                                                                        stroke="currentColor"
                                                                                        stroke-width="2"
                                                                                        stroke-linecap="round"
                                                                                        stroke-linejoin="round">
                                                                                        <rect width="18" height="18"
                                                                                            x="3" y="4" rx="2" ry="2" />
                                                                                        <line x1="16" x2="16" y1="2"
                                                                                            y2="6" />
                                                                                        <line x1="8" x2="8" y1="2"
                                                                                            y2="6" />
                                                                                        <line x1="3" x2="21" y1="10"
                                                                                            y2="10" />
                                                                                    </svg>
                                                                                    <strong>
                                                                                        <%= day %>
                                                                                    </strong>
                                                                                </div>

                                                                                <!-- Column 2: Timings -->
                                                                                <div class="slot-col slot-time">
                                                                                    <svg width="13" height="13"
                                                                                        viewBox="0 0 24 24" fill="none"
                                                                                        stroke="currentColor"
                                                                                        stroke-width="2"
                                                                                        stroke-linecap="round"
                                                                                        stroke-linejoin="round">
                                                                                        <circle cx="12" cy="12"
                                                                                            r="10" />
                                                                                        <polyline
                                                                                            points="12 6 12 12 16 14" />
                                                                                    </svg>
                                                                                    <span>
                                                                                        <%= timeFormatted %>
                                                                                    </span>
                                                                                </div>

                                                                                <!-- Column 3: Consultation Type -->
                                                                                <div class="slot-col slot-type">
                                                                                    <span
                                                                                        class="slot-type-badge <%= typeClass %>">
                                                                                        <%= type %>
                                                                                    </span>
                                                                                </div>

                                                                                <!-- Column 4: Apply / Book Slot Button -->
                                                                                <div class="slot-col slot-action">
                                                                                    <a href="${pageContext.request.contextPath}/patient/book-slot?availabilityId=<%= slot.getAvailabilityId() %>"
                                                                                        class="btn-slot-book">
                                                                                        Book <%= day %> &rarr;
                                                                                    </a>
                                                                                </div>
                                                                            </div>
                                                                            <% } %>
                                                                    </div>
                                                                </div>

                                                                <!-- 3. BOTTOM BLOCK: Consult Fee & Profile Link -->
                                                                <div class="doc-card-bottom-bar">
                                                                    <div class="doc-fee-box">
                                                                        <span class="doc-fee-caption">Consult
                                                                            Fee:</span>
                                                                        <span class="doc-fee-value">
                                                                            <%= feeDisplay %>
                                                                        </span>
                                                                    </div>
                                                                    <a href="${pageContext.request.contextPath}/patient/doctor-details?doctorId=<%= doctor.getDoctorId() %>"
                                                                        class="btn btn-secondary doc-profile-link">
                                                                        View Full Profile &rarr;
                                                                    </a>
                                                                </div>
                                                            </article>
                                                            <% } } else { %>
                                                                <div class="doc-empty-box">
                                                                    <svg width="36" height="36" viewBox="0 0 24 24"
                                                                        fill="none" stroke="currentColor"
                                                                        stroke-width="2" stroke-linecap="round"
                                                                        stroke-linejoin="round">
                                                                        <circle cx="12" cy="12" r="10" />
                                                                        <line x1="12" y1="8" x2="12" y2="12" />
                                                                        <line x1="12" y1="16" x2="12.01" y2="16" />
                                                                    </svg>
                                                                    <h3>No Available Specialists Found</h3>
                                                                    <p>No doctors matched your selection. Try adjusting
                                                                        your search term, specialty, or day filter.</p>
                                                                </div>
                                                                <% } %>
                                                </div>