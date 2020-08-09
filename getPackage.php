<?php

    include "PackageSelector.php";

    $ps = new PackageSelector();
    $channels = $_POST['channels'];
    echo json_encode($ps->getPackage($channels));

?>