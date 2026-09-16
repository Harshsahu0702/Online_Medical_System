<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Dashboard");
    request.setAttribute(
        "pageDescription",
        "Overview of your healthcare activity, appointments, medications, and health information."
    );
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>MediCore | Patient Dashboard</title>

    <!-- Common Patient Styles -->
    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/patient/css/patient-common.css">

    <!-- Dashboard Styles -->
    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/patient/css/dashboard.css">

</head>


<body>

    <!-- ================================================================
         APPLICATION LAYOUT
         ================================================================ -->

    <div class="app-layout">


        <!-- ============================================================
             SIDEBAR COMPONENT
             ============================================================ -->

        <jsp:include page="components/sidebar.jsp" />


        <!-- ============================================================
             MAIN APPLICATION AREA
             ============================================================ -->

        <div class="app-main">


            <!-- ========================================================
                 NAVBAR COMPONENT
                 ======================================================== -->

            <jsp:include page="components/navbar.jsp" />


            <!-- ========================================================
                 DASHBOARD CONTENT
                 ======================================================== -->

            <main class="page-container">


                <!-- ====================================================
                     PAGE HEADER
                     ==================================================== -->

                <jsp:include page="components/patient-header.jsp" />


                <!-- ====================================================
                     WELCOME BANNER
                     ==================================================== -->

                <section class="dash-welcome-banner">

                    <div class="dash-welcome-text">

                        <h2>
                            Good morning, Eleanor 👋
                        </h2>

                        <p>
                            Your blood pressure reading from yesterday is
                            steady. You have an upcoming cardiologist
                            consultation tomorrow at 10:30 AM.
                        </p>

                    </div>


                    <div class="dash-welcome-actions">

                        <a
                            href="${pageContext.request.contextPath}/patient/appointments/book-appointment.jsp"
                            class="btn btn-secondary dash-book-btn">

                            <svg
                                class="icon icon-sm"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <path d="M12 5v14"/>
                                <path d="M5 12h14"/>

                            </svg>

                            Book Appointment

                        </a>

                    </div>

                </section>


                <!-- ====================================================
                     KEY VITALS
                     ==================================================== -->

                <section
                    class="vitals-grid"
                    aria-label="Key health vitals">


                    <!-- Blood Pressure -->

                    <div class="vital-card">

                        <div class="vital-icon-box vital-blood-pressure">

                            <svg
                                class="icon"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/>

                            </svg>

                        </div>

                        <div>

                            <div class="vital-value">
                                118/78
                                <span>mmHg</span>
                            </div>

                            <div class="vital-label">
                                Blood Pressure (Normal)
                            </div>

                        </div>

                    </div>


                    <!-- Heart Rate -->

                    <div class="vital-card">

                        <div class="vital-icon-box vital-heart-rate">

                            <svg
                                class="icon"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <path d="M22 12h-4l-3 9L9 3l-3 9H2"/>

                            </svg>

                        </div>

                        <div>

                            <div class="vital-value">
                                72
                                <span>bpm</span>
                            </div>

                            <div class="vital-label">
                                Resting Heart Rate
                            </div>

                        </div>

                    </div>


                    <!-- Glucose -->

                    <div class="vital-card">

                        <div class="vital-icon-box vital-glucose">

                            <svg
                                class="icon"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <path d="m12 3-1.9 5.8a2 2 0 0 1-1.3 1.3L3 12l5.8 1.9a2 2 0 0 1 1.3 1.3L12 21l1.9-5.8a2 2 0 0 1 1.3-1.3L21 12l-5.8-1.9a2 2 0 0 1-1.3-1.3z"/>

                            </svg>

                        </div>

                        <div>

                            <div class="vital-value">
                                98
                                <span>mg/dL</span>
                            </div>

                            <div class="vital-label">
                                Glucose (Fasting)
                            </div>

                        </div>

                    </div>


                    <!-- Fourth Vital -->

                    <div class="vital-card">

                        <div class="vital-icon-box vital-general">

                            <svg
                                class="icon"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <circle
                                    cx="12"
                                    cy="12"
                                    r="9"/>

                                <path d="M12 8v4"/>
                                <path d="M12 16h.01"/>

                            </svg>

                        </div>

                        <div>

                            <div class="vital-value">
                                —
                            </div>

                            <div class="vital-label">
                                Latest Health Reading
                            </div>

                        </div>

                    </div>

                </section>


                <!-- ====================================================
                     QUICK ACTIONS
                     ==================================================== -->

                <section
                    class="quick-actions-bar"
                    aria-label="Quick actions">


                    <!-- Check Symptoms -->

                    <a
                        href="${pageContext.request.contextPath}/patient/medical-assistant/medical-assistant.jsp"
                        class="quick-action-btn">

                        <div class="quick-action-icon quick-action-assistant">

                            <svg
                                class="icon"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <path d="m12 3-1.9 5.8a2 2 0 0 1-1.3 1.3L3 12l5.8 1.9a2 2 0 0 1 1.3 1.3L12 21l1.9-5.8a2 2 0 0 1 1.3-1.3L21 12l-5.8-1.9a2 2 0 0 1-1.3-1.3z"/>

                            </svg>

                        </div>

                        <span>
                            Check Symptoms
                        </span>

                    </a>


                    <!-- Find Specialists -->

                    <a
                        href="${pageContext.request.contextPath}/patient/doctors/find-doctor.jsp"
                        class="quick-action-btn">

                        <div class="quick-action-icon quick-action-doctors">

                            <svg
                                class="icon"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                                <circle cx="9" cy="7" r="4"/>

                            </svg>

                        </div>

                        <span>
                            Find Specialists
                        </span>

                    </a>


                    <!-- Order Medicine -->

                    <a
                        href="${pageContext.request.contextPath}/patient/medicines/medicines.jsp"
                        class="quick-action-btn">

                        <div class="quick-action-icon quick-action-medicines">

                            <svg
                                class="icon"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"/>

                            </svg>

                        </div>

                        <span>
                            Order Medicine
                        </span>

                    </a>


                    <!-- Emergency -->

                    <a
                        href="${pageContext.request.contextPath}/patient/emergency/emergency.jsp"
                        class="quick-action-btn">

                        <div class="quick-action-icon quick-action-emergency">

                            <svg
                                class="icon"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>

                            </svg>

                        </div>

                        <span>
                            Emergency Center
                        </span>

                    </a>

                </section>


                <!-- ====================================================
                     MAIN DASHBOARD GRID
                     ==================================================== -->

                <section class="dash-main-grid">


                    <!-- ==================================================
                         LEFT COLUMN
                         ================================================== -->

                    <div class="dash-column">


                        <!-- Upcoming Consultation -->

                        <article class="card">

                            <div class="card-header">

                                <div class="card-title">

                                    <svg
                                        class="icon"
                                        viewBox="0 0 24 24"
                                        aria-hidden="true">

                                        <rect
                                            width="18"
                                            height="18"
                                            x="3"
                                            y="4"
                                            rx="2"/>

                                        <path d="M16 2v4"/>
                                        <path d="M8 2v4"/>
                                        <path d="M3 10h18"/>

                                    </svg>

                                    Upcoming Consultation

                                </div>


                                <a
                                    href="${pageContext.request.contextPath}/patient/appointments/appointments.jsp"
                                    class="btn btn-sm btn-secondary">

                                    View All

                                </a>

                            </div>


                            <div class="card-body">

                                <div class="appointment-preview">

                                    <div class="appointment-date">

                                        <strong>
                                            24
                                        </strong>

                                        <span>
                                            OCT
                                        </span>

                                    </div>


                                    <div class="appointment-info">

                                        <h3>
                                            Dr. Sarah Jenkins, MD
                                        </h3>

                                        <p>
                                            Cardiology Specialist
                                        </p>

                                        <span class="badge badge-info">
                                            Tomorrow at 10:30 AM
                                        </span>

                                        <span class="badge badge-neutral">
                                            Video Consultation
                                        </span>

                                    </div>


                                    <div class="appointment-actions">

                                        <a
                                            href="${pageContext.request.contextPath}/patient/appointments/book-appointment.jsp"
                                            class="btn btn-sm btn-secondary">

                                            Reschedule

                                        </a>

                                        <button
                                            type="button"
                                            class="btn btn-sm btn-primary"
                                            id="joinConsultationBtn">

                                            Join Call

                                        </button>

                                    </div>

                                </div>

                            </div>

                        </article>


                        <!-- Active Prescriptions -->

                        <article class="card">

                            <div class="card-header">

                                <div class="card-title">

                                    <svg
                                        class="icon"
                                        viewBox="0 0 24 24"
                                        aria-hidden="true">

                                        <path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 0 0 7 7Z"/>

                                    </svg>

                                    Active Prescriptions & Adherence

                                </div>


                                <a
                                    href="${pageContext.request.contextPath}/patient/prescriptions/prescriptions.jsp"
                                    class="btn btn-sm btn-secondary">

                                    Prescription List

                                </a>

                            </div>


                            <div class="card-body card-body-no-padding">

                                <div class="table-responsive">

                                    <table class="data-table">

                                        <thead>

                                            <tr>

                                                <th>
                                                    Medication
                                                </th>

                                                <th>
                                                    Dosage
                                                </th>

                                                <th>
                                                    Frequency
                                                </th>

                                                <th>
                                                    Refill Status
                                                </th>

                                            </tr>

                                        </thead>


                                        <tbody>

                                            <tr>

                                                <td>

                                                    <strong>
                                                        Atorvastatin
                                                    </strong>

                                                    <span class="table-secondary-text">
                                                        For Cholesterol
                                                    </span>

                                                </td>

                                                <td>
                                                    20 mg
                                                </td>

                                                <td>
                                                    1 tablet at bedtime
                                                </td>

                                                <td>

                                                    <span class="badge badge-success">
                                                        14 Days Left
                                                    </span>

                                                </td>

                                            </tr>


                                            <tr>

                                                <td>

                                                    <strong>
                                                        Lisinopril
                                                    </strong>

                                                    <span class="table-secondary-text">
                                                        For Blood Pressure
                                                    </span>

                                                </td>

                                                <td>
                                                    10 mg
                                                </td>

                                                <td>
                                                    1 tablet morning
                                                </td>

                                                <td>

                                                    <span class="badge badge-warning">
                                                        Refill Due (3d)
                                                    </span>

                                                </td>

                                            </tr>

                                        </tbody>

                                    </table>

                                </div>

                            </div>

                        </article>

                    </div>


                    <!-- ==================================================
                         RIGHT COLUMN
                         ================================================== -->

                    <div class="dash-column">


                        <!-- Medical Snapshot -->

                        <article class="card">

                            <div class="card-header">

                                <div class="card-title">

                                    <svg
                                        class="icon"
                                        viewBox="0 0 24 24"
                                        aria-hidden="true">

                                        <circle
                                            cx="12"
                                            cy="12"
                                            r="10"/>

                                        <path d="M12 16v-4"/>
                                        <path d="M12 8h.01"/>

                                    </svg>

                                    Medical Snapshot

                                </div>

                            </div>


                            <div class="card-body snapshot-list">


                                <div class="snapshot-item">

                                    <span>
                                        Blood Group:
                                    </span>

                                    <strong>
                                        O Positive (O+)
                                    </strong>

                                </div>


                                <div class="snapshot-item">

                                    <span>
                                        Known Allergies:
                                    </span>

                                    <strong class="text-danger">
                                        Penicillin, Peanuts
                                    </strong>

                                </div>


                                <div class="snapshot-item">

                                    <span>
                                        Primary Physician:
                                    </span>

                                    <strong>
                                        Dr. Marcus Bell
                                    </strong>

                                </div>


                                <div class="snapshot-item">

                                    <span>
                                        Insurance ID:
                                    </span>

                                    <strong>
                                        BCBS-992140
                                    </strong>

                                </div>

                            </div>

                        </article>


                        <!-- Recent Activity -->

                        <article class="card">

                            <div class="card-header">

                                <div class="card-title">
                                    Recent Activity
                                </div>

                            </div>


                            <div class="card-body recent-activity-list">


                                <div class="activity-item">

                                    <span class="activity-dot activity-primary"></span>

                                    <div>

                                        <strong>
                                            Lab Report Uploaded:
                                        </strong>

                                        Comprehensive Blood Panel is ready.

                                        <span class="activity-time">
                                            Yesterday, 4:15 PM
                                        </span>

                                    </div>

                                </div>


                                <div class="activity-item">

                                    <span class="activity-dot activity-success"></span>

                                    <div>

                                        <strong>
                                            Pharmacy Order #8491:
                                        </strong>

                                        Delivered to your address.

                                        <span class="activity-time">
                                            Oct 21, 2026
                                        </span>

                                    </div>

                                </div>

                            </div>

                        </article>

                    </div>

                </section>

            </main>


            <!-- ========================================================
                 FOOTER COMPONENT
                 ======================================================== -->

            <jsp:include page="components/footer.jsp" />

        </div>

    </div>


    <!-- ================================================================
         DASHBOARD JAVASCRIPT
         ================================================================ -->

    <script
        src="${pageContext.request.contextPath}/patient/js/patient-common.js">
    </script>

    <script
        src="${pageContext.request.contextPath}/patient/js/dashboard.js">
    </script>

</body>

</html>