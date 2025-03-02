<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login</title>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Sansita+Swashed:wght@600&display=swap");

        body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(45deg, greenyellow, dodgerblue);
            font-family: "Sansita Swashed", cursive;
        }

        .center {
            position: relative;
            padding: 50px 50px;
            background: #fff;
            border-radius: 10px;
        }

        .center h1 {
            font-size: 2em;
            border-left: 5px solid dodgerblue;
            padding: 10px;
            color: #000;
            letter-spacing: 5px;
            margin-bottom: 60px;
            font-weight: bold;
            padding-left: 10px;
        }

        .center .inputbox {
            position: relative;
            width: 300px;
            height: 50px;
            margin-bottom: 50px;
        }

        .center .inputbox input {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            border: 2px solid #000;
            outline: none;
            background: none;
            padding: 10px;
            border-radius: 10px;
            font-size: 1.2em;
        }

        .center .inputbox:last-child {
            margin-bottom: 0;
        }

        .center .inputbox span {
            position: absolute;
            top: 14px;
            left: 20px;
            font-size: 1em;
            transition: 0.6s;
            font-family: sans-serif;
        }

        .center .inputbox input:focus ~ span,
        .center .inputbox input:valid ~ span {
            transform: translateX(-13px) translateY(-35px);
            font-size: 1em;
        }

        .center .inputbox [type="button"] {
            width: 50%;
            background: dodgerblue;
            color: #fff;
            border: #fff;
            cursor: pointer;
        }

        .center .inputbox:hover [type="button"] {
            background: linear-gradient(45deg, greenyellow, dodgerblue);
        }

        /* Add styling for the error and success messages */
        .message {
            padding: 10px;
            text-align: center;
            font-weight: bold;
        }
        .error {
            color: #721c24;
            background-color: #f8d7da;
        }
        .success {
            color: #155724;
            background-color: #d4edda;
        }
    </style>
</head>
<body>
    <div class="center">
        <h1>Student Login</h1>

        <!-- Display success or error messages -->
        <%
            String message = request.getParameter("message");
            if (message != null) {
                String messageClass = message.equals("Please sign up") ? "error" : "success";
        %>
            <div class="message <%= messageClass %>">
                <%= message %>
            </div>
        <% } %>

        <form id="loginForm" action="StudentLoginServlet" method="post">
            <div class="inputbox">
                <input type="text" id="username" name="username" required="required">
                <span>Username</span>
            </div>
            <div class="inputbox">
                <input type="password" id="password" name="password" required="required">
                <span>Password</span>
            </div>
            <div class="inputbox">
                <input type="submit" value="Submit">
            </div>
        </form>

        <!-- Sign up button that redirects to the sign-up page -->
        <div class="inputbox">
            <a href="student_registration.jsp">
                <input type="button" value="Sign Up">
            </a>
        </div>
    </div>

    <script>
        // Validate form before submission
        document.getElementById('loginForm').onsubmit = function(e) {
            const password = document.getElementById('password').value;

            // Password validation: at least 6 characters
            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                e.preventDefault(); // Prevent form submission
            }
        };
    </script>
</body>
</html>
