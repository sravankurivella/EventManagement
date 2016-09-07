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
            #flt0_events_table {
                width: 70px;
            }
            #flt3_events_table {
                width: 310px;
            }
            #flt5_events_table {
                width: 100px;
            }
            .table-responsive table.TF{
                font:normal 16px arial, tahoma, helvetica, sans-serif;
                border:none;
            }
            .table-responsive table.TF th{
                background-color:transparent; 
                border-bottom: 2px solid #ddd;
                border-top: 1px solid #ddd;
                border-right:none;
                border-left:none;
                padding:8px;
                color:#333;
            }
            .table-responsive table.TF td{
                padding:8px;
                border-bottom:none;
                border-right:none;
            }
            .table-responsive .fltrow{ /* filter grid row appearance */
                height:auto;
                background-color:transparent;
            }
            .table-responsive .fltrow td, .fltrow th{
                padding:2px !important;
            } 
            .table-responsive .flt {
                font-size: 16px;
                border: 1px solid #ccc;
                margin: 0;
                width: 150;
                vertical-align: middle;
            }
        </style>
        <script type="text/javascript" language="javascript" src="TableFilter/tablefilter.js">
        var tf01 = new TF("events_table");  
        tf01.AddGrid();  
        </script>  
       
    </head>
    <body>
        
        <?php
        session_start();
        if ($_SESSION["login"] != "YES") {
	  header("Location: home.html");
	}
        ?>
        <h1>Event Management System</h1>
        
        <h4 class = "userlabel">Welcome, <?php echo $_SESSION['username']?>!!</h4>
        <a href ="userhome.php">Home</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
        <a href ="bookinghistory.php">Booking History</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
        <a href="logout.php">Logout</a>
        <div class ="container" >
            <h2>Available Events</h2>
            <div class="table-responsive">          
                <table class="table filterable" id="events_table">
                    <thead>
                        <tr>
                            <th>Event ID</th>
                            <th>Event Name</th>
                            <th>Event Type</th>
                            <th>Event Description</th>
                            <th>Featuring</th>
                            <th>Duration of Event</th>
                            <th>Average Rating</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $servername = "localhost:3306";
                        $username = "root";
                        $password = "circus465";
                        $dbname = "eventmanagementsystem";
            $conn = new mysqli($servername, $username, $password, $dbname);
            if ($conn->connect_error){
                die("Connection Failed");
            }
            $sql = "SELECT * FROM `view_events_available1`";
//            $sql->bind_param('ss',$email,$pwd);
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                            while ($row = $result->fetch_assoc()) {
                                echo "<tr><td><a href='getvenues.php?id=".$row['event_id']."'>" . $row['event_id'] . "</a></td><td>" . $row['event_name'] . "</td><td>" . $row['type'] . "</td><td>" . $row['description'] . "</td><td>" .$row['Featuring']."</td><td>". $row['duration'] . "</td><td>" . $row['Average Rating']. "</td></tr>";
                            }
                        } else {
                            echo "0 results";
                        }
                        ?>
                </table>
            </div>
            
            <h2>Upcoming Events</h2>
            <div class="table-responsive">          
                <table class="table filterable" id="events_table_upcoming">
                    <thead>
                        <tr>
                            <th>Event ID</th>
                            <th>Event Name</th>
                            <th>Event Type</th>
                            <th>Event Description</th>
                            <th>Featuring</th>
                            <th>Duration of Event</th>
                            <th>Average Rating</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $sql = "SELECT * FROM `view_events_upcoming`";
//            $sql->bind_param('ss',$email,$pwd);
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                            while ($row = $result->fetch_assoc()) {
                                echo "<tr><td>". $row['event_id'] . "</a></td><td>" . $row['event_name'] . "</td><td>" . $row['type'] . "</td><td>" . $row['description'] . "</td><td>" .$row['Featuring']."</td><td>". $row['duration'] . "</td><td>" . $row['Average Rating']. "</td></tr>";
                            }
                        } else {
                            echo "0 results";
                        }
                        ?>
                </table>
            </div>
        </div>
        
        
    </body>
</html>
            
