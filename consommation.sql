-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mer 14 Janvier 2015 à 21:47
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

USE consommation;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `consommation`
--

-- --------------------------------------------------------

--
-- Structure de la table `tableau`
--

CREATE TABLE IF NOT EXISTS `tableau` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `lieu` varchar(20) NOT NULL,
  `consommable` varchar(20) NOT NULL,
  `annee` smallint(6) NOT NULL,
  `mois` tinyint(4) NOT NULL,
  `compteur` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=327 ;

--
-- Contenu de la table `tableau`
--

INSERT INTO `tableau` (`id`, `lieu`, `consommable`, `annee`, `mois`, `compteur`) VALUES
(310, 'Ecole', 'EAU', 2014, 3, 1200),
(311, 'Ecole', 'EAU', 2014, 4, 1256),
(312, 'Ecole', 'EAU', 2014, 5, 1302),
(313, 'Ecole', 'EAU', 2014, 6, 1324),
(314, 'Ecole', 'EAU', 2014, 7, 1356),
(315, 'Ecole', 'EAU', 2014, 8, 1409),
(316, 'Ecole', 'EAU', 2014, 9, 1489),
(317, 'Ecole', 'EAU', 2014, 10, 1509),
(318, 'Ecole', 'EAU', 2014, 11, 1645),
(319, 'Ecole', 'electricite', 2014, 3, 234),
(320, 'Ecole', 'electricite', 2014, 4, 245),
(321, 'Ecole', 'electricite', 2014, 5, 265),
(322, 'Ecole', 'electricite', 2014, 6, 274),
(323, 'Ecole', 'electricite', 2014, 7, 287),
(324, 'Ecole', 'electricite', 2014, 8, 293),
(325, 'Ecole', 'electricite', 2014, 9, 301),
(326, 'Ecole', 'electricite', 2014, 10, 321);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `adresse` varchar(60) DEFAULT ' ',
  `mail` varchar(50) DEFAULT '   ',
  `fixe` varchar(15) DEFAULT '   ',
  `mobile` varchar(15) DEFAULT ' ',
  `fonction` varchar(15) DEFAULT 'normal',
  `motpasse` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nom`, `prenom`, `adresse`, `mail`, `fixe`, `mobile`, `fonction`, `motpasse`) VALUES
(1, 'Ogor  ', 'Robert ', '  29280 Loc-Maria-plouzan', ' robert.ogor@gmail.com', '0298450978', '0685742312', 'administrateur', 'robert'),
(2, 'Dupond ', 'Georges ', '5 rue  de la mairie 29280 Plouzan', 'Georges.Dupond@free.fr', '0298450976', '068574768', 'normal', 'georges'),
(3, 'Dupuit', 'Rolland', '5 rue dee Siam  29200 Brest', 'Dupond.rolland@wanadoo.fr', '0298470564', '0685634285', 'normal', 'rolland'),
(4, 'Verdeaux', 'Lucien', 'rue deu bourg 29230 Guilers', 'luvien.verdeaux@yahoo.fr', '0298470589', '0685635635', 'normal', 'lucien'),
(5, 'Rioual', 'Hubert', 'Rue du Stade 29890 Saint Renan', 'hubert.rioual@hotlone.com', '0298470589', '0685635687', 'normal', 'hubert'),
(6, 'Raguenes ', 'alain ', 'rue de l', 'alain.raguenes@plouzane.fr', '0298934589', '0685635535', 'normal', 'alain'),
(7, 'Helies ', 'Jean Jacques ', 'Rue ecole  29280 Loc-Maria-plouzan', 'jacques@ore.fr', '0965677656', '0685684287', 'normal', 'jacques');

CREATE TABLE IF NOT EXISTS `consommable` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
  )ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

INSERT INTO `consommable` (`id`, `nom`) values
(1, 'eau'),
(2, 'electricite');


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
