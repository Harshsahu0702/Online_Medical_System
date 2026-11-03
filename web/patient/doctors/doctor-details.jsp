<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="patient.model.Doctor" %>
<%@ page import="patient.model.DoctorAvailability" %>

<%
    request.setAttribute("pageTitle", "Doctor Details");
    request.setAttribute("pageDescription", "Review doctor information, consultation details, and availability.");
    Doctor doctor = (Doctor) request.getAttribute("doctor");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Doctor Details</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/doctors.css">
</head>

<body>

    <div class="app-layout">

        <jsp:include page="../components/sidebar.jsp" />

        <div class="app-main">

            <jsp:include page="../components/navbar.jsp" />

            <main class="page-container">

                <jsp:include page="../components/patient-header.jsp" />

                <% if (doctor == null) { %>
                    <section class="card">
                        <div class="card-body" style="padding: 40px; text-align: center;">
                            <h3>Doctor Not Found</h3>
                            <p>The requested doctor profile could not be retrieved.</p>
                            <br>
                            <a href="${pageContext.request.contextPath}/patient/find-doctor" class="btn btn-primary">Back to Doctors</a>
                        </div>
                    </section>
                <% } else { %>

                <div class="doctor-details-layout">

                    <section class="card doctor-profile-card">

                        <div class="card-body">

                            <div class="doctor-profile-header">

                                <div class="doctor-profile-img">
                                    <%= doctor.getName() != null && !doctor.getName().trim().isEmpty() ? doctor.getName().trim().substring(0, 1).toUpperCase() : "D" %>
                                </div>

                                <div class="doctor-profile-info">

                                    <h2>
                                        <%= doctor.getName() %>
                                    </h2>

                                    <div class="doctor-spec">
                                        <%= doctor.getSpecialization() %>
                                    </div>

                                    <div class="doctor-hospital">
                                        <%= doctor.getClinicName() %>
                                    </div>

                                    <div class="doctor-rating">
                                        ★ 4.9 (128 reviews)
                                    </div>

                                </div>

                            </div>

                            <div class="doctor-profile-meta">

                                <div>
                                    <span>Experience</span>
                                    <strong><%= doctor.getExperience() %> Years</strong>
                                </div>

                                <div>
                                    <span>Consultation Fee</span>
                                    <strong>₹ <%= doctor.getConsultationFee() %></strong>
                                </div>

                                <div>
                                    <span>Consultation</span>
                                    <strong><%= doctor.getConsultationType() %></strong>
                                </div>

                            </div>

                        </div>

                    </section>


                    <section class="card">

                        <div class="card-body">

                            <h3 class="section-title">
                                About the Doctor
                            </h3>

                            <p class="doctor-description">
                                <%= doctor.getBio() != null && !doctor.getBio().trim().isEmpty() ? doctor.getBio() : "No bio available." %>
                            </p>

                        </div>

                    </section>


                    <section class="card">

                        <div class="card-body">

                            <h3 class="section-title">
                                Qualification &amp; Specialization
                            </h3>

                            <div class="doctor-specialty-tags">

                                <span class="badge">
                                    <%= doctor.getQualification() %>
                                </span>

                                <span class="badge">
                                    <%= doctor.getSpecialization() %>
                                </span>

                            </div>

                        </div>

                    </section>


                    <section class="card">

                        <div class="card-body">

                            <h3 class="section-title">
                                Availability
                            </h3>

                            <div class="doctor-availability">

                                <% if (doctor.getAvailabilityList() != null && !doctor.getAvailabilityList().isEmpty()) { 
                                    for (DoctorAvailability da : doctor.getAvailabilityList()) { %>
                                    <div class="availability-day">

                                        <div>
                                            <strong><%= da.getDay() %></strong>
                                            <span><%= da.getConsultationType() %></span>
                                        </div>

                                        <div class="availability-time">
                                            <%= da.getStartTime() %> - <%= da.getEndTime() %>
                                        </div>

                                    </div>
                                <% } } else { %>
                                    <p>No availability schedules listed.</p>
                                <% } %>

                            </div>

                        </div>

                    </section>


                    <section class="card">

                        <div class="card-body">

                            <h3 class="section-title">
                                Consultation Options
                            </h3>

                            <div class="consultation-options">

                                <div class="consultation-option">

                                    <div>
                                        <strong>In-person Visit</strong>
                                        <span><%= doctor.getClinicName() %></span>
                                    </div>

                                    <strong>₹ <%= doctor.getConsultationFee() %></strong>

                                </div>

                                <div class="consultation-option">

                                    <div>
                                        <strong>Video Consultation</strong>
                                        <span>Online appointment</span>
                                    </div>

                                    <strong>₹ <%= doctor.getConsultationFee() %></strong>

                                </div>

                            </div>

                        </div>

                    </section>


                    <section class="card doctor-booking-card">

                        <div class="card-body">

                            <h3 class="section-title">
                                Book an Appointment
                            </h3>

                            <p>
                                Choose a convenient date and consultation
                                type to schedule your visit.
                            </p>

                            <a href="${pageContext.request.contextPath}/patient/find-doctor?searchTerm=<%= doctor.getName() %>&specialty=<%= doctor.getSpecialization() %>"
                                class="btn btn-primary">
                                Book Appointment
                            </a>

                        </div>

                    </section>

                </div>

                <% } %>

            </main>

            <jsp:include page="../components/footer.jsp" />

        </div>

    </div>

    <script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
    <script src="${pageContext.request.contextPath}/patient/js/doctors.js"></script>

</body>

</html>