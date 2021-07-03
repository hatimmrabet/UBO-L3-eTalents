<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Jury extends CI_Controller {
	public function __construct()
	{
		parent::__construct();
		$this->load->model('db_model');
		$this->load->helper('url_helper');
		if($this->session->userdata('statut') != 'jury')
		{
			redirect("visiteur/seconnecter");
		}

	}

	public function accueil()
	{
		$data['titre'] = 'Espace Membre de Jury :';
		$data['compte'] = $this->db_model->get_jury_by_pseudo($_SESSION["pseudo"]);
		
		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('jury/page_accueil',$data);
		$this->load->view('templates/bas');
	}

	public function informations_compte()
	{
		$data['titre'] = 'Informations personnelles :';
		$data['compte'] = $this->db_model->get_jury_by_pseudo($_SESSION["pseudo"]);
		
		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('jury/compte_informations',$data);
		$this->load->view('templates/bas');
	}

	public function modif_mdp_compte()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');

		$this->form_validation->set_rules('nom', 'nom', 'required|max_length[45]');
		$this->form_validation->set_rules('prenom', 'prenom', 'required|max_length[45]');
		$this->form_validation->set_rules('mail', 'mail', 'required|valid_email|max_length[45]');
		$this->form_validation->set_rules('discipline', 'discipline', 'required|max_length[64]');
		$this->form_validation->set_rules('bio', 'bio', 'required|max_length[256]');
		$this->form_validation->set_rules('site', 'site', 'valid_url|max_length[256]');
		$this->form_validation->set_rules('mdp', 'mdp', 'required|min_length[5]');
		$this->form_validation->set_rules('mdpconf', 'mdpconf', 'required|matches[mdp]|min_length[5]');

		$data['compte'] = $this->db_model->get_jury_by_pseudo($_SESSION["pseudo"]);

		if ($this->form_validation->run() == FALSE)
		{
			$this->load->view('templates/haut');
			$this->load->view('templates/sidebar_prv');
			$this->load->view('templates/navbar_prv');
			$this->load->view('jury/compte_modif_mdp',$data);
			$this->load->view('templates/bas');
		}
		else
		{
			if(strcmp($this->input->post('mdp'), $this->input->post('mdpconf')) == 0)
			{
				$this->db_model->update_info_compte($_SESSION["pseudo"]);
				$this->db_model->update_info_jury($_SESSION["pseudo"]);
				$this->session->set_flashdata("success", '<div class="alert alert-success" role="alert">Modification des données avec success </div>');
				redirect("jury/informations_compte");
			}
			else
			{
				$this->session->set_flashdata("err", '<div class="alert alert-danger" role="alert">Les deux mot de passe ne correspondent pas </div>');
				$this->load->view('templates/haut');
				$this->load->view('templates/sidebar_prv');
				$this->load->view('templates/navbar_prv');
				$this->load->view('jury/compte_modif_mdp',$data);
				$this->load->view('templates/bas');
			}
		}
	}

	public function afficher_concours()
	{
		$data['titre'] = 'Liste des Concours :';
		$data['concours'] = $this->db_model->get_all_concours_jury();
		
		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('jury/concours_liste',$data);
		$this->load->view('templates/bas');
	}
	
	public function afficher_preselection($id)
	{
		$data['titre'] = 'Liste des Candidatures Préselctionnées :';
		$data['cands'] = $this->db_model->get_all_preselection($id);
		$data['cats'] = $this->db_model->get_all_cats_by_cnc_id($id);

		$this->load->view('templates/haut');
		$this->load->view('templates/sidebar_prv');
		$this->load->view('templates/navbar_prv');
		$this->load->view('jury/preselection_afficher',$data);
		$this->load->view('templates/bas');
	}

}

?>