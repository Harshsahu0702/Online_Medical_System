<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Patient Registration - OmniHealth</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-dark: #090d16;
            --brand-purple: #6366f1;
            --brand-purple-hover: #4f46e5;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 1.25rem;
            position: relative;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(99, 102, 241, 0.18) 0%, transparent 40%),
                radial-gradient(circle at 90% 80%, rgba(2, 132, 199, 0.15) 0%, transparent 40%);
        }

        .signup-card {
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 24px;
            padding: 3rem 2.5rem;
            width: 100%;
            max-width: 680px;
            box-shadow: 0 25px 60px -15px rgba(0, 0, 0, 0.8), 0 0 35px rgba(99, 102, 241, 0.15);
            position: relative;
            z-index: 10;
        }

        .brand-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .brand-icon {
            width: 52px;
            height: 52px;
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 0.85rem;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
            color: white;
            font-size: 1.5rem;
            font-weight: 800;
        }

        .title {
            font-family: 'Outfit', sans-serif;
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            margin-bottom: 0.35rem;
            color: #ffffff;
        }

        .subtitle {
            font-size: 0.9rem;
            color: var(--text-secondary);
        }

        .alert-error {
            background: rgba(244, 63, 94, 0.15);
            border: 1px solid rgba(244, 63, 94, 0.3);
            color: #fb7185;
            padding: 0.85rem 1rem;
            border-radius: 10px;
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
        }

        @media (max-width: 600px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #cbd5e1;
            margin-bottom: 0.45rem;
        }

        .form-input, .form-select {
            width: 100%;
            padding: 0.85rem 1.15rem;
            background: rgba(9, 13, 22, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 12px;
            color: white;
            font-size: 0.95rem;
            font-family: inherit;
            outline: none;
            transition: all 0.2s;
        }

        .form-input:focus, .form-select:focus {
            border-color: #818cf8;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.25);
            background: rgba(15, 23, 42, 0.95);
        }

        .radio-group {
            display: flex;
            gap: 1.5rem;
            align-items: center;
            height: 48px;
        }

        .radio-label {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: #cbd5e1;
            cursor: pointer;
        }

        .section-separator {
            grid-column: 1 / -1;
            margin: 0.5rem 0 0.25rem 0;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            font-family: 'Outfit', sans-serif;
            font-size: 1.1rem;
            font-weight: 700;
            color: #818cf8;
        }

        .btn-submit {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.05rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
            margin-top: 1rem;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #4f46e5, #4338ca);
            transform: translateY(-2px);
        }

        .footer-links {
            margin-top: 1.75rem;
            text-align: center;
            font-size: 0.85rem;
            color: var(--text-secondary);
        }

        .footer-links a {
            color: #a5b4fc;
            text-decoration: none;
            font-weight: 600;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="signup-card">
    <div class="brand-header">
        <div class="brand-icon">
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><line x1="19" y1="8" x2="19" y2="14"></line><line x1="22" y1="11" x2="16" y2="11"></line></svg>
        </div>
        <h1 class="title">Create Patient Account</h1>
        <p class="subtitle">Join OmniHealth for verified doctor consults and home medicine delivery</p>
    </div>

    <%
        String signupError = (String) session.getAttribute("signupError");
        if(signupError != null){
    %>
    <div class="alert-error">
        <%= signupError %>
    </div>
    <%
            session.removeAttribute("signupError");
        }
    %>

    <form method="post" action="${pageContext.request.contextPath}/patient/signup">
        <div class="form-grid">

            <div class="form-group">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-input" placeholder="e.g. John Doe" required>
            </div>

            <div class="form-group">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-input" placeholder="e.g. john@example.com" required>
            </div>

            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-input" placeholder="Choose a secure password" required>
            </div>

            <div class="form-group">
                <label class="form-label">Contact Phone</label>
                <input type="text" name="phone" class="form-input" placeholder="e.g. +91 9876543210" required>
            </div>

            <div class="form-group">
                <label class="form-label">Gender</label>
                <div class="radio-group">
                    <label class="radio-label">
                        <input type="radio" name="gender" value="male" checked> Male
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="gender" value="female"> Female
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Blood Group</label>
                <select name="bloodgroup" class="form-select" required>
                    <option value="O+">O Positive (O+)</option>
                    <option value="O-">O Negative (O-)</option>
                    <option value="A+">A Positive (A+)</option>
                    <option value="A-">A Negative (A-)</option>
                    <option value="B+">B Positive (B+)</option>
                    <option value="B-">B Negative (B-)</option>
                    <option value="AB+">AB Positive (AB+)</option>
                    <option value="AB-">AB Negative (AB-)</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">Date of Birth</label>
                <input type="date" name="dob" class="form-input" required>
            </div>

            <div class="form-group">
                <label class="form-label">Residential Address</label>
                <input type="text" name="address" class="form-input" placeholder="Street, City, Pin Code" required>
            </div>

            <!-- EMERGENCY CONTACT SECTION -->
            <div class="section-separator">
                🚨 Emergency Contact Guardian
            </div>

            <div class="form-group">
                <label class="form-label">Guardian / Kin Name</label>
                <input type="text" name="emergency_name" class="form-input" placeholder="e.g. Mary Doe">
            </div>

            <div class="form-group">
                <label class="form-label">Relationship</label>
                <input type="text" name="emergency_relation" class="form-input" placeholder="e.g. Mother, Spouse, Brother">
            </div>

            <div class="form-group full-width">
                <label class="form-label">Emergency Hotline Number</label>
                <input type="text" name="emergency_contact" class="form-input" placeholder="e.g. +91 9123456789">
            </div>

        </div>

        <button type="submit" class="btn-submit">
            Complete Patient Registration &rarr;
        </button>
    </form>

    <div class="footer-links">
        Already registered? <a href="${pageContext.request.contextPath}/patient/Login.jsp">Sign In Here</a> &bull; 
        <a href="${pageContext.request.contextPath}/MainLogin.jsp">Return to Home</a>
    </div>
</div>

</body>
</html>
