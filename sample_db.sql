-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for cps_db
CREATE DATABASE IF NOT EXISTS `cps_db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `cps_db`;

-- Dumping structure for table cps_db.cps_addon_packs
CREATE TABLE IF NOT EXISTS `cps_addon_packs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = Inactive, 1 = Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table cps_db.cps_addon_packs: ~6 rows (approximately)
/*!40000 ALTER TABLE `cps_addon_packs` DISABLE KEYS */;
INSERT INTO `cps_addon_packs` (`id`, `name`, `price`, `is_active`) VALUES
	(1, 'Add On 1', 30.00, 1),
	(2, 'Add On 2', 30.00, 1),
	(3, 'Add On 3', 30.00, 1),
	(4, 'Add On 5', 100.00, 1),
	(5, 'Add On 6', 100.00, 1),
	(6, 'Add On 7', 100.00, 1);
/*!40000 ALTER TABLE `cps_addon_packs` ENABLE KEYS */;

-- Dumping structure for table cps_db.cps_addon_pack_details
CREATE TABLE IF NOT EXISTS `cps_addon_pack_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pkg_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = Inactive, 1 = Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- Dumping data for table cps_db.cps_addon_pack_details: ~39 rows (approximately)
/*!40000 ALTER TABLE `cps_addon_pack_details` DISABLE KEYS */;
INSERT INTO `cps_addon_pack_details` (`id`, `pkg_id`, `channel_id`, `is_active`) VALUES
	(1, 1, 16, 1),
	(2, 1, 8, 1),
	(3, 1, 12, 1),
	(4, 1, 14, 1),
	(5, 1, 15, 1),
	(6, 2, 5, 1),
	(7, 2, 12, 1),
	(8, 2, 26, 1),
	(9, 2, 23, 1),
	(10, 2, 6, 1),
	(11, 3, 23, 1),
	(12, 3, 5, 1),
	(13, 3, 14, 1),
	(14, 3, 8, 1),
	(15, 3, 26, 1),
	(16, 4, 13, 1),
	(17, 4, 26, 1),
	(18, 4, 7, 1),
	(19, 4, 22, 1),
	(20, 4, 19, 1),
	(21, 4, 8, 1),
	(22, 4, 25, 1),
	(23, 4, 24, 1),
	(24, 5, 12, 1),
	(25, 5, 26, 1),
	(26, 5, 24, 1),
	(27, 5, 19, 1),
	(28, 5, 8, 1),
	(29, 5, 25, 1),
	(30, 5, 5, 1),
	(31, 5, 23, 1),
	(32, 6, 13, 1),
	(33, 6, 12, 1),
	(34, 6, 7, 1),
	(35, 6, 8, 1),
	(36, 6, 25, 1),
	(37, 6, 23, 1),
	(38, 6, 15, 1),
	(39, 6, 19, 1);
/*!40000 ALTER TABLE `cps_addon_pack_details` ENABLE KEYS */;

-- Dumping structure for table cps_db.cps_base_packs
CREATE TABLE IF NOT EXISTS `cps_base_packs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = Inactive, 1 = Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Dumping data for table cps_db.cps_base_packs: ~8 rows (approximately)
/*!40000 ALTER TABLE `cps_base_packs` DISABLE KEYS */;
INSERT INTO `cps_base_packs` (`id`, `name`, `price`, `is_active`) VALUES
	(1, 'Package 1', 100.00, 1),
	(2, 'Package 2', 100.00, 1),
	(3, 'Package 3', 120.00, 1),
	(4, 'Package 4', 120.00, 1),
	(5, 'Package 5', 120.00, 1),
	(6, 'Package 6', 150.00, 1),
	(7, 'Package 7', 150.00, 1),
	(8, 'Package 8', 150.00, 1);
/*!40000 ALTER TABLE `cps_base_packs` ENABLE KEYS */;

