<?php if(isset($_SESSION["pseudo"]))
{

  /*********************************************************************************************************/
  /****************************************       JURY          ********************************************/
  /*********************************************************************************************************/

  if($_SESSION["statut"] == "jury")
  {
?>
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<?php echo base_url();?>index.php/jury/accueil">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-futbol"></i>
        </div>
        <div class="sidebar-brand-text mx-3">FootBall<sup>fs</sup></div>
      </a>
      <!-- Divider -->
      <hr class="sidebar-divider my-0">
      <!-- Nav Item - Dashboard -->
      <li class="nav-item">
        <a class="nav-link" href="<?php echo base_url();?>index.php/jury/accueil">
          <i class="fas fa-home"></i>
          <span>Accueil</span>
        </a>
      </li>
      <hr class="sidebar-divider my-0">
      <li class="nav-item">
        <a class="nav-link" href="<?php echo base_url();?>index.php/jury/informations_compte">
          <i class="fas fa-address-card"></i>
          <span>Profil</span>
        </a>
      </li>
      <!-- Divider -->
      <hr class="sidebar-divider">
      <!-- Heading -->
      <div class="sidebar-heading">
        Gestion :
      </div>
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-medal"></i>
          <span>Concours</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Gestion des concours:</h6>
            <a class="collapse-item" href="<?php echo base_url();?>index.php/jury/afficher_concours">Affichage</a>
          </div>
        </div>
      </li>
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">
      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>
    </ul>
<?php
  }
  /*********************************************************************************************************/
  /************************************       ORGANISATEUR      ********************************************/
  /*********************************************************************************************************/
  else if($_SESSION["statut"] == "organisateur")
  {
?>
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<?php echo base_url();?>index.php/organisateur/accueil">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-futbol"></i>
        </div>
        <div class="sidebar-brand-text mx-3">FootBall<sup>fs</sup></div>
      </a>
      <!-- Divider -->
      <hr class="sidebar-divider my-0">
      <!-- Nav Item - Dashboard -->
      <li class="nav-item">
        <a class="nav-link" href="<?php echo base_url();?>index.php/organisateur/accueil">
          <i class="fas fa-home"></i>
          <span>Accueil</span>
        </a>
      </li>
      <hr class="sidebar-divider my-0">
      <li class="nav-item">
        <a class="nav-link" href="<?php echo base_url();?>index.php/organisateur/informations_compte">
          <i class="fas fa-address-card"></i>
          <span>Profil</span>
        </a>
      </li>
      <!-- Divider -->
      <hr class="sidebar-divider">
      <!-- Heading -->
      <div class="sidebar-heading">
        Gestion :
      </div>
      <!-- Nav Item -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-medal"></i>
          <span>Concours</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Gestion des concours:</h6>
            <a class="collapse-item" href="<?php echo base_url();?>index.php/organisateur/afficher_concours">Affichage</a>
          </div>
        </div>
      </li>

      <!-- Nav Item -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseComptes" aria-expanded="true" aria-controls="collapseComptes">
          <i class="far fa-user-circle"></i>
          <span>Comptes</span>
        </a>
        <div id="collapseComptes" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Gestion des comptes:</h6>
            <a class="collapse-item" href="<?php echo base_url();?>index.php/organisateur/lister_comptes">Affichage</a>
            <a class="collapse-item" href="<?php echo base_url();?>index.php/organisateur/creation_compte">Création</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">
      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>
    </ul>
<?php
    }
  }
?>