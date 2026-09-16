<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Emergency Request Failed</title>

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

        .failure-container {
            width: 100%;
            max-width: 560px;

            background: white;

            padding: 40px 35px;

            border-radius: 20px;

            text-align: center;

            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
        }

        .failure-icon {
            width: 80px;
            height: 80px;

            margin: 0 auto 20px;

            display: flex;
            justify-content: center;
            align-items: center;

            border-radius: 50%;

            background: #ffebee;

            color: #c62828;

            font-size: 42px;
            font-weight: bold;
        }

        h1 {
            margin: 0 0 15px;

            color: #b71c1c;

            font-size: 30px;
        }

        .message {
            margin-bottom: 30px;

            color: #555;

            font-size: 16px;

            line-height: 1.6;
        }

        .error-box {
            padding: 18px;

            margin-bottom: 30px;

            border-radius: 12px;

            background: #fff5f5;

            border: 1px solid #ffcdd2;

            color: #555;

            font-size: 14px;

            line-height: 1.5;
        }

        .retry-button {
            display: inline-block;

            padding: 13px 28px;

            border-radius: 10px;

            background: #c62828;

            color: white;

            text-decoration: none;

            font-size: 16px;

            font-weight: bold;

            transition: 0.3s;
        }

        .retry-button:hover {
            background: #8e0000;

            transform: translateY(-2px);
        }

        .home-button {
            display: inline-block;

            margin-top: 15px;

            padding: 11px 24px;

            border-radius: 10px;

            background: #eeeeee;

            color: #444;

            text-decoration: none;

            font-size: 14px;

            font-weight: bold;

            transition: 0.3s;
        }

        .home-button:hover {
            background: #dddddd;
        }

        @media (max-width: 600px) {

            .failure-container {
                padding: 30px 20px;
            }

            h1 {
                font-size: 25px;
            }

            .failure-icon {
                width: 70px;
                height: 70px;

                font-size: 36px;
            }

            .retry-button,
            .home-button {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="failure-container">

    <div class="failure-icon">
        !
    </div>

    <h1>Emergency Request Failed</h1>

    <p class="message">
        We were unable to submit your emergency request.
        Please try again.
    </p>

    <div class="error-box">
        Something went wrong while processing your request.
        Please check your information and try again.
    </div>

    <a href="emergency/emergency.jsp" class="retry-button">
        Try Again
    </a>

    <br>

    <a href="../index.jsp" class="home-button">
        Back to Home
    </a>

</div>

</body>
</html>