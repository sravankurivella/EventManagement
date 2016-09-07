<?php
    session_start();
    if ($_SESSION["login"] != "YES") {
	  header("Location: home.html");
	}
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
            #num_tkts{width:5%;display: inline-block;}
        </style>
    </head>
    <body>
         <h1>Event Management System</h1>
        
        <h4 class = "userlabel">Welcome, <?php echo $_SESSION['username']?>!!</h4>
         <a href ="userhome.php">Home</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
        <a href ="bookinghistory.php">Booking History</a>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
        <a href="logout.php">Logout</a>
<?php
$booking_id = $_GET['booking_id'];

$call = $conn->prepare('CALL cancellation_transaction(?,@result);');
$call->bind_param('i', $booking_id);
$call->execute();
$select = $conn->query('SELECT @result');
$result = $select->fetch_assoc();
$status = $result['@result'];
echo "<h1>".$status."</h1>";
?>
    </body>
</html>
