<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Symptom Assessment");
    request.setAttribute(
        "pageDescription",
        "Select your current symptoms and provide additional details for educational guidance."
    );
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>MediCore | Symptom Assessment</title>

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/patient/css/patient-common.css">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/patient/css/medical-assistant.css">

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
                 MEDICAL DISCLAIMER
                 ======================================================== -->

            <div class="disclaimer-alert">

                <svg
                    class="icon icon-lg"
                    viewBox="0 0 24 24"
                    aria-hidden="true">

                    <circle
                        cx="12"
                        cy="12"
                        r="10"/>

                    <line
                        x1="12"
                        x2="12"
                        y1="8"
                        y2="12"/>

                    <line
                        x1="12"
                        x2="12.01"
                        y1="16"
                        y2="16"/>

                </svg>


                <div>

                    <strong>
                        Important Medical Notice:
                    </strong>

                    This tool is for informational and educational
                    guidance only. It is
                    <u>not</u>
                    a doctor's diagnosis, medical advice, or an
                    emergency service.

                    If you are experiencing chest pain, severe bleeding,
                    or difficulty breathing, immediately use the
                    <strong>Emergency SOS</strong>
                    section or contact your local emergency service.

                </div>

            </div>


            <!-- ========================================================
                 SYMPTOM ASSESSMENT CARD
                 ======================================================== -->

            <section class="card assistant-card">

                <div class="card-header">

                    <div class="card-title">

                        <svg
                            class="icon"
                            viewBox="0 0 24 24"
                            aria-hidden="true">

                            <path
                                d="m12 3-1.9 5.8a2 2 0 0 1-1.3 1.3L3 12l5.8 1.9a2 2 0 0 1 1.3 1.3L12 21l1.9-5.8a2 2 0 0 1 1.3-1.3L21 12l-5.8-1.9a2 2 0 0 1-1.3-1.3L12 3Z"/>

                        </svg>

                        Step 1: Select Your Current Symptoms

                    </div>

                </div>


                <div class="card-body">

                    <p class="assistant-instruction">
                        Click all applicable symptoms you are
                        experiencing today:
                    </p>


                    <!-- ==================================================
                         SYMPTOM OPTIONS
                         ================================================== -->

                    <div
                        class="symptom-tag-container"
                        id="symptomChipsContainer">


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Mild Fever">

                            🌡️ Mild Fever

                        </button>


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Dry Cough">

                            🗣️ Dry Cough

                        </button>


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Throat Irritation">

                            🧣 Throat Irritation

                        </button>


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Headache">

                            🤕 Headache

                        </button>


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Fatigue">

                            🥱 Fatigue & Weakness

                        </button>


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Nasal Congestion">

                            🤧 Nasal Congestion

                        </button>


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Stomach Acid / Heartburn">

                            🔥 Heartburn / Acidity

                        </button>


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Joint Pain">

                            🦴 Joint & Body Ache

                        </button>


                        <button
                            type="button"
                            class="symptom-chip"
                            data-symptom="Skin Itchiness">

                            🧴 Skin Rash / Itch

                        </button>

                    </div>


                    <!-- ==================================================
                         DURATION
                         ================================================== -->

                    <div class="form-group assistant-form-group">

                        <label
                            class="form-label"
                            for="symptomDuration">

                            Duration of Symptoms

                        </label>


                        <select
                            class="form-control"
                            id="symptomDuration"
                            name="symptomDuration">

                            <option value="1">
                                Started Today (&lt; 24 hours)
                            </option>

                            <option
                                value="3"
                                selected>
                                2 to 3 Days
                            </option>

                            <option value="7">
                                About 1 Week
                            </option>

                            <option value="14">
                                More than 2 Weeks
                            </option>

                        </select>

                    </div>


                    <!-- ==================================================
                         ADDITIONAL NOTES
                         ================================================== -->

                    <div class="form-group assistant-form-group">

                        <label
                            class="form-label"
                            for="symptomNotes">

                            Additional Health Notes (Optional)

                        </label>


                        <textarea
                            class="form-control"
                            id="symptomNotes"
                            name="symptomNotes"
                            rows="3"
                            placeholder="e.g., Slightly worse in the morning, took paracetamol once..."></textarea>

                    </div>


                    <!-- ==================================================
                         GENERATE GUIDANCE
                         ================================================== -->

                    <button
                        type="button"
                        class="btn btn-primary assistant-generate-btn"
                        id="generateGuidanceBtn">

                        <svg
                            class="icon icon-sm"
                            viewBox="0 0 24 24"
                            aria-hidden="true">

                            <polygon
                                points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>

                        </svg>

                        Generate Health Guidance Report

                    </button>

                </div>

            </section>


            <!-- ========================================================
                 SELECTED SYMPTOMS SUMMARY
                 ======================================================== -->

            <section
                class="card selected-symptoms-card"
                id="selectedSymptomsCard"
                hidden>

                <div class="card-header">

                    <div class="card-title">
                        Selected Symptoms
                    </div>

                </div>


                <div class="card-body">

                    <div
                        class="selected-symptoms-list"
                        id="selectedSymptomsList">
                    </div>

                </div>

            </section>


            <!-- ========================================================
                 EMERGENCY REMINDER
                 ======================================================== -->

            <section class="assistant-emergency-card">

                <div>

                    <strong>
                        Need urgent medical attention?
                    </strong>

                    <p>
                        Do not use this assessment for emergency
                        situations.
                    </p>

                </div>


                <a
                    href="${pageContext.request.contextPath}/patient/emergency/emergency.jsp"
                    class="btn btn-secondary">

                    Open Emergency Center

                </a>

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
    src="${pageContext.request.contextPath}/patient/js/medical-assistant.js">
</script>

</body>

</html>