<?php
    session_start();
    if ($_SESSION["login"] != "YES") {
	  header("Location: home.html");
	}
        $customer_id = $_SESSION['customerid'];
    $servername = "localhost:3306";
    $username = "root";
    $password = "circus465";
    $dbname = "eventmanagementsystem";
    $conn = new mysqli($servername, $username, $password, $dbname);
        if ($conn->connect_error){
            die("Connection Failed");
        }
        
?>


<html>
    <head>
        <title>Event Management System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="wnameth=device-wnameth, initial-scale=1.0">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <style>h1, h4, h2{text-align:center}
            body{background-color:#FFF0E0}
            h4.userlabel {text-align: right}
        </style>
    </head>
    <body>
                <h1>Event Management System</h1>
                <h4 class = "userlabel">Welcome, <?php echo $_SESSION['username']?>!!</h4>
                <a href ="userhome.php">Home</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                <a href ="bookinghistory.php">Booking History</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
        <a href="logout.php">Logout</a>
        <div class ="container" id="events_table">
            <div class="table-responsive">          
                <table class="table filterable" id="events_table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Event Name</th>
                            <th>Venue Name</th>
                            <th>Play Date</th>
                            <th>Play Time</th>
                            <th>Number of Tickets</th>
                            <th>Total Cost</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>

        <?php
            $sql = "SELECT * FROM booking_details WHERE `Customer ID` = ".$customer_id.";";
           
            $result1 = $conn->query($sql);
            if ($result1->num_rows > 0) {
                            while ($row = $result1->fetch_assoc()) {
                                echo "<tr><td>".$row['Booking ID']."</td><td>".$row['Event Name']."</td><td>".$row['Venue Name'].
                                        "</td><td>".$row['Date']."</td><td>".$row['Time']."</td><td>".$row['Number of Tickets'].
                                        "</td><td>".$row['Total Cost']."</td><td>".$row['Status']."</td><td><a href='cancel.php?booking_id=".$row['Booking ID']."'>Cancel Tickets</a></td></tr>";
                            }
            }
        ?>
                    </tbody>
                </table>
        
    </body>
</html>



