<html>
    <head>Login</head>
    <body>
        <?php
            
            $email = $_POST["email"];
            //$email = mysql_real_escape_string($email);
            
            $pwd = $_POST["pwd"];
            //$pwd = mysql_real_escape_string($pwd);
            $servername = "localhost:3306";
            $username = "root";
            $password = "circus465";
            $dbname = "eventmanagementsystem";
            $conn = new mysqli($servername, $username, $password, $dbname);
            if ($conn->connect_error){
                die("Connection Failed");
            }
            
            $sql = "SELECT * FROM customer WHERE email = \"".$email."\" and password = \"".$pwd."\";";
            $result = $conn->query($sql);
            $rows = $result->num_rows;
                        
            if ($rows == 1){
            session_start();
            $_SESSION["login"] = "YES";
            while ($row = $result->fetch_assoc())
            {
            $_SESSION["username"] = $row['last_name']." ".$row['first_name'];
            $_SESSION["customerid"] = $row['customer_id'];    
            }
            
            echo"<h1>Login Successful</h1>";
            header("location: welcome.php");
            }
            else{
                echo"<h1>invalid credentials</h1>";
                echo"<h1>$pwd</h1>";
            }
            ?>
        

    </body>
</html>