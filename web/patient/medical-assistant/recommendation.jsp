<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Educational Recommendation");
    request.setAttribute(
        "pageDescription",
        "Review your symptom assessment and educational care guidance."
    );
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>MediCore | Educational Recommendation</title>

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

                    This report is for informational and educational
                    guidance only. It is
                    <u>not</u>
                    a doctor's diagnosis, medical advice, or an
                    emergency service.

                </div>

            </div>


            <!-- ========================================================
                 RECOMMENDATION CARD
                 ======================================================== -->

            <section class="card recommendation-card">

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

                            <path d="m9 12 2 2 4-4"/>

                        </svg>

                        Educational Recommendation

                    </div>

                </div>


                <div
                    class="card-body"
                    id="recommendationContent">

                    <!-- Content populated by recommendation.js -->

                    <div class="recommendation-loading">

                        <svg
                            class="icon icon-xl"
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

                        <p>
                            Loading your educational guidance...
                        </p>

                    </div>

                </div>

            </section>


            <!-- ========================================================
                 ACTIONS
                 ======================================================== -->

            <section class="recommendation-actions">

                <a
                    href="${pageContext.request.contextPath}/patient/medical-assistant/symptoms.jsp"
                    class="btn btn-secondary">

                    Review Symptoms

                </a>


                <a
                    href="${pageContext.request.contextPath}/patient/doctors/find-doctor.jsp"
                    class="btn btn-primary">

                    Find a Specialist

                </a>

            </section>


            <!-- ========================================================
                 EMERGENCY NOTICE
                 ======================================================== -->

            <section class="assistant-emergency-card">

                <div>

                    <strong>
                        Experiencing an emergency?
                    </strong>

                    <p>
                        Do not rely on this educational report for
                        emergency medical decisions.
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