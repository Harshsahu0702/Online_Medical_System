<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="patient.model.Patient" %>
<%
    request.setAttribute("pageTitle", "Patient Profile");
    request.setAttribute("pageDescription","Manage your personal details, emergency contacts, and medical history.");
%>
<%
    Patient patient = (Patient) request.getAttribute("patient");
    String name = patient.getName();
    String email = patient.getEmail();
    String gender = patient.getGender();
    String address = patient.getAddress();
    String dob = patient.getDob();
    String contact = patient.getContact();
    String bloodGroup = patient.getBloodGroup();
    String emergencyName = patient.getEmergencyName();
    String emergencyRelation = patient.getEmergencyRelation();
    String emergencyContact = patient.getEmergencyContact();
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>MediCore | Patient Profile</title>

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/patient/css/patient-common.css">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/patient/css/profile.css">

</head>


<body>

<div class="app-layout">

    <!-- Sidebar -->
    <jsp:include page="../components/sidebar.jsp" />


    <div class="app-main">

        <!-- Navbar -->
        <jsp:include page="../components/navbar.jsp" />


        <main class="page-container">

            <!-- Page Header -->
            <jsp:include page="../components/patient-header.jsp" />


            <!-- ==========================================================
                 PROFILE HERO
                 ========================================================== -->

            <section class="profile-hero">

                <div class="profile-hero-left">

                    <div class="profile-large-avatar">
                        EW
                    </div>


                    <div class="profile-identity">

                        <h2 id="displayProfileName">
                            <%= name %>
                        </h2>

<!--                        <p>
                            Patient ID: #MED-88421
                            <span aria-hidden="true">•</span>
                            Registered Since Jan 2024
                        </p>-->


                        <div class="profile-badges">

                            <span class="badge badge-info">
                                Blood Group: <%= bloodGroup %>
                            </span>

<!--                            <span class="badge badge-success">
                                Account Verified
                            </span>-->

                        </div>

                    </div>

                </div>


                <div class="profile-emergency-status">

                    <span>
                        Emergency Contact Status
                    </span>

                    <strong>
                        Verified & Linked
                    </strong>

                </div>

            </section>


            <!-- ==========================================================
                 PERSONAL & CONTACT INFORMATION
                 ========================================================== -->

            <section class="card profile-information-card">

                <div class="card-header">

                    <div class="card-title">
                        Personal & Contact Information
                    </div>


                    <a
                        href="${pageContext.request.contextPath}/patient/profile/edit"
                        class="btn btn-primary btn-sm">

                        Edit Profile

                    </a>

                </div>


                <div class="card-body">

                    <div class="profile-details-grid">


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Full Legal Name
                            </span>

                            <strong>
                                <%= name %>
                            </strong>

                        </div>


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Date of Birth
                            </span>

                            <strong>
                                <%= dob %>
                            </strong>

                        </div>


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Biological Gender
                            </span>

                            <strong>
                                <%= gender %>
                            </strong>

                        </div>


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Phone Number
                            </span>

                            <strong>
                                <%= contact %>
                            </strong>

                        </div>


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Email Address
                            </span>

                            <strong>
                                <%= email %>
                            </strong>

                        </div>


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Address
                            </span>

                            <strong>
                                <%= address %>
                            </strong>

                        </div>


                    </div>

                </div>

            </section>


            <!-- ==========================================================
                 EMERGENCY CONTACT
                 ========================================================== -->

            <section class="card profile-information-card">

                <div class="card-header">

                    <div class="card-title">
                        Emergency Contact
                    </div>

                </div>


                <div class="card-body">

                    <div class="profile-details-grid">


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Contact Name
                            </span>

                            <strong>
                                <%= emergencyName %>
                            </strong>

                        </div>


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Relationship
                            </span>

                            <strong>
                                <%= emergencyRelation %>
                            </strong>

                        </div>


                        <div class="profile-detail">

                            <span class="profile-detail-label">
                                Emergency Phone
                            </span>

                            <strong>
                                <%= emergencyContact %>
                            </strong>

                        </div>


                    </div>

                </div>

            </section>


            <!-- ==========================================================
                 MEDICAL INFORMATION
                 ========================================================== -->

            <section class="card profile-information-card">

                <div class="card-header">

                    <div class="card-title">
                        Medical Information
                    </div>

                </div>


                <div class="card-body">

                    <div class="profile-medical-grid">


                        <div class="profile-medical-item">

                            <span class="profile-detail-label">
                                Known Allergies
                            </span>

                            <p class="profile-medical-danger">
                                Penicillin (Severe Hives),
                                Peanut Extracts
                            </p>

                        </div>


                        <div class="profile-medical-item">

                            <span class="profile-detail-label">
                                Pre-existing Medical Conditions
                            </span>

                            <p>
                                Mild Hypertension,
                                Exercise-Induced Asthma
                            </p>

                        </div>


                    </div>

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
    src="${pageContext.request.contextPath}/patient/js/profile.js">
</script>

</body>

</html>
