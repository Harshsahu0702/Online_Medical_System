<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setAttribute("pageTitle", "Edit Profile");
    request.setAttribute(
        "pageDescription",
        "Update your personal details, emergency contact, and medical information."
    );
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>MediCore | Edit Profile</title>

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


            <form
                id="patientProfileForm"
                action="${pageContext.request.contextPath}/patient/profile/profile.jsp"
                method="post">


                <!-- ======================================================
                     PERSONAL & CONTACT INFORMATION
                     ====================================================== -->

                <section class="card profile-information-card">

                    <div class="card-header">

                        <div class="card-title">
                            Personal & Contact Information
                        </div>

                    </div>


                    <div class="card-body">

                        <div class="form-grid-3">


                            <!-- Full Legal Name -->

                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profFullName">

                                    Full Legal Name

                                </label>

                                <input
                                    type="text"
                                    class="form-control"
                                    id="profFullName"
                                    name="fullName"
                                    value="Eleanor Vance"
                                    required>

                            </div>


                            <!-- Date of Birth -->

                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profDob">

                                    Date of Birth

                                </label>

                                <input
                                    type="date"
                                    class="form-control"
                                    id="profDob"
                                    name="dateOfBirth"
                                    value="1992-06-14"
                                    required>

                            </div>


                            <!-- Biological Gender -->

                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profGender">

                                    Biological Gender

                                </label>

                                <select
                                    class="form-control"
                                    id="profGender"
                                    name="gender">

                                    <option
                                        value="Female"
                                        selected>
                                        Female
                                    </option>

                                    <option value="Male">
                                        Male
                                    </option>

                                </select>

                            </div>


                            <!-- Phone -->

                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profPhone">

                                    Phone Number

                                </label>

                                <input
                                    type="tel"
                                    class="form-control"
                                    id="profPhone"
                                    name="phone"
                                    value="+1 (555) 123-4567">

                            </div>


                            <!-- Email -->

                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profEmail">

                                    Email Address

                                </label>

                                <input
                                    type="email"
                                    class="form-control"
                                    id="profEmail"
                                    name="email"
                                    value="eleanor.vance@example.com">

                            </div>


                            <!-- Address -->

                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profAddress">

                                    Address

                                </label>

                                <input
                                    type="text"
                                    class="form-control"
                                    id="profAddress"
                                    name="address"
                                    value="245 Oak Avenue">

                            </div>

                        </div>

                    </div>

                </section>


                <!-- ======================================================
                     EMERGENCY CONTACT
                     ====================================================== -->

                <section class="card profile-information-card">

                    <div class="card-header">

                        <div class="card-title">
                            Emergency Contact
                        </div>

                    </div>


                    <div class="card-body">

                        <div class="form-grid-3">


                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profEmName">

                                    Contact Name

                                </label>

                                <input
                                    type="text"
                                    class="form-control"
                                    id="profEmName"
                                    name="emergencyContactName"
                                    value="Michael Vance"
                                    required>

                            </div>


                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profEmRel">

                                    Relationship

                                </label>

                                <input
                                    type="text"
                                    class="form-control"
                                    id="profEmRel"
                                    name="emergencyContactRelationship"
                                    value="Spouse"
                                    required>

                            </div>


                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profEmPhone">

                                    Emergency Phone

                                </label>

                                <input
                                    type="tel"
                                    class="form-control"
                                    id="profEmPhone"
                                    name="emergencyContactPhone"
                                    value="+1 (555) 998-1122"
                                    required>

                            </div>

                        </div>

                    </div>

                </section>


                <!-- ======================================================
                     MEDICAL INFORMATION
                     ====================================================== -->

                <section class="card profile-information-card">

                    <div class="card-header">

                        <div class="card-title">
                            Medical Information
                        </div>

                    </div>


                    <div class="card-body">

                        <div class="form-grid-2">


                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profAllergies">

                                    Known Allergies

                                </label>

                                <textarea
                                    class="form-control"
                                    id="profAllergies"
                                    name="allergies"
                                    rows="3">Penicillin (Severe Hives), Peanut Extracts</textarea>

                            </div>


                            <div class="form-group">

                                <label
                                    class="form-label"
                                    for="profConditions">

                                    Pre-existing Medical Conditions

                                </label>

                                <textarea
                                    class="form-control"
                                    id="profConditions"
                                    name="medicalConditions"
                                    rows="3">Mild Hypertension, Exercise-Induced Asthma</textarea>

                            </div>

                        </div>


                        <!-- Form Actions -->

                        <div class="profile-form-actions">

                            <a
                                href="${pageContext.request.contextPath}/patient/profile/profile.jsp"
                                class="btn btn-secondary">

                                Cancel

                            </a>


                            <button
                                type="submit"
                                class="btn btn-primary">

                                Save Profile Changes

                            </button>

                        </div>

                    </div>

                </section>

            </form>

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