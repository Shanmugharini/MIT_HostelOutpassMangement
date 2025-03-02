<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MIT Hostel</title>
     <style>
            /* Reset some default styling */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            /* Overall page styling */
            body {
                display: flex;
                background-color: #cce7ff;
            }
            /* Sidebar styling */
                    .sidebar {
                        width: 200px;
                        background-color: #002c6d;
                        color: white;
                        padding: 20px;
                        height: 100vh;
                    }

                    .sidebar h2 {
                        margin-bottom: 20px;
                        text-align: center;
                    }
                      .sidebar a {
                                display: block;
                                color: white;
                                text-decoration: none;
                                padding: 10px 0;
                                margin: 10px 0;
                                text-align: center;
                            }

                            .sidebar a:hover {
                                background-color: #00449b;
                                border-radius: 5px;
                            }
                           .main-content {
                                       flex: 1;
                                       display: flex;
                                       justify-content: center;
                                       align-items: center;
                                       padding: 20px;
                                   }

                                   .profile-card {
                                       background-color: white;
                                       width: 300px;
                                       padding: 20px;
                                       border-radius: 10px;
                                       box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                                       text-align: center;
                                   }
                                      .profile-card img {
                                               width: 100px;
                                               height: 100px;
                                               border-radius: 50%;
                                               margin-bottom: 20px;
                                           }

                                           .profile-card .info {
                                               margin: 10px 0;
                                           }

                                           .profile-card .info label {
                                               display: block;
                                               font-weight: bold;
                                               margin-bottom: 5px;
                                           }
                                           .profile-card .info span {
                                                       display: block;
                                                       padding: 5px;
                                                       background-color: #f2f2f2;
                                                       border-radius: 5px;
                                                   }

                                                   /* Log Out button styling */
                                                   .logout {
                                                       margin-top: 20px;
                                                       padding: 10px 20px;
                                                       background-color: red;
                                                       color: white;
                                                       border: none;
                                                       border-radius: 5px;
                                                       cursor: pointer;
                                                   }

                                                   .logout:hover {
                                                       background-color: darkred;
                                                   }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <h2>MIT Hostel</h2>
        <a href="#">Home</a>
        <a href="outpassForm.jsp">Request Pass</a>
        <a href="CurrentPassServlet">Current Pass</a>
         <a href="RejectedPassServlet">Rejected Pass</a>
        <a href="PassHistoryServlet">Pass History</a>
        <form action="index.jsp" method="post">
            <button type="submit" class="logout">Log Out</button>
        </form>
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
        <div class="profile-card">
            <img src="img/stud.jpg" alt="Profile Picture">
            <div class="info">
                <label>Roll Number</label>
                <span><%= request.getAttribute("rollNumber") != null ? request.getAttribute("rollNumber"):"2022503568" %></span>
            </div>
            <div class="info">
                <label>Name</label>
                <span><%= request.getAttribute("name") != null ? request.getAttribute("name"):"B.Shanmugaharini" %></span>
            </div>
            <div class="info">
                <label>Department</label>
                <span><%= request.getAttribute("department") != null ? request.getAttribute("department") :"CT" %></span>
            </div>
            <div class="info">
                <label>Batch</label>
                <span><%= request.getAttribute("hostel") != null ? request.getAttribute("hostel") : "Ponni" %></span>
            </div>
        </div>
    </div>

</body>
</html>
