<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String loggedOut = request.getParameter("loggedOut");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrator Sign In - OmniHealth Master Console</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: #0f172a;
            color: #f8fafc;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 1.5rem;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: "";
            position: absolute;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(79, 70, 229, 0.25) 0%, rgba(15, 23, 42, 0) 70%);
            top: -100px;
            right: -100px;
            border-radius: 50%;
        }

        body::after {
            content: "";
            position: absolute;
            width: 450px;
            height: 450px;
            background: radial-gradient(circle, rgba(2, 132, 199, 0.2) 0%, rgba(15, 23, 42, 0) 70%);
            bottom: -100px;
            left: -100px;
            border-radius: 50%;
        }

        .login-card {
            background: rgba(30, 41, 59, 0.85);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2.5rem;
            width: 100%;
            max-width: 440px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            position: relative;
            z-index: 10;
        }

        .brand-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .brand-icon {
            width: 54px;
            height: 54px;
            background: linear-gradient(135deg, #6366f1 0%, #4338ca 100%);
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
        }

        .title {
            font-size: 1.6rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            margin: 0 0 0.35rem 0;
            color: white;
        }

        .subtitle {
            font-size: 0.875rem;
            color: #94a3b8;
            margin: 0;
        }

        .alert {
            padding: 0.85rem 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.875rem;
            font-weight: 600;
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.2);
            border: 1px solid rgba(239, 68, 68, 0.4);
            color: #fca5a5;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.2);
            border: 1px solid rgba(16, 185, 129, 0.4);
            color: #a7f3d0;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-label {
            display: block;
            font-size: 0.825rem;
            font-weight: 600;
            color: #cbd5e1;
            margin-bottom: 0.45rem;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem 1rem;
            background: rgba(15, 23, 42, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 8px;
            color: white;
            font-size: 0.95rem;
            font-family: inherit;
            box-sizing: border-box;
            outline: none;
            transition: all 0.2s;
        }

        .form-input:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.3);
            background: rgba(15, 23, 42, 0.9);
        }

        .btn-submit {
            width: 100%;
            background: #4f46e5;
            color: white;
            padding: 0.85rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.95rem;
            border: none;
            cursor: pointer;
            transition: background 0.15s;
            margin-top: 0.5rem;
        }

        .btn-submit:hover {
            background: #4338ca;
        }

        .footer-links {
            margin-top: 1.75rem;
            text-align: center;
            font-size: 0.85rem;
            color: #94a3b8;
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
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
        </div>
        <h1 class="title">OmniHealth Admin</h1>
        <p class="subtitle">Platform Security & Governance Gateway</p>
    </div>

    <% if (errorMessage != null) { %>
    <div class="alert alert-danger">
        <%= errorMessage %>
    </div>
    <% } %>

    <% if ("true".equals(loggedOut)) { %>
    <div class="alert alert-success">
        Administrator signed out safely.
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/AdminLoginServlet" method="post">
        <div class="form-group">
            <label class="form-label">Administrator Email</label>
            <input type="email" name="email" class="form-input" value="admin@omnihealth.com" required autofocus>
        </div>

        <div class="form-group">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-input" value="admin123" required>
        </div>

        <button type="submit" class="btn-submit">
            Enter Admin Console &rarr;
        </button>
    </form>

    <div class="footer-links">
        <a href="<%= request.getContextPath() %>/MainLogin.jsp">&larr; Return to Healthcare Portals</a>
    </div>
</div>

</body>
</html>
