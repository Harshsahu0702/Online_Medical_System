<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Emergency</title>
        <style>
            * {
                 box-sizing: border-box;
                }
            html {
                width: 100%;
                min-height: 100%;
            }
            body {
                margin: 0;
                width: 100%;
                min-height: 100vh;
                min-height: 100dvh;
                font-family: Arial, Helvetica, sans-serif;
                background: linear-gradient(
                135deg,
                #f8f9fa,
                #e9ecef
                );
                overflow-x: hidden;
                overflow-y: auto;
                padding: clamp(20px, 5vh, 50px) 16px;
            }
            .emergency-container {
                width: 100%;
                max-width: 560px;
                margin: 0 auto;
                background-color: white;
                padding: clamp(24px, 4vw, 40px);
                border-radius: 14px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
                }
                h1 {
                    margin: 0 0 10px 0;
                    text-align: center;
                    font-size: clamp(24px, 4vw, 32px);
                    color: #c62828;
                    line-height: 1.2;
                }
                .info {
                    margin: 0 0 clamp(22px, 4vh, 32px) 0;
                    text-align: center;
                    color: #666;
                    font-size: clamp(14px, 2vw, 16px);
                    line-height: 1.5;
                    }
                    .form-group {
                               margin-bottom: clamp(16px, 3vh, 22px);
                    }
                label {
                    display: block;
                    margin-bottom: 7px;
                    font-size: clamp(14px, 2vw, 16px);
                    font-weight: bold;
                    color: #333;
                }
                input[type="text"],
                input[type="tel"],
                select,
                textarea {
                        width: 100%;
                        padding: 12px 14px;
                        border: 1px solid #ccc;
                        border-radius: 7px;
                        font-family: Arial, Helvetica, sans-serif;
                        font-size: 16px;
                        background-color: white;
                        transition: border-color 0.2s, box-shadow 0.2s;
                }
                input[type="text"]:focus,
                input[type="tel"]:focus,
                select:focus,
                textarea:focus {
                    outline: none;
                    border-color: #d32f2f;
                    box-shadow: 0 0 0 3px rgba(211, 47, 47, 0.12);
                }
                textarea {
                    width: 100%;
                    min-height: 110px;
                    resize: vertical;
                }
                .buttons {
                    display: flex;
                    gap: 12px;
                    margin-top: 26px;
                    }
                input[type="submit"],
                input[type="reset"] {
                        min-height: 44px;
                        padding: 11px 18px;
                        border: none;
                        border-radius: 7px;
                        font-size: 15px;
                        cursor: pointer;
                        transition: 0.2s;
                    }
                    input[type="submit"] {
                            flex: 1;    
                            background-color: #d32f2f;
                            color: white;
                            font-weight: bold;
                        }
                    input[type="submit"]:hover {
                            background-color: #b71c1c;
                    }
                    input[type="reset"] {
                            flex: 0 0 110px;
                            background-color: #e9ecef;
                            color: #333;
                        }
                    input[type="reset"]:hover {
                            background-color: #d6d8db;
                     }
                     @media (max-width: 600px) {
                                body {
                                    padding: 16px 10px;
                            }
                    .emergency-container {
                            padding: 24px 20px;
                            border-radius: 10px;
                            }
                    .buttons {
                            flex-direction: column;
                        }
                    input[type="submit"],
                    input[type="reset"] {
                            width: 100%;
                            flex: none;
                        }
                    }
                    @media (max-width: 350px) {
                            body {
                                padding: 10px 6px;
                            }
                            .emergency-container {
                                    padding: 20px 15px;
                            }
                            input[type="text"],
                            input[type="tel"],
                            select,
                            textarea {
                                    padding: 10px;
                        }
                    }
          </style>
        <script>
            function validate()
            {
                let type = document.forms["emergency"]["type"].value;
                let description = document.forms["emergency"]["description"].value.trim();
                let location = document.forms["emergency"]["location"].value.trim(); 
                let contact = document.forms["emergency"]["contact"].value.trim();
                if(type==null || type=="")
                {
                    alert("please select emergency type");
                    return false;
                }
                if(description==null || description=="")
                {
                    alert("please enter an emergency description");
                    return false;
                }
                if(location==null || location=="")
                {
                    alert("please enter emergency location");
                    return false;
                }
                if(contact==null || contact=="")
                {
                    alert("please enter contact number");
                    return false;
                }
                if (!/^[6-9][0-9]{9}$/.test(contact)) 
                { 
                    alert("Please enter a valid 10-digit mobile number."); 
                    return false; 
                }
                return true;
            }   
           
            </script>
    </head>
    <body>
        <div class="emergency-container">
            <h1>Emergency Assistance</h1>
            <p class="info">
                Please provide the following information for an emergency
                assistance to be arranged
            </p>
            <form name="emergency" method="post" onsubmit="return validate()" action="emergency">
                <div class="form-group">
                    <label for="type">Emergency Type</label>
                    <select name="type" id="type">
                        <option value="">---Select Emergency Type---</option>
                        <option value="Accident">Accident</option>
                        <option value="Injury">Injury</option>
                        <option value="Breathing Problem">Breathing Problem</option>
                        <option value="Unconsciousness">Unconsciousness</option>
                        <option value="Severe Illness">Severe Illness</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Emergency Description</label>
                    <textarea name="description" id="description" rows="5" 
                        placeholder="Briefly describe the emergency..."></textarea>
                </div>
                <div class="form-group">
                    <label for="location">Location</label>
                    <input name="location" id="location" type="text" placeholder="Enter Emergency Location">
                </div>
                <div class="form-group">
                    <label for="contact">Contact No:</label>
                    <input name="contact" id="contact" type="tel" placeholder="Enter 10-digit mobile no" maxlength="10">
                </div>
                <div class="buttons">
                    <input type="submit" value="Submit Emergency Request">
                    <input type="reset" value="Reset">
                </div>
            </form>
        </div>
    </body>
</html>