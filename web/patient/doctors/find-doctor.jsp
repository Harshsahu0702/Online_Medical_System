<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <% request.setAttribute("pageTitle", "Find & Consult Specialists" ); request.setAttribute( "pageDescription"
        , "Connect with certified medical practitioners, read reviews, and schedule visits." ); %>

        <!DOCTYPE html>
        <html lang="en">

        <head>

            <meta charset="UTF-8">

            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <title>MediCore | Find a Doctor</title>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/patient-common.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/patient/css/doctors.css?v=3.0">
        </head>

        <body>

            <div class="app-layout">

                <!-- SIDEBAR -->

                <jsp:include page="../components/sidebar.jsp" />

                <div class="app-main">

                    <!-- NAVBAR-->

                    <jsp:include page="../components/navbar.jsp" />

                    <main class="page-container">
                        <!-- PAGE HEADER-->

                        <jsp:include page="../components/patient-header.jsp" />

                        <!-- DOCTOR SEARCH & FILTERS-->

                        <!-- DOCTOR SEARCH & FILTERS-->

                        <section class="card doctor-filter-card">
                            <div class="card-body doctor-filter-body">
                                <form action="${pageContext.request.contextPath}/patient/find-doctor" method="GET"
                                    class="doctor-filter-bar">

                                    <!-- Search Field -->
                                    <div class="doctor-search-field">
                                        <label class="form-label" for="docSearchTerm">
                                            Search Doctors
                                        </label>
                                        <div class="doctor-search-wrapper">
                                            <svg class="icon icon-sm" viewBox="0 0 24 24" aria-hidden="true">
                                                <circle cx="11" cy="11" r="8" />
                                                <path d="m21 21-4.3-4.3" />
                                            </svg>

                                            <input type="search" name="searchTerm"
                                                class="form-control doctor-search-input" id="docSearchTerm"
                                                placeholder="Search by doctor name or clinic..."
                                                value="${param.searchTerm}" autocomplete="off">
                                        </div>
                                    </div>

                                    <!-- Specialty Dropdown -->
                                    <div class="doctor-filter-field">
                                        <label class="form-label" for="docSpecialtyFilter">
                                            Specialty
                                        </label>

                                        <select class="form-control" name="specialty" id="docSpecialtyFilter">
                                            <option value="">All Specialties</option>
                                            <option value="General Physician" ${param.specialty=='General Physician'
                                                ? 'selected' : '' }>General Physician</option>
                                            <option value="Cardiologist" ${param.specialty=='Cardiologist' ? 'selected'
                                                : '' }>Cardiologist</option>
                                            <option value="Dermatologist" ${param.specialty=='Dermatologist'
                                                ? 'selected' : '' }>Dermatologist</option>
                                            <option value="Neurologist" ${param.specialty=='Neurologist' ? 'selected'
                                                : '' }>Neurologist</option>
                                            <option value="Orthopedic" ${param.specialty=='Orthopedic' ? 'selected' : ''
                                                }>Orthopedic</option>
                                            <option value="Pediatrician" ${param.specialty=='Pediatrician' ? 'selected'
                                                : '' }>Pediatrician</option>
                                            <option value="Gynecologist" ${param.specialty=='Gynecologist' ? 'selected'
                                                : '' }>Gynecologist</option>
                                            <option value="Obstetrician" ${param.specialty=='Obstetrician' ? 'selected'
                                                : '' }>Obstetrician</option>
                                            <option value="ENT Specialist" ${param.specialty=='ENT Specialist'
                                                ? 'selected' : '' }>ENT Specialist</option>
                                            <option value="Ophthalmologist" ${param.specialty=='Ophthalmologist'
                                                ? 'selected' : '' }>Ophthalmologist</option>
                                            <option value="Psychiatrist" ${param.specialty=='Psychiatrist' ? 'selected'
                                                : '' }>Psychiatrist</option>
                                            <option value="Oncologist" ${param.specialty=='Oncologist' ? 'selected' : ''
                                                }>Oncologist</option>
                                            <option value="Endocrinologist" ${param.specialty=='Endocrinologist'
                                                ? 'selected' : '' }>Endocrinologist</option>
                                            <option value="Gastroenterologist" ${param.specialty=='Gastroenterologist'
                                                ? 'selected' : '' }>Gastroenterologist</option>
                                            <option value="Pulmonologist" ${param.specialty=='Pulmonologist'
                                                ? 'selected' : '' }>Pulmonologist</option>
                                            <option value="Nephrologist" ${param.specialty=='Nephrologist' ? 'selected'
                                                : '' }>Nephrologist</option>
                                            <option value="Urologist" ${param.specialty=='Urologist' ? 'selected' : ''
                                                }>Urologist</option>
                                            <option value="Dentist" ${param.specialty=='Dentist' ? 'selected' : '' }>
                                                Dentist</option>
                                            <option value="Rheumatologist" ${param.specialty=='Rheumatologist'
                                                ? 'selected' : '' }>Rheumatologist</option>
                                            <option value="General Surgeon" ${param.specialty=='General Surgeon'
                                                ? 'selected' : '' }>General Surgeon</option>
                                        </select>
                                    </div>

                                    <!-- Availability Dropdown -->
                                    <div class="doctor-filter-field">
                                        <label class="form-label" for="docAvailabilityFilter">
                                            Availability Day
                                        </label>
                                        <select class="form-control" name="day" id="docAvailabilityFilter">
                                            <option value="">Any Day</option>
                                            <option value="Monday" ${param.day=='Monday' ? 'selected' : '' }>Monday
                                            </option>
                                            <option value="Tuesday" ${param.day=='Tuesday' ? 'selected' : '' }>Tuesday
                                            </option>
                                            <option value="Wednesday" ${param.day=='Wednesday' ? 'selected' : '' }>
                                                Wednesday</option>
                                            <option value="Thursday" ${param.day=='Thursday' ? 'selected' : '' }>
                                                Thursday</option>
                                            <option value="Friday" ${param.day=='Friday' ? 'selected' : '' }>Friday
                                            </option>
                                            <option value="Saturday" ${param.day=='Saturday' ? 'selected' : '' }>
                                                Saturday</option>
                                            <option value="Sunday" ${param.day=='Sunday' ? 'selected' : '' }>Sunday
                                            </option>
                                        </select>
                                    </div>

                                    <!-- Search & Reset Actions -->
                                    <div class="doctor-filter-actions">
                                        <button type="submit" class="btn btn-primary doctor-submit-btn">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none"
                                                stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                stroke-linejoin="round" aria-hidden="true">
                                                <circle cx="11" cy="11" r="8" />
                                                <path d="m21 21-4.3-4.3" />
                                            </svg>
                                            <span>Search</span>
                                        </button>
                                        <% if (request.getParameter("searchTerm") !=null ||
                                            request.getParameter("specialty") !=null || request.getParameter("day")
                                            !=null) { %>
                                            <a href="${pageContext.request.contextPath}/patient/find-doctor"
                                                class="btn btn-secondary doctor-reset-btn" title="Clear Filters">
                                                Reset
                                            </a>
                                            <% } %>
                                    </div>
                                </form>
                            </div>
                        </section>

                        <!-- DOCTOR RESULTS -->

                        <section class="doctor-results-section" aria-label="Available doctors">
                            <jsp:include page="doctor-list.jsp" />
                        </section>
                    </main>

                    <!-- Footer -->
                    <jsp:include page="../components/footer.jsp" />
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/patient/js/patient-common.js">
            </script>

            <!--<script
    src="${pageContext.request.contextPath}/patient/js/doctors.js">
</script>-->
        </body>

        </html>