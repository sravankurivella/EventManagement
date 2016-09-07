<?php

	// Start up your PHP Session 
	session_start();

	// If the user is not logged in send him/her to the login form
	if ($_SESSION["login"] != "YES") {
	  header("Location: home.html");
	}
        else{
            header("Location: userhome.php");
        }

	?>
<html>
        <body>
Hellooooo
        </body>
</html>
