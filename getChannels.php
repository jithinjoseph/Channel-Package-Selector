<?php

    include "PackageSelector.php";

    $ps = new PackageSelector();
    echo json_encode($ps->getChannels());

?>