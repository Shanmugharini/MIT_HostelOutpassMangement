<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submission Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f9;
        }

        .message-container {
            width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .message-container h2 {
            color: green;
        }

        .cancel-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: red;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .cancel-button:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>

<div class="message-container">
    <h2>Your outpass form submitted successfully!</h2>
    <button class="cancel-button" onclick="goBack()">Cancel</button>
</div>

<script>
    function goBack() {
        // Go back to the previous page
        window.history.back();
    }
</script>

</body>
</html>
