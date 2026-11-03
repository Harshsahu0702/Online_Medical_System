<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="patient.model.Patient" %>
<%
    request.setAttribute("pageTitle", "Patient Profile");
    request.setAttribute("pageDescription","Manage your personal details, emergency contacts, and medical history.");
%>
<%
    Patient patient = (Patient) request.getAttribute("patient");
    String name = (patient != null && patient.getName() != null) ? patient.getName() : "Patient";
    String email = (patient != null && patient.getEmail() != null) ? patient.getEmail() : "";
    String gender = (patient != null && patient.getGender() != null) ? patient.getGender() : "Not specified";
    String address = (patient != null && patient.getAddress() != null) ? patient.getAddress() : "Not specified";
    String dob = (patient != null && patient.getDob() != null) ? patient.getDob() : "Not specified";
    String contact = (patient != null && patient.getContact() != null) ? patient.getContact() : "Not specified";
    String bloodGroup = (patient != null && patient.getBloodGroup() != null && !patient.getBloodGroup().isEmpty()) ? patient.getBloodGroup() : "Not specified";
    String emergencyName = (patient != null && patient.getEmergencyName() != null) ? patient.getEmergencyName() : "Not set";
    String emergencyRelation = (patient != null && patient.getEmergencyRelation() != null) ? patient.getEmergencyRelation() : "N/A";
    String emergencyContact = (patient != null && patient.getEmergencyContact() != null) ? patient.getEmergencyContact() : "N/A";

    String initials = "P";
    if (name != null && !name.trim().isEmpty()) {
        String[] parts = name.trim().split("\\s+");
        if (parts.length >= 2) {
            initials = ("" + parts[0].charAt(0) + parts[1].charAt(0)).toUpperCase();
        } else {
            initials = ("" + parts[0].charAt(0)).toUpperCase();
        }
    }
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


            <% if ("1".equals(request.getParameter("updated"))) { %>
                <div style="background: #ecfdf5; border: 1.5px solid #10b981; border-radius: 10px; padding: 14px 20px; margin-bottom: 22px; color: #065f46; font-weight: 600; display: flex; align-items: center; gap: 10px;">
                    <span style="font-size: 18px;">✓</span> Profile updated and saved successfully!
                </div>
            <% } %>

            <!-- ==========================================================
                 PROFILE HERO
                 ========================================================== -->

            <section class="profile-hero">

                <div class="profile-hero-left">

                    <div class="profile-large-avatar">
                        <%= initials %>
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
                                Blood Group
                            </span>

                            <p style="font-weight: 700; color: #0284c7; font-size: 16px;">
                                <%= bloodGroup %>
                            </p>

                        </div>


                        <div class="profile-medical-item">

                            <span class="profile-detail-label">
                                Residential / Delivery Region
                            </span>

                            <p>
                                <%= address %>
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