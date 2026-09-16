<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Book Appointment");
    request.setAttribute("pageDescription", "Choose a doctor, date, time, and consultation type.");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Book Appointment</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/appointments.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="../components/sidebar.jsp" />
    <div class="app-main">
        <jsp:include page="../components/navbar.jsp" />
        <main class="page-container">
            <jsp:include page="../components/patient-header.jsp" />

            <section class="card appointment-booking-card">
                <div class="card-body">
                    <form id="appointmentBookingForm" class="appointment-form" action="${pageContext.request.contextPath}/bookAppointment" method="post">
                        <div class="form-section">
                            <h2 class="section-title">Doctor Information</h2>
                            <div class="form-group">
                                <label class="form-label" for="doctorId">Select Doctor</label>
                                <select class="form-control" id="doctorId" name="doctorId" required>
                                    <option value="">Choose a doctor</option>
                                    <option value="1">Dr. Sarah Jenkins, MD - Cardiology</option>
                                    <option value="2">Dr. Michael Chang, MD - Dermatology</option>
                                    <option value="3">Dr. Rachel Patel, MD - Neurology</option>
                                    <option value="4">Dr. Marcus Bell, MD - General Medicine</option>
                                    <option value="5">Dr. Sophia Rivera, MD - Pediatrics</option>
                                    <option value="6">Dr. David Kim, MD - Orthopedics</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-section">
                            <h2 class="section-title">Appointment Details</h2>
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="appointmentDate">Date</label>
                                    <input type="date" class="form-control" id="appointmentDate" name="appointmentDate" required>
                                </div>
                                <div class="form-group">
                                    <label class="form-label" for="appointmentTime">Time</label>
                                    <select class="form-control" id="appointmentTime" name="appointmentTime" required>
                                        <option value="">Select a time</option>
                                        <option value="09:00">09:00 AM</option>
                                        <option value="10:00">10:00 AM</option>
                                        <option value="11:00">11:00 AM</option>
                                        <option value="12:00">12:00 PM</option>
                                        <option value="14:00">02:00 PM</option>
                                        <option value="15:00">03:00 PM</option>
                                        <option value="16:00">04:00 PM</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="consultationType">Consultation Type</label>
                                <select class="form-control" id="consultationType" name="consultationType" required>
                                    <option value="">Choose consultation type</option>
                                    <option value="IN_PERSON">In-person Visit</option>
                                    <option value="VIDEO">Video Consultation</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="appointmentReason">Reason for Visit</label>
                                <textarea class="form-control" id="appointmentReason" name="appointmentReason" rows="4" placeholder="Briefly describe the reason for your consultation..." maxlength="500"></textarea>
                            </div>
                        </div>

                        <div class="appointment-form-actions">
                            <a href="${pageContext.request.contextPath}/patient/appointments/appointments.jsp" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Confirm Appointment</button>
                        </div>
                    </form>
                </div>
            </section>
        </main>
        <jsp:include page="../components/footer.jsp" />
    </div>
</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/appointments.js"></script>
</body>
</html>