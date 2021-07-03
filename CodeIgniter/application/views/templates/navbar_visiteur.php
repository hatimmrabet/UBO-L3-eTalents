<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">
  <!-- Main Content -->
  <div id="content">

    <!-- Topbar -->
    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
      <a href="<?php echo base_url();?>index.php/visiteur/afficher_actualites"><img class="navbar-brand" style="width: 62px;" src="<?php echo base_url();?>style/img/logo_etalent.png"></img></a>
      <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav">
          <a class="nav-item nav-link active font-weight-bold text-primary" href="<?php echo base_url();?>index.php/visiteur/afficher_actualites">Home<span class="sr-only">(current)</span></a>
          <a class="nav-item nav-link font-weight-bold text-primary" href="<?php echo base_url();?>index.php/visiteur/afficher_concours">Concours</a>
          <a class="nav-item nav-link font-weight-bold text-primary" href="<?php echo base_url();?>index.php/visiteur/suivre_candidature">Suivi de candidature</a>
        </div>
      </div>
      <form class="form-inline my-2 my-lg-0">
        <a class="btn btn-outline-primary font-weight-bold my-2 my-sm-0" type="submit" href="<?php echo base_url();?>index.php/visiteur/seconnecter">Se connecter</a>
      </form>
    </nav>
    <!-- End of Topbar -->