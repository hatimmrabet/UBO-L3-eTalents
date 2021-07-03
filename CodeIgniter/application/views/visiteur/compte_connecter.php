<div class="container-fluid " style="width: 80%;">
  <div class="row justify-content-center">
    <div class="col-xl-10 col-lg-12 col-md-9">
      <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
          <div class="row">
            <div class="col-lg-6 d-none d-lg-block" style="background: url('<?php echo base_url(); ?>style/img/bg_seconnecter.jpg');background-position: center;background-size: cover;"></div>
            <div class="col-lg-6">
              <div class="p-5">
                <div class="text-center">
                  <h1 class="h4 font-weight-bold text-primary mb-5">Se connecter :</h1>
                </div>
                <?php if ($this->session->flashdata("err") != null)
                      {
                        echo $this->session->flashdata("err");
                      }
                ?>
                <?php echo form_open('visiteur/seconnecter'); ?>
                <div class="form-group">
                  <label class="font-weight-bold text-primary">Pseudo :</label>
                  <input type="text" name="pseudo" placeholder="Enter votre pseudo" maxlength="20" class="form-control" style="border-radius: 1rem;" >
                  <small class="form-text text-danger"><?php echo form_error('pseudo'); ?></small>
                </div>
                <div class="form-group">
                  <label class="font-weight-bold text-primary">Mot de passe :</label >
                  <input type="password" name="mdp" placeholder="Enter votre mot de passe" class="form-control" style="border-radius: 1rem;" >
                  <small class="form-text text-danger"><?php echo form_error('mdp'); ?></small>
                </div>
                <input type="submit" name="submit" value="Visualiser" class="btn btn-primary btn-user btn-block font-weight-bold" style="border-radius: 1rem;font-size: 16px;padding: 0.5rem 1rem;"/>
              </form>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>