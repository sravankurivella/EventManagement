<?php 
    $email = $_POST["email1"];
    $email = mysql_real_escape_string($email);
    $reg_password = mysql_real_escape_string($_POST["reg_password"]);
    $fname = $_POST["fname"];
    $fname = mysql_real_escape_string($fname);
    $lname = $_POST["lname"];
    $lname = mysql_real_escape_string($lname);
    $dob = $_POST["dob"];
    $dob = mysql_real_escape_string($dob);
    $ccnum = $_POST["ccnum"];
    $ccnum = mysql_real_escape_string($ccnum);
    $ccm = $_POST["ccm"];
    $ccm = mysql_real_escape_string($ccm);
   // echo $ccm;
	$ccy = $_POST["ccy"];
    $ccy = mysql_real_escape_string($ccy);
    $cccvv = $_POST["cccvv"];
    $servername = "localhost:3306";
    $username = "root";
    
    $dbname = "eventmanagementsystem";

// Create connection
$conn = new mysqli($servername, $username, "circus465", $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$sql = "INSERT INTO customer(first_name, last_name,email, password, cc_number, cc_name, cc_month, cc_year, cc_cvv) values ('$fname','$lname','$email','$reg_password','$ccnum','$fname','$ccm','$ccy','$cccvv')";
$result = $conn->query($sql);

if ($result) {
    echo "New record created successfully";
	header('location:home.html');
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
$conn->close();
?>