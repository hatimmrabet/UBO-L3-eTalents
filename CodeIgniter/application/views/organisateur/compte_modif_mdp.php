<div class="container-fluid" style="width: 85%;">
  <div class="card border-left-primary shadow my-3 ">
    <div class="card-body">
      <div class="h6 font-weight-bold text-primary text-uppercase mb-2">Modification des informations Personnelles :</div>
      <div class="table-responsive">
        <table class="table " id="dataTable" width="100%" cellspacing="0">
          <?php echo form_open('organisateur/modif_mdp_compte');?>
          <tr>
            <th style="width: 40%;">Pseudo</th>
            <td>
              <div class="input-group input-group-sm">
                <input type="text" disabled  required  class="form-control" value="<?php echo $compte->cpt_pseudo; ?>">
              </div>
            </td>
          </tr>
          <tr>
            <th style="width: 40%;">Nom</th>
            <td>
              <div class="input-group input-group-sm">
                <input type="text" required  class="form-control" maxlength="45" name="nom" value="<?php echo $compte->cpt_nom; ?>">
              </div>            
            </td>
            <small class="form-text text-danger"><?php echo form_error('nom'); ?></small>
          </tr>
          <tr>
            <th style="width: 40%;">Prenom</th>
            <td>
              <div class="input-group input-group-sm">
                <input type="text" required  class="form-control" maxlength="45" name="prenom" value="<?php echo $compte->cpt_prenom; ?>">
              </div>            
            </td>
            <small class="form-text text-danger"><?php echo form_error('prenom'); ?></small>
          </tr>
          <tr>
            <th style="width: 40%;">e-mail</th>
            <td>
              <div class="input-group input-group-sm">
                <input type="text"  required class="form-control" maxlength="45" name="mail" value="<?php echo $compte->cpt_mail; ?>">
              </div>            
              <small class="form-text text-danger"><?php echo form_error('mail'); ?></small>
            </td>
          </tr>
          <tr>
            <th style="width: 40%;vertical-align: text-top;">Mot de passe</th>
            <td>
              <div class="input-group input-group-sm">
                <input type="password" required minlength="5" class="form-control" name="mdp" value="">
              </div>
              <small class="form-text text-danger"><?php echo form_error('mdp'); ?></small>
            </td>
          </tr>
          <tr>
            <th style="width: 40%;vertical-align: text-top;">Confirmation de mot de passe</th>
            <td>
              <div class="input-group input-group-sm">
                <input type="password"  required minlength="5" class="form-control" name="mdpconf" value="">
              </div>
              <small class="form-text text-danger"><?php echo form_error('mdpconf'); ?></small>
            </td>
          </tr>
          <tr>
            <td style="text-align: center;" colspan="2">
              <button type="submit" class="btn btn-success btn-sm mr-3">Valider</button>
              <a class="btn btn-danger btn-sm" href="<?php echo base_url().'index.php/organisateur/informations_compte' ?>">Annuler</a>
            </td>
          </tr>
        </form>
      </table>
    </div>
  </div>
</div>
</div>