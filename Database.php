<?php

    /* Open database connection */
    function connectDb()
    {
        $host = "localhost";
        $username = "root";
        $password = "";
        $database = "cps_db";
        $db = new mysqli($host, $username, $password, $database) or die("Connection failed: %s\n".$db->error);
        return $db;
    }

    function disconnectDb($db)
    {
        $db->close();
    }

?>