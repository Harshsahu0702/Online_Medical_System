<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Portal Sign In - OmniHealth</title>
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
            padding: 2rem 1rem;
            position: relative;
            overflow-x: hidden;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(99, 102, 241, 0.18) 0%, transparent 40%),
                radial-gradient(circle at 90% 80%, rgba(2, 132, 199, 0.15) 0%, transparent 40%);
        }

        .login-card {
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 24px;
            padding: 2.75rem 2.5rem;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 25px 60px -15px rgba(0, 0, 0, 0.7), 0 0 35px rgba(99, 102, 241, 0.15);
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
            margin-bottom: 1rem;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
            color: white;
            font-size: 1.5rem;
            font-weight: 800;
        }

        .title {
            font-family: 'Outfit', sans-serif;
            font-size: 1.85rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            margin-bottom: 0.35rem;
            color: #ffffff;
        }

        .subtitle {
            font-size: 0.875rem;
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

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #cbd5e1;
            margin-bottom: 0.45rem;
        }

        .form-input {
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

        .form-input:focus {
            border-color: #818cf8;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.25);
            background: rgba(15, 23, 42, 0.95);
        }

        .btn-submit {
            width: 100%;
            padding: 0.95rem;
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
            margin-top: 0.5rem;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #4f46e5, #4338ca);
            transform: translateY(-2px);
        }

        /* Demo helper box */
        .demo-helper {
            margin-top: 1.5rem;
            padding: 1.15rem;
            background: rgba(99, 102, 241, 0.08);
            border: 1px dashed rgba(99, 102, 241, 0.3);
            border-radius: 14px;
            font-size: 0.825rem;
        }

        .demo-helper-title {
            display: flex;
            justify-content: space-between;
            font-weight: 700;
            color: #a5b4fc;
            margin-bottom: 0.5rem;
        }

        .btn-demo-fill {
            width: 100%;
            margin-top: 0.75rem;
            padding: 0.55rem;
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 8px;
            color: #ffffff;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-demo-fill:hover {
            background: rgba(99, 102, 241, 0.25);
            border-color: #818cf8;
            color: #a5b4fc;
        }

        .footer-links {
            margin-top: 1.75rem;
            text-align: center;
            font-size: 0.85rem;
            color: var(--text-secondary);
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
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

<div class="login-card">
    <div class="brand-header">
        <div class="brand-icon">
            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
        </div>
        <h1 class="title">Patient Portal</h1>
        <p class="subtitle">Sign in to manage appointments, prescriptions &amp; health records</p>
    </div>

    <%
        String loginError = (String) session.getAttribute("loginError");
        if(loginError != null){
    %>
    <div class="alert-error">
        <%= loginError %>
    </div>
    <%
            session.removeAttribute("loginError");
        }
    %>

    <form method="post" action="${pageContext.request.contextPath}/patient/login" id="patientForm">
        <div class="form-group">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" id="patEmailInput" class="form-input" placeholder="e.g. nikhil@gmail.com" required autofocus>
        </div>

        <div class="form-group">
            <label class="form-label">Password</label>
            <input type="password" name="password" id="patPassInput" class="form-input" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-submit">
            Sign In &rarr;
        </button>
    </form>

    <div class="demo-helper">
        <div class="demo-helper-title">
            <span>✨ Viva Demo Patient</span>
            <span>Verified</span>
        </div>
        <div style="color: #cbd5e1; font-family: monospace;">Email: nikhil@gmail.com</div>
        <div style="color: #cbd5e1; font-family: monospace;">Pass: nikhil</div>
        <button type="button" class="btn-demo-fill" onclick="fillAndSubmit()">
            ⚡ 1-Click Fill &amp; Sign In
        </button>
    </div>

    <div class="footer-links">
        <div>
            New patient? <a href="${pageContext.request.contextPath}/patient/Signup.jsp">Register for Care</a>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/MainLogin.jsp" style="color: var(--text-secondary);">&larr; Return to Healthcare Ecosystem</a>
        </div>
    </div>
</div>

<script>
    function fillAndSubmit() {
        document.getElementById('patEmailInput').value = 'nikhil@gmail.com';
        document.getElementById('patPassInput').value = 'nikhil';
        document.getElementById('patientForm').submit();
    }
</script>

</body>
</html>
