<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Available Specialists");
    request.setAttribute(
        "pageDescription",
        "Browse available doctors and review their consultation information."
    );
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>MediCore | Doctor List</title>

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/patient/css/patient-common.css">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/patient/css/doctors.css">

</head>


<body>

<div class="app-layout">

    <!-- ================================================================
         SIDEBAR
         ================================================================ -->

    <jsp:include page="../components/sidebar.jsp" />


    <div class="app-main">

        <!-- ============================================================
             NAVBAR
             ============================================================ -->

        <jsp:include page="../components/navbar.jsp" />


        <main class="page-container">

            <!-- ========================================================
                 PAGE HEADER
                 ======================================================== -->

            <jsp:include page="../components/patient-header.jsp" />


            <!-- ========================================================
                 RESULTS HEADER
                 ======================================================== -->

            <section class="doctor-list-toolbar">

                <div>

                    <h2 class="doctor-results-title">
                        Available Specialists
                    </h2>

                    <p
                        class="doctor-results-count"
                        id="doctorResultsCount">

                        6 specialists available

                    </p>

                </div>


                <a
                    href="${pageContext.request.contextPath}/patient/doctors/find-doctor.jsp"
                    class="btn btn-secondary">

                    Refine Search

                </a>

            </section>


            <!-- ========================================================
                 DOCTOR GRID
                 ======================================================== -->

            <section
                class="doctor-grid"
                id="doctorGridContainer"
                aria-label="Doctor list">


                <!-- ====================================================
                     DR. SARAH JENKINS
                     ==================================================== -->

                <article class="doctor-card">

                    <div>

                        <div class="doctor-header">

                            <div class="doctor-img">
                                SJ
                            </div>


                            <div class="doctor-info">

                                <h4>
                                    Dr. Sarah Jenkins, MD
                                </h4>

                                <div class="doctor-spec">
                                    Cardiology
                                </div>

                                <div class="doctor-hospital">
                                    Metro Heart Institute
                                </div>

                            </div>

                        </div>


                        <div class="doctor-meta">

                            <div>

                                <span>
                                    Experience:
                                </span>

                                <strong>
                                    12 yrs
                                </strong>

                            </div>


                            <div>

                                <span>
                                    Rating:
                                </span>

                                <strong class="doctor-rating">
                                    ★ 4.9 (128)
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="doctor-card-footer">

                        <div>

                            <div class="doctor-fee-label">
                                Consult Fee
                            </div>

                            <div class="doctor-fee">
                                $60
                            </div>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/patient/doctors/doctor-details.jsp?doctorId=1"
                            class="btn btn-sm btn-primary">

                            View Profile

                        </a>

                    </div>

                </article>


                <!-- ====================================================
                     DR. MICHAEL CHANG
                     ==================================================== -->

                <article class="doctor-card">

                    <div>

                        <div class="doctor-header">

                            <div class="doctor-img">
                                MC
                            </div>


                            <div class="doctor-info">

                                <h4>
                                    Dr. Michael Chang, MD
                                </h4>

                                <div class="doctor-spec">
                                    Dermatology
                                </div>

                                <div class="doctor-hospital">
                                    Skin &amp; Laser Center
                                </div>

                            </div>

                        </div>


                        <div class="doctor-meta">

                            <div>

                                <span>
                                    Experience:
                                </span>

                                <strong>
                                    9 yrs
                                </strong>

                            </div>


                            <div>

                                <span>
                                    Rating:
                                </span>

                                <strong class="doctor-rating">
                                    ★ 4.8 (94)
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="doctor-card-footer">

                        <div>

                            <div class="doctor-fee-label">
                                Consult Fee
                            </div>

                            <div class="doctor-fee">
                                $50
                            </div>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/patient/doctors/doctor-details.jsp?doctorId=2"
                            class="btn btn-sm btn-primary">

                            View Profile

                        </a>

                    </div>

                </article>


                <!-- ====================================================
                     DR. RACHEL PATEL
                     ==================================================== -->

                <article class="doctor-card">

                    <div>

                        <div class="doctor-header">

                            <div class="doctor-img">
                                RP
                            </div>


                            <div class="doctor-info">

                                <h4>
                                    Dr. Rachel Patel, MD
                                </h4>

                                <div class="doctor-spec">
                                    Neurology
                                </div>

                                <div class="doctor-hospital">
                                    St. Jude Neuroscience
                                </div>

                            </div>

                        </div>


                        <div class="doctor-meta">

                            <div>

                                <span>
                                    Experience:
                                </span>

                                <strong>
                                    15 yrs
                                </strong>

                            </div>


                            <div>

                                <span>
                                    Rating:
                                </span>

                                <strong class="doctor-rating">
                                    ★ 5.0 (160)
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="doctor-card-footer">

                        <div>

                            <div class="doctor-fee-label">
                                Consult Fee
                            </div>

                            <div class="doctor-fee">
                                $75
                            </div>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/patient/doctors/doctor-details.jsp?doctorId=3"
                            class="btn btn-sm btn-primary">

                            View Profile

                        </a>

                    </div>

                </article>


                <!-- ====================================================
                     DR. MARCUS BELL
                     ==================================================== -->

                <article class="doctor-card">

                    <div>

                        <div class="doctor-header">

                            <div class="doctor-img">
                                MB
                            </div>


                            <div class="doctor-info">

                                <h4>
                                    Dr. Marcus Bell, MD
                                </h4>

                                <div class="doctor-spec">
                                    General Medicine
                                </div>

                                <div class="doctor-hospital">
                                    Springfield Community Clinic
                                </div>

                            </div>

                        </div>


                        <div class="doctor-meta">

                            <div>

                                <span>
                                    Experience:
                                </span>

                                <strong>
                                    14 yrs
                                </strong>

                            </div>


                            <div>

                                <span>
                                    Rating:
                                </span>

                                <strong class="doctor-rating">
                                    ★ 4.7 (210)
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="doctor-card-footer">

                        <div>

                            <div class="doctor-fee-label">
                                Consult Fee
                            </div>

                            <div class="doctor-fee">
                                $40
                            </div>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/patient/doctors/doctor-details.jsp?doctorId=4"
                            class="btn btn-sm btn-primary">

                            View Profile

                        </a>

                    </div>

                </article>


                <!-- ====================================================
                     DR. SOPHIA RIVERA
                     ==================================================== -->

                <article class="doctor-card">

                    <div>

                        <div class="doctor-header">

                            <div class="doctor-img">
                                SR
                            </div>


                            <div class="doctor-info">

                                <h4>
                                    Dr. Sophia Rivera, MD
                                </h4>

                                <div class="doctor-spec">
                                    Pediatrics
                                </div>

                                <div class="doctor-hospital">
                                    Children's Health Pavilion
                                </div>

                            </div>

                        </div>


                        <div class="doctor-meta">

                            <div>

                                <span>
                                    Experience:
                                </span>

                                <strong>
                                    8 yrs
                                </strong>

                            </div>


                            <div>

                                <span>
                                    Rating:
                                </span>

                                <strong class="doctor-rating">
                                    ★ 4.9 (88)
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="doctor-card-footer">

                        <div>

                            <div class="doctor-fee-label">
                                Consult Fee
                            </div>

                            <div class="doctor-fee">
                                $45
                            </div>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/patient/doctors/doctor-details.jsp?doctorId=5"
                            class="btn btn-sm btn-primary">

                            View Profile

                        </a>

                    </div>

                </article>


                <!-- ====================================================
                     DR. DAVID KIM
                     ==================================================== -->

                <article class="doctor-card">

                    <div>

                        <div class="doctor-header">

                            <div class="doctor-img">
                                DK
                            </div>


                            <div class="doctor-info">

                                <h4>
                                    Dr. David Kim, MD
                                </h4>

                                <div class="doctor-spec">
                                    Orthopedics
                                </div>

                                <div class="doctor-hospital">
                                    Joint &amp; Spine Specialty Clinic
                                </div>

                            </div>

                        </div>


                        <div class="doctor-meta">

                            <div>

                                <span>
                                    Experience:
                                </span>

                                <strong>
                                    11 yrs
                                </strong>

                            </div>


                            <div>

                                <span>
                                    Rating:
                                </span>

                                <strong class="doctor-rating">
                                    ★ 4.8 (112)
                                </strong>

                            </div>

                        </div>

                    </div>


                    <div class="doctor-card-footer">

                        <div>

                            <div class="doctor-fee-label">
                                Consult Fee
                            </div>

                            <div class="doctor-fee">
                                $65
                            </div>

                        </div>


                        <a
                            href="${pageContext.request.contextPath}/patient/doctors/doctor-details.jsp?doctorId=6"
                            class="btn btn-sm btn-primary">

                            View Profile

                        </a>

                    </div>

                </article>


            </section>

        </main>


        <!-- Footer -->
        <jsp:include page="../components/footer.jsp" />

    </div>

</div>


<script
    src="${pageContext.request.contextPath}/patient/js/patient-common.js">
</script>

<script
    src="${pageContext.request.contextPath}/patient/js/doctors.js">
</script>

</body>

</html>