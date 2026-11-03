<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String err = (String) request.getAttribute("errorMessage");
    if (err == null) {
        err = request.getParameter("error");
    }
    String enteredEmail = (String) request.getAttribute("enteredEmail");
    if (enteredEmail == null) {
        enteredEmail = "";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PharmaCare Pro | Pharmacy Partner Sign-In</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --pharm-primary: #059669;
            --pharm-primary-hover: #047857;
            --pharm-light: #ecfdf5;
            --pharm-border: #a7f3d0;
            --pharm-dark: #0f172a;
            --pharm-slate: #334155;
            --pharm-muted: #64748b;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #f0fdf4 0%, #f8fafc 50%, #ecfdf5 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px 16px;
            color: var(--pharm-slate);
        }

        .login-card {
            background: #ffffff;
            width: 440px;
            max-width: 100%;
            padding: 40px 36px;
            border-radius: 20px;
            box-shadow: 0 20px 45px -10px rgba(5, 150, 105, 0.14), 0 0 0 1px rgba(16, 185, 129, 0.15);
        }

        .login-header {
            text-align: center;
            margin-bottom: 28px;
        }

        .logo-icon-wrap {
            width: 58px;
            height: 58px;
            background: linear-gradient(135deg, #10b981 0%, #047857 100%);
            color: white;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 14px auto;
            font-size: 28px;
            box-shadow: 0 8px 20px -4px rgba(16, 185, 129, 0.4);
        }

        .login-title {
            font-family: 'Outfit', sans-serif;
            font-size: 24px;
            font-weight: 800;
            color: #064e3b;
            letter-spacing: -0.02em;
        }

        .login-subtitle {
            margin-top: 6px;
            color: var(--pharm-muted);
            font-size: 13px;
            line-height: 1.5;
        }

        .alert-error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #991b1b;
            padding: 12px 14px;
            border-radius: 10px;
            font-size: 13px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            font-size: 13px;
            color: #1e293b;
        }

        .input-box {
            width: 100%;
            height: 46px;
            padding: 0 14px;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            font-family: inherit;
            color: #0f172a;
            background: #f8fafc;
            outline: none;
            transition: all 0.2s ease;
        }

        .input-box:focus {
            border-color: #059669;
            background: #ffffff;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.2);
        }

        .btn-submit {
            width: 100%;
            height: 46px;
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(5, 150, 105, 0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #047857 0%, #059669 100%);
            box-shadow: 0 6px 16px rgba(5, 150, 105, 0.35);
            transform: translateY(-1px);
        }

        .demo-box {
            margin-top: 24px;
            padding: 14px;
            background: #ecfdf5;
            border: 1px dashed #6ee7b7;
            border-radius: 12px;
            text-align: center;
        }

        .demo-header {
            font-size: 12px;
            font-weight: 700;
            color: #065f46;
            margin-bottom: 4px;
        }

        .demo-creds {
            font-size: 12px;
            color: #047857;
            margin-bottom: 10px;
            font-family: monospace;
        }

        .btn-autofill {
            width: 100%;
            padding: 8px 12px;
            background: #ffffff;
            border: 1px solid #a7f3d0;
            border-radius: 8px;
            color: #065f46;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.15s;
        }

        .btn-autofill:hover {
            background: #d1fae5;
            border-color: #34d399;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: var(--pharm-muted);
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: color 0.15s;
        }

        .back-link:hover {
            color: var(--pharm-primary);
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <div class="logo-icon-wrap">💊</div>
        <h1 class="login-title">PharmaCare Pro</h1>
        <p class="login-subtitle">Sign in to manage medicine catalog, stock depletion alerts, and patient prescription fulfillments.</p>
    </div>

    <% if (err != null && !err.trim().isEmpty()) { %>
        <div class="alert-error">
            <span>⚠️</span>
            <span><%= err %></span>
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/PharmacyLoginServlet" method="post" id="pharmacyLoginForm">
        <div class="form-group">
            <label for="pharmacyEmail">Registered Pharmacy Email</label>
            <input type="email" id="pharmacyEmail" name="email" class="input-box"
                   placeholder="pharmacare@omnihealth.com" value="<%= enteredEmail %>" required autocomplete="email">
        </div>

        <div class="form-group">
            <label for="pharmacyPassword">Password</label>
            <input type="password" id="pharmacyPassword" name="password" class="input-box"
                   placeholder="••••••••" required autocomplete="current-password">
        </div>

        <button type="submit" class="btn-submit">
            Sign In to Pharmacy Portal &rarr;
        </button>
    </form>

    <div class="demo-box">
        <div class="demo-header">💊 Live Partner Pharmacy Credentials:</div>
        <div class="demo-creds">pharmacare@omnihealth.com &bull; admin123</div>
        <button type="button" class="btn-autofill" onclick="autofillDemo()">
            ⚡ 1-Click Fill &amp; Sign In
        </button>
    </div>

    <a href="${pageContext.request.contextPath}/MainLogin.jsp" class="back-link">
        &larr; Return to Healthcare Main Portal
    </a>
</div>

<script>
function autofillDemo() {
    document.getElementById('pharmacyEmail').value = 'pharmacare@omnihealth.com';
    document.getElementById('pharmacyPassword').value = 'admin123';
    document.getElementById('pharmacyLoginForm').submit();
}
</script>

</body>
</html>

