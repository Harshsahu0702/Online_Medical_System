<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Interactive Medical Assistant");
    request.setAttribute(
        "pageDescription",
        "Educational symptom assessment and specialist guidance."
    );
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>MediCore | Medical Assistant</title>

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
                 ASSISTANT INTRODUCTION
                 ======================================================== -->

            <section class="card assistant-intro-card">

                <div class="card-body">

                    <div class="assistant-intro-content">

                        <div class="assistant-intro-icon">

                            <svg
                                class="icon icon-xl"
                                viewBox="0 0 24 24"
                                aria-hidden="true">

                                <path
                                    d="m12 3-1.9 5.8a2 2 0 0 1-1.3 1.3L3 12l5.8 1.9a2 2 0 0 1 1.3 1.3L12 21l1.9-5.8a2 2 0 0 1 1.3-1.3L21 12l-5.8-1.9a2 2 0 0 1-1.3-1.3z"/>

                            </svg>

                        </div>


                        <div>

                            <h2>
                                Understand Your Symptoms
                            </h2>

                            <p>
                                Select the symptoms you are experiencing
                                to receive educational care guidance and
                                a suggested medical specialty.
                            </p>

                        </div>

                    </div>


                    <a
                        href="${pageContext.request.contextPath}/patient/medical-assistant/symptoms.jsp"
                        class="btn btn-primary">

                        Start Symptom Assessment

                        <svg
                            class="icon icon-sm"
                            viewBox="0 0 24 24"
                            aria-hidden="true">

                            <path d="M5 12h14"/>
                            <path d="m13 6 6 6-6 6"/>

                        </svg>

                    </a>

                </div>

            </section>


            <!-- ========================================================
                 HOW IT WORKS
                 ======================================================== -->

            <section class="assistant-steps-grid">


                <div class="card assistant-step-card">

                    <div class="assistant-step-number">
                        1
                    </div>

                    <h3>
                        Select Symptoms
                    </h3>

                    <p>
                        Choose the symptoms that best describe
                        what you are experiencing.
                    </p>

                </div>


                <div class="card assistant-step-card">

                    <div class="assistant-step-number">
                        2
                    </div>

                    <h3>
                        Add Details
                    </h3>

                    <p>
                        Provide the approximate duration and
                        any additional health notes.
                    </p>

                </div>


                <div class="card assistant-step-card">

                    <div class="assistant-step-number">
                        3
                    </div>

                    <h3>
                        Review Guidance
                    </h3>

                    <p>
                        Review informational care tips and
                        suggested medical specialties.
                    </p>

                </div>

            </section>


            <!-- ========================================================
                 EMERGENCY LINK
                 ======================================================== -->

            <section class="assistant-emergency-card">

                <div>

                    <strong>
                        Experiencing a medical emergency?
                    </strong>

                    <p>
                        Do not use the Medical Assistant for
                        emergency diagnosis or treatment.
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
