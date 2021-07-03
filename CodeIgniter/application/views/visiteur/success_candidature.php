<div class="container">
  <div class="card shadow mb-4 mt-4">

    <div class="card-header py-3">
      <h4 class="m-0 font-weight-bold text-primary"><?php echo $titre ?></h4>
    </div>

    <div class="card-body">
      <?php if ($this->session->flashdata("success") != null)
            {
              echo $this->session->flashdata("success");
            }
      ?>
        <div class="form-row">
          <div class="form-group col-md">
            <label for="inputPassword4">N° de Dossier</label>
            <input type="text" class="form-control" id="inputnom" maxlength="45" readonly value="<?php echo $ndd; ?>">
          </div>
          <div class="form-group col-md">
            <label for="inputAddress">N° de Candidat</label>
            <input type="text" class="form-control" id="inputAddress" maxlength="45" readonly value="<?php echo $ndc; ?>">
          </div>
        </div>
        <a href="<?php echo base_url();?>index.php/visiteur/suivre_candidature" target="_blank"><button type="submit" class="btn btn-primary">Suivi de candidature</button></a>
    </div> <!-- fin card body -->
  </div> <!-- fin de card -->
</div> <!-- fin container -->