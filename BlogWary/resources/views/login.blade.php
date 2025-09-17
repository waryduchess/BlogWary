<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f3f4f6;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        #login {
            width: 400px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        fieldset {
            border: 2px dotted #6366f1;
            padding: 20px;
            border-radius: 4px;
        }

        legend {
            padding: 0 10px;
            color: #6366f1;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #4f46e5;
            font-size: 14px;
        }

        label:after {
            content: '*';
            color: #ef4444;
            margin-left: 4px;
        }

        input {
            width: 100%;
            padding: 8px;
            border: 1px solid #e5e7eb;
            border-radius: 4px;
            box-sizing: border-box;
            margin-top: 5px;
        }

        input:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.2);
        }

        .forgot-password {
            display: block;
            text-align: right;
            color: #6366f1;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #6366f1;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background-color: #4f46e5;
        }
    </style>
</head>
<body>
    <div id="login">
        <form action="" method="post">
            @csrf
            <fieldset>
                <legend>Welcome again!</legend>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" name="email" id="email" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" required>
                </div>

                <a href="#" class="forgot-password">Forgot Password?</a>

                <button type="submit">Log In</button>
            </fieldset>
        </form>
    </div>
</body>
</html>