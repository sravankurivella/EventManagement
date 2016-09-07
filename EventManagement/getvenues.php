<?php
    session_start();
    if ($_SESSION["login"] != "YES") {
	  header("Location: home.html");
	}
        
        
    $event_id =  $_GET['id'];
    $servername = "localhost:3306";
    $username = "root";
    $password = "circus465";
    $dbname = "eventmanagementsystem";
    $conn = new mysqli($servername, $username, $password, $dbname);
        if ($conn->connect_error){
            die("Connection Failed");
        }
    $sql = "SELECT * FROM `view_events_available1` WHERE event_id = ".$event_id.";";
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
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
            <h2>Available Venues for Event: <?php echo $row['event_name']; ?></h2>
            <div class="table-responsive">          
                <table class="table filterable" id="events_table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Venue ID</th>
                            <th>Venue Name</th>
                            <th>Address</th>
                            <th>Play Date</th>
                            <th>Play Time</th>
                            <th>Available Seats</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>

        <?php
            $sql = "SELECT * FROM `view_event_venues1` WHERE event_id = ".$event_id.";";
            $result1 = $conn->query($sql);
            if ($result1->num_rows > 0) {
                            while ($row = $result1->fetch_assoc()) {
                                echo "<tr><td>".$row['ev_id']."</td><td>".$row['venue_id']."</td><td>".$row['venue_name'].
                                        "</td><td>".$row['address']."</td><td>".$row['play_date']."</td><td>".$row['play_time'].
                                        "</td><td>".$row['available_seats']."</td><td><a class='bktkts' href='makebooking.php?ev_id=".$row['ev_id']."'>Book Tickets</a></td></tr>";
                            }
            }
        ?>
                    </tbody>
                </table>
                
                
                <!--<div class="popup">
                    <span>Chose number of tickets</span>
                    
                </div>-->
        
    </body>
    
<!--    <script>
    $(".bktkts").on("click",function(e){
        e.preventDefault();
        var num = prompt("How many tickets?");
        document.getElementById("numberoftkts").value = num;
        document.getElementById("book").submit();
    })
    </script>-->
</html>



