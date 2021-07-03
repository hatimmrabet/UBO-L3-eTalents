-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le :  Dim 04 avr. 2021 à 17:47
-- Version du serveur :  10.3.9-MariaDB
-- Version de PHP :  7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `znl3-zm_rabeha`
--

-- --------------------------------------------------------

--
-- Structure de la table `tj_candidature_note`
--

DROP TABLE IF EXISTS `tj_candidature_note`;
CREATE TABLE `tj_candidature_note` (
  `cpt_pseudo` varchar(20) NOT NULL,
  `cnd_id` int(11) NOT NULL,
  `note` int(11) NOT NULL
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
CREATE TABLE `tj_concours_categorie` (
  `cnc_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tj_concours_categorie`
--

INSERT INTO `tj_concours_categorie` (`cnc_id`, `cat_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 2),
(3, 3),
(13, 3);

-- --------------------------------------------------------

--
-- Structure de la table `tj_concours_jury`
--

DROP TABLE IF EXISTS `tj_concours_jury`;
CREATE TABLE `tj_concours_jury` (
  `cnc_id` int(11) NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL
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
CREATE TABLE `t_actualite_act` (
  `act_id` int(11) NOT NULL,
  `act_text` varchar(126) NOT NULL,
  `act_date` date NOT NULL,
  `act_etat` char(1) NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL,
  `cnc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
CREATE TABLE `t_candidature_cnd` (
  `cnd_id` int(11) NOT NULL,
  `cnd_numDossier` char(20) NOT NULL,
  `cnd_numCandidat` char(8) NOT NULL,
  `cnd_mail` varchar(45) NOT NULL,
  `cnd_nom` varchar(45) NOT NULL,
  `cnd_prenom` varchar(45) NOT NULL,
  `cnd_biographie` varchar(256) NOT NULL,
  `cnd_dateCandidature` date NOT NULL,
  `cnd_etat` char(1) NOT NULL DEFAULT 'T',
  `cnc_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Structure de la table `t_categorie_cat`
--

DROP TABLE IF EXISTS `t_categorie_cat`;
CREATE TABLE `t_categorie_cat` (
  `cat_id` int(11) NOT NULL,
  `cat_nom` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
CREATE TABLE `t_compte_cpt` (
  `cpt_pseudo` varchar(20) NOT NULL,
  `cpt_mdp` char(64) NOT NULL,
  `cpt_nom` varchar(45) NOT NULL,
  `cpt_prenom` varchar(45) NOT NULL,
  `cpt_mail` varchar(45) NOT NULL,
  `cpt_etat` char(1) NOT NULL DEFAULT 'D'
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

-- --------------------------------------------------------

--
-- Structure de la table `t_concours_cnc`
--

DROP TABLE IF EXISTS `t_concours_cnc`;
CREATE TABLE `t_concours_cnc` (
  `cnc_id` int(11) NOT NULL,
  `cnc_nom` varchar(64) NOT NULL,
  `cnc_discipline` varchar(64) NOT NULL,
  `cnc_textIntro` varchar(256) NOT NULL,
  `cnc_dateDebut` date NOT NULL,
  `cnc_dureeCandidature` int(11) NOT NULL,
  `cnc_dureePreselection` int(11) NOT NULL,
  `cnc_dureeEvaluation` int(11) NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_concours_cnc`
--

INSERT INTO `t_concours_cnc` (`cnc_id`, `cnc_nom`, `cnc_discipline`, `cnc_textIntro`, `cnc_dateDebut`, `cnc_dureeCandidature`, `cnc_dureePreselection`, `cnc_dureeEvaluation`, `cpt_pseudo`) VALUES
(1, 'The RaceBall', 'Football Freestyle', 'Soyez prêt, UrbanBall lance le concours « The RaceBall » pour élire le meilleur YouTuBaller.', '2020-10-07', 20, 14, 7, 'organisateur'),
(2, 'The Freestyler', 'Football Freestyle', 'Nous voilà avec un courcours Spéciale pour élire le meilleur Freestyler d\'Afrique.', '2020-10-21', 18, 20, 14, 'organisateur'),
(3, 'THE CNC 2020', 'Football Skills', 'The CNC pour le meilleur footballeur des foot salle.', '2020-11-18', 10, 20, 9, 'organisateur'),
(12, 'VA18', 'VA18', 'VA18', '2020-11-29', 10, 10, 10, 'organisateur'),
(13, 'The Golden Ball', 'Football Freestyle', 'Nous voilà avec un courcours Spéciale pour élire le meilleur Freestyler d\'EUROPE.', '2020-12-04', 10, 6, 5, 'ayuuya');

-- --------------------------------------------------------

--
-- Structure de la table `t_document_doc`
--

DROP TABLE IF EXISTS `t_document_doc`;
CREATE TABLE `t_document_doc` (
  `doc_id` int(11) NOT NULL,
  `doc_titre` varchar(64) NOT NULL,
  `doc_url` varchar(128) NOT NULL,
  `cnd_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(47, 'photo', 'NDD73537816842490602NDC52310.jpg', 58);

-- --------------------------------------------------------

--
-- Structure de la table `t_membre_jury`
--

DROP TABLE IF EXISTS `t_membre_jury`;
CREATE TABLE `t_membre_jury` (
  `cpt_pseudo` varchar(20) NOT NULL,
  `jury_biographie` varchar(256) NOT NULL,
  `jury_discipline` varchar(64) NOT NULL,
  `jury_url` varchar(256) DEFAULT NULL
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
CREATE TABLE `t_message_msg` (
  `msg_id` int(11) NOT NULL,
  `msg_text` varchar(128) NOT NULL,
  `msg_date` datetime NOT NULL,
  `msg_etat` char(1) NOT NULL,
  `sjt_id` int(11) NOT NULL,
  `cpt_pseudo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
CREATE TABLE `t_organisateur_org` (
  `cpt_pseudo` varchar(20) NOT NULL
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
CREATE TABLE `t_sujet_sjt` (
  `sjt_id` int(11) NOT NULL,
  `sjt_titre` varchar(64) NOT NULL,
  `cnc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `t_sujet_sjt`
--

INSERT INTO `t_sujet_sjt` (`sjt_id`, `sjt_titre`, `cnc_id`) VALUES
(2, 'Notage de Leo Messi', 2);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `tj_candidature_note`
--
ALTER TABLE `tj_candidature_note`
  ADD PRIMARY KEY (`cpt_pseudo`,`cnd_id`),
  ADD KEY `fk_t_membreJury_jury_has_t_candidature_cand_t_candidature_c_idx` (`cnd_id`),
  ADD KEY `fk_t_membreJury_jury_has_t_candidature_cand_t_membreJury_ju_idx` (`cpt_pseudo`);

--
-- Index pour la table `tj_concours_categorie`
--
ALTER TABLE `tj_concours_categorie`
  ADD PRIMARY KEY (`cnc_id`,`cat_id`),
  ADD KEY `fk_t_concours_con_has_t_categorie_cat_t_categorie_cat1_idx` (`cat_id`),
  ADD KEY `fk_t_concours_con_has_t_categorie_cat_t_concours_con1_idx` (`cnc_id`);

--
-- Index pour la table `tj_concours_jury`
--
ALTER TABLE `tj_concours_jury`
  ADD PRIMARY KEY (`cnc_id`,`cpt_pseudo`),
  ADD KEY `fk_t_membre_jury_has_t_concours_cnc_t_concours_cnc1_idx` (`cnc_id`),
  ADD KEY `fk_t_membre_jury_has_t_concours_cnc_t_membre_jury1_idx` (`cpt_pseudo`);

--
-- Index pour la table `t_actualite_act`
--
ALTER TABLE `t_actualite_act`
  ADD PRIMARY KEY (`act_id`),
  ADD KEY `fk_t_actualite_act_t_admin_adm1_idx` (`cpt_pseudo`),
  ADD KEY `fk_t_actualite_act_t_concours_con1_idx` (`cnc_id`);

--
-- Index pour la table `t_candidature_cnd`
--
ALTER TABLE `t_candidature_cnd`
  ADD PRIMARY KEY (`cnd_id`),
  ADD UNIQUE KEY `cand_mail_UNIQUE` (`cnd_mail`),
  ADD UNIQUE KEY `cnd_numDossier_UNIQUE` (`cnd_numDossier`),
  ADD UNIQUE KEY `cnd_numCandidat_UNIQUE` (`cnd_numCandidat`),
  ADD KEY `fk_t_candidature_cand_t_categorie_cat1_idx` (`cat_id`),
  ADD KEY `fk_t_candidature_cnd_t_concours_cnc1_idx` (`cnc_id`);

--
-- Index pour la table `t_categorie_cat`
--
ALTER TABLE `t_categorie_cat`
  ADD PRIMARY KEY (`cat_id`);

--
-- Index pour la table `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  ADD PRIMARY KEY (`cpt_pseudo`),
  ADD UNIQUE KEY `pfl_mail_UNIQUE` (`cpt_mail`);

--
-- Index pour la table `t_concours_cnc`
--
ALTER TABLE `t_concours_cnc`
  ADD PRIMARY KEY (`cnc_id`),
  ADD KEY `fk_t_concours_con_t_admin_adm1_idx` (`cpt_pseudo`);

--
-- Index pour la table `t_document_doc`
--
ALTER TABLE `t_document_doc`
  ADD PRIMARY KEY (`doc_id`),
  ADD KEY `fk_t_document_doc_t_candidature_cand1_idx` (`cnd_id`);

--
-- Index pour la table `t_membre_jury`
--
ALTER TABLE `t_membre_jury`
  ADD PRIMARY KEY (`cpt_pseudo`);

--
-- Index pour la table `t_message_msg`
--
ALTER TABLE `t_message_msg`
  ADD PRIMARY KEY (`msg_id`),
  ADD KEY `fk_t_message_msg_t_sujet_sjt1_idx` (`sjt_id`),
  ADD KEY `fk_t_message_msg_t_membreJury_jury1_idx` (`cpt_pseudo`);

--
-- Index pour la table `t_organisateur_org`
--
ALTER TABLE `t_organisateur_org`
  ADD PRIMARY KEY (`cpt_pseudo`);

--
-- Index pour la table `t_sujet_sjt`
--
ALTER TABLE `t_sujet_sjt`
  ADD PRIMARY KEY (`sjt_id`),
  ADD KEY `fk_t_sujet_sjt_t_concours_cnc1_idx` (`cnc_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `t_actualite_act`
--
ALTER TABLE `t_actualite_act`
  MODIFY `act_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT pour la table `t_candidature_cnd`
--
ALTER TABLE `t_candidature_cnd`
  MODIFY `cnd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT pour la table `t_categorie_cat`
--
ALTER TABLE `t_categorie_cat`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `t_concours_cnc`
--
ALTER TABLE `t_concours_cnc`
  MODIFY `cnc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `t_document_doc`
--
ALTER TABLE `t_document_doc`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT pour la table `t_message_msg`
--
ALTER TABLE `t_message_msg`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `t_sujet_sjt`
--
ALTER TABLE `t_sujet_sjt`
  MODIFY `sjt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
