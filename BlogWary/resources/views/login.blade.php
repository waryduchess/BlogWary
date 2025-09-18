<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="{{ asset('css/login.css') }}">
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