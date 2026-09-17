<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Login - Online Medical System</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }
        body {
            margin: 0;
            background: #f4f7fb;
            color: #2c3e50;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .login-card {
            background: white;
            width: 440px;
            max-width: 90%;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            border: 1px solid #e2e8f0;
        }
        .login-header {
            text-align: center;
            margin-bottom: 28px;
        }
        .logo-icon {
            font-size: 38px;
            color: #244b6b;
            margin-bottom: 8px;
            display: inline-block;
        }
        .login-title {
            margin: 0;
            font-size: 24px;
            color: #244b6b;
            font-weight: 700;
        }
        .login-subtitle {
            margin-top: 6px;
            color: #64748b;
            font-size: 14px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 13px;
            color: #334155;
        }
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.2s;
        }
        input:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #244b6b;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background: #1a3650;
        }
        .alert {
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 13px;
        }
        .alert-danger {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
        .alert-success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }
        .login-footer {
            margin-top: 24px;
            text-align: center;
            font-size: 13px;
            color: #64748b;
        }
        .login-footer a {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
        }
        .login-footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <div class="logo-icon">⚕</div>
        <h1 class="login-title">Doctor Portal Login</h1>
        <p class="login-subtitle">Sign in to manage appointments & consultations</p>
    </div>

    <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null && !errorMessage.isEmpty()) { 
    %>
        <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <% 
        String logoutParam = request.getParameter("logout");
        if ("1".equals(logoutParam)) { 
    %>
        <div class="alert alert-success">You have logged out successfully.</div>
    <% } %>

    <form action="<%= request.getContextPath() %>/DoctorLoginServlet" method="POST">
        <div class="form-group">
            <label for="email">Doctor Email Address</label>
            <input type="email" id="email" name="email" placeholder="doctor@hospital.com" required autofocus>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-submit">Sign In to Dashboard</button>
    </form>

    <div class="login-footer">
        Are you a new doctor? <a href="<%= request.getContextPath() %>/DoctorRegisterServlet">Register Here</a>
    </div>
</div>

</body>
</html>
