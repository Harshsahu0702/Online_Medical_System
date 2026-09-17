<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Emergency Request Submitted</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            min-height: 100dvh;

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 30px 16px;

            font-family: Arial, sans-serif;

            background: linear-gradient(
                135deg,
                #dff6ff,
                #e8f5e9
            );

            overflow-x: hidden;
        }

        .success-container {
            width: 100%;
            max-width: 560px;

            background: white;

            padding: 40px 35px;

            border-radius: 20px;

            text-align: center;

            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
        }

        .success-icon {
            width: 80px;
            height: 80px;

            margin: 0 auto 20px;

            display: flex;
            justify-content: center;
            align-items: center;

            border-radius: 50%;

            background: #e8f5e9;

            color: #2e7d32;

            font-size: 45px;
            font-weight: bold;
        }

        h1 {
            margin: 0 0 15px;

            color: #1b5e20;

            font-size: 30px;
        }

        .message {
            margin-bottom: 30px;

            color: #555;

            font-size: 16px;

            line-height: 1.6;
        }

        .details {
            padding: 20px;

            margin-bottom: 30px;

            border-radius: 12px;

            background: #f5f5f5;

            text-align: left;
        }

        .detail-row {
            display: flex;

            justify-content: space-between;

            gap: 20px;

            padding: 10px 0;

            border-bottom: 1px solid #ddd;

            font-size: 15px;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .label {
            font-weight: bold;

            color: #555;
        }

        .value {
            color: #222;

            font-weight: 500;

            text-align: right;
        }

        .status {
            color: #f57c00;
        }

        .home-button {
            display: inline-block;

            padding: 13px 28px;

            border-radius: 10px;

            background: #2e7d32;

            color: white;

            text-decoration: none;

            font-size: 16px;

            font-weight: bold;

            transition: 0.3s;
        }

        .home-button:hover {
            background: #1b5e20;

            transform: translateY(-2px);
        }

        .note {
            margin-top: 20px;

            font-size: 13px;

            color: #777;

            line-height: 1.5;
        }

        @media (max-width: 600px) {

            .success-container {
                padding: 30px 20px;
            }

            h1 {
                font-size: 25px;
            }

            .success-icon {
                width: 70px;
                height: 70px;

                font-size: 38px;
            }

            .detail-row {
                flex-direction: column;

                gap: 4px;
            }

            .value {
                text-align: left;
            }

            .home-button {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<%
    Integer emergencyID = (Integer) request.getAttribute("emergencyID");
%>

<div class="success-container">

    <div class="success-icon">
        ✓
    </div>

    <h1>Emergency Request Submitted</h1>

    <p class="message">
        Your emergency request has been successfully submitted.
        Our medical team has received your request and will respond accordingly.
    </p>

    <div class="details">

        <div class="detail-row">
            <span class="label">Emergency ID</span>

            <span class="value">
                <%= emergencyID %>
            </span>
        </div>

        <div class="detail-row">
            <span class="label">Status</span>

            <span class="value status">
                Pending
            </span>
        </div>

    </div>

    <a href="../index.jsp" class="home-button">
        Back to Home
    </a>

    <p class="note">
        Please keep your Emergency ID for future reference.
    </p>

</div>

</body>
</html>