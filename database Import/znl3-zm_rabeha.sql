-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 03 juil. 2021 à 14:51
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `znl3-zm_rabeha`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `ActiverActualite`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActiverActualite` (IN `id` INT)  BEGIN
	update t_actualite_act set act_etat = 'A' where act_id = id;
END$$

DROP PROCEDURE IF EXISTS `ActiverCompte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActiverCompte` (IN `id` VARCHAR(20))  BEGIN
	update t_compte_cpt set cpt_etat = 'A' where cpt_pseudo = id;
END$$

DROP PROCEDURE IF EXISTS `ActualiteCreationConcours`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualiteCreationConcours` ()  BEGIN
	declare id int;
	declare textAct Text;
	declare pseudo VARCHAR(20);
	select idDernierConcours() into id;
	select cpt_pseudo, CONCAT('NOUVEAU CONCOURS : ', cnc_nom,' | Date de début : ',cnc_dateDebut,' | ',cnc_textIntro) into pseudo, textAct 
	from t_concours_cnc 
	where cnc_id = id;
	insert into t_actualite_act values(null,textAct,sysdate(),'A', pseudo, id);
END$$

DROP PROCEDURE IF EXISTS `AffichagePalmaresUnConcours`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AffichagePalmaresUnConcours` (IN `id` INT)  BEGIN
    set @rang:=0;
    select DISTINCT @rang:=@rang+1 rang, cnd_nom, cnd_prenom
    from PalmaresConcours
    where cnc_id = id
    and PhaseDuConcours(cnc_id) = 'Terminé'
    limit 3;
END$$

DROP PROCEDURE IF EXISTS `AnnulerCandidature`$$
CREATE DEFINER=`zm_rabeha`@`localhost` PROCEDURE `AnnulerCandidature` (IN `id` INT)  BEGIN
	update t_candidature_cnd set cnd_etat = 'A' where cnd_id = id;
END$$

DROP PROCEDURE IF EXISTS `DeleteCompte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCompte` (IN `pseudo` VARCHAR(20))  BEGIN
	DELETE from t_compte_cpt
	where cpt_pseudo = pseudo
	and cpt_pseudo != 'organisateur';
END$$

DROP PROCEDURE IF EXISTS `DesactiverActualite`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DesactiverActualite` (IN `id` INT)  BEGIN
	update t_actualite_act set act_etat = 'D' where act_id = id;
END$$

DROP PROCEDURE IF EXISTS `DesactiverCompte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DesactiverCompte` (IN `id` VARCHAR(20))  BEGIN
	update t_compte_cpt set cpt_etat = 'D' where cpt_pseudo = id;
END$$

