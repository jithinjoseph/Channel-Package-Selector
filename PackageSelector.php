<?php

    include "Database.php";

    class PackageSelector
    {
        public function __construct()
        {
            $this->db = connectDb();
        }

        public function __destruct()
        {
            disconnectDb($this->db);
        }

        public function getChannels()
        {
            $sql = "SELECT id, name, price
                    FROM cps_channels c
                    WHERE c.is_active=1 LIMIT 50";
            $result = $this->db->query($sql);
            return $result->fetch_all(MYSQLI_ASSOC);
        }

        public function getPackage($channels)
        {
            $package = array(
                "base" => array(),
                "addon" => array(),
                "extra" => array(),
                "price" => 0
            );
            /* Get different base packs */
            $sql1 = "SELECT c.pkg_id,b.name,b.price,GROUP_CONCAT(c.channel_id) AS channels
                    FROM cps_base_pack_details c
                    JOIN cps_base_packs b ON b.id=c.pkg_id
                    WHERE c.is_active=1 AND c.channel_id IN (".implode(',', $channels).")
                    GROUP BY b.id";
            $result1 = $this->db->query($sql1);
            $base_pkgs = $result1->fetch_all(MYSQLI_ASSOC);
            $total_price = 0;
            $prev_price = 0;

            /* Loop through each base pack */
            foreach ($base_pkgs as $p) {
                $price = $p['price'];
                $pkg_channels = explode(',', $p['channels']);
                $comb_price = 0;
                $combination = array("addon_packages" => array(), "channels" => array());

                /* Check whether package has all requested channels */
                if (count($channels) != count($pkg_channels)) {

                    /* Find AddOn combination with missing channels */
                    $sql2 = "SELECT GROUP_CONCAT(ad.pkg_id) AS package_ids,GROUP_CONCAT(a.name) AS package_names,
                            GROUP_CONCAT(ad.channel_id) AS channels,SUM(a.price) AS price
                            FROM cps_addon_pack_details ad
                            JOIN cps_addon_packs a ON a.id=ad.pkg_id
                            LEFT JOIN cps_base_pack_details bd ON bd.pkg_id=".$p['pkg_id']."
                                    AND bd.channel_id=ad.channel_id
                            WHERE ad.is_active=1 AND ad.channel_id IN (".implode(',', $channels).") AND bd.id IS NULL";
                    $result2 = $this->db->query($sql2);
                    $adn_pkgs_c = $result2->fetch_all(MYSQLI_ASSOC);
                    $adn_channels = array();
                    $adn_pkg_ids = array();
                    $adn_pkg_names = array();
                    if (isset($adn_pkgs_c[0]['package_ids'])) {
                        $adn_channels = explode(',', $adn_pkgs_c[0]['channels']);
                        $adn_pkg_ids = explode(',', $adn_pkgs_c[0]['package_ids']);
                        $adn_pkg_names = explode(',', $adn_pkgs_c[0]['package_names']);
                    }
                    $adn_pkg_details = array();
                    $adn_pkg_price = 0;

                    /* Check whether combination has all missing channels */
                    if (count($channels) == (count($pkg_channels)+count($adn_channels))) {
                        $adn_pkg_price = $adn_pkgs_c[0]['price'];
                        foreach ($adn_pkg_ids as $key => $value) {
                            $adn_pkg_details[$value] = array(
                                "id" => $value,
                                "name" => $adn_pkg_names[$key]
                            );
                        }
                    }

                    /* Find AddOn + Channels combinations */
                    $sql3 = "SELECT c.pkg_id,a.name,a.price,GROUP_CONCAT(c.channel_id) AS channels
                            FROM cps_addon_pack_details c
                            JOIN cps_addon_packs a ON a.id=c.pkg_id
                            LEFT JOIN cps_base_pack_details bd ON bd.pkg_id=".$p['pkg_id']."
                                    AND bd.channel_id=c.channel_id
                            WHERE c.is_active=1 AND c.channel_id IN (".implode(',', $channels).") AND bd.id IS NULL
                            GROUP BY a.id";
                    $result3 = $this->db->query($sql3);
                    $adn_pkgs = $result3->fetch_all(MYSQLI_ASSOC);
                    $adn_c_price = 0;
                    $adn_c_dtls = array();
                    /* Loop through each AddOns */
                    foreach ($adn_pkgs as $ap) {
                        $a_price = $ap['price'];
                        $a_channels = explode(',', $ap['channels']);

                        /* Check whether AddOn has all missing channels */
                        if (count($channels) != (count($pkg_channels)+count($a_channels))) {
                            /* Find SUM of missing channels */
                            $sql4 = "SELECT SUM(c.price) AS price,GROUP_CONCAT(c.id) AS channels
                                FROM cps_channels c
                                LEFT JOIN cps_addon_pack_details ad ON ad.pkg_id=".$ap['pkg_id']."
                                        AND ad.channel_id=c.id
                                LEFT JOIN cps_base_pack_details bd ON bd.pkg_id=".$p['pkg_id']."
                                        AND bd.channel_id=c.id
                                WHERE c.is_active=1 AND c.id IN (".implode(',', $channels).") AND bd.id IS NULL
                                        AND ad.id IS NULL";
                            $result4 = $this->db->query($sql4);
                            $ms_chnls = $result4->fetch_all(MYSQLI_ASSOC);
                            $a_price = $a_price+$ms_chnls[0]['price'];
                        }

                        /* Find the minimum priced combination */
                        if ($adn_c_price>0) {
                            if ($a_price<$adn_c_price) {
                                $adn_c_price = $a_price;
                                $adn_c_dtls["package"] = $ap['pkg_id'];
                                $adn_c_dtls["package_name"] = $ap['name'];
                                $adn_c_dtls["channels"] = explode(',', $ms_chnls[0]['channels']);
                            }
                        } else {
                            $adn_c_price = $a_price;
                            $adn_c_dtls["package"] = $ap['pkg_id'];
                            $adn_c_dtls["package_name"] = $ap['name'];
                            $adn_c_dtls["channels"] = explode(',', $ms_chnls[0]['channels']);
                        }
                    }

                    /* Find the minimum priced combination */
                    if ($adn_pkg_price>0) {
                        if ($adn_pkg_price<$adn_c_price) {
                            $combination["addon_packages"] = $adn_pkg_details;
                            $combination["channels"] = array();
                            $comb_price = $adn_pkg_price;
                        } else {
                            if (!empty($adn_c_dtls)) {
                                $combination["addon_packages"] = array(
                                    0 => array(
                                        "id" => $adn_c_dtls["package"],
                                        "name" => $adn_c_dtls["package_name"]
                                    )
                                );
                                $combination["channels"] = $adn_c_dtls["channels"];
                            }
                            $comb_price = $adn_c_price;
                        }
                    } else {
                        if (!empty($adn_c_dtls)) {
                            $combination["addon_packages"] = array(
                                0 => array(
                                    "id" => $adn_c_dtls["package"],
                                    "name" => $adn_c_dtls["package_name"]
                                )
                            );
                            $combination["channels"] = $adn_c_dtls["channels"];
                        }
                        $comb_price = $adn_c_price;
                    }
                }
                $price = $price + $comb_price;

                /* Find the minimum priced Package */
                if ($total_price>0) {
                    if ($price<$total_price) {
                        $total_price = $price;
                        $package["base"] = array(
                            "id" => $p['pkg_id'],
                            "name" => $p['name']
                        );
                        $package["addon"] = $combination["addon_packages"];
                        $package["extra"] = $combination["channels"];
                        $package["price"] = $total_price;
                    }
                } else {
                    $total_price = $price;
                    $package["base"] = array(
                        "id" => $p['pkg_id'],
                        "name" => $p['name']
                    );
                    $package["addon"] = $combination["addon_packages"];
                    $package["extra"] = $combination["channels"];
                    $package["price"] = $total_price;
                }
            }
            return $package;
        }
    }

?>