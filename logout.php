<?php 

    session_start(); 

    if (isset($_SESSION['UserName'])){
        unset($_SESSION['UserName']); 
        if(isset($_SESSION['Cart']))
            unset($_SESSION['Cart']);
    }
    // Unset all of the session variables.
    $_SESSION = array();
    session_destroy();
    header("location:login.php");
?>