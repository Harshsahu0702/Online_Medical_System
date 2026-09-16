<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Find & Consult Specialists");
    request.setAttribute(
        "pageDescription",
        "Connect with certified medical practitioners, read reviews, and schedule visits."
    );
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>MediCore | Find a Doctor</title>

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
                 DOCTOR SEARCH & FILTERS
                 ======================================================== -->

            <section class="card doctor-filter-card">

                <div class="card-body doctor-filter-body">

                    <div class="doctor-filter-bar">


                        <!-- Search -->

                        <div class="doctor-search-field">

                            <label
                                class="form-label"
                                for="docSearchTerm">

                                Search Doctors

                            </label>

                            <div class="doctor-search-wrapper">

                                <svg
                                    class="icon icon-sm"
                                    viewBox="0 0 24 24"
                                    aria-hidden="true">

                                    <circle
                                        cx="11"
                                        cy="11"
                                        r="8"/>

                                    <path
                                        d="m21 21-4.3-4.3"/>

                                </svg>


                                <input
                                    type="search"
                                    class="form-control doctor-search-input"
                                    id="docSearchTerm"
                                    placeholder="Search by doctor name, hospital, or sub-specialty..."
                                    autocomplete="off">

                            </div>

                        </div>


                        <!-- Specialty -->

                        <div class="doctor-filter-field">

                            <label
                                class="form-label"
                                for="docSpecialtyFilter">

                                Specialty

                            </label>


                            <select
                                class="form-control"
                                id="docSpecialtyFilter">

                                <option value="ALL">
                                    All Specialties
                                </option>

                                <option value="Cardiology">
                                    Cardiology
                                </option>

                                <option value="Dermatology">
                                    Dermatology
                                </option>

                                <option value="Neurology">
                                    Neurology
                                </option>

                                <option value="Pediatrics">
                                    Pediatrics
                                </option>

                                <option value="General Medicine">
                                    General Medicine
                                </option>

                                <option value="Orthopedics">
                                    Orthopedics
                                </option>

                            </select>

                        </div>


                        <!-- Availability -->

                        <div class="doctor-filter-field">

                            <label
                                class="form-label"
                                for="docAvailabilityFilter">

                                Availability

                            </label>


                            <select
                                class="form-control"
                                id="docAvailabilityFilter">

                                <option value="ALL">
                                    Any Availability
                                </option>

                                <option value="Today">
                                    Available Today
                                </option>

                                <option value="Tomorrow">
                                    Available Tomorrow
                                </option>

                            </select>

                        </div>


                    </div>

                </div>

            </section>


            <!-- ========================================================
                 DOCTOR RESULTS
                 ======================================================== -->

            <section
                class="doctor-results-section"
                aria-label="Available doctors">


                <div class="doctor-results-header">

                    <div>

                        <h2 class="doctor-results-title">
                            Available Specialists
                        </h2>

                        <p
                            class="doctor-results-count"
                            id="doctorResultsCount">

                            Loading doctors...

                        </p>

                    </div>

                </div>


                <div
                    class="doctor-grid"
                    id="doctorGridContainer">

                    <!--
                        Doctor cards are rendered by doctors.js.
                    -->

                </div>

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