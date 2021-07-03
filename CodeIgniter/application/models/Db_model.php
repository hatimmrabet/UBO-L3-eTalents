<?php
class Db_model extends CI_Model {
	public function __construct()
	{
		$this->load->database();
	}

	public function get_all_compte()
	{
		$query = $this->db->query("SELECT cpt_pseudo FROM t_compte_cpt;");
		return $query->result_array();
	}

	public function get_actualite($numero)
	{
		$query = $this->db->query("SELECT act_id, act_text FROM t_actualite_act WHERE
		act_id=".$numero.";");
		return $query->row();
	}

	public function get_all_actualite()
	{
		$query = $this->db->query("SELECT * 
			FROM t_actualite_act 
			join t_concours_cnc using(cnc_id)
			where act_etat = 'A'
			ORDER BY act_date desc, act_id desc
			limit 5;");
		return $query->result_array();
	}

	public function get_nombre_comptes()
	{
		$query = $this->db->query("SELECT count(*) as nbr FROM t_compte_cpt;");
		return $query->row();
	}

	public function get_all_concours()
	{
		$query = $this->db->query("SELECT DISTINCT cnc_id,cnc_nom,cnc_dateDebut,PhaseDuConcours(cnc_id) as phase,t_concours_cnc.cpt_pseudo as org, cat_id, cat_nom, t_membre_jury.cpt_pseudo as jury, cpt_nom, cpt_prenom, jury_discipline, nbCandidature(cnc_id) as nbCnd
			from t_concours_cnc
			left join tj_concours_categorie using(cnc_id)
			left join t_categorie_cat using(cat_id)
			left join tj_concours_jury USING(cnc_id)
			left join t_membre_jury on tj_concours_jury.cpt_pseudo = t_membre_jury.cpt_pseudo 
			left join t_compte_cpt on t_compte_cpt.cpt_pseudo = t_membre_jury.cpt_pseudo
			order by cnc_dateDebut desc;");
		return $query->result_array();
	}

		public function get_all_concours_jury()
	{
		$query = $this->db->query("SELECT DISTINCT cnc_id,cnc_nom,cnc_dateDebut,PhaseDuConcours(cnc_id) as phase,t_concours_cnc.cpt_pseudo as org, cat_id, cat_nom, t_membre_jury.cpt_pseudo as jury, cpt_nom, cpt_prenom, jury_discipline, nbCandidature(cnc_id) as nbCnd, nbPreselectionne(cnc_id) as nbPre
			from t_concours_cnc
			left join tj_concours_categorie using(cnc_id)
			left join t_categorie_cat using(cat_id)
			left join tj_concours_jury USING(cnc_id)
			left join t_membre_jury on tj_concours_jury.cpt_pseudo = t_membre_jury.cpt_pseudo 
			left join t_compte_cpt on t_compte_cpt.cpt_pseudo = t_membre_jury.cpt_pseudo
			where cnc_id in (	SELECT cnc_id
								from tj_concours_jury
								where cpt_pseudo = '".$_SESSION["pseudo"]."')
			order by cnc_dateDebut desc;");
		return $query->result_array();
	}

	public function get_details_concours_by_id($id)
	{
		$query = $this->db->query("SELECT *,PhaseDuConcours(cnc_id) as phase,t_concours_cnc.cpt_pseudo as org, t_membre_jury.cpt_pseudo as jury, adddate(cnc_dateDebut, cnc_dureeCandidature) as preselection, adddate(cnc_dateDebut, cnc_dureeCandidature+cnc_dureePreselection) as eval, adddate(cnc_dateDebut, cnc_dureeCandidature+cnc_dureePreselection+cnc_dureeEvaluation) as fin
			from t_concours_cnc
			left join tj_concours_categorie using(cnc_id)
			left join t_categorie_cat using(cat_id)
			left join tj_concours_jury USING(cnc_id)
			left join t_membre_jury on tj_concours_jury.cpt_pseudo = t_membre_jury.cpt_pseudo 
			left join t_compte_cpt on t_compte_cpt.cpt_pseudo = t_membre_jury.cpt_pseudo
			where cnc_id = '".$id."';");
		return $query->result_array();
	}	

	public function get_concours_info($id)
	{
		$query = $this->db->query("	SELECT *, nbCandidature(cnc_id) as nbCnd, nbPreselectionne(cnc_id) as nbPre
									from t_concours_cnc
									where cnc_id = ".$id.";");
		return $query->row_array();
	}

	//toutes les candidatures d'un concours
	public function get_all_candidatures($id)
	{
		$query = $this->db->query("	SELECT * 
									from t_candidature_cnd
									left join t_document_doc using(cnd_id)
									where cnc_id = ".$id." 
									order by cnd_dateCandidature;");
		return $query->result_array();
	}

	public function get_all_preselection($id)
	{
		$query = $this->db->query("	SELECT *, nbPreselectionne(cnc_id) as nbpre, nbImage_cnd(cnd_id) as nbImg
									from t_candidature_cnd
									left join t_document_doc using(cnd_id)
									where cnc_id = ".$id."
									and cnd_etat = 'P'
									order by cnd_dateCandidature;");
		return $query->result_array();
	}

	public function get_all_images_cnc($id)
	{
		$query = $this->db->query("	SELECT *
									from t_document_doc
									where doc_url like '%.jpg'
									or doc_url like '%.png';");
		return $query->result_array();
	}

	public function get_all_cats_by_cnc_id($id)
	{
		$query = $this->db->query("	SELECT *,nbcand_cnc_by_cat(cnc_id, cat_id) as nbcand_cat, nbpre_cnc_by_cat(cnc_id, cat_id) as nbpre_cat
									from t_categorie_cat
									join tj_concours_categorie using(cat_id)
									where cnc_id = ".$id."
									ORDER BY nbcand_cat desc,cat_id ;");
		return $query->result_array();
	}	

	public function get_all_jury_concours()
	{
		$query = $this->db->query("	SELECT * 
									FROM t_compte_cpt
									join t_membre_jury using(cpt_pseudo) 
									join tj_concours_jury using(cpt_pseudo);");
		return $query->result_array();
	}

	public function get_all_categories_concours()
	{
		$query = $this->db->query("	SELECT * 
									from t_categorie_cat 
									join tj_concours_categorie using(cat_id) ;");
		return $query->result_array();
	}

	public function set_compte()
	{
		$this->load->helper('url');

		$id = $this->input->post('id');
		$mdp = $this->input->post('mdp');
		
		$req = "INSERT INTO t_compte_cpt VALUES ('".$id."','".$mdp."','nom','prenom','mail','D');";
		$query = $this->db->query($req);
		return ($query);
	}

	public function get_candidature_by_codes()
	{
		$this->load->helper('url');

		$dossier = htmlspecialchars(addslashes($this->input->post('numDossier')));
		$cand = htmlspecialchars(addslashes($this->input->post('numCand')));

		$query = $this->db->query("	SELECT *, nbDocument(cnd_id) as nb_doc
									from t_candidature_cnd
									join t_concours_cnc using(cnc_id)
									join t_categorie_cat using(cat_id)
									where cnd_numDossier = '".$dossier."'
									and cnd_numCandidat = '".$cand."';");
		return $query->row();
	}

	//les documents d'un candidat
	public function get_all_documents_by_cnd_id($id)
	{
		$query = $this->db->query("	SELECT *
									from t_document_doc
									where cnd_id = ".$id.";");
		return $query->result_array();
	}

	public function connect_compte($pseudo, $mdp)
	{
		$mdp = $this->get_hashed_code($mdp);
		$query = $this->db->query(" SELECT cpt_pseudo, cpt_etat
									from t_compte_cpt
									where cpt_pseudo = '".$pseudo."'
									and cpt_mdp = '".$mdp."';");
		if ($query->num_rows()>0) {
			return true;
		}else
		{
			return false;
		}
	}

	public function donnees_session_compte($pseudo)
	{
		$query = $this->db->query(" SELECT cpt_pseudo, cpt_etat as etat, StatutCompte(cpt_pseudo) as statut
									from DonneesDuCompte
									where cpt_pseudo = '".$pseudo."';");
		return $query->row();
	}

	public function get_jury_by_pseudo($pseudo)
	{
		$query = $this->db->query(" SELECT *, StatutCompte(cpt_pseudo) as statut
							from DonneesDuCompte
							join t_membre_jury using(cpt_pseudo)
							where cpt_pseudo = '".$pseudo."';");
		return $query->row();
	}

	public function get_org_by_pseudo($pseudo)
	{
		$query = $this->db->query(" SELECT *, StatutCompte(cpt_pseudo) as statut
							from DonneesDuCompte
							join t_organisateur_org using(cpt_pseudo)
							where cpt_pseudo = '".$pseudo."';");
		return $query->row();
	}

	public function get_hashed_code($code)
	{
		$salt1 = "NUNCAteDEJAREMOSsola";
		$salt2 = "MESqueUNCLUB";
		$password = hash('sha256', $salt1.$code.$salt2);
		return $password;
	}

	//maj des infos d'org
	public function update_info_compte($pseudo)
	{
		$nom = htmlspecialchars(addslashes(trim($this->input->post('nom'))));
		$prenom = htmlspecialchars(addslashes(trim($this->input->post('prenom'))));
		$mail = htmlspecialchars(addslashes(trim($this->input->post('mail'))));
		$mdp = $this->get_hashed_code(htmlspecialchars(addslashes($this->input->post('mdp'))));
		$query = $this->db->query(" UPDATE t_compte_cpt
									SET cpt_nom = '".$nom."',
									cpt_prenom = '".$prenom."',
									cpt_mail = '".$mail."',
									cpt_mdp = '".$mdp."'
									WHERE cpt_pseudo = '".$pseudo."';");
		return $query;
	}

	// maj des info jury
	public function update_info_jury($pseudo)
	{
		$bio = htmlspecialchars(addslashes(trim($this->input->post('bio'))));
		$site = htmlspecialchars(addslashes(trim($this->input->post('site'))));
		$discipline = htmlspecialchars(addslashes(trim($this->input->post('discipline'))));
		if($site =="")
		{
			$query = $this->db->query(" UPDATE t_membre_jury
									SET jury_biographie = '".$bio."',
									jury_discipline = '".$discipline."' ,
									jury_url = null
									WHERE cpt_pseudo = '".$pseudo."';");
		}else
		{
		$query = $this->db->query(" UPDATE t_membre_jury
									SET jury_biographie = '".$bio."',
									jury_discipline = '".$discipline."' ,
									jury_url = '".$site."'
									WHERE cpt_pseudo = '".$pseudo."';");
		}
		return $query;
	}

	//les donnees de tous les comptes et leurs status
	public function get_all_comptes()
	{
		$query = $this->db->query("	SELECT t_compte_cpt.cpt_pseudo,cpt_nom,cpt_prenom,cpt_mail,cpt_etat, StatutCompte(t_compte_cpt.cpt_pseudo) as statut
									FROM t_compte_cpt
									left join t_organisateur_org on t_organisateur_org.cpt_pseudo = t_compte_cpt.cpt_pseudo
									left join t_membre_jury on t_membre_jury.cpt_pseudo = t_compte_cpt.cpt_pseudo 
									ORDER by statut desc;");
		return $query->result_array();
	}
	
	//verification de l'existance d'un pseudo
	public function compte_existe($pseudo)
	{
		$pseudo = htmlspecialchars(addslashes(trim($pseudo)));
		$query = $this->db->query("	SELECT * from t_compte_cpt where cpt_pseudo = '".$pseudo."';");
		if($query->num_rows()>0)
			return true;
		else
			return false;
	}

	//insertion compte
	public function insert_compte()
	{
		$pseudo = htmlspecialchars(addslashes(trim($this->input->post('pseudo'))));
		$nom = htmlspecialchars(addslashes(trim($this->input->post('nom'))));
		$prenom = htmlspecialchars(addslashes(trim($this->input->post('prenom'))));
		$mail = htmlspecialchars(addslashes(trim($this->input->post('mail'))));
		$mdp = $this->get_hashed_code(htmlspecialchars(addslashes($this->input->post('password'))));
		$etat = htmlspecialchars(addslashes($this->input->post('etat')));

		$query = $this->db->query("	INSERT into t_compte_cpt
									VALUES ('".$pseudo."','".$mdp."','".$nom."','".$prenom."','".$mail."','".$etat."') ;");
		return $query;
	}

	//insertion jury
	public function insert_jury()
	{
		$pseudo = htmlspecialchars(addslashes(trim($this->input->post('pseudo'))));
		$bio = htmlspecialchars(addslashes(trim($this->input->post('bio'))));
		$site = htmlspecialchars(addslashes(trim($this->input->post('site'))));
		$discipline = htmlspecialchars(addslashes(trim($this->input->post('discipline'))));
		if($site == ""){
			$query = $this->db->query("	INSERT into t_membre_jury
									VALUES ('".$pseudo."','".$bio."','".$discipline."',null) ;");
		}else
		{
			$query = $this->db->query("	INSERT into t_membre_jury
									VALUES ('".$pseudo."','".$bio."','".$discipline."','".$site."') ;");
		}
		return $query;
	}

	//insertion organisateur
	public function insert_org()
	{
		$pseudo = htmlspecialchars(addslashes(trim($this->input->post('pseudo'))));
		$query = $this->db->query("	INSERT into t_organisateur_org VALUES ('".$pseudo."') ;");
		return $query;
	}

	//suppression d'un compte
	public function delete_compte($pseudo)
	{
		$pseudo = htmlspecialchars(addslashes(trim($pseudo)));
		$query = $this->db->query("	DELETE FROM t_compte_cpt where cpt_pseudo = '".$pseudo."') ;");
		return $query;
	}

	//suppression d'une candidature
	public function delete_candidature($id)
	{
		// un trigger supprime automatiquement les documents de cette candidature
		$query = $this->db->query("DELETE FROM t_candidature_cnd where cnd_id = ".$id.";");
		return $query;
	}

	//existance d'un numero de dossier
	public function candature_existe($ndd, $ndc)
	{
		$query = $this->db->query("	SELECT * 
									from t_candidature_cnd 
									where cnd_numDossier = '".$ndd."'
									and cnd_numCandidat ='".$ndc."'	;");
		if($query->num_rows()>0)
			return true;
		else
			return false;
	}

	//ajout d'une canidature
	public function ajout_candidature($idcnc, $ndd, $ndc)
	{
		$this->load->helper('date');
		$nom = htmlspecialchars(addslashes(trim($this->input->post('nom'))));
		$prenom = htmlspecialchars(addslashes(trim($this->input->post('prenom'))));
		$mail = htmlspecialchars(addslashes(trim($this->input->post('mail'))));
		$bio = htmlspecialchars(addslashes(trim($this->input->post('bio'))));
		$cat = htmlspecialchars(addslashes(trim($this->input->post('categorie'))));

		$query = $this->db->query("	
			INSERT INTO t_candidature_cnd
			VALUES (null,'".$ndd."','".$ndc."','".$mail."','".$nom."','".$prenom."','".$bio."','".date('Y-m-d')."','T','".$idcnc."','".$cat."');");
		return $query;
	}

	//information d'un candidature apartir de ses codes
	public function get_candidature($ndd, $ndc)
	{
		$ndd = htmlspecialchars(addslashes($ndd));
		$ndc = htmlspecialchars(addslashes($ndc));
		$query = $this->db->query("	SELECT *,nbDocument(cnd_id) as nb_doc
									from t_candidature_cnd
									where cnd_numDossier = '".$ndd."'
									and cnd_numCandidat = '".$ndc."';");
		return $query->row();
	}

	//ajout des documents a la base
	public function ajout_document($data, $id)
	{
		$titre = htmlspecialchars(addslashes(trim($this->input->post('file_titre'))));
		$url = $data["file_name"];
		$query = $this->db->query("
						INSERT INTO t_document_doc
						VALUES (null,'".$titre."','".$url."','".$id."') ;");
		return $query;
	}

	public function annuler_cand()
	{
		$id = $this->input->post('cndid');
		$query = $this->db->query("CALL AnnulerCandidature(".$id.");");
		return $query;
	}
}
?>