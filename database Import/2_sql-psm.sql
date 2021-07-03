--
-- DROP VIEWS/FUNCTION/PROCEDURES 
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


--
-- CREAT VIEW/FUNCTION/PROCEDURES 
--
DELIMITER //
CREATE PROCEDURE ActiverCompte(in id VARCHAR(20))
BEGIN
	update t_compte_cpt set cpt_etat = 'A' where cpt_pseudo = id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActiverActualite(in id INT)
BEGIN
	update t_actualite_act set act_etat = 'A' where act_id = id;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION CandidatureNoteJuryActive(id INT) RETURNS int(11)
BEGIN
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
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AffichagePalmaresUnConcours(in id INT)
BEGIN
    set @rang:=0;
    select DISTINCT @rang:=@rang+1 rang, cnd_nom, cnd_prenom
    from PalmaresConcours
    where cnc_id = id
    and PhaseDuConcours(cnc_id) = 'Terminé'
    limit 3;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeleteCompte(in pseudo varchar(20))
BEGIN
	DELETE from t_compte_cpt
	where cpt_pseudo = pseudo
	and cpt_pseudo != 'organisateur';
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION CandidatureNoteTotal(id INT) RETURNS int(11)
BEGIN
    DECLARE NoteTotal INT;
    SELECT sum(note) into NoteTotal
    from tj_candidature_note
    where cnd_id = id;
	if NoteTotal is null then RETURN 0;
    else return NoteTotal;
	end if;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AnnulerCandidature(IN id INT)
BEGIN
	update t_candidature_cnd set cnd_etat = 'A' where cnd_id = id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DesactiverActualite(in id INT)
BEGIN
	update t_actualite_act set act_etat = 'D' where act_id = id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualiteCreationConcours()
BEGIN
	declare id int;
	declare textAct Text;
	declare pseudo VARCHAR(20);
	select idDernierConcours() into id;
	select cpt_pseudo, CONCAT('NOUVEAU CONCOURS : ', cnc_nom,' | Date de début : ',cnc_dateDebut,' | ',cnc_textIntro) into pseudo, textAct 
	from t_concours_cnc 
	where cnc_id = id;
	insert into t_actualite_act values(null,textAct,sysdate(),'A', pseudo, id);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ModifierEtatCompte(in id VARCHAR(20))
BEGIN
	set @etat = (SELECT cpt_etat from t_compte_cpt where cpt_pseudo = id);
	if @etat = 'A' then
		call DesactiverCompte(id);
	else
		call ActiverCompte(id); 
	end if;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ModifierEtatActualite(in id INT)
BEGIN
	set @etat = (SELECT act_etat from t_actualite_act where act_id = id);
	if @etat = 'A' then
		call DesactiverActualite(id);
	else
		call ActiverActualite(id); 
	end if;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION PhaseDuConcours(id INT) RETURNS text CHARSET utf8
BEGIN
	set @dateCnc = (SELECT cnc_dateDebut	from t_concours_cnc where cnc_id = id) ;
	set @nbCandidature = (SELECT cnc_dureeCandidature	from t_concours_cnc where cnc_id = id) ;
	set @nbPreselec = (SELECT cnc_dureePreselection	from t_concours_cnc where cnc_id = id) ;
	set @nbEval = (SELECT cnc_dureeEvaluation	from t_concours_cnc where cnc_id = id) ;

	if sysdate() >= adddate(@dateCnc,@nbCandidature+@nbPreselec+@nbEval) then return 'Terminé';
	elseif sysdate() >= adddate(@dateCnc,@nbCandidature+@nbPreselec) then return 'Evaluation';
	elseif sysdate() >= adddate(@dateCnc,@nbCandidature) then RETURN 'Préselection';
	elseif sysdate() >= @dateCnc then return 'Candidature';
	else return 'à Venir';
	end if;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DesactiverCompte(in id VARCHAR(20))
BEGIN
	update t_compte_cpt set cpt_etat = 'D' where cpt_pseudo = id;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION nbCandidature(id INT) RETURNS int(11)
BEGIN
	set @nbr = (SELECT count(*) from t_candidature_cnd where cnc_id = id);
	RETURN @nbr;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION nbImage_cnd(id INT) RETURNS int(11)
BEGIN
	set @nbr = (SELECT count(*)
				from t_document_doc
				where (doc_url like '%.jpg'
				or doc_url like '%.png')
                AND cnd_id = id);
	RETURN @nbr;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION idDernierConcours() RETURNS int(11)
BEGIN
	RETURN (SELECT max(cnc_id) from t_concours_cnc);
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION nbPreselectionne(id INT) RETURNS int(11)
BEGIN
	set @nbr = (SELECT count(*) from t_candidature_cnd where cnd_etat = 'P' and cnc_id = id);
	RETURN @nbr;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION StatutCompte(id VARCHAR(20)) RETURNS text CHARSET utf8
BEGIN
	set @existe = (SELECT count(*) from t_organisateur_org where cpt_pseudo = id);
	IF @existe = 1 then
		RETURN 'organisateur';
	END IF;
	set @existe = (SELECT count(*) from t_membre_jury where cpt_pseudo = id);
	IF @existe = 1 then
		RETURN 'jury';
	END IF;
	RETURN NULL;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION nbDocument(id INT) RETURNS int(11)
BEGIN
	set @nbr = (SELECT count(*) from t_document_doc where cnd_id = id);
	RETURN @nbr;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION nbpre_cnc_by_cat(cncid INT, catid INT) RETURNS int(11)
BEGIN
	set @nbr = (SELECT count(*) 
                from t_candidature_cnd 
                where cnc_id = cncid
               and cat_id = catid
               and cnd_etat = 'P');
	RETURN @nbr;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION nbcand_cnc_by_cat(cncid INT, catid INT) RETURNS int(11)
BEGIN
	set @nbr = (SELECT count(cnd_id) 
                from t_candidature_cnd 
                where cnc_id = cncid
               and cat_id = catid);
	RETURN @nbr;
END//
DELIMITER ;

--
-- VUES
--

CREATE VIEW DonneesDuCompte AS 
SELECT cpt_pseudo, cpt_nom, cpt_prenom, cpt_mail, cpt_etat 
FROM t_compte_cpt;

CREATE VIEW CategoriesDuConcours AS 
SELECT *
FROM t_concours_cnc
join tj_concours_categorie using(cnc_id)
join t_categorie_cat using(cat_id);

CREATE VIEW MessagesDuSujet AS 
SELECT *
FROM t_sujet_sjt
join t_message_msg using(sjt_id);

CREATE VIEW PalmaresConcours AS 
select DISTINCT cnc_id, cnd_nom, cnd_prenom, CandidatureNoteJuryActive(cnd_id) as note
from t_candidature_cnd
left join tj_candidature_note using(cnd_id)
ORDER BY CandidatureNoteJuryActive(cnd_id) DESC;
