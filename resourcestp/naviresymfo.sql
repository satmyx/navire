-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 04 mars 2023 à 14:26
-- Version du serveur : 5.7.36
-- Version de PHP : 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `naviresymfo`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `majdates`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `majdates` ()  BEGIN
    DECLARE dernieremiseajour DATETIME ;    
    DECLARE nbsecondes bigint;
       SELECT dernieremodif.datedernieremodif INTO dernieremiseajour
      FROM naviresymfo.dernieremodif
      where id=1;  
     
	select UNIX_TIMESTAMP(now()) - UNIX_TIMESTAMP(dernieremiseajour) into nbsecondes from  dernieremodif where id=1;
    update naviresymfo.navire set navire.eta=date_add(navire.eta, interval nbsecondes second);
    update naviresymfo.escale set escale.dateHeureArrivee=date_add(escale.dateHeureArrivee , interval nbsecondes second),
									escale.dateHeureDepart=date_add(escale.dateHeureDepart , interval nbsecondes second);

    update dernieremodif set datedernieremodif = now();
  END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `aisshiptype`
--

DROP TABLE IF EXISTS `aisshiptype`;
CREATE TABLE IF NOT EXISTS `aisshiptype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aisshiptype` int(11) NOT NULL,
  `libelle` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `aisshiptype`
--

INSERT INTO `aisshiptype` (`id`, `aisshiptype`, `libelle`) VALUES
(1, 1, 'Reserved'),
(2, 2, 'Wing In Ground'),
(3, 3, 'Special Category'),
(4, 4, 'High-Speed Craft'),
(5, 5, 'Special Category'),
(6, 6, 'Passenger'),
(7, 7, 'Cargo'),
(8, 8, 'Tanker'),
(9, 9, 'Reserved');

-- --------------------------------------------------------

--
-- Structure de la table `dernieremodif`
--

