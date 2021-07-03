<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Visiteur extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('db_model');
		$this->load->helper('url_helper');
	}

	//Affichage des actualites dans la page accueil
	public function afficher_actualites()
	{
		$data['titre'] = 'Actualités :';
		$data['actu'] = $this->db_model->get_all_actualite();

		$this->load->view('templates/haut');
		$this->load->view('templates/navbar_visiteur');
		$this->load->view('visiteur/accueil',$data);
		$this->load->view('templates/bas');
	}

	//afficher tous les concours
	public function afficher_concours()
	{
		$data['titre'] = 'Liste des Concours :';
		$data['concours'] = $this->db_model->get_all_concours();
		
		$this->load->view('templates/haut');
		$this->load->view('templates/navbar_visiteur');
		$this->load->view('visiteur/concours_liste',$data);
		$this->load->view('templates/bas');
	}

	//afficher details concours
	public function afficher_details_concours($id)
	{
		$data['titre'] = 'Details du concours :';
		$data['concours'] = $this->db_model->get_details_concours_by_id($id);
		
		$this->load->view('templates/haut');
		$this->load->view('templates/navbar_visiteur');
		$this->load->view('visiteur/concours_details',$data);
		$this->load->view('templates/bas');
	}

	//formulaire à remplir pour suivre une candidature
	public function suivre_candidature()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');

		$this->form_validation->set_rules('numDossier', 'Numero de dossier', 'required|exact_length[20]',
						array('required' =>'le champ "{field}" est obligatoire.' ,
							'exact_length' => '{field} doit contenir  {param} caractéres.')
						);

		$this->form_validation->set_rules('numCand', 'Numero de candidature', 'required|exact_length[8]',
						array('required' =>'le champ "{field}" est obligatoire.' ,
							'exact_length' => '{field} doit contenir {param} caractéres.')
						);
		
		if ($this->form_validation->run() == FALSE)
		{
			$this->load->view('templates/haut');
			$this->load->view('templates/navbar_visiteur');
			$this->load->view('visiteur/candidature_suivi');
			$this->load->view('templates/bas');
		}
		else
		{
			$data["cand"] = $this->db_model->get_candidature_by_codes();

			if(!empty($data["cand"]))
			{
				$data["titre"] = "Récapitulatif de votre Candidature : ";
				$data["docs"] = $this->db_model->get_all_documents_by_cnd_id($data["cand"]->cnd_id);

				$this->load->view('templates/haut');
				$this->load->view('templates/navbar_visiteur');
				$this->load->view('visiteur/candidature_details',$data);
				$this->load->view('templates/bas');
			}
			else
			{
				$this->session->set_flashdata("err",'<div class="alert alert-danger mb-3" style="text-align: center;" role="alert">
									Le <b>Numero de dossier</b> et celui de <b>candidature</b> ne correspondent à aucune candidature</div>');
                redirect("visiteur/suivre_candidature");
			}
		}
	}

	public function supprimer_candidature()
	{
		$this->load->helper('form');
		$this->load->helper('file');
		$this->load->library('form_validation');

		$this->form_validation->set_rules('numDossiercnf', 'Votre numero de dossier', 'required');
		$this->form_validation->set_rules('numCandidatcnf', 'Votre numero de candidat', 'required');
		$this->form_validation->set_rules('numDossier', 'Numero de dossier', 'required|exact_length[20]|matches[numDossiercnf]',
						array('required' =>'le champ "{field}" est obligatoire.' ,
							'exact_length' => '{field} doit contenir  {param} caractéres.'));
		$this->form_validation->set_rules('numCand', 'Numero de candidature', 'required|exact_length[8]|matches[numCandidatcnf]',
						array('required' =>'le champ "{field}" est obligatoire.' ,
							'exact_length' => '{field} doit contenir {param} caractéres.'));

		$data["cand"] = $this->db_model->get_candidature_by_codes();

		if ($this->form_validation->run())
		{
			if(!empty($data["cand"]))
			{
				$files = $this->db_model->get_all_documents_by_cnd_id($data["cand"]->cnd_id);
				foreach ($files as $file) {
					$path = '/var/www/html/licence/lic113/V2/CodeIgniter/style/docs/'.$file["doc_url"];
					unlink($path);
				}
				$this->db_model->delete_candidature($data["cand"]->cnd_id);
				$this->session->set_flashdata("success",'<div class="alert alert-success mb-3" style="text-align: center;" role="alert">
									Suppression de votre candidature avec success</div>');
			}
		}
		else
		{
			$this->session->set_flashdata("err",'<div class="alert alert-danger mb-3" style="text-align: center;" role="alert">
									<b>Suppression annulée</b> : Le <b>Numero de dossier</b> et celui de <b>candidature</b> ne correspondent à votre candidature</div>');
		}
		redirect("visiteur/suivre_candidature");
	}

	//lister les pseudo (non utilisé au site)
	public function lister()
	{
		$data['titre'] = 'Liste des pseudos :';
		$data['pseudos'] = $this->db_model->get_all_compte();
		$data['nb_compte'] = $this->db_model->get_nombre_comptes();
		
		$this->load->view('templates/haut');
		$this->load->view('visiteur/compte_liste',$data);
		$this->load->view('templates/bas');
	}

	//creer les comptes (non utilisé au site et ne fonctionne pas)
	public function creer()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');

		$this->form_validation->set_rules('id', 'id', 'required');
		$this->form_validation->set_rules('mdp', 'mdp', 'required');

		if ($this->form_validation->run() == FALSE)
		{
			$this->load->view('templates/haut');
			$this->load->view('templates/navbar_visiteur');
			$this->load->view('visiteur/compte_creer');
			$this->load->view('templates/bas');
		}
		else
		{
			$this->db_model->set_compte();
			$this->load->view('templates/haut');
			$this->load->view('templates/navbar_visiteur');
			$this->load->view('visiteur/compte_succes');
			$this->load->view('templates/bas');
		}
	}

	// se connecter au session privée
	public function seconnecter()
	{
		if(!isset($_SESSION["pseudo"]))
		{
			$this->load->helper('form');
			$this->load->library('form_validation');
			$this->form_validation->set_rules('pseudo', 'pseudo', 'required');
			$this->form_validation->set_rules('mdp', 'mdp', 'required');
			if ($this->form_validation->run() == FALSE)
			{
				$this->load->view('templates/haut');
				$this->load->view('templates/navbar_visiteur');
				$this->load->view('visiteur/compte_connecter');
				$this->load->view('templates/bas');
			}
			else
			{
				$pseudo = htmlspecialchars(addslashes(trim($this->input->post('pseudo'))));
				$password = $this->input->post('mdp');
				if($this->db_model->connect_compte($pseudo,$password))
				{
					$data = $this->db_model->donnees_session_compte($pseudo);
					if($data->etat == 'A')
					{
						$session_data = array(	'pseudo' => $pseudo,
												'statut' => $data->statut );

						$this->session->set_userdata($session_data);

						if($data->statut == 'organisateur')
							redirect("organisateur/accueil");
						else if($data->statut == 'jury')
							redirect("jury/accueil");
					}
					else
					{
						$this->session->set_flashdata("err",'<div class="alert alert-danger" role="alert">Votre compte est désactivé</div>');
					}
				}
				else
				{
				$this->session->set_flashdata("err",'<div class="alert alert-danger" role="alert">Votre pseudo ou votre mot de passe est incorrect </div>');
				}
				$this->load->view('templates/haut');
				$this->load->view('templates/navbar_visiteur');
				$this->load->view('visiteur/compte_connecter');
				$this->load->view('templates/bas');
			}
		}else // if(isset($_SESSION["peudo"]))
		{
			if($_SESSION["statut"] == "jury" )
			{
				redirect("jury/accueil");
			}
			if($_SESSION["statut"] == "organisateur" )
			{
				redirect("organisateur/accueil");
			}
		}
	}

	//se deconnecter du session privée
	public function sedeconnecter()
	{
		unset( $_SESSION["pseudo"], $_SESSION["statut"] );
		$this->session->sess_destroy();
		redirect("visiteur/seconnecter");
	}

	//generer un numero de dossier
	public function generer_numeroDossier()
	{
		$this->load->helper('string');
		$string = 'NDD'.strtoupper(random_string('numeric', 17));
		return $string;
	}

	//generer numero de candidat
	public function generer_numeroCandidat()
	{
		$this->load->helper('string');
		$string = 'NDC'.strtoupper(random_string('numeric', 5));
		return $string;
	}

	public function upload_file($ndd, $ndc)
	{
		$this->load->helper('file');
		$this->load->helper('form');
		$this->load->library('form_validation');

		$this->form_validation->set_rules('file_titre', 'titre fichier', 'required');
		if (empty($_FILES['fichier']['name']))
		{
		    $this->form_validation->set_rules('fichier', 'Document', 'required');
		}
		$config['upload_path']          = './style/docs/';
		$config['file_name']			= $ndd.$ndc;
		$config['allowed_types']        = 'gif|jpg|png|pdf|jpeg';
        $config['max_size']             = 1000000;
        $config['max_width']            = 0;
        $config['max_height']           = 0;
        $config['remove_spaces']		= true;

        $this->load->library('upload', $config);
		$this->upload->initialize($config);


    	$data["titre"] = "Ajout d'un document à votre candidature : ";
    	$data["cand"] = $this->db_model->get_candidature($ndd, $ndc);
		$data["docs"] = $this->db_model->get_all_documents_by_cnd_id($data["cand"]->cnd_id);

        if($this->form_validation->run() == false)
		{
	        $this->load->view('templates/haut');
			$this->load->view('templates/navbar_visiteur');
			$this->load->view('visiteur/ajout_document',$data);
			$this->load->view('templates/bas');
	    }
	    else
	    {
	    	if(!$this->upload->do_upload('fichier'))
	        {
	            $this->session->set_flashdata("err",'<div class="alert alert-danger mb-3" style="text-align: center;" role="alert">
									Ajout de document annulé : '.$this->upload->display_errors().'</div>');
	        }
	        else
	        {
	        	$this->db_model->ajout_document($this->upload->data(), $data["cand"]->cnd_id);
	        	$this->session->set_flashdata("success",'<div class="alert alert-success mb-3" style="text-align: center;" role="alert">
									Document ajouté avec success.</div>');
	        }
	       	redirect('visiteur/upload_file/'.$data["cand"]->cnd_numDossier.'/'.$data["cand"]->cnd_numCandidat);
	    }
	}

	// la candidature pour un concours
	public function inscription($id)
	{
		$this->load->helper('form');
		$this->load->library('form_validation');
		
		$this->form_validation->set_rules('nom', 'nom', 'required|trim|max_length[45]');
		$this->form_validation->set_rules('prenom', 'prenom', 'required|trim|max_length[45]');
		$this->form_validation->set_rules('mail', 'mail', 'required|trim|valid_email|max_length[45]');
		$this->form_validation->set_rules('bio', 'bio', 'required|trim|max_length[256]');
		$this->form_validation->set_rules('categorie', 'categorie', 'required');
		//$this->form_validation->set_rules('fichier', 'fichier', 'required');

		if($this->form_validation->run() == false)
		{
			$data["titre"] = "Formulaire de candidature :";
			$data["id"] = $id;
			$data["cats"] = $this->db_model->get_all_cats_by_cnc_id($id);

			$this->load->view('templates/haut');
			$this->load->view('templates/navbar_visiteur');
			$this->load->view('visiteur/formulaire_candidature',$data);
			$this->load->view('templates/bas');
		}
		else
		{
			$ndd = $this->generer_numeroDossier();
			$ndc = $this->generer_numeroCandidat();
			while ($this->db_model->candature_existe($ndd,$ndc)) {
				$ndd = $this->generer_numeroDossier();
				$ndc = $this->generer_numeroCandidat();
			}

			if($this->db_model->ajout_candidature($id,$ndd,$ndc))
			{
				//$this->upload_file($ndd,$ndc);
				$this->session->set_flashdata("success",'<div class="alert alert-success mb-3" style="text-align: center;" role="alert">
									Votre Candidature est faite avec success.</div>');
				$data["ndd"] = $ndd;
				$data["ndc"] = $ndc;
				$data["titre"] = "Utilisez ces codes pour suivre votre candidature :";
                $this->load->view('templates/haut');
				$this->load->view('templates/navbar_visiteur');
				$this->load->view('visiteur/success_candidature',$data);
				$this->load->view('templates/bas');
			}
			else
			{
				$this->session->set_flashdata("err",'<div class="alert alert-danger mb-3 mx-auto w-50" style="text-align: center;" role="alert">
									Ce mail est déja utilisé</div>');
                redirect("visiteur/inscription/".$id);
			}
		}
	}

	public function afficher_preselection($id)
	{
		$data['titre'] = 'Liste des Candidatures Préselctionnées :';
		$data['info'] =  $this->db_model->get_concours_info($id);
		$data['cands'] = $this->db_model->get_all_preselection($id);
		$data['cats'] = $this->db_model->get_all_cats_by_cnc_id($id);
		$data['imgs'] = $this->db_model->get_all_images_cnc($id);

        $this->load->view('templates/haut');
		$this->load->view('templates/navbar_visiteur');
		$this->load->view('visiteur/preselection_afficher',$data);
		$this->load->view('templates/bas');
	}


}
?>