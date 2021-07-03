<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Organisateur extends CI_Controller {
	public function __construct()
	{
		parent::__construct();
		$this->load->model('db_model');
		$this->load->helper('url_helper');
		if($this->session->userdata('statut') != 'organisateur')
		{
			redirect("visiteur/seconnecter");
		}

	}

	public function accueil()
	{
		$data['titre'] = 'Espace Membre de Organisateur :';
		$data['compte'] = $this->db_model->get_org_by_pseudo($_SESSION["pseudo"]);
		
		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('organisateur/page_accueil',$data);
		$this->load->view('templates/bas');
	}

	//afficher details concours
	public function afficher_details_concours($id)
	{
		$data['titre'] = 'Details du concours :';
		$data['concours'] = $this->db_model->get_details_concours_by_id($id);
		
		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('organisateur/concours_details',$data);
		$this->load->view('templates/bas');
	}

	public function informations_compte()
	{
		$data['titre'] = 'Informations personnelles :';
		$data['compte'] = $this->db_model->get_org_by_pseudo($_SESSION["pseudo"]);
		
		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('organisateur/compte_informations',$data);
		$this->load->view('templates/bas');
	}

	public function modif_mdp_compte()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');

		$this->form_validation->set_rules('nom', 'nom', 'required|max_length[45]');
		$this->form_validation->set_rules('prenom', 'prenom', 'required|max_length[45]');
		$this->form_validation->set_rules('mail', 'mail', 'required|valid_email|max_length[45]');
		$this->form_validation->set_rules('mdp', 'mdp', 'required|min_length[5]');
		$this->form_validation->set_rules('mdpconf', 'mdpconf', 'required|matches[mdp]|min_length[5]');

		$data['compte'] = $this->db_model->get_org_by_pseudo($_SESSION["pseudo"]);

		if ($this->form_validation->run() == FALSE)
		{
			$this->load->view('templates/haut');
			$this->load->view('templates/sidebar_prv');
			$this->load->view('templates/navbar_prv');
			$this->load->view('organisateur/compte_modif_mdp',$data);
			$this->load->view('templates/bas');
		}
		else
		{
			if(strcmp($this->input->post('mdp'), $this->input->post('mdpconf')) == 0)
			{
				$this->db_model->update_info_compte($_SESSION["pseudo"]);
				redirect("organisateur/informations_compte");
			}
			else
			{
				$this->load->view('templates/haut');
				$this->load->view('templates/sidebar_prv');
				$this->load->view('templates/navbar_prv');
				$this->load->view('organisateur/compte_modif_mdp',$data);
				$this->load->view('templates/bas');
			}
		}
	}

	public function afficher_concours()
	{
		$data['titre'] = 'Liste des Concours :';
		$data['concours'] = $this->db_model->get_all_concours();
		
		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('organisateur/concours_affichage',$data);
		$this->load->view('templates/bas');
	}
	
	public function lister_comptes()
	{
		$data['titre'] = 'Liste des Comptes :';
		$data['comptes'] = $this->db_model->get_all_comptes();
		
		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('organisateur/comptes_affichage',$data);
		$this->load->view('templates/bas');
	}

	//choix entre creer un jury ou un admin
	public function creation_compte()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');
		$this->form_validation->set_rules('choix', 'choix', 'required');

		if ($this->form_validation->run() == FALSE)
		{
			$this->load->view('templates/haut');
			$this->load->view('templates/sidebar_prv');
			$this->load->view('templates/navbar_prv');
			$this->load->view('organisateur/choix_ajout_compte');
			$this->load->view('templates/bas');
		}
		else
		{
			if($this->input->post("choix") == 'org' )
				redirect("organisateur/creation_compte_org");
			if($this->input->post("choix") == 'jury' )
				redirect("organisateur/creation_compte_jury");
		}

	}

	public function creation_compte_jury()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');

		$this->form_validation->set_rules('pseudo', 'pseudo', 'required|max_length[20]');
		$this->form_validation->set_rules('nom', 'nom', 'required|max_length[45]');
		$this->form_validation->set_rules('etat', 'etat', 'required');
		$this->form_validation->set_rules('prenom', 'prenom', 'required|max_length[45]');
		$this->form_validation->set_rules('mail', 'mail', 'required|valid_email|max_length[45]');
		$this->form_validation->set_rules('password', 'password', 'required|min_length[5]');
		$this->form_validation->set_rules('discipline', 'discipline', 'required|max_length[64]');
		$this->form_validation->set_rules('bio', 'bio', 'required|max_length[256]');
		$this->form_validation->set_rules('site', 'site', 'max_length[256]');

		$data['titre'] = 'Ajouter un compte membre du jury :';

		if ($this->form_validation->run() == FALSE)
		{
			$this->load->view('templates/haut');
			$this->load->view('templates/sidebar_prv');
			$this->load->view('templates/navbar_prv');
			$this->load->view('organisateur/ajout_compte',$data);
			$this->load->view('templates/bas');
		}
		else
		{
			if(!$this->db_model->compte_existe($this->input->post('pseudo')))
			{
				if($this->db_model->insert_compte() != null)
				{
					if($this->db_model->insert_jury() != null)
					{
						$this->session->set_flashdata("success", '<div class="alert alert-success" role="alert">Ajout de compte avec success</div>');
						redirect("organisateur/lister_comptes");
					}
					else
					{
						$this->db_model->delete_compte($this->input->post('pseudo'));
						$this->session->set_flashdata("err",'<div class="alert alert-danger" role="alert">Insertion annulé de membre de jury</div>');
						redirect("organisateur/creation_compte_jury");
					}
				}else{
					$this->session->set_flashdata("err",'<div class="alert alert-danger" role="alert">Les informations du compte ne sont pas correctes</div>');
					redirect("organisateur/creation_compte_jury");
				}
			}else
			{
				$this->session->set_flashdata("err",'<div class="alert alert-danger" role="alert">Le pseudo demandé existe déja</div>');
				redirect("organisateur/creation_compte_jury");
			}
		}
	}

	//creation compte d'admin
	public function creation_compte_org()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');

		$this->form_validation->set_rules('pseudo', 'pseudo', 'required|max_length[20]');
		$this->form_validation->set_rules('nom', 'nom', 'required|max_length[45]');
		$this->form_validation->set_rules('etat', 'etat', 'required');
		$this->form_validation->set_rules('prenom', 'prenom', 'required|max_length[45]');
		$this->form_validation->set_rules('mail', 'mail', 'required|valid_email|max_length[45]');
		$this->form_validation->set_rules('password', 'password', 'required|min_length[5]');

		$data['titre'] = 'Ajouter un compte organisateur :';

		if ($this->form_validation->run() == FALSE)
		{
			$this->load->view('templates/haut');
			$this->load->view('templates/sidebar_prv');
			$this->load->view('templates/navbar_prv');
			$this->load->view('organisateur/ajout_compte',$data);
			$this->load->view('templates/bas');
		}
		else
		{
			if(!$this->db_model->compte_existe($this->input->post('pseudo')))
			{
				if($this->db_model->insert_compte() != null)
				{
					if($this->db_model->insert_org() != null)
					{
						$this->session->set_flashdata("success", '<div class="alert alert-success" role="alert">Ajout de compte avec success</div>');
						redirect("organisateur/lister_comptes");
					}
					else
					{
						$this->db_model->delete_compte($this->input->post('pseudo'));
						$this->session->set_flashdata("err",'<div class="alert alert-danger" role="alert">Insertion annulé de membre de jury</div>');
						redirect("organisateur/creation_compte_org");
					}
				}else{
					$this->session->set_flashdata("err",'<div class="alert alert-danger" role="alert">Les informations du compte ne sont pas correctes</div>');
					redirect("organisateur/creation_compte_org");
				}
			}else
			{
				$this->session->set_flashdata("err",'<div class="alert alert-danger" role="alert">Le pseudo demandé existe déja</div>');
				redirect("organisateur/creation_compte_org");
			}
		}
	}

	//affichage de toutes les candidatures selon son categorie
	public function afficher_toutes_candidatures($id)
	{
		$this->load->helper('form');
		$data['titre'] = 'Toutes les candidatures : ';
		$data['cands'] = $this->db_model->get_all_candidatures($id);
		$data['cats'] = $this->db_model->get_all_cats_by_cnc_id($id);

		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('organisateur/candidatures_affichage',$data);
		$this->load->view('templates/bas');
	}

	public function annuler_candidature()
	{
		$this->load->helper('form');
		if($this->db_model->annuler_cand())
		{
			$id = $this->input->post('cncid');
			$this->session->set_flashdata("success",'<div class="alert alert-success" role="alert">Annulation de candidature avec success.</div>');
			redirect("organisateur/afficher_toutes_candidatures/".$id);
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
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('organisateur/preselection_afficher',$data);
		$this->load->view('templates/bas');
	}


} ?>