-- Dumping structure for table cps_db.cps_base_pack_details
CREATE TABLE IF NOT EXISTS `cps_base_pack_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pkg_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = Inactive, 1 = Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- Dumping data for table cps_db.cps_base_pack_details: ~55 rows (approximately)
/*!40000 ALTER TABLE `cps_base_pack_details` DISABLE KEYS */;
INSERT INTO `cps_base_pack_details` (`id`, `pkg_id`, `channel_id`, `is_active`) VALUES
	(1, 1, 4, 1),
	(2, 1, 2, 1),
	(3, 1, 9, 1),
	(4, 1, 18, 1),
	(5, 1, 20, 1),
	(6, 2, 21, 1),
	(7, 2, 1, 1),
	(8, 2, 10, 1),
	(9, 2, 18, 1),
	(10, 2, 11, 1),
	(11, 3, 21, 1),
	(12, 3, 2, 1),
	(13, 3, 18, 1),
	(14, 3, 3, 1),
	(15, 3, 11, 1),
	(16, 3, 20, 1),
	(17, 3, 10, 1),
	(18, 4, 21, 1),
	(19, 4, 11, 1),
	(20, 4, 17, 1),
	(21, 4, 18, 1),
	(22, 4, 1, 1),
	(23, 4, 2, 1),
	(24, 4, 20, 1),
	(25, 5, 21, 1),
	(26, 5, 10, 1),
	(27, 5, 4, 1),
	(28, 5, 3, 1),
	(29, 5, 11, 1),
	(30, 5, 20, 1),
	(31, 5, 9, 1),
	(32, 6, 4, 1),
	(33, 6, 20, 1),
	(34, 6, 9, 1),
	(35, 6, 21, 1),
	(36, 6, 17, 1),
	(37, 6, 1, 1),
	(38, 6, 3, 1),
	(39, 6, 2, 1),
	(40, 7, 17, 1),
	(41, 7, 1, 1),
	(42, 7, 4, 1),
	(43, 7, 2, 1),
	(44, 7, 20, 1),
	(45, 7, 3, 1),
	(46, 7, 9, 1),
	(47, 7, 10, 1),
	(48, 8, 20, 1),
	(49, 8, 9, 1),
	(50, 8, 4, 1),
	(51, 8, 18, 1),
	(52, 8, 11, 1),
	(53, 8, 10, 1),
	(54, 8, 17, 1),
	(55, 8, 21, 1);
/*!40000 ALTER TABLE `cps_base_pack_details` ENABLE KEYS */;

-- Dumping structure for table cps_db.cps_channels
CREATE TABLE IF NOT EXISTS `cps_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 = Inactive, 1 = Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- Dumping data for table cps_db.cps_channels: ~26 rows (approximately)
/*!40000 ALTER TABLE `cps_channels` DISABLE KEYS */;
INSERT INTO `cps_channels` (`id`, `name`, `price`, `is_active`) VALUES
	(1, 'Asianet', 19.00, 1),
	(2, 'Asianet Movies', 15.00, 1),
	(3, 'Asianet Plus', 5.00, 1),
	(4, 'Flowers TV', 10.00, 1),
	(5, 'Kochu TV', 5.00, 1),
	(6, 'Surya Comedy', 4.00, 1),
	(7, 'Surya Movies', 11.00, 1),
	(8, 'Surya Music', 4.00, 1),
	(9, 'Surya TV', 12.00, 1),
	(10, 'Sony MAX', 1.00, 1),
	(11, 'Star Movies', 12.00, 1),
	(12, 'Star Plus', 19.00, 1),
	(13, 'Star Gold', 8.00, 1),
	(14, 'Zee Cinema', 15.00, 1),
	(15, 'Zee TV', 19.00, 1),
	(16, 'Sun Music', 6.00, 1),
	(17, 'Surya News', 1.00, 1),
	(18, 'Asianet News', 1.00, 1),
	(19, 'Sun News', 1.00, 1),
	(20, 'Sun TV', 19.00, 1),
	(21, 'Star Sports', 19.00, 1),
	(22, 'Sony ESPN', 5.00, 1),
	(23, 'National Geographic', 2.00, 1),
	(24, 'News18 India', 0.10, 1),
	(25, 'BBC World News', 1.00, 1),
	(26, 'Colors', 19.00, 1);
/*!40000 ALTER TABLE `cps_channels` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