DROP TABLE IF EXISTS `dernieremodif`;
CREATE TABLE IF NOT EXISTS `dernieremodif` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datedernieremodif` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `dernieremodif`
--

INSERT INTO `dernieremodif` (`id`, `datedernieremodif`) VALUES
(1, '2023-03-04 14:26:09');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230304132011', '2023-03-04 14:22:16', 416),
('DoctrineMigrations\\Version20230304132458', '2023-03-04 14:26:04', 33);

-- --------------------------------------------------------

--
-- Structure de la table `escale`
--

DROP TABLE IF EXISTS `escale`;
CREATE TABLE IF NOT EXISTS `escale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idnavire` int(11) NOT NULL,
  `idport` int(11) NOT NULL,
  `dateHeureArrivee` datetime NOT NULL,
  `dateHeureDepart` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C39FEDD36A50BD94` (`idnavire`),
  KEY `IDX_C39FEDD3905EAC6C` (`idport`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `escale`
--

INSERT INTO `escale` (`id`, `idnavire`, `idport`, `dateHeureArrivee`, `dateHeureDepart`) VALUES
(1, 1, 3, '2022-09-16 04:59:13', '2022-11-01 10:10:13'),
(2, 1, 3, '2022-11-09 01:54:13', '2023-01-04 05:55:13'),
(3, 1, 7, '2023-01-08 05:36:13', '2023-01-31 11:40:13'),
(4, 1, 6, '2023-02-01 03:44:13', '2023-02-01 15:46:13'),
(5, 2, 10, '2023-01-19 06:50:13', '2023-01-19 17:12:13'),
(6, 2, 10, '2023-02-15 07:39:13', '2023-02-15 18:10:13'),
(7, 2, 10, '2023-02-23 07:56:13', '2023-03-02 18:39:13'),
(8, 2, 9, '2023-02-26 09:15:13', '2023-02-26 22:50:13'),
(9, 2, 8, '2023-03-01 15:40:13', '2023-03-12 05:40:13'),
(10, 3, 15, '2023-03-03 02:02:13', '2023-03-03 19:02:13'),
(11, 3, 14, '2023-03-04 04:28:13', '2023-03-05 05:31:13'),
(12, 3, 13, '2023-03-05 12:46:13', '2023-03-07 03:52:13'),
(13, 3, 12, '2023-03-07 11:45:13', '2023-03-07 20:43:13'),
(14, 3, 11, '2023-03-12 09:52:13', '2023-03-13 13:34:13'),
(15, 4, 19, '2023-02-10 01:22:13', '2023-02-10 17:58:13'),
(16, 4, 18, '2023-02-11 12:00:13', '2023-02-12 11:01:13'),
(17, 4, 17, '2023-02-16 03:27:13', '2023-02-17 12:25:13'),
(18, 4, 17, '2023-02-17 13:35:13', '2023-02-19 02:23:13'),
(19, 4, 16, '2023-03-11 10:16:13', '2023-03-12 05:35:13'),
(23, 5, 25, '2023-02-27 00:27:13', '2023-03-01 12:30:13'),
(24, 5, 21, '2023-03-04 10:18:13', '2023-03-05 14:20:13'),
(25, 5, 20, '2023-03-08 19:43:13', '2023-03-10 05:42:13'),
(26, 5, 20, '2023-03-11 08:27:13', '2023-03-12 05:50:13'),
(31, 6, 24, '2023-01-20 03:40:13', '2023-01-22 07:49:13'),
(32, 6, 24, '2023-01-24 19:45:13', '2023-01-25 18:19:13'),
(33, 6, 24, '2023-01-25 21:43:13', '2023-01-26 07:04:13'),
(34, 6, 23, '2023-03-03 01:43:13', '2023-03-04 13:47:13'),
(35, 6, 23, '2023-03-04 17:17:13', '2023-03-05 11:54:13');

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `navire`
--

DROP TABLE IF EXISTS `navire`;
CREATE TABLE IF NOT EXISTS `navire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idaisshiptype` int(11) NOT NULL,
  `idpays` int(11) NOT NULL,
  `idport` int(11) DEFAULT NULL,
  `imo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mmsi` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicatifappel` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eta` datetime DEFAULT NULL,
  `longueur` int(11) NOT NULL,
  `largeur` int(11) NOT NULL,
  `tirantdeau` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EED103839F5FA88` (`idaisshiptype`),
  KEY `IDX_EED1038E750CD0E` (`idpays`),
  KEY `IDX_EED1038905EAC6C` (`idport`),
  KEY `ind_IMO` (`imo`),
  KEY `ind_MMSI` (`mmsi`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `navire`
--

INSERT INTO `navire` (`id`, `idaisshiptype`, `idpays`, `idport`, `imo`, `nom`, `mmsi`, `indicatifappel`, `eta`, `longueur`, `largeur`, `tirantdeau`) VALUES
(1, 6, 60, 4, '9007491', 'CLUB MED 2', '227194000', 'FNIR', '2023-02-06 02:40:13', 187, 20, 5.2),
(2, 6, 133, 2, '9744001', 'SYMPHONY OF THE SEAS', '311000660', 'C6DF6', '2023-03-08 09:10:13', 362, 66, 9),
(3, 7, 136, 12, '9193680', 'MSC TIA', '255806080', 'CQIV6', '2023-03-12 08:40:13', 194, 28, 11.1),
(4, 7, 151, 16, '9502910', 'MAERSK EMERALD', '563090400', '9V6464', '2023-03-02 07:40:13', 366, 48, 14.9),
(5, 7, 102, 17, '9755933', 'MSC DIANA', '636017433', 'D5KX8', '2023-03-10 17:40:13', 400, 59, 13.6),
(6, 8, 102, 22, '9280366', 'CONFIDENCE', '636012164', 'A8DU7', '2023-03-17 18:40:13', 229, 32, 7.5);

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicatif` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_indicatif` (`indicatif`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`id`, `nom`, `indicatif`) VALUES
(1, 'Aruba (Ile d\')', 'ABW'),
(2, 'Angola', 'AGO'),
(3, 'Anguilla (Ile d\')', 'AIA'),
(4, 'Albanie', 'ALB'),
(5, 'Aland (Iles d\')', 'ALD'),
(6, 'Antilles Néerlandaises', 'ANT'),
(7, 'Emirats Arabes Unis', 'ARE'),
(8, 'Argentine', 'ARG'),
(9, 'Kerguelen (Iles)', 'ATF'),
(10, 'Antigua et Barbuda', 'ATG'),
(11, 'Australie', 'AUS'),
(12, 'Autriche', 'AUT'),
(13, 'Azerbaidjan', 'AZE'),
(14, 'Belgique', 'BEL'),
(15, 'Benin', 'BEN'),
(16, 'Bangladesh', 'BGO'),
(17, 'Bulgarie', 'BGR'),
(18, 'Bahrein', 'BHR'),
(19, 'Bahamas', 'BHS'),
(20, 'Belize', 'BLZ'),
(21, 'Bermudes (Iles)', 'BMU'),
(22, 'Bolivie', 'BOL'),
(23, 'Brésil', 'BRA'),
(24, 'Barbade (Ile de La)', 'BRB'),
(25, 'Brunei', 'BRN'),
(26, 'Canada', 'CAN'),
(27, 'Suisse', 'CHE'),
(28, 'Chili', 'CHL'),
(29, 'Chine', 'CHN'),
(30, 'Côte d\'Ivoire', 'CIV'),
(31, 'Cameroun', 'CMR'),
(32, 'Canaries (Iles)', 'CNI'),
(33, 'Congo (Rép. Dem. du)', 'COD'),
(34, 'Congo', 'COG'),
(35, 'Cook (Iles)', 'COK'),
(36, 'Colombie', 'COL'),
(37, 'Comores (Iles des)', 'COM'),
(38, 'Cap Vert (Iles du)', 'CPV'),
(39, 'Costa Rica', 'CRI'),
(40, 'Cuba', 'CUB'),
(41, 'Curaçao', 'CUR'),
(42, 'Cayman (Iles)', 'CYM'),
(43, 'Chypre', 'CYP'),
(44, 'Tchèque (République)', 'CZE'),
(45, 'Allemagne', 'DEU'),
(46, 'Djibouti', 'DJI'),
(47, 'Dominique', 'DMA'),
(48, 'Danemark', 'DNK'),
(49, 'Dominicaine (République)', 'DOM'),
(50, 'Algérie', 'DZA'),
(51, 'Equateur', 'ECU'),
(52, 'Egypte', 'EGY'),
(53, 'Erythrée', 'ERI'),
(54, 'Espagne', 'ESP'),
(55, 'Estonie', 'EST'),
(56, 'Ethiopie', 'ETH'),
(57, 'Finlande', 'FIN'),
(58, 'Fiji (Iles)', 'FJI'),
(59, 'Falkland (Iles)', 'FLK'),
(60, 'France', 'FRA'),
(61, 'Feroe (Iles)', 'FRO'),
(62, 'Micronésie', 'FSM'),
(63, 'Gabon', 'GAB'),
(64, 'Royaume-Uni', 'GBR'),
(65, 'Georgie', 'GEO'),
(66, 'Ghana', 'GHA'),
(67, 'Gibraltar', 'GIB'),
(68, 'Guinée', 'GIN'),
(69, 'Guadeloupe', 'GLP'),
(70, 'Gambie', 'GMB'),
(71, 'Guinée-Bissau', 'GNB'),
(72, 'Guinée Equatoriale', 'GNQ'),
(73, 'Grèce', 'GRC'),
(74, 'Grenade', 'GRD'),
(75, 'Groenland', 'GRL'),
(76, 'Guatemala', 'GTM'),
(77, 'Guam', 'GUM'),
(78, 'Honduras', 'HND'),
(79, 'Croatie', 'HRV'),
(80, 'Haiti', 'HTI'),
(81, 'Hongrie', 'HUN'),
(82, 'Indonésie', 'IDN'),
(83, 'Inde', 'IND'),
(84, 'Ile de Man', 'IOM'),
(85, 'Irlande (Rép. d\')', 'IRL'),
(86, 'Iran', 'IRN'),
(87, 'Iraq', 'IRQ'),
(88, 'Iceland', 'ISL'),
(89, 'Israël', 'ISR'),
(90, 'Italie', 'ITA'),
(91, 'Jamaïque', 'JAM'),
(92, 'Jordanie', 'JOR'),
(93, 'Japon', 'JPN'),
(94, 'Kenya', 'KEN'),
(95, 'Cambodge', 'KHM'),
(96, 'Kiribati', 'KIR'),
(97, 'Corée du Sud', 'KOR'),
(98, 'Koweit', 'KWT'),
(99, 'Kazakhstan', 'KZA'),
(100, 'Laos', 'LAO'),
(101, 'Liban', 'LBN'),
(102, 'Liberia', 'LBR'),
(103, 'Libye', 'LBY'),
(104, 'Sainte Lucie', 'LCA'),
(105, 'Sri Lanka', 'LKA'),
(106, 'Lituanie', 'LTU'),
(107, 'Luxembourg', 'LUX'),
(108, 'Lettonie', 'LVA'),
(109, 'Maroc', 'MAR'),
(110, 'Monaco', 'MCO'),
(111, 'Madagascar', 'MDG'),
(112, 'Maldives (Iles)', 'MDV'),
(113, 'Mexique', 'MEX'),
(114, 'Marshall (Iles)', 'MHL'),
(115, 'Malte ', 'MLT'),
(116, 'Myanmar', 'MMR'),
(117, 'Mozambique', 'MOZ'),
(118, 'Mauritanie', 'MRT'),
(119, 'Montenegro', 'MTG'),
(120, 'Maurice (Ile)', 'MUS'),
(121, 'Malaisie', 'MYS'),
(122, 'Namibie', 'NAM'),
(123, 'Nouvelle-Calédonie', 'NCL'),
(124, 'Nigéria', 'NGA'),
(125, 'Nicaragua', 'NIC'),
(126, 'Norvège (Reg. Intern.)', 'NIS'),
(127, 'Pays-Bas', 'NLD'),
(128, 'Norvège', 'NOR'),
(129, 'Nauru (Rép. de)', 'NRU'),
(130, 'Nouvelle-Zélande', 'NZL'),
(131, 'Oman', 'OMN'),
(132, 'Pakistan', 'PAK'),
(133, 'Panama', 'PAN'),
(134, 'Pérou', 'PER'),
(135, 'Philippines', 'PHL'),
(136, 'Madère', 'PMD'),
(137, 'Papouasie-Nlle Guinée', 'PNG'),
(138, 'Pologne', 'POL'),
(139, 'Porto Rico', 'PRI'),
(140, 'Corée du Nord', 'PRK'),
(141, 'Portugal', 'PRT'),
(142, 'Paraguay', 'PRY'),
(143, 'Polynésie Française', 'PYF'),
(144, 'Qatar', 'QAT'),
(145, 'Réunion (Ile de La)', 'REU'),
(146, 'Roumanie', 'ROM'),
(147, 'Russie (Fédér. de)', 'RUS'),
(148, 'Arabie Saoudite (Roy. d\')', 'SAU'),
(149, 'Soudan', 'SDN'),
(150, 'Sénégal', 'SEN'),
(151, 'Singapour', 'SGP'),
(152, 'Salomon (Iles)', 'SLB'),
(153, 'Sierra Leone', 'SLE'),
(154, 'Salvador', 'SLV'),
(155, 'Somalie', 'SOM'),
(156, 'St Pierre et Miquelon', 'SPM'),
(157, 'Sao Tome & Principe', 'STP'),
(158, 'Suriname', 'SUR'),
(159, 'Slovaquie', 'SVK'),
(160, 'Slovénie', 'SVN'),
(161, 'Suède', 'SWE'),
(162, 'Seychelles', 'SYC'),
(163, 'Syrie', 'SYR'),
(164, 'Tahiti', 'TAH'),
(165, 'Togo', 'TGO'),
(166, 'Thaïlande', 'THA'),
(167, 'Turkménistan', 'TKM'),
(168, 'Tonga', 'TON'),
(169, 'Trinité et Tobago', 'TTO'),
(170, 'Tunisie', 'TUN'),
(171, 'Turquie', 'TUR'),
(172, 'Tuvalu', 'TUV'),
(173, 'Taiwan', 'TWN'),
(174, 'Tanzanie', 'TZA'),
(175, 'Ouganda', 'UGA'),
(176, 'Ukraine', 'UKR'),
(177, 'Uruguay', 'URY'),
(178, 'Etats-Unis', 'USA'),
(179, 'St Vincent et Grenadines', 'VCT'),
(180, 'Venezuela', 'VEN'),
(181, 'Vierges (Iles)', 'VGB'),
(182, 'Vietnam', 'VNM'),
(183, 'Vanuatu', 'VUT'),
(184, 'Samoa (Iles)', 'WSM'),
(185, 'Yemen', 'YEM'),
(186, 'Afrique du Sud', 'ZAF');

-- --------------------------------------------------------

--
-- Structure de la table `port`
--

DROP TABLE IF EXISTS `port`;
CREATE TABLE IF NOT EXISTS `port` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idpays` int(11) NOT NULL,
  `nom` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicatif` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_43915DCCE750CD0E` (`idpays`),
  KEY `ind_INDICATIF` (`indicatif`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `port`
--

INSERT INTO `port` (`id`, `idpays`, `nom`, `indicatif`) VALUES
(2, 40, 'Cayo Coco', 'CUCCC'),
(3, 60, 'La Seyne Sur Mer', 'FRYNE'),
(4, 60, 'Toulon', 'FRTLN'),
(5, 60, 'Le Havre', 'FRLEH'),
(6, 141, 'Lisboa', 'PTLIS'),
(7, 141, 'Setubal', 'PTSET'),
(8, 19, 'Little Stirrup Cay', 'BSCOC'),
(9, 19, 'Port de NASSAU', 'BSNAS'),
(10, 178, 'Miami', 'USMIA'),
(11, 171, 'istanbul', 'TRIST'),
(12, 160, 'Koper', 'SIKOP'),
(13, 90, 'Venezia', 'ITVCE'),
(14, 90, 'Ravenna', 'ITRAN'),
(15, 90, 'Trieste', 'ITTRS'),
(16, 178, 'Long Beach', 'USLGB'),
(17, 29, 'Shangaï', 'CNSHG'),
(18, 29, 'Yantian', 'CNYTN'),
(19, 29, 'Nansha', 'CNNSA'),
(20, 29, 'Ningbo', 'CNNGB'),
(21, 97, 'Busan New Port', 'KRBNP'),
(22, 124, 'Port Harcourt', 'NGPHC'),
(23, 67, 'Gibraltar', 'GIGIB'),
(24, 178, 'New York', 'USNYC'),
(25, 29, 'Qingdao', 'CNQDG');

-- --------------------------------------------------------

--
-- Structure de la table `porttypecompatible`
--

DROP TABLE IF EXISTS `porttypecompatible`;
CREATE TABLE IF NOT EXISTS `porttypecompatible` (
  `idport` int(11) NOT NULL,
  `idaisshiptype` int(11) NOT NULL,
  PRIMARY KEY (`idport`,`idaisshiptype`),
  KEY `IDX_2C02FFDB905EAC6C` (`idport`),
  KEY `IDX_2C02FFDB39F5FA88` (`idaisshiptype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `porttypecompatible`
--

INSERT INTO `porttypecompatible` (`idport`, `idaisshiptype`) VALUES
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(2, 6),
(2, 7),
(2, 8),
(3, 3),
(3, 4),
(3, 6),
(4, 3),
(4, 4),
(4, 6),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(5, 8),
(6, 3),
(6, 4),
(6, 5),
(6, 6),
(7, 4),
(7, 6),
(8, 4),
(8, 6),
(9, 6),
(9, 7),
(9, 8),
(10, 6),
(10, 7),
(10, 8),
(11, 6),
(11, 7),
(11, 8),
(12, 6),
(12, 7),
(12, 8),
(13, 6),
(13, 7),
(13, 8),
(14, 7),
(14, 8),
(15, 6),
(15, 7),
(15, 8),
(16, 6),
(16, 7),
(16, 8),
(17, 3),
(17, 4),
(17, 5),
(17, 7),
(17, 8),
(18, 4),
(18, 5),
(18, 7),
(18, 8),
(19, 4),
(19, 5),
(19, 7),
(19, 8),
(20, 4),
(20, 5),
(20, 7),
(20, 8),
(21, 6),
(21, 7),
(21, 8),
(22, 5),
(22, 7),
(22, 8),
(23, 3),
(23, 4),
(23, 5),
(23, 6),
(23, 7),
(23, 8),
(24, 2),
(24, 3),
(24, 4),
(24, 5),
(24, 6),
(24, 7),
(24, 8);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `escale`
--
ALTER TABLE `escale`
  ADD CONSTRAINT `FK_C39FEDD36A50BD94` FOREIGN KEY (`idnavire`) REFERENCES `navire` (`id`),
  ADD CONSTRAINT `FK_C39FEDD3905EAC6C` FOREIGN KEY (`idport`) REFERENCES `port` (`id`);

--
-- Contraintes pour la table `navire`
--
ALTER TABLE `navire`
  ADD CONSTRAINT `FK_EED103839F5FA88` FOREIGN KEY (`idaisshiptype`) REFERENCES `aisshiptype` (`id`),
  ADD CONSTRAINT `FK_EED1038905EAC6C` FOREIGN KEY (`idport`) REFERENCES `port` (`id`),
  ADD CONSTRAINT `FK_EED1038E750CD0E` FOREIGN KEY (`idpays`) REFERENCES `pays` (`id`);

--
-- Contraintes pour la table `port`
--
ALTER TABLE `port`
  ADD CONSTRAINT `FK_43915DCCE750CD0E` FOREIGN KEY (`idpays`) REFERENCES `pays` (`id`);

--
-- Contraintes pour la table `porttypecompatible`
--
ALTER TABLE `porttypecompatible`
  ADD CONSTRAINT `FK_2C02FFDB39F5FA88` FOREIGN KEY (`idaisshiptype`) REFERENCES `aisshiptype` (`id`),
  ADD CONSTRAINT `FK_2C02FFDB905EAC6C` FOREIGN KEY (`idport`) REFERENCES `port` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
