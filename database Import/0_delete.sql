--
-- DELETE TABLES
--
-- TABLE JOINTURES
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`tj_concours_jury` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`tj_concours_categorie` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`tj_candidature_note` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`tj_edition_jury` ;

-- COMMUNICATION
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_actualite_act` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_message_msg` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_sujet_sjt` ;

-- CANDIDATURE
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_document_doc` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_candidature_cnd` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_categorie_cat` ;

-- CONCOURS
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_edition_edt` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_concours_cnc` ;

-- COMPTE
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_organisateur_org` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_membre_jury` ;
DROP TABLE IF EXISTS `znl3-zm_rabeha`.`t_compte_cpt` ;


--
-- DELETE SQL-PSM
--
DROP VIEW IF EXISTS DonneesDuCompte;
DROP VIEW IF EXISTS CategoriesDuConcours;
DROP VIEW IF EXISTS MessagesDuSujet;
DROP VIEW IF EXISTS PalmaresConcours;

DROP FUNCTION IF EXISTS StatutCompte;
DROP FUNCTION IF EXISTS nbCandidature;
DROP FUNCTION IF EXISTS idDernierConcours;
DROP FUNCTION IF EXISTS PhaseDuConcours;
DROP FUNCTION IF EXISTS CandidatureNoteJuryActive;
DROP FUNCTION IF EXISTS CandidatureNoteTotal;
DROP FUNCTION IF EXISTS nbDocument;
DROP FUNCTION IF EXISTS nbImage_cnd;
DROP FUNCTION IF EXISTS nbPreselectionne;
DROP FUNCTION IF EXISTS nbcand_cnc_by_cat;
DROP FUNCTION IF EXISTS nbpre_cnc_by_cat;

DROP PROCEDURE IF EXISTS ActiverActualite;
DROP PROCEDURE IF EXISTS DesactiverActualite;
DROP PROCEDURE IF EXISTS ModifierEtatActualite;
DROP PROCEDURE IF EXISTS ActiverCompte;
DROP PROCEDURE IF EXISTS DesactiverCompte;
DROP PROCEDURE IF EXISTS ModifierEtatCompte;
DROP PROCEDURE IF EXISTS ActualiteCreationConcours;
DROP PROCEDURE IF EXISTS DeleteCompte;
DROP PROCEDURE IF EXISTS AffichagePalmaresUnConcours;
DROP PROCEDURE IF EXISTS AffichagePalmares;
DROP PROCEDURE IF EXISTS AnnulerCandidature;

DROP TRIGGER IF EXISTS DeleteSujet;
DROP TRIGGER IF EXISTS DeleteCandidature;
DROP TRIGGER IF EXISTS InsertAutoAct;
DROP TRIGGER IF EXISTS DeleteConcours;
DROP TRIGGER IF EXISTS DeleteCompte;
DROP TRIGGER IF EXISTS InsertAutoAct_UpdateConcours;