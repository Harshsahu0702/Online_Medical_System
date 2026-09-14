<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.doctor.Specialization" %>
<%@ page import="model.doctor.Clinic" %>
<!DOCTYPE html>
<html>  
<head>
    <meta charset="UTF-8">
    <title>Doctor Registration</title>
    <style>

        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            background: #f4f7fb;
            color: #2c3e50;
        }

        .container {
            width: 850px;
            max-width: 95%;
            margin: 35px auto;
            background: white;
            padding: 35px 40px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.10);
        }

        h1 {
            text-align: center;
            margin: 0;
            color: #244b6b;
            font-size: 30px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            margin-top: 8px;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .section-title {
            font-size: 18px;
            font-weight: bold;
            color: #3498db;
            border-bottom: 2px solid #e8eef3;
            padding-bottom: 8px;
            margin-top: 25px;
            margin-bottom: 20px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 18px;
        }

        .form-group {
            flex: 1;
        }

        .full-width {
            width: 100%;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #34495e;
            font-size: 14px;
        }

        .required {
            color: red;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccd6df;
            border-radius: 6px;
            font-size: 14px;
            background: white;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 3px rgba(52,152,219,0.25);
        }

        .hint {
            display: block;
            margin-top: 5px;
            font-size: 12px;
            color: #888;
        }

        /* ================================
           MESSAGES
           ================================ */

        .message {
            text-align: center;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .error {
            background: #fdeaea;
            color: #d63031;
            border: 1px solid #f5b7b1;
        }

        .success {
            background: #eafaf1;
            color: #1e8449;
            border: 1px solid #a9dfbf;
        }

        .info {
            background: #eaf5fc;
            color: #2874a6;
            border: 1px solid #aed6f1;
        }

        /* ================================
           DOCUMENT SECTION
           ================================ */

        .documents-box {
            background: #f8fafc;
            border: 1px solid #dfe6e9;
            border-radius: 8px;
            padding: 22px;
            margin-top: 10px;
        }

        .documents-intro {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
            margin-top: 0;
            margin-bottom: 22px;
        }

        .document-group {
            background: white;
            border: 1px solid #e1e7ec;
            border-radius: 7px;
            padding: 16px;
            margin-bottom: 15px;
        }

        .document-group:last-child {
            margin-bottom: 0;
        }

        .document-group input[type="file"] {
            padding: 9px;
            cursor: pointer;
            background: white;
        }

        .document-hint {
            display: block;
            margin-top: 6px;
            color: #888;
            font-size: 12px;
            line-height: 1.4;
        }

        .optional {
            color: #888;
            font-size: 12px;
            font-weight: normal;
        }

        .document-warning {
            margin-top: 15px;
            padding: 12px;
            background: #fff8e1;
            border: 1px solid #f5d76e;
            border-radius: 6px;
            color: #7d6608;
            font-size: 12px;
            line-height: 1.5;
        }

        /* ================================
           BUTTON
           ================================ */

        .btn {
            width: 100%;
            padding: 14px;
            margin-top: 25px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn:hover {
            background: #2980b9;
        }

        .note {
            margin-top: 15px;
            padding: 12px;
            background: #fff8e1;
            border: 1px solid #f5d76e;
            border-radius: 6px;
            color: #7d6608;
            font-size: 13px;
            line-height: 1.5;
        }

        @media screen and (max-width: 700px) {

            .container {
                padding: 25px 20px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

        }

    </style>
</head>
<body>
<div class="container">
    <h1>Doctor Registration</h1>
    
    <div class="subtitle">
        Register your professional details to join the Online Medical System
    </div>
    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");
    %>
    <% if ("1".equals(success)) { %>

        <div class="message success">
            Registration submitted successfully.
            Your account is now waiting for administrator approval.
        </div>

    <% } else if ("1".equals(error)) { %>

        <div class="message error">
            Registration failed. Please check your details and try again.
        </div>

    <% } else if ("password".equals(error)) { %>

        <div class="message error">
            Password and Confirm Password do not match.
        </div>

    <% } else if ("number".equals(error)) { %>

        <div class="message error">
            Please enter valid numeric values.
        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="message error">
            Please fill all required fields correctly.
        </div>

    <% } else if ("documents".equals(error)) { %>

        <div class="message error">
            Please upload all required documents.
            Only PDF, JPG, JPEG and PNG files up to 5 MB are allowed.
        </div>

    <% } %>


    <!--REGISTRATION FORM -->
    <form action="<%= request.getContextPath() %>/DoctorRegisterServlet"
          method="post"
          enctype="multipart/form-data">
        
        <!-- PERSONAL INFORMATION -->
        <div class="section-title">
            Personal Information
        </div>
        
        <div class="form-row">

            <div class="form-group">

                <label>
                    Full Name <span class="required">*</span>
                </label>

                <input type="text"
                       name="name"
                       placeholder="Enter full name"
                       maxlength="100"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Email Address <span class="required">*</span>
                </label>

                <input type="email"
                       name="email"
                       placeholder="doctor@example.com"
                       maxlength="150"
                       required>

            </div>

        </div>


        <div class="form-row">

            <div class="form-group">

                <label>
                    Phone Number <span class="required">*</span>
                </label>

                <input type="tel"
                       name="phone"
                       placeholder="Enter phone number"
                       maxlength="20"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Consultation Type <span class="required">*</span>
                </label>

                <select name="consultationType" required>

                    <option value="BOTH">
                        Online + In-Clinic
                    </option>

                    <option value="ONLINE">
                        Online Only
                    </option>

                    <option value="IN_CLINIC">
                        In-Clinic Only
                    </option>

                </select>

            </div>

        </div>

        <!-- PROFESSIONAL INFORMATION -->

        <div class="section-title">
            Professional Information
        </div>
        
        <div class="form-row">

            <!-- SPECIALIZATION -->

            <div class="form-group">

                <label>
                    Specialization <span class="required">*</span>
                </label>

                <select name="specializationId" required>

                    <option value="">
                        Select Specialization
                    </option>


                    <%

                        List<Specialization> specializations =
                                (List<Specialization>)
                                request.getAttribute("specializations");


                        if (specializations != null) {

                            for (Specialization s :
                                    specializations) {

                    %>

                        <option value="<%= s.getSpecializationId() %>">

                            <%= s.getName() %>

                        </option>

                    <%

                            }

                        }

                    %>

                </select>

            </div>


            <!-- QUALIFICATION -->

            <div class="form-group">

                <label>
                    Qualification <span class="required">*</span>
                </label>

                <input type="text"
                       name="qualification"
                       placeholder="e.g. MBBS, MD"
                       maxlength="150"
                       required>

            </div>

        </div>


        <div class="form-row">


            <!-- EXPERIENCE -->

            <div class="form-group">

                <label>
                    Experience (Years) <span class="required">*</span>
                </label>

                <input type="number"
                       name="experience"
                       min="0"
                       max="70"
                       placeholder="e.g. 5"
                       required>

            </div>


            <!-- LICENSE -->

            <div class="form-group">

                <label>
                    Medical License Number
                    <span class="required">*</span>
                </label>

                <input type="text"
                       name="licenseNumber"
                       placeholder="Enter medical license number"
                       maxlength="100"
                       required>

            </div>

        </div>


        <div class="form-row">


            <!-- REGISTRATION AUTHORITY -->

            <div class="form-group">

                <label>
                    Registration Authority
                </label>

                <input type="text"
                       name="registrationAuthority"
                       placeholder="e.g. NMC / State Medical Council"
                       maxlength="150">

            </div>


            <!-- CONSULTATION FEE -->

            <div class="form-group">

                <label>
                    Consultation Fee (₹)
                    <span class="required">*</span>
                </label>

                <input type="number"
                       name="consultationFee"
                       min="0"
                       step="0.01"
                       placeholder="e.g. 500"
                       required>

            </div>

        </div>

        <!-- CLINIC INFORMATION -->

        <div class="section-title">
            Clinic Information
        </div>


        <div class="form-row">

            <div class="form-group full-width">

                <label>
                    Associated Clinic
                </label>

                <select name="clinicId">

                    <option value="0">
                        No Clinic / Independent Doctor
                    </option>


                    <%

                        List<Clinic> clinics =
                                (List<Clinic>)
                                request.getAttribute("clinics");


                        if (clinics != null) {

                            for (Clinic c :
                                    clinics) {

                    %>

                        <option value="<%= c.getClinicId() %>">

                            <%= c.getClinicName() %>
                            -
                            <%= c.getCity() %>

                        </option>

                    <%

                            }

                        }

                    %>

                </select>


                <span class="hint">
                    You can register without selecting a clinic.
                </span>

            </div>

        </div>
                    
        <!-- BIO -->
        <div class="form-row">

            <div class="form-group full-width">

                <label>
                    Professional Bio
                </label>

                <textarea name="bio"
                          maxlength="1000"
                          placeholder="Write a short description about your professional experience, expertise and services..."></textarea>

            </div>

        </div>

        <!-- DOCUMENTS -->
        <div class="section-title">
            Professional Documents
        </div>


        <div class="documents-box">

            <p class="documents-intro">

                Please upload the following documents for verification.
                These documents will be reviewed by the administrator
                before your doctor account is activated.

            </p>

            <!-- MEDICAL REGISTRATION CERTIFICATE -->
            <div class="document-group">

                <label>

                    Medical Registration Certificate
                    <span class="required">*</span>

                </label>

                <input type="file"
                       name="registrationCertificate"
                       accept=".pdf,.jpg,.jpeg,.png"
                       required>

                <span class="document-hint">

                    Upload your Medical Council / NMC / State Medical
                    Council registration certificate.

                    Allowed: PDF, JPG, JPEG, PNG.
                    Maximum size: 5 MB.

                </span>

            </div>
            <!-- MBBS DEGREE -->
            <div class="document-group">

                <label>

                    MBBS Degree Certificate
                    <span class="required">*</span>

                </label>

                <input type="file"
                       name="mbbsCertificate"
                       accept=".pdf,.jpg,.jpeg,.png"
                       required>

                <span class="document-hint">

                    Upload your MBBS degree certificate.

                    Allowed: PDF, JPG, JPEG, PNG.
                    Maximum size: 5 MB.

                </span>

            </div>

            <!-- IDENTITY PROOF -->
            
            <div class="document-group">

                <label>

                    Identity Proof
                    <span class="required">*</span>

                </label>

                <input type="file"
                       name="identityProof"
                       accept=".pdf,.jpg,.jpeg,.png"
                       required>

                <span class="document-hint">

                    Upload a valid government-issued identity document.

                    Allowed: PDF, JPG, JPEG, PNG.
                    Maximum size: 5 MB.

                </span>

            </div>

            <!-- ADDITIONAL QUALIFICATION -->

            <div class="document-group">

                <label>

                    Additional Qualification Certificate

                    <span class="optional">
                        (Optional)
                    </span>

                </label>

                <input type="file"
                       name="additionalQualification"
                       accept=".pdf,.jpg,.jpeg,.png">

                <span class="document-hint">

                    Upload MD, MS, DM, M.Ch or any other
                    additional qualification certificate.

                    Allowed: PDF, JPG, JPEG, PNG.
                    Maximum size: 5 MB.

                </span>

            </div>

            <!-- DOCUMENT WARNING -->

            <div class="document-warning">

                <strong>Document Verification:</strong>

                All uploaded documents will initially have
                <strong>PENDING</strong> verification status.
                The administrator will verify the documents
                before activating your doctor account.

            </div>

        </div>

        <!-- SECURITY -->

        <div class="section-title">
            Account Security
        </div>


        <div class="form-row">

            <div class="form-group">

                <label>
                    Password <span class="required">*</span>
                </label>

                <input type="password"
                       name="password"
                       placeholder="Create password"
                       minlength="6"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Confirm Password
                    <span class="required">*</span>
                </label>

                <input type="password"
                       name="confirmPassword"
                       placeholder="Confirm password"
                       minlength="6"
                       required>

            </div>

        </div>

        <!-- ADMIN APPROVAL NOTE -->

        <div class="note">

            <strong>Important:</strong>

            Your registration will first be reviewed by the
            administrator.

            Your account will remain in
            <strong>PENDING</strong> status until the
            administrator approves your registration and
            verifies your submitted documents.

        </div>

        <!-- SUBMIT -->

        <button type="submit" class="btn">
            Register as Doctor
        </button>
    </form>
</div>
</body>
</html>