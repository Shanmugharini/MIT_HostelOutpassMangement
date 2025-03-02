<!DOCTYPE html>
<html>
<head>
    <title>User Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-container label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        .form-container input, .form-container select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-container button {
            width: 100%;
            padding: 10px;
            background-color: #0A3981;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #0056b3;
        }
        .logout{
                            background-color: #f8d7da;
                            color: #721c24;
                            padding: 10px;
                            margin-top: 20px;
                            text-align: center;
                             width: 100%;
                             border:none;
                                        font-weight: bold;
                        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add RC</h2>
        <form action="SubmitForm" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="block">Block:</label>
            <select id="block" name="block" required>
                <option value="">--Select Block--</option>
                <option value="Ponni">Ponni</option>
                <option value="vagai">vagai</option>
                <option value="Kaveri">Kaveri</option>
                <option value="NRI">NRI</option>
            </select>

            <button type="submit">Submit</button>
        </form>
        <form action="executive.jsp" method="post">
                                        <button type="submit" class="logout">Go back</button>
                                    </form>
    </div>
</body>
</html>
