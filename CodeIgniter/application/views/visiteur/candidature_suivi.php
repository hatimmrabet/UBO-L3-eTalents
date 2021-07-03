<div class="container-fluid" style="width: 85%;">
  <div class="row justify-content-center">
    <div class="col-xl-10 col-lg-12 col-md-9">
      <div class="card o-hidden border-0 shadow-lg my-5 ">
        <div class="card-body p-0"> 
          <div class="row">
            <div class="col-lg-6 d-none d-lg-block" style="background: url('<?php echo base_url(); ?>style/img/bg_suivi_commande.jpg');background-position: center;background-size: cover;"></div>
            <div class="col-lg-6 p-5">
              <?php if ($this->session->flashdata("err") != null)
                          {
                            echo $this->session->flashdata("err");
                          }
                          else if($this->session->flashdata("success") != null)
                          {
                            echo $this->session->flashdata("success");
                          }
                    ?>
                  <div class="text-center">
                    <h1 class="h4 font-weight-bold text-primary m-3">Suivi de candidature :</h1>
                  </div>
                  <!-- Formulaire -->
                  <div class="user mb-5">
                    <?php echo form_open('candidature_suivre'); ?>
                    <div class="form-group">
                      <label class="font-weight-bold text-primary">Numero de dossier :</label>
                      <input type="text" name="numDossier" placeholder="Enter N° de dossier" maxlength="20" class="form-control" style="border-radius: 1rem;" >
                      <small class="form-text text-danger"><?php echo form_error('numDossier'); ?></small>
                    </div>
                    <div class="form-group">
                      <label class="font-weight-bold text-primary">Numero de candidature :</label >
                      <input type="text" name="numCand" placeholder="Enter N° de candidature" maxlength="8" class="form-control" style="border-radius: 1rem;" >
                      <small class="form-text text-danger"><?php echo form_error('numCand'); ?></small>
                    </div>
                    <input type="submit" name="submit" value="Visualiser" class="btn btn-primary btn-user btn-block font-weight-bold" style="border-radius: 1rem;font-size: 16px;padding: 0.5rem 1rem;"/>
                  </form>
                </div>
                <!-- fin de formulaire -->
              </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>