DROP PROCEDURE IF EXISTS `ModifierEtatActualite`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModifierEtatActualite` (IN `id` INT)  BEGIN
	set @etat = (SELECT act_etat from t_actualite_act where act_id = id);
	if @etat = 'A' then
		call DesactiverActualite(id);
	else
		call ActiverActualite(id); 
	end if;
END$$

DROP PROCEDURE IF EXISTS `ModifierEtatCompte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModifierEtatCompte` (IN `id` VARCHAR(20))  BEGIN
	set @etat = (SELECT cpt_etat from t_compte_cpt where cpt_pseudo = id);
	if @etat = 'A' then
		call DesactiverCompte(id);
	else
		call ActiverCompte(id); 
	end if;
END$$

--
-- Fonctions
--
DROP FUNCTION IF EXISTS `CandidatureNoteJuryActive`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `CandidatureNoteJuryActive` (`id` INT) RETURNS INT(11) BEGIN
    DECLARE NoteTotal INT;
    SELECT sum(note) into NoteTotal
    from tj_candidature_note
    where cnd_id = id
    and cpt_pseudo in (SELECT DISTINCT cpt_pseudo
                       from t_compte_cpt
                       where cpt_etat = 'A');
	if NoteTotal is null then RETURN 0;
    else return NoteTotal;
	end if;
END$$

DROP FUNCTION IF EXISTS `CandidatureNoteTotal`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `CandidatureNoteTotal` (`id` INT) RETURNS INT(11) BEGIN
    DECLARE NoteTotal INT;
    SELECT sum(note) into NoteTotal
    from tj_candidature_note
    where cnd_id = id;
	if NoteTotal is null then RETURN 0;
    else return NoteTotal;
	end if;
END$$

DROP FUNCTION IF EXISTS `idDernierConcours`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `idDernierConcours` () RETURNS INT(11) BEGIN
	RETURN (SELECT max(cnc_id) from t_concours_cnc);
END$$

DROP FUNCTION IF EXISTS `nbCandidature`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `nbCandidature` (`id` INT) RETURNS INT(11) BEGIN
	set @nbr = (SELECT count(*) from t_candidature_cnd where cnc_id = id);
	RETURN @nbr;
END$$

DROP FUNCTION IF EXISTS `nbcand_cnc_by_cat`$$
CREATE DEFINER=`zm_rabeha`@`localhost` FUNCTION `nbcand_cnc_by_cat` (`cncid` INT, `catid` INT) RETURNS INT(11) BEGIN
	set @nbr = (SELECT count(cnd_id) 
                from t_candidature_cnd 
                where cnc_id = cncid
               and cat_id = catid);
	RETURN @nbr;
END$$

DROP FUNCTION IF EXISTS `nbDocument`$$
CREATE DEFINER=`zm_rabeha`@`localhost` FUNCTION `nbDocument` (`id` INT) RETURNS INT(11) BEGIN
	set @nbr = (SELECT count(*) from t_document_doc where cnd_id = id);
	RETURN @nbr;
END$$

DROP FUNCTION IF EXISTS `nbImage_cnd`$$
CREATE DEFINER=`zm_rabeha`@`localhost` FUNCTION `nbImage_cnd` (`id` INT) RETURNS INT(11) BEGIN
	set @nbr = (SELECT count(*)
				from t_document_doc
				where (doc_url like '%.jpg'
				or doc_url like '%.png')
                AND cnd_id = id);
	RETURN @nbr;
END$$

DROP FUNCTION IF EXISTS `nbPreselectionne`$$
CREATE DEFINER=`zm_rabeha`@`localhost` FUNCTION `nbPreselectionne` (`id` INT) RETURNS INT(11) BEGIN
	set @nbr = (SELECT count(*) from t_candidature_cnd where cnd_etat = 'P' and cnc_id = id);
	RETURN @nbr;
END$$

DROP FUNCTION IF EXISTS `nbpre_cnc_by_cat`$$
CREATE DEFINER=`zm_rabeha`@`localhost` FUNCTION `nbpre_cnc_by_cat` (`cncid` INT, `catid` INT) RETURNS INT(11) BEGIN
	set @nbr = (SELECT count(*) 
                from t_candidature_cnd 
                where cnc_id = cncid
               and cat_id = catid
               and cnd_etat = 'P');
	RETURN @nbr;
END$$

DROP FUNCTION IF EXISTS `PhaseDuConcours`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `PhaseDuConcours` (`id` INT) RETURNS TEXT CHARSET utf8 BEGIN
	set @dateCnc = (SELECT cnc_dateDebut	from t_concours_cnc where cnc_id = id) ;
	set @nbCandidature = (SELECT cnc_dureeCandidature	from t_concours_cnc where cnc_id = id) ;
	set @nbPreselec = (SELECT cnc_dureePreselection	from t_concours_cnc where cnc_id = id) ;
	set @nbEval = (SELECT cnc_dureeEvaluation	from t_concours_cnc where cnc_id = id) ;

	if sysdate() >= adddate(@dateCnc,@nbCandidature+@nbPreselec+@nbEval) then return 'Terminé';
	elseif sysdate() >= adddate(@dateCnc,@nbCandidature+@nbPreselec) then return 'Evaluation';
	elseif sysdate() >= adddate(@dateCnc,@nbCandidature) then RETURN 'Preselection';
	elseif sysdate() >= @dateCnc then return 'Candidature';
	else return 'à Venir';
	end if;
END$$

DROP FUNCTION IF EXISTS `StatutCompte`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `StatutCompte` (`id` VARCHAR(20)) RETURNS TEXT CHARSET utf8 BEGIN
	set @existe = (SELECT count(*) from t_organisateur_org where cpt_pseudo = id);
	IF @existe = 1 then
		RETURN 'organisateur';
	END IF;
	set @existe = (SELECT count(*) from t_membre_jury where cpt_pseudo = id);
	IF @existe = 1 then
		RETURN 'jury';
	END IF;
	RETURN NULL;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `categoriesduconcours`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `CategoriesDuConcours`;
CREATE VIEW CategoriesDuConcours AS 
	SELECT *
	FROM t_concours_cnc
	join tj_concours_categorie using(cnc_id)
	join t_categorie_cat using(cat_id);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `donneesducompte`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `DonneesDuCompte`;
CREATE VIEW DonneesDuCompte AS 
	SELECT cpt_pseudo, cpt_nom, cpt_prenom, cpt_mail, cpt_etat 
	FROM t_compte_cpt;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `messagesdusujet`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `MessagesDuSujet`;
CREATE VIEW MessagesDuSujet AS 
	SELECT *
	FROM t_sujet_sjt
	join t_message_msg using(sjt_id);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `palmaresconcours`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `PalmaresConcours`;
CREATE VIEW PalmaresConcours AS 
	select DISTINCT cnc_id, cnd_nom, cnd_prenom, CandidatureNoteJuryActive(cnd_id) as note
	from t_candidature_cnd
	left join tj_candidature_note using(cnd_id)
	ORDER BY CandidatureNoteJuryActive(cnd_id) DESC;

-- --------------------------------------------------------

--
-- Structure de la table `tj_candidature_note`
--

DROP TABLE IF EXISTS `tj_candidature_note`;
CREATE TABLE IF NOT EXISTS `tj_candidature_note` (
  `cpt_pseudo` varchar(20) NOT NULL,
  `cnd_id` int(11) NOT NULL,
  `note` int(11) NOT NULL,
  PRIMARY KEY (`cpt_pseudo`,`cnd_id`),
  KEY `fk_t_membreJury_jury_has_t_candidature_cand_t_candidature_c_idx` (`cnd_id`),
  KEY `fk_t_membreJury_jury_has_t_candidature_cand_t_membreJury_ju_idx` (`cpt_pseudo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tj_candidature_note`
--

INSERT INTO `tj_candidature_note` (`cpt_pseudo`, `cnd_id`, `note`) VALUES
('anass_ait', 6, 3),
('hatimmrabet2', 6, 2),
('putra', 6, 4),
('saadoun', 4, 2),
('saadoun', 5, 1),
('saadoun', 6, 1);

-- --------------------------------------------------------

--
-- Structure de la table `tj_concours_categorie`
--

DROP TABLE IF EXISTS `tj_concours_categorie`;
CREATE TABLE IF NOT EXISTS `tj_concours_categorie` (
  `cnc_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  PRIMARY KEY (`cnc_id`,`cat_id`),
  KEY `fk_t_concours_con_has_t_categorie_cat_t_categorie_cat1_idx` (`cat_id`),
  KEY `fk_t_concours_con_has_t_categorie_cat_t_concours_con1_idx` (`cnc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tj_concours_categorie`
--

INSERT INTO `tj_concours_categorie` (`cnc_id`, `cat_id`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2),
(3, 2),
(1, 3),
(3, 3),
(13, 3);

-- --------------------------------------------------------

--
-- Structure de la table `tj_concours_jury`
--

DROP TABLE IF EXISTS `tj_concours_jury`;
CREATE TABLE IF NOT EXISTS `tj_concours_jury` (
  `cnc_id` int(11) NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL,
  PRIMARY KEY (`cnc_id`,`cpt_pseudo`),
  KEY `fk_t_membre_jury_has_t_concours_cnc_t_concours_cnc1_idx` (`cnc_id`),
  KEY `fk_t_membre_jury_has_t_concours_cnc_t_membre_jury1_idx` (`cpt_pseudo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tj_concours_jury`
--

INSERT INTO `tj_concours_jury` (`cnc_id`, `cpt_pseudo`) VALUES
(1, 'anass_ait'),
(1, 'hatimmrabet2'),
(1, 'khadija'),
(1, 'putra'),
(1, 'saadoun'),
(2, 'anass_ait'),
(2, 'hatimmrabet2'),
(2, 'putra'),
(2, 'saadoun'),
(13, 'hatimmrabet2'),
(13, 'khadija'),
(13, 'saadoun');

-- --------------------------------------------------------

--
-- Structure de la table `t_actualite_act`
--

DROP TABLE IF EXISTS `t_actualite_act`;
CREATE TABLE IF NOT EXISTS `t_actualite_act` (
  `act_id` int(11) NOT NULL AUTO_INCREMENT,
  `act_text` varchar(126) NOT NULL,
  `act_date` date NOT NULL,
  `act_etat` char(1) NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL,
  `cnc_id` int(11) NOT NULL,
  PRIMARY KEY (`act_id`),
  KEY `fk_t_actualite_act_t_admin_adm1_idx` (`cpt_pseudo`),
  KEY `fk_t_actualite_act_t_concours_con1_idx` (`cnc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_actualite_act`
--

INSERT INTO `t_actualite_act` (`act_id`, `act_text`, `act_date`, `act_etat`, `cpt_pseudo`, `cnc_id`) VALUES
(1, 'Nouvelle édition du concours dans les prochaines jours', '2020-10-20', 'D', 'organisateur', 1),
(2, 'Prolongation de la péride de candidature', '2020-10-12', 'A', 'organisateur', 1),
(4, 'The Freestyler | 2021-01-28 | Nous voilà avec un courcours Spéciale pour élire le meilleur Freestyler d\'Afrique.', '2020-10-20', 'D', 'organisateur', 2),
(20, 'NOUVEAU CONCOURS : The CNC | Date de début : 2020-09-11 | The CNC pour le meilleur footballeur des foot salle.', '2020-10-30', 'A', 'organisateur', 3),
(33, 'UPDATE CONOURS (The RaceBall) : « Attention, changement de date début » Nouvelle date : 2020-10-11.', '2020-11-18', 'A', 'organisateur', 1),
(34, 'UPDATE CONCOURS (The Freestylers) : « Attention, changement du nom » Nouveau nom : The Freestyler.', '2020-11-18', 'A', 'organisateur', 2),
(35, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-10-27.', '2020-11-18', 'A', 'organisateur', 2),
(36, 'UPDATE CONCOURS (THE CNC 2020) : « Attention, changement de discipline » Nouvelle discipline : Football Skills.', '2020-11-18', 'A', 'organisateur', 3),
(37, 'UPDATE CONCOURS (THE CNC 2020) : « Attention, changement de date début » Nouvelle date : 2020-09-14.', '2020-11-18', 'A', 'organisateur', 3),
(40, 'NOUVEAU CONCOURS : VA18 | Date de début : 2020-11-15 | VA18', '2020-11-18', 'A', 'organisateur', 12),
(41, 'UPDATE CONCOURS (VA18) : « Attention, changement de date début » Nouvelle date : 2020-09-14.', '2020-11-18', 'A', 'organisateur', 12),
(42, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-11-04.', '2020-12-04', 'A', 'organisateur', 2),
(43, 'UPDATE CONCOURS (THE CNC 2020) : « Attention, changement de date début » Nouvelle date : 2020-11-24.', '2020-12-05', 'A', 'organisateur', 3),
(44, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-10-29.', '2020-12-05', 'A', 'organisateur', 2),
(45, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-10-20.', '2020-12-05', 'A', 'organisateur', 2),
(46, 'UPDATE CONCOURS (THE CNC 2020) : « Attention, changement de date début » Nouvelle date : 2020-11-10.', '2020-12-06', 'A', 'organisateur', 3),
(47, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-10-06.', '2020-12-06', 'A', 'organisateur', 2),
(48, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-10-20.', '2020-12-06', 'A', 'organisateur', 2),
(49, 'UPDATE CONCOURS (The RaceBall) : « Attention, changement de date début » Nouvelle date : 2020-10-01.', '2020-12-06', 'A', 'organisateur', 1),
(50, 'UPDATE CONCOURS (THE CNC 2020) : « Attention, changement de date début » Nouvelle date : 2020-11-19.', '2020-12-06', 'A', 'organisateur', 3),
(51, 'UPDATE CONCOURS (THE CNC 2020) : « Attention, changement de date début » Nouvelle date : 2020-11-30.', '2020-12-06', 'A', 'organisateur', 3),
(52, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-11-10.', '2020-12-06', 'A', 'organisateur', 2),
(53, 'UPDATE CONCOURS (The RaceBall) : « Attention, changement de date début » Nouvelle date : 2020-12-01.', '2020-12-08', 'A', 'organisateur', 1),
(54, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-12-31.', '2020-12-08', 'A', 'organisateur', 2),
(55, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-11-30.', '2020-12-08', 'A', 'organisateur', 2),
(56, 'UPDATE CONCOURS (VA18) : « Attention, changement de date début » Nouvelle date : 2020-10-07.', '2020-12-08', 'A', 'organisateur', 12),
(57, 'UPDATE CONCOURS (VA18) : « Attention, changement de date début » Nouvelle date : 2020-12-01.', '2020-12-08', 'A', 'organisateur', 12),
(58, 'UPDATE CONCOURS (THE CNC 2020) : « Attention, changement de date début » Nouvelle date : 2020-11-03.', '2020-12-08', 'A', 'organisateur', 3),
(59, 'UPDATE CONCOURS (The RaceBall) : « Attention, changement de date début » Nouvelle date : 2020-11-11.', '2020-12-08', 'A', 'organisateur', 1),
(60, 'UPDATE CONCOURS (The RaceBall) : « Attention, changement de date début » Nouvelle date : 2020-11-01.', '2020-12-08', 'A', 'organisateur', 1),
(61, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-10-29.', '2020-12-08', 'A', 'organisateur', 2),
(62, 'UPDATE CONCOURS (THE CNC 2020) : « Attention, changement de date début » Nouvelle date : 2020-11-18.', '2020-12-08', 'A', 'organisateur', 3),
(63, 'UPDATE CONCOURS (VA18) : « Attention, changement de date début » Nouvelle date : 2020-10-14.', '2020-12-08', 'A', 'organisateur', 12),
(64, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-12-01.', '2020-12-08', 'A', 'organisateur', 2),
(65, 'UPDATE CONCOURS (The RaceBall) : « Attention, changement de date début » Nouvelle date : 2020-10-28.', '2020-12-08', 'A', 'organisateur', 1),
(66, 'UPDATE CONCOURS (The RaceBall) : « Attention, changement de date début » Nouvelle date : 2020-11-27.', '2020-12-08', 'A', 'organisateur', 1),
(67, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-11-11.', '2020-12-08', 'A', 'organisateur', 2),
(68, 'UPDATE CONCOURS (The Freestyler) : « Attention, changement de date début » Nouvelle date : 2020-10-21.', '2020-12-08', 'A', 'organisateur', 2),
(69, 'UPDATE CONCOURS (VA18) : « Attention, changement de date début » Nouvelle date : 2020-11-29.', '2020-12-08', 'A', 'organisateur', 12),
(70, 'UPDATE CONCOURS (The RaceBall) : « Attention, changement de date début » Nouvelle date : 2020-10-07.', '2020-12-08', 'A', 'organisateur', 1),
(71, 'NOUVEAU CONCOURS : The Golden Ball | Date de début : 2020-10-31 | Nous voilà avec un courcours Spéciale pour élire le meilleur', '2020-12-08', 'A', 'ayuuya', 13),
(72, 'UPDATE CONCOURS (The Golden Ball) : « Attention, changement de date début » Nouvelle date : 2020-12-04.', '2020-12-08', 'A', 'ayuuya', 13);

-- --------------------------------------------------------

--
-- Structure de la table `t_candidature_cnd`
--

DROP TABLE IF EXISTS `t_candidature_cnd`;
CREATE TABLE IF NOT EXISTS `t_candidature_cnd` (
  `cnd_id` int(11) NOT NULL AUTO_INCREMENT,
  `cnd_numDossier` char(20) NOT NULL,
  `cnd_numCandidat` char(8) NOT NULL,
  `cnd_mail` varchar(45) NOT NULL,
  `cnd_nom` varchar(45) NOT NULL,
  `cnd_prenom` varchar(45) NOT NULL,
  `cnd_biographie` varchar(256) NOT NULL,
  `cnd_dateCandidature` date NOT NULL,
  `cnd_etat` char(1) NOT NULL DEFAULT 'T',
  `cnc_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  PRIMARY KEY (`cnd_id`),
  UNIQUE KEY `cand_mail_UNIQUE` (`cnd_mail`),
  UNIQUE KEY `cnd_numDossier_UNIQUE` (`cnd_numDossier`),
  UNIQUE KEY `cnd_numCandidat_UNIQUE` (`cnd_numCandidat`),
  KEY `fk_t_candidature_cand_t_categorie_cat1_idx` (`cat_id`),
  KEY `fk_t_candidature_cnd_t_concours_cnc1_idx` (`cnc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_candidature_cnd`
--

INSERT INTO `t_candidature_cnd` (`cnd_id`, `cnd_numDossier`, `cnd_numCandidat`, `cnd_mail`, `cnd_nom`, `cnd_prenom`, `cnd_biographie`, `cnd_dateCandidature`, `cnd_etat`, `cnc_id`, `cat_id`) VALUES
(4, 'NDC20201007080043330', 'NC212008', 'messi@gmail.com', 'leo', 'messi', 'un joueur du FC Barcelone.', '2020-10-23', 'P', 2, 2),
(5, 'NDD20201047080043330', 'NC212009', 'cesc@gmail.com', 'cesc', 'fabrigas', 'un ancien joueur du FC Barcelone et Arsenal.', '2020-10-23', 'P', 2, 2),
(6, 'NDD20201047180043330', 'NC212089', 'baghdad@gmail.com', 'baghdad', 'bounjah', 'un ancien joueur du Etoile sportif de sahel.', '2020-10-23', 'T', 2, 2),
(7, 'NDD20201047180043331', 'NC218089', 'amina@gmail.com', 'el amim', 'amina', 'une joueure du Stade brestois 29.', '2020-10-23', 'A', 1, 1),
(8, 'NDC20201007000003330', 'NC202001', 'khalil@gmail.com', 'Chemki', 'khalil', 'Joueur de sousse pour 5 ans. ', '2020-10-23', 'P', 1, 1),
(12, 'NDD20201007000043332', 'NC202022', 'halima2@gmail.com', 'halima', 'lmarchi', 'une freestyleur de football.pas connu au niveau mondial.', '2020-10-23', 'P', 1, 1),
(38, 'NDD72495361083792106', 'NDC39816', 'Chloe2005@gmail.com', 'CHLOE', 'Arminien', 'je suis CHOLE', '2020-12-06', 'A', 3, 3),
(49, 'NDD45731026196325407', 'NDC29786', 'haitam.mr@gmail.com', 'Haitam', 'M\'rabet', 'Je fais du freestyle il y a plus de 3 ans.', '2020-12-08', 'P', 3, 3),
(50, 'NDD01345867829206571', 'NDC03614', 'neymar@gmail.com', 'Neymar', 'Jr', 'Joueur de PSG et ancien freestyler', '2020-12-08', 'P', 3, 2),
(51, 'NDD78134835705069242', 'NDC63509', 'salh@gmail.com', 'Ayoubi', 'Salaheddin', 'Sans experience...', '2020-12-08', 'T', 2, 2),
(52, 'NDD58715839634421067', 'NDC54837', 'chemkhi@gmail.com', 'Chemkhi', 'Iheb', 'Supporteur de l\'Etoile de Sousse, et freestyler.', '2020-12-08', 'P', 2, 1),
(53, 'NDD26515043877609192', 'NDC05621', 'antonella@gmail.com', 'Roccuzzo', 'Antonella', 'Je suis la femme de MESSI.', '2020-12-08', 'P', 1, 2),
(54, 'NDD91046273084815397', 'NDC49503', 'paul@gmail.com', 'Allaire', 'Paul', 'Joueur de basket mais je fais du freestyle de foot', '2020-12-08', 'T', 13, 3),
(55, 'NDD90396628738204575', 'NDC73061', 'mhmdsakka25@gmail.com', 'Sakka', 'Mohammad', 'Etudiant', '2020-12-09', 'T', 13, 3),
(58, 'NDD73537816842490602', 'NDC52310', 'jaha@gmail.com', 'totiix', 'im', 'je teste', '2020-12-09', 'A', 13, 3);

--
-- Déclencheurs `t_candidature_cnd`
--
DROP TRIGGER IF EXISTS `DeleteCandidature`;
DELIMITER $$
CREATE TRIGGER `DeleteCandidature` BEFORE DELETE ON `t_candidature_cnd` FOR EACH ROW BEGIN
	/* 	Seulement dans ce cas/ normalement une fois la candidature est 
		fermée il ne peut pas supprimer candidature 	*/
	DELETE from tj_candidature_note where tj_candidature_note.cnd_id = old.cnd_id;	
	DELETE from t_document_doc where t_document_doc.cnd_id = old.cnd_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_categorie_cat`
--

DROP TABLE IF EXISTS `t_categorie_cat`;
CREATE TABLE IF NOT EXISTS `t_categorie_cat` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_nom` varchar(45) NOT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_categorie_cat`
--

INSERT INTO `t_categorie_cat` (`cat_id`, `cat_nom`) VALUES
(1, 'Débutant'),
(2, 'Sénior'),
(3, 'Pro');

-- --------------------------------------------------------

--
-- Structure de la table `t_compte_cpt`
--

DROP TABLE IF EXISTS `t_compte_cpt`;
CREATE TABLE IF NOT EXISTS `t_compte_cpt` (
  `cpt_pseudo` varchar(20) NOT NULL,
  `cpt_mdp` char(64) NOT NULL,
  `cpt_nom` varchar(45) NOT NULL,
  `cpt_prenom` varchar(45) NOT NULL,
  `cpt_mail` varchar(45) NOT NULL,
  `cpt_etat` char(1) NOT NULL DEFAULT 'D',
  PRIMARY KEY (`cpt_pseudo`),
  UNIQUE KEY `pfl_mail_UNIQUE` (`cpt_mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_compte_cpt`
--

INSERT INTO `t_compte_cpt` (`cpt_pseudo`, `cpt_mdp`, `cpt_nom`, `cpt_prenom`, `cpt_mail`, `cpt_etat`) VALUES
('anass_ait', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'ait abdelkrim', 'Anass', 'anass@gmail.com', 'A'),
('ayuuya', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'Akdi', 'Aya', 'aya@gmail.com', 'A'),
('hatimmrabet2', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'M\'rabet', 'Hatim', 'mrabet.hatim2018@gmail.com', 'A'),
('idefix', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'ide', 'fix', 'idefix@gmail.com', 'A'),
('imadmh', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'MEHSSANI', 'Imad', 'imad@gmail.com', 'D'),
('khadija', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'El Bahi', 'khadija', 'khadija@gmail.com', 'A'),
('khalid', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'AHANNACH', 'Khalid', 'hatimmrabet2@gmail.com', 'D'),
('organisateur', '969232affd8d9251bb217fd6c8f87344d24260e17948f9c114045aa206d27d49', 'Marc', 'Valérie', 'vmarc@gmail.com', 'A'),
('putra', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'CHEMKHI', 'Iheb', 'ihebchemkhi@gmail.com', 'A'),
('saadoun', '6cc9ae9aa8e9851454d4eb902f73b8f2101d4737efddda233b7f894ab620563b', 'Saad', 'Mehyaoui', 'saadoun@gmail.com', 'D');

--
-- Déclencheurs `t_compte_cpt`
--
DROP TRIGGER IF EXISTS `DeleteCompte`;
DELIMITER $$
CREATE TRIGGER `DeleteCompte` BEFORE DELETE ON `t_compte_cpt` FOR EACH ROW BEGIN
	IF old.cpt_pseudo != 'organisateur' Then
		UPDATE t_concours_cnc set t_concours_cnc.cpt_pseudo = 'organisateur' WHERE t_concours_cnc.cpt_pseudo = old.cpt_pseudo and sysdate() >= t_concours_cnc.cnc_dateDebut;
		DELETE FROM t_concours_cnc where t_concours_cnc.cpt_pseudo = old.cpt_pseudo;
		DELETE FROM t_actualite_act where t_actualite_act.cpt_pseudo = old.cpt_pseudo;
		DELETE FROM t_message_msg where t_message_msg.cpt_pseudo = old.cpt_pseudo;
		DELETE FROM tj_candidature_note where tj_candidature_note.cpt_pseudo = old.cpt_pseudo;
		DELETE FROM tj_concours_jury where tj_concours_jury.cpt_pseudo = old.cpt_pseudo;
		DELETE FROM t_organisateur_org where t_organisateur_org.cpt_pseudo = old.cpt_pseudo;
		DELETE FROM t_membre_jury where t_membre_jury.cpt_pseudo = old.cpt_pseudo;
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_concours_cnc`
--

DROP TABLE IF EXISTS `t_concours_cnc`;
CREATE TABLE IF NOT EXISTS `t_concours_cnc` (
  `cnc_id` int(11) NOT NULL AUTO_INCREMENT,
  `cnc_nom` varchar(64) NOT NULL,
  `cnc_discipline` varchar(64) NOT NULL,
  `cnc_textIntro` varchar(256) NOT NULL,
  `cnc_dateDebut` date NOT NULL,
  `cnc_dureeCandidature` int(11) NOT NULL,
  `cnc_dureePreselection` int(11) NOT NULL,
  `cnc_dureeEvaluation` int(11) NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL,
  PRIMARY KEY (`cnc_id`),
  KEY `fk_t_concours_con_t_admin_adm1_idx` (`cpt_pseudo`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_concours_cnc`
--

INSERT INTO `t_concours_cnc` (`cnc_id`, `cnc_nom`, `cnc_discipline`, `cnc_textIntro`, `cnc_dateDebut`, `cnc_dureeCandidature`, `cnc_dureePreselection`, `cnc_dureeEvaluation`, `cpt_pseudo`) VALUES
(1, 'The RaceBall', 'Football Freestyle', 'Soyez prêt, UrbanBall lance le concours « The RaceBall » pour élire le meilleur YouTuBaller.', '2020-10-07', 20, 14, 7, 'organisateur'),
(2, 'The Freestyler', 'Football Freestyle', 'Nous voilà avec un courcours Spéciale pour élire le meilleur Freestyler d\'Afrique.', '2020-10-21', 18, 20, 14, 'organisateur'),
(3, 'THE CNC 2020', 'Football Skills', 'The CNC pour le meilleur footballeur des foot salle.', '2020-11-18', 10, 20, 9, 'organisateur'),
(12, 'VA18', 'VA18', 'VA18', '2020-11-29', 10, 10, 10, 'organisateur'),
(13, 'The Golden Ball', 'Football Freestyle', 'Nous voilà avec un courcours Spéciale pour élire le meilleur Freestyler d\'EUROPE.', '2020-12-04', 10, 6, 5, 'ayuuya');

--
-- Déclencheurs `t_concours_cnc`
--
DROP TRIGGER IF EXISTS `DeleteConcours`;
DELIMITER $$
CREATE TRIGGER `DeleteConcours` BEFORE DELETE ON `t_concours_cnc` FOR EACH ROW BEGIN
	IF sysdate() < old.cnc_dateDebut then
		DELETE FROM t_actualite_act WHERE t_actualite_act.cnc_id = old.cnc_id;
		DELETE FROM t_candidature_cnd WHERE t_candidature_cnd.cnc_id = old.cnc_id;
		DELETE FROM tj_concours_jury WHERE tj_concours_jury.cnc_id = old.cnc_id;
		DELETE FROM tj_concours_categorie WHERE tj_concours_categorie.cnc_id = old.cnc_id;
		DELETE FROM t_categorie_cat WHERE t_categorie_cat.cat_id not in (SELECT distinct cat_id from tj_concours_categorie);
	END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `InsertAutoAct`;
DELIMITER $$
CREATE TRIGGER `InsertAutoAct` AFTER INSERT ON `t_concours_cnc` FOR EACH ROW BEGIN
	call ActualiteCreationConcours();
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `InsertAutoAct_UpdateConcours`;
DELIMITER $$
CREATE TRIGGER `InsertAutoAct_UpdateConcours` AFTER UPDATE ON `t_concours_cnc` FOR EACH ROW BEGIN
	if OLD.cnc_nom != NEW.cnc_nom then
		insert into t_actualite_act 
		values(null,concat('UPDATE CONOURS (',OLD.cnc_nom,') : « Attention, changement du nom » Nouveau nom : ',NEW.cnc_nom,'.'),sysdate(),'A',OLD.cpt_pseudo,NEW.cnc_id);
	end if;

	if OLD.cnc_dateDebut != NEW.cnc_dateDebut then
		insert into t_actualite_act 
		values(null,concat('UPDATE CONOURS (',OLD.cnc_nom,') : « Attention, changement de date début » Nouvelle date : ',NEW.cnc_dateDebut,'.'),sysdate(),'A',OLD.cpt_pseudo,NEW.cnc_id);
	end if;

	if OLD.cnc_discipline != NEW.cnc_discipline then
		insert into t_actualite_act 
		values(null,concat('UPDATE CONOURS (',OLD.cnc_nom,') : « Attention, changement de discipline » Nouvelle discipline : ',NEW.cnc_discipline,'.'),sysdate(),'A',OLD.cpt_pseudo,NEW.cnc_id);
	end if;

	if OLD.cnc_dureeCandidature != NEW.cnc_dureeCandidature then
		insert into t_actualite_act 
		values(null,concat('UPDATE CONOURS (',OLD.cnc_nom,') : « Attention, changement des dates » Nouvelle durée de Candidature : ',NEW.cnc_dureeCandidature,' jours.'),sysdate(),'A',OLD.cpt_pseudo,NEW.cnc_id);
	end if;

	if OLD.cnc_dureePreselection != NEW.cnc_dureePreselection then
		insert into t_actualite_act 
		values(null,concat('UPDATE CONOURS (',OLD.cnc_nom,') : « Attention, changement des dates » Nouvelle durée de Preselection : ',NEW.cnc_dureePreselection,' jours.'),sysdate(),'A',OLD.cpt_pseudo,NEW.cnc_id);
	end if;

	if OLD.cnc_dureeEvaluation != NEW.cnc_dureeEvaluation then
		insert into t_actualite_act 
		values(null,concat('UPDATE CONOURS (',OLD.cnc_nom,') : « Attention, changement des dates » Nouvelle durée d'Evaluation : ',NEW.cnc_dureeEvaluation,' jours.'),sysdate(),'A',OLD.cpt_pseudo,NEW.cnc_id);
	end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_document_doc`
--

DROP TABLE IF EXISTS `t_document_doc`;
CREATE TABLE IF NOT EXISTS `t_document_doc` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_titre` varchar(64) NOT NULL,
  `doc_url` varchar(128) NOT NULL,
  `cnd_id` int(11) NOT NULL,
  PRIMARY KEY (`doc_id`),
  KEY `fk_t_document_doc_t_candidature_cand1_idx` (`cnd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_document_doc`
--

INSERT INTO `t_document_doc` (`doc_id`, `doc_titre`, `doc_url`, `cnd_id`) VALUES
(32, 'test', 'NDC20201007000003330NC202001.pdf', 8),
(33, 'Photo de profile', 'NDC20201007000003330NC202001.jpg', 8),
(34, 'ma photo', 'NDD45731026196325407NDC29786.jpg', 49),
(35, 'lettre de motivation', 'NDD45731026196325407NDC29786.pdf', 49),
(36, 'photo', 'NDD01345867829206571NDC03614.jpg', 50),
(37, 'test', 'NDD01345867829206571NDC036141.jpg', 50),
(38, 'Photo de profile', 'NDD78134835705069242NDC63509.png', 51),
(39, 'PDF', 'NDD78134835705069242NDC63509.pdf', 51),
(40, 'Photo de profile', 'NDD20201047080043330NC212009.jpg', 5),
(41, 'Photo de profile', 'NDC20201007080043330NC212008.jpg', 4),
(42, 'Photo de profile', 'NDD58715839634421067NDC54837.jpg', 52),
(43, 'Photo de profile', 'NDD26515043877609192NDC05621.jpg', 53),
(45, 'avec monaco', 'NDD20201047080043330NC2120091.jpg', 5),
(46, 'avec mo\'naco', 'NDD20201047080043330NC2120092.jpg', 5),
(47, 'photo', 'NDD73537816842490602NDC52310.jpg', 58),
(49, 'test', 'NDC20201007000003330NC2020011.jpg', 8);

-- --------------------------------------------------------

--
-- Structure de la table `t_membre_jury`
--

DROP TABLE IF EXISTS `t_membre_jury`;
CREATE TABLE IF NOT EXISTS `t_membre_jury` (
  `cpt_pseudo` varchar(20) NOT NULL,
  `jury_biographie` varchar(256) NOT NULL,
  `jury_discipline` varchar(64) NOT NULL,
  `jury_url` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`cpt_pseudo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_membre_jury`
--

INSERT INTO `t_membre_jury` (`cpt_pseudo`, `jury_biographie`, `jury_discipline`, `jury_url`) VALUES
('anass_ait', 'Ancien joueur de l\'équipe nationale marocaine.', 'Joueur de football', NULL),
('hatimmrabet2', 'Ancien joueur de FC Barcelone et de l\'équipe nationale marocaine.', 'Joueur de football', 'https://fr.linkedin.com/in/hatimmrabet'),
('idefix', 'je teste', 'test', NULL),
('imadmh', 'J\'ai deja jouer avec le MAT pendant 5 ans.', 'Joueur milieu du terrain', NULL),
('khadija', 'Préparatrice physique de MAT.', 'Préparateur physique', NULL),
('putra', 'Ancien défenseur de l\'équipe nationale tunisienne.', 'Joueur de football', 'https://www.instagram.com/hatimmrabet2/'),
('saadoun', 'Gardien du it-tihad zemamra.', 'Joueur de futsal', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `t_message_msg`
--

DROP TABLE IF EXISTS `t_message_msg`;
CREATE TABLE IF NOT EXISTS `t_message_msg` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `msg_text` varchar(128) NOT NULL,
  `msg_date` datetime NOT NULL,
  `msg_etat` char(1) NOT NULL,
  `sjt_id` int(11) NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL,
  PRIMARY KEY (`msg_id`),
  KEY `fk_t_message_msg_t_sujet_sjt1_idx` (`sjt_id`),
  KEY `fk_t_message_msg_t_membreJury_jury1_idx` (`cpt_pseudo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_message_msg`
--

INSERT INTO `t_message_msg` (`msg_id`, `msg_text`, `msg_date`, `msg_etat`, `sjt_id`, `cpt_pseudo`) VALUES
(3, 'je sais pas combien je doit donner à messi', '2020-10-11 13:13:34', 'A', 2, 'hatimmrabet2'),
(4, 'franchement il a fait un bon show', '2020-10-11 13:13:52', 'A', 2, 'saadoun'),
(5, 'moi perso, j\'ai lui donné 4 points', '2020-10-11 13:14:22', 'A', 2, 'anass_ait'),
(6, 'si si il les merite ', '2020-10-11 13:14:44', 'A', 2, 'saadoun'),
(7, 'et toi saad, tu lui a donné combien', '2020-10-11 13:15:10', 'A', 2, 'hatimmrabet2'),
(8, '4 points', '2020-10-11 13:15:30', 'A', 2, 'saadoun'),
(9, 'moi aussi, j\'ai lui donné 4 points, il est le meilleur', '2020-10-11 13:16:19', 'A', 2, 'putra');

-- --------------------------------------------------------

--
-- Structure de la table `t_organisateur_org`
--

DROP TABLE IF EXISTS `t_organisateur_org`;
CREATE TABLE IF NOT EXISTS `t_organisateur_org` (
  `cpt_pseudo` varchar(20) NOT NULL,
  PRIMARY KEY (`cpt_pseudo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_organisateur_org`
--

INSERT INTO `t_organisateur_org` (`cpt_pseudo`) VALUES
('ayuuya'),
('khalid'),
('organisateur');

-- --------------------------------------------------------

--
-- Structure de la table `t_sujet_sjt`
--

DROP TABLE IF EXISTS `t_sujet_sjt`;
CREATE TABLE IF NOT EXISTS `t_sujet_sjt` (
  `sjt_id` int(11) NOT NULL AUTO_INCREMENT,
  `sjt_titre` varchar(64) NOT NULL,
  `cnc_id` int(11) NOT NULL,
  PRIMARY KEY (`sjt_id`),
  KEY `fk_t_sujet_sjt_t_concours_cnc1_idx` (`cnc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_sujet_sjt`
--

INSERT INTO `t_sujet_sjt` (`sjt_id`, `sjt_titre`, `cnc_id`) VALUES
(2, 'Notage de Leo Messi', 2);

--
-- Déclencheurs `t_sujet_sjt`
--
DROP TRIGGER IF EXISTS `DeleteSujet`;
DELIMITER $$
CREATE TRIGGER `DeleteSujet` BEFORE DELETE ON `t_sujet_sjt` FOR EACH ROW BEGIN
	DELETE from t_message_msg where t_message_msg.sjt_id = old.sjt_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la vue `categoriesduconcours`
--
DROP TABLE IF EXISTS `categoriesduconcours`;

DROP VIEW IF EXISTS `categoriesduconcours`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `categoriesduconcours`  AS  select `tj_concours_categorie`.`cat_id` AS `cat_id`,`t_concours_cnc`.`cnc_id` AS `cnc_id`,`t_concours_cnc`.`cnc_nom` AS `cnc_nom`,`t_concours_cnc`.`cnc_discipline` AS `cnc_discipline`,`t_concours_cnc`.`cnc_textIntro` AS `cnc_textIntro`,`t_concours_cnc`.`cnc_dateDebut` AS `cnc_dateDebut`,`t_concours_cnc`.`cnc_dureeCandidature` AS `cnc_dureeCandidature`,`t_concours_cnc`.`cnc_dureePreselection` AS `cnc_dureePreselection`,`t_concours_cnc`.`cnc_dureeEvaluation` AS `cnc_dureeEvaluation`,`t_concours_cnc`.`cpt_pseudo` AS `cpt_pseudo`,`t_categorie_cat`.`cat_nom` AS `cat_nom` from ((`t_concours_cnc` join `tj_concours_categorie` on((`t_concours_cnc`.`cnc_id` = `tj_concours_categorie`.`cnc_id`))) join `t_categorie_cat` on((`tj_concours_categorie`.`cat_id` = `t_categorie_cat`.`cat_id`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `donneesducompte`
--
DROP TABLE IF EXISTS `donneesducompte`;

DROP VIEW IF EXISTS `donneesducompte`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `donneesducompte`  AS  select `t_compte_cpt`.`cpt_pseudo` AS `cpt_pseudo`,`t_compte_cpt`.`cpt_nom` AS `cpt_nom`,`t_compte_cpt`.`cpt_prenom` AS `cpt_prenom`,`t_compte_cpt`.`cpt_mail` AS `cpt_mail`,`t_compte_cpt`.`cpt_etat` AS `cpt_etat` from `t_compte_cpt` ;

-- --------------------------------------------------------

--
-- Structure de la vue `messagesdusujet`
--
DROP TABLE IF EXISTS `messagesdusujet`;

DROP VIEW IF EXISTS `messagesdusujet`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `messagesdusujet`  AS  select `t_sujet_sjt`.`sjt_id` AS `sjt_id`,`t_sujet_sjt`.`sjt_titre` AS `sjt_titre`,`t_sujet_sjt`.`cnc_id` AS `cnc_id`,`t_message_msg`.`msg_id` AS `msg_id`,`t_message_msg`.`msg_text` AS `msg_text`,`t_message_msg`.`msg_date` AS `msg_date`,`t_message_msg`.`msg_etat` AS `msg_etat`,`t_message_msg`.`cpt_pseudo` AS `cpt_pseudo` from (`t_sujet_sjt` join `t_message_msg` on((`t_sujet_sjt`.`sjt_id` = `t_message_msg`.`sjt_id`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `palmaresconcours`
--
DROP TABLE IF EXISTS `palmaresconcours`;

DROP VIEW IF EXISTS `palmaresconcours`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `palmaresconcours`  AS  select distinct `t_candidature_cnd`.`cnc_id` AS `cnc_id`,`t_candidature_cnd`.`cnd_nom` AS `cnd_nom`,`t_candidature_cnd`.`cnd_prenom` AS `cnd_prenom`,`CandidatureNoteJuryActive`(`t_candidature_cnd`.`cnd_id`) AS `note` from (`t_candidature_cnd` left join `tj_candidature_note` on((`t_candidature_cnd`.`cnd_id` = `tj_candidature_note`.`cnd_id`))) order by `CandidatureNoteJuryActive`(`t_candidature_cnd`.`cnd_id`) desc ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `tj_candidature_note`
--
ALTER TABLE `tj_candidature_note`
  ADD CONSTRAINT `fk_t_membreJury_jury_has_t_candidature_cand_t_candidature_cand1` FOREIGN KEY (`cnd_id`) REFERENCES `t_candidature_cnd` (`cnd_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_membreJury_jury_has_t_candidature_cand_t_membreJury_jury1` FOREIGN KEY (`cpt_pseudo`) REFERENCES `t_membre_jury` (`cpt_pseudo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `tj_concours_categorie`
--
ALTER TABLE `tj_concours_categorie`
  ADD CONSTRAINT `fk_t_concours_con_has_t_categorie_cat_t_categorie_cat1` FOREIGN KEY (`cat_id`) REFERENCES `t_categorie_cat` (`cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_concours_con_has_t_categorie_cat_t_concours_con1` FOREIGN KEY (`cnc_id`) REFERENCES `t_concours_cnc` (`cnc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `tj_concours_jury`
--
ALTER TABLE `tj_concours_jury`
  ADD CONSTRAINT `fk_t_membre_jury_has_t_concours_cnc_t_concours_cnc1` FOREIGN KEY (`cnc_id`) REFERENCES `t_concours_cnc` (`cnc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_membre_jury_has_t_concours_cnc_t_membre_jury1` FOREIGN KEY (`cpt_pseudo`) REFERENCES `t_membre_jury` (`cpt_pseudo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_actualite_act`
--
ALTER TABLE `t_actualite_act`
  ADD CONSTRAINT `fk_t_actualite_act_t_admin_adm1` FOREIGN KEY (`cpt_pseudo`) REFERENCES `t_organisateur_org` (`cpt_pseudo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_actualite_act_t_concours_con1` FOREIGN KEY (`cnc_id`) REFERENCES `t_concours_cnc` (`cnc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_candidature_cnd`
--
ALTER TABLE `t_candidature_cnd`
  ADD CONSTRAINT `fk_t_candidature_cand_t_categorie_cat1` FOREIGN KEY (`cat_id`) REFERENCES `t_categorie_cat` (`cat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_candidature_cnd_t_concours_cnc1` FOREIGN KEY (`cnc_id`) REFERENCES `t_concours_cnc` (`cnc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_concours_cnc`
--
ALTER TABLE `t_concours_cnc`
  ADD CONSTRAINT `fk_t_concours_con_t_admin_adm1` FOREIGN KEY (`cpt_pseudo`) REFERENCES `t_organisateur_org` (`cpt_pseudo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_document_doc`
--
ALTER TABLE `t_document_doc`
  ADD CONSTRAINT `fk_t_document_doc_t_candidature_cand1` FOREIGN KEY (`cnd_id`) REFERENCES `t_candidature_cnd` (`cnd_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_membre_jury`
--
ALTER TABLE `t_membre_jury`
  ADD CONSTRAINT `fk_t_membreJury_jury_t_profil_pfl1` FOREIGN KEY (`cpt_pseudo`) REFERENCES `t_compte_cpt` (`cpt_pseudo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_message_msg`
--
ALTER TABLE `t_message_msg`
  ADD CONSTRAINT `fk_t_message_msg_t_membreJury_jury1` FOREIGN KEY (`cpt_pseudo`) REFERENCES `t_membre_jury` (`cpt_pseudo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_message_msg_t_sujet_sjt1` FOREIGN KEY (`sjt_id`) REFERENCES `t_sujet_sjt` (`sjt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_organisateur_org`
--
ALTER TABLE `t_organisateur_org`
  ADD CONSTRAINT `fk_t_admin_adm_t_profil_pfl1` FOREIGN KEY (`cpt_pseudo`) REFERENCES `t_compte_cpt` (`cpt_pseudo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_sujet_sjt`
--
ALTER TABLE `t_sujet_sjt`
  ADD CONSTRAINT `fk_t_sujet_sjt_t_concours_cnc1` FOREIGN KEY (`cnc_id`) REFERENCES `t_concours_cnc` (`cnc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
