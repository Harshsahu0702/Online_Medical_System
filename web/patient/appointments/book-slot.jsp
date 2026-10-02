<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="patient.model.BookAppointment" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    BookAppointment slot = (BookAppointment) request.getAttribute("slot");
    if (slot == null) {
        response.sendRedirect(request.getContextPath() + "/patient/find-doctor");
        return;
    }
    request.setAttribute("pageTitle", "Book Slot with " + slot.getDoctorName());
    request.setAttribute("pageDescription", "Choose an appointment date, time, and confirm your booking.");

    // Simple date calculation: start from today and step forward day-by-day until matching the doctor's day
    String slotDay = (slot.getDayOfWeek() != null) ? slot.getDayOfWeek().trim() : "Monday";
    LocalDate appointmentDate = LocalDate.now();
    while (!appointmentDate.getDayOfWeek().toString().equalsIgnoreCase(slotDay)) {
        appointmentDate = appointmentDate.plusDays(1);
    }
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("EEEE, dd MMM yyyy");

    // Extract start and end hour/minute from slot timings (e.g. "09:00:00" to "12:00:00")
    String[] startParts = slot.getStartTime().split(":");
    int startHour = Integer.parseInt(startParts[0].trim());
    int startMin = Integer.parseInt(startParts[1].trim());

    String[] endParts = slot.getEndTime().split(":");
    int endHour = Integer.parseInt(endParts[0].trim());
    int endMin = Integer.parseInt(endParts[1].trim());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Book Slot - <%= slot.getDoctorName() %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/appointments.css">
    <style>
        .slot-booking-container {
            max-width: 820px;
            margin: 0 auto;
        }

        .slot-doc-header-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px 24px;
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            border: 1px solid #bae6fd;
            border-radius: 16px;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 16px;
        }

        .slot-doc-profile {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .slot-doc-avatar {
            width: 58px;
            height: 58px;
            background: #0284c7;
            color: #ffffff;
            font-size: 20px;
            font-weight: 700;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 10px rgba(2, 132, 199, 0.25);
            flex-shrink: 0;
        }

        .slot-doc-info h2 {
            margin: 0 0 4px;
            font-size: 20px;
            color: #0f172a;
            font-weight: 700;
        }

        .slot-doc-meta {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #475569;
            font-size: 13.5px;
            flex-wrap: wrap;
        }

        .slot-doc-badge {
            background: #ffffff;
            color: #0369a1;
            padding: 2px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 600;
            border: 1px solid #7dd3fc;
        }

        .slot-fee-box {
            text-align: right;
        }

        .slot-fee-label {
            font-size: 12px;
            color: #64748b;
            display: block;
        }

        .slot-fee-amount {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
        }

        .slot-shift-banner {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 14px 20px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .shift-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13.5px;
            color: #334155;
        }

        .shift-item svg {
            color: #0284c7;
            flex-shrink: 0;
        }

        .shift-divider {
            color: #cbd5e1;
        }

        @media (max-width: 600px) {
            .slot-doc-header-card {
                flex-direction: column;
                align-items: flex-start;
            }
            .slot-fee-box {
                text-align: left;
            }
        }
    </style>
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <div class="slot-booking-container">
                <!-- 1. Doctor Profile & Specialization Header -->
                <div class="slot-doc-header-card">
                    <div class="slot-doc-profile">
                        <div class="slot-doc-avatar">
                            <% 
                                String docName = slot.getDoctorName();
                                String initials = (docName != null && docName.length() >= 2) ? docName.substring(0, 2).toUpperCase() : "DR";
                            %>
                            <%= initials %>
                        </div>
                        <div class="slot-doc-info">
                            <h2><%= slot.getDoctorName() %></h2>
                            <div class="slot-doc-meta">
                                <span class="slot-doc-badge"><%= slot.getSpecialization() %></span>
                                <span>•</span>
                                <span><%= slot.getClinicName() %></span>
                                <span>•</span>
                                <span><strong><%= slot.getExperience() %> yrs</strong> exp</span>
                            </div>
                        </div>
                    </div>
                    <div class="slot-fee-box">
                        <span class="slot-fee-label">Consultation Fee</span>
                        <span class="slot-fee-amount">
                            <%= slot.getConsultationFee() > 0 ? "₹ " + ((slot.getConsultationFee() == (long)slot.getConsultationFee()) ? String.format("%d", (long)slot.getConsultationFee()) : String.format("%.2f", slot.getConsultationFee())) : "Free" %>
                        </span>
                    </div>
                </div>

                <!-- 2. Shift Info Banner -->
                <div class="slot-shift-banner">
                    <div class="shift-item">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect width="18" height="18" x="3" y="4" rx="2" ry="2"/>
                            <line x1="16" y1="2" x2="16" y2="6"/>
                            <line x1="8" y1="2" x2="8" y2="6"/>
                            <line x1="3" y1="10" x2="21" y2="10"/>
                        </svg>
                        <span>Regular Day: <strong><%= slot.getDayOfWeek() %></strong></span>
                    </div>
                    <span class="shift-divider">|</span>
                    <div class="shift-item">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10"/>
                            <polyline points="12 6 12 12 16 14"/>
                        </svg>
                        <span>Available Timings: <strong><%= slot.getStartTime() %> – <%= slot.getEndTime() %></strong></span>
                    </div>
                    <span class="shift-divider">|</span>
                    <div class="shift-item">
                        <span>Mode: <strong><%= slot.getConsultationType() %></strong></span>
                    </div>
                </div>

                <!-- 3. The Main Booking Form -->
                <section class="card appointment-booking-card">
                    <div class="card-body">
                        <form id="slotBookingForm" class="appointment-form" action="${pageContext.request.contextPath}/patient/book-slot" method="post">
                            <input type="hidden" name="availabilityId" value="<%= slot.getAvailabilityId() %>">
                            <input type="hidden" name="doctorId" value="<%= slot.getDoctorId() %>">

                            <!-- Appointment Date & Time Selection -->
                            <div class="form-section">
                                <h3 class="section-title">Appointment Schedule</h3>
                                
                                <div class="form-row">
                                    <!-- Date Dropdown (Simple loop: Next 6 occurrences of this weekday) -->
                                    <div class="form-group">
                                        <label class="form-label" for="appointmentDate">
                                            Appointment Date <span style="font-weight: normal; color: #64748b; font-size: 13px;">(Upcoming <%= slot.getDayOfWeek() %>s)</span>
                                        </label>
                                        <select class="form-control" id="appointmentDate" name="appointmentDate" required>
                                            <%
                                                LocalDate currDate = appointmentDate;
                                                for (int i = 0; i < 6; i++) {
                                                    String val = currDate.toString();
                                                    String label = currDate.format(dateFormatter);
                                                    String note = (i == 0) ? " (Next Available)" : (" (In " + i + " " + (i == 1 ? "week" : "weeks") + ")");
                                            %>
                                                <option value="<%= val %>"><%= label %><%= note %></option>
                                            <%
                                                    currDate = currDate.plusDays(7);
                                                }
                                            %>
                                        </select>
                                    </div>

                                    <!-- Time Dropdown (Simple loop: Step by 30 mins) -->
                                    <div class="form-group">
                                        <label class="form-label" for="appointmentTime">
                                            Appointment Time <span style="font-weight: normal; color: #64748b; font-size: 13px;">(Every 30 mins)</span>
                                        </label>
                                        <select class="form-control" id="appointmentTime" name="appointmentTime" required>
                                            <%
                                                int h = startHour;
                                                int m = startMin;
                                                while (h < endHour || (h == endHour && m <= endMin)) {
                                                    // Value for database (e.g. 09:00:00, 09:30:00)
                                                    String hourStr = (h < 10) ? ("0" + h) : ("" + h);
                                                    String minStr = (m < 10) ? ("0" + m) : ("" + m);
                                                    String val = hourStr + ":" + minStr + ":00";

                                                    // Label for display (e.g. 9:00 AM, 11:30 AM)
                                                    String ampm = (h >= 12) ? "PM" : "AM";
                                                    int displayH = (h > 12) ? (h - 12) : ((h == 0) ? 12 : h);
                                                    String label = displayH + ":" + minStr + " " + ampm;
                                            %>
                                                <option value="<%= val %>"><%= label %></option>
                                            <%
                                                    // Step by 30 minutes
                                                    m += 30;
                                                    if (m >= 60) {
                                                        h++;
                                                        m = 0;
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Additional Appointment Details -->
                            <div class="form-section">
                                <h3 class="section-title">Consultation Details</h3>

                                <div class="form-group">
                                    <label class="form-label" for="consultationType">Consultation Type</label>
                                    <select class="form-control" id="consultationType" name="consultationType" required>
                                        <%
                                            String slotType = slot.getConsultationType() != null ? slot.getConsultationType().toUpperCase() : "BOTH";
                                            if (slotType.contains("ONLINE") || slotType.contains("BOTH")) {
                                        %>
                                            <option value="ONLINE">Video Consultation (Online)</option>
                                        <%
                                            }
                                            if (slotType.contains("OFFLINE") || slotType.contains("IN-PERSON") || slotType.contains("BOTH")) {
                                        %>
                                            <option value="IN_PERSON">In-person Hospital Visit</option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="appointmentReason">Reason for Visit (Optional)</label>
                                    <textarea class="form-control" id="appointmentReason" name="reason" rows="4" placeholder="Briefly describe your symptoms or reason for consulting the doctor..." maxlength="500"></textarea>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="appointment-form-actions">
                                <a href="${pageContext.request.contextPath}/patient/find-doctor" class="btn btn-secondary">
                                    Cancel
                                </a>
                                <button type="submit" class="btn btn-primary" id="btnConfirmBooking">
                                    Confirm &amp; Book Appointment &rarr;
                                </button>
                            </div>
                        </form>
                    </div>
                </section>
            </div>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
</body>
</html>
