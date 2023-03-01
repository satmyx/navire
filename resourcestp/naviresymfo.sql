-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 01, 2023 at 04:38 PM
-- Server version: 8.0.27
-- PHP Version: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `naviresymfo`
--

-- --------------------------------------------------------

--
-- Table structure for table `ais_ship_type`
--

DROP TABLE IF EXISTS `ais_ship_type`;
CREATE TABLE IF NOT EXISTS `ais_ship_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ais_ship_type` int NOT NULL,
  `libelle` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20221228121929', '2023-03-01 14:58:51', 1992),
('DoctrineMigrations\\Version20230301135728', '2023-03-01 15:00:41', 530),
('DoctrineMigrations\\Version20230301142237', '2023-03-01 15:23:03', 366),
('DoctrineMigrations\\Version20230301143125', '2023-03-01 15:31:30', 1196),
('DoctrineMigrations\\Version20230301150548', '2023-03-01 16:05:53', 3750),
('DoctrineMigrations\\Version20230301151148', '2023-03-01 16:11:53', 299),
('DoctrineMigrations\\Version20230301151954', '2023-03-01 16:20:02', 1858),
('DoctrineMigrations\\Version20230301152438', '2023-03-01 16:24:42', 2290),
('DoctrineMigrations\\Version20230301152811', '2023-03-01 16:28:14', 2878),
('DoctrineMigrations\\Version20230301153812', '2023-03-01 16:38:19', 2767);

-- --------------------------------------------------------

--
-- Table structure for table `escale`
--

DROP TABLE IF EXISTS `escale`;
CREATE TABLE IF NOT EXISTS `escale` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idnavire` int NOT NULL,
  `idport` int NOT NULL,
  `dateHeureArrivee` datetime NOT NULL,
  `dateHeureDepart` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C39FEDD36A50BD94` (`idnavire`),
  KEY `IDX_C39FEDD3905EAC6C` (`idport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `navire`
--

DROP TABLE IF EXISTS `navire`;
CREATE TABLE IF NOT EXISTS `navire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `imo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mmsi` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicatifappel` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eta` datetime DEFAULT NULL,
  `idaisshiptype` int NOT NULL,
  `longueur` int NOT NULL,
  `largeur` int NOT NULL,
  `tirantdeau` double NOT NULL,
  `idpays` int NOT NULL,
  `idport` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EED103839F5FA88` (`idaisshiptype`),
  KEY `IDX_EED1038E750CD0E` (`idpays`),
  KEY `ind_IMO` (`imo`),
  KEY `ind_MMSI` (`mmsi`),
  KEY `IDX_EED1038905EAC6C` (`idport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicatif` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_indicatif` (`indicatif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `port`
--

DROP TABLE IF EXISTS `port`;
CREATE TABLE IF NOT EXISTS `port` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicatif` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idpays` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_INDICATIF` (`indicatif`),
  KEY `IDX_43915DCCE750CD0E` (`idpays`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `porttypecompatible`
--

DROP TABLE IF EXISTS `porttypecompatible`;
CREATE TABLE IF NOT EXISTS `porttypecompatible` (
  `idport` int NOT NULL,
  `idaisshiptype` int NOT NULL,
  PRIMARY KEY (`idport`,`idaisshiptype`),
  KEY `IDX_2C02FFDB905EAC6C` (`idport`),
  KEY `IDX_2C02FFDB39F5FA88` (`idaisshiptype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `escale`
--
ALTER TABLE `escale`
  ADD CONSTRAINT `FK_C39FEDD36A50BD94` FOREIGN KEY (`idnavire`) REFERENCES `navire` (`id`),
  ADD CONSTRAINT `FK_C39FEDD3905EAC6C` FOREIGN KEY (`idport`) REFERENCES `port` (`id`);

--
-- Constraints for table `navire`
--
ALTER TABLE `navire`
  ADD CONSTRAINT `FK_EED103839F5FA88` FOREIGN KEY (`idaisshiptype`) REFERENCES `ais_ship_type` (`id`),
  ADD CONSTRAINT `FK_EED1038905EAC6C` FOREIGN KEY (`idport`) REFERENCES `port` (`id`),
  ADD CONSTRAINT `FK_EED1038E750CD0E` FOREIGN KEY (`idpays`) REFERENCES `pays` (`id`);

--
-- Constraints for table `port`
--
ALTER TABLE `port`
  ADD CONSTRAINT `FK_43915DCCE750CD0E` FOREIGN KEY (`idpays`) REFERENCES `pays` (`id`);

--
-- Constraints for table `porttypecompatible`
--
ALTER TABLE `porttypecompatible`
  ADD CONSTRAINT `FK_2C02FFDB39F5FA88` FOREIGN KEY (`idaisshiptype`) REFERENCES `ais_ship_type` (`id`),
  ADD CONSTRAINT `FK_2C02FFDB905EAC6C` FOREIGN KEY (`idport`) REFERENCES `port` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
