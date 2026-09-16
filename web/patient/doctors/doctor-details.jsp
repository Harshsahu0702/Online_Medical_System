<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Doctor Details");
    request.setAttribute(
        "pageDescription",
        "Review doctor information, consultation details, and availability."
    );
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

            <div class="doctor-details-layout">

                <section class="card doctor-profile-card">

                    <div class="card-body">

                        <div class="doctor-profile-header">

                            <div class="doctor-profile-img">
                                SJ
                            </div>

                            <div class="doctor-profile-info">

                                <h2>
                                    Dr. Sarah Jenkins, MD
                                </h2>

                                <div class="doctor-spec">
                                    Cardiology
                                </div>

                                <div class="doctor-hospital">
                                    Metro Heart Institute
                                </div>

                                <div class="doctor-rating">
                                    ★ 4.9 (128 reviews)
                                </div>

                            </div>

                        </div>

                        <div class="doctor-profile-meta">

                            <div>
                                <span>Experience</span>
                                <strong>12 Years</strong>
                            </div>

                            <div>
                                <span>Consultation Fee</span>
                                <strong>$60</strong>
                            </div>

                            <div>
                                <span>Consultation</span>
                                <strong>In-person &amp; Video</strong>
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
                            Dr. Sarah Jenkins is a board-certified cardiologist
                            with over 12 years of clinical experience. She
                            specializes in preventive cardiology, hypertension,
                            and cardiovascular health.
                        </p>

                    </div>

                </section>


                <section class="card">

                    <div class="card-body">

                        <h3 class="section-title">
                            Areas of Expertise
                        </h3>

                        <div class="doctor-specialty-tags">

                            <span class="badge">
                                Preventive Cardiology
                            </span>

                            <span class="badge">
                                Hypertension
                            </span>

                            <span class="badge">
                                Heart Health
                            </span>

                            <span class="badge">
                                Cardiovascular Disease
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

                            <div class="availability-day">

                                <div>
                                    <strong>Today</strong>
                                    <span>Available</span>
                                </div>

                                <div class="availability-time">
                                    10:00 AM - 4:00 PM
                                </div>

                            </div>

                            <div class="availability-day">

                                <div>
                                    <strong>Tomorrow</strong>
                                    <span>Available</span>
                                </div>

                                <div class="availability-time">
                                    9:00 AM - 2:00 PM
                                </div>

                            </div>

                            <div class="availability-day">

                                <div>
                                    <strong>Friday</strong>
                                    <span>Available</span>
                                </div>

                                <div class="availability-time">
                                    11:00 AM - 5:00 PM
                                </div>

                            </div>

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
                                    <span>Metro Heart Institute</span>
                                </div>

                                <strong>$60</strong>

                            </div>

                            <div class="consultation-option">

                                <div>
                                    <strong>Video Consultation</strong>
                                    <span>Online appointment</span>
                                </div>

                                <strong>$60</strong>

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

                        <a
                            href="${pageContext.request.contextPath}/patient/appointments/book-appointment.jsp?doctorId=1"
                            class="btn btn-primary">
                            Book Appointment
                        </a>

                    </div>

                </section>

            </div>

        </main>

        <jsp:include page="../components/footer.jsp" />

    </div>

</div>

<script src="${pageContext.request.contextPath}/patient/js/patient-common.js"></script>
<script src="${pageContext.request.contextPath}/patient/js/doctors.js"></script>

</body>
</html>