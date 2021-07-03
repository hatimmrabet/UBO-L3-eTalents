<?php if($titre == "Ajouter un compte membre du jury :"){ ?>
<div class="container-fluid">
  <div class="card shadow mb-4 mt-4">

    <div class="card-header py-3">
      <h4 class="m-0 font-weight-bold text-primary"><?php echo $titre ?></h4>
    </div>

    <div class="card-body">
      <?php if ($this->session->flashdata("err") != null)
            {
              echo $this->session->flashdata("err");
            }
          echo form_open('organisateur/creation_compte_jury');
      ?>
        <div class="form-row">
          <div class="form-group col-md">
            <label for="inputEmail4">Pseudo</label>
            <input type="text" class="form-control" id="inputEmail4" maxlength="20" required placeholder="Pseudo" name="pseudo">
            <small class="form-text text-danger"><?php echo form_error('pseudo'); ?></small>
          </div>
          <div class="form-group col-md-4">
            <label for="inputAddress2">e-mail</label>
            <input type="email" class="form-control" id="inputAddress2" maxlength="45" required placeholder="e-mail" name="mail">
            <small class="form-text text-danger"><?php echo form_error('mail'); ?></small>
          </div>
          <div class="form-group col-md-4">
            <label for="inputAddress2">Mot de passe</label>
            <input type="password" class="form-control" id="inputPassword4" minlength="5" required placeholder="Mot de passe" name="password">
            <small class="form-text text-danger"><?php echo form_error('password'); ?></small>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group col-md">
            <label for="inputPassword4">Nom</label>
            <input type="text" class="form-control" id="inputnom" maxlength="45" required placeholder="Nom" name="nom">
            <small class="form-text text-danger"><?php echo form_error('nom'); ?></small>
          </div>
          <div class="form-group col-md">
            <label for="inputAddress">Prenom</label>
            <input type="text" class="form-control" id="inputAddress" maxlength="45" required placeholder="Prenom" name="prenom">
            <small class="form-text text-danger"><?php echo form_error('prenom'); ?></small>
          </div>
          <div class="form-group col-md-3">
            <label for="inputZip">Discipline</label>
            <input type="text" class="form-control" id="inputZip" maxlength="64" required placeholder="Discipline" name="discipline">
            <small class="form-text text-danger"><?php echo form_error('discipline'); ?></small>
          </div>
          <div class="form-group col-md-1">
            <label for="inputState">Etat</label>
            <select id="inputState" class="form-control" required name="etat" >
              <option selected value="D">D</option>
              <option value="A">A</option>
            </select>
            <small class="form-text text-danger"><?php echo form_error('etat'); ?></small>
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <label for="inputCity">Biographie</label>
            <textarea type="textarea" class="form-control" maxlength="256" id="inputCity" required placeholder="Biographie" name="bio"></textarea>
            <small class="form-text text-danger"><?php echo form_error('bio'); ?></small>
          </div>
          <div class="form-group col-md-6">
            <label for="inputZip">Site web</label>
            <input type="text" class="form-control" id="inputSite" maxlength="256" placeholder="Site web" name="site">
            <small class="form-text text-danger"><?php echo form_error('site'); ?></small>
          </div>
        </div>
        <button type="submit" class="btn btn-primary">Ajouter Compte</button>
        <a href="<?php echo base_url().'index.php/organisateur/creation_compte' ?>" class="btn btn-danger">Annuler</a>
      </form>
    </div> <!-- fin card body -->
  </div> <!-- fin de card -->
</div> <!-- fin container -->

<?php }
if($titre == "Ajouter un compte organisateur :"){ ?>

<div class="container-fluid">
  <div class="card shadow mb-4 mt-4">

    <div class="card-header py-3">
      <h4 class="m-0 font-weight-bold text-primary"><?php echo $titre ?></h4>
    </div>

    <div class="card-body">
      <?php if ($this->session->flashdata("err") != null)
            {
              echo $this->session->flashdata("err");
            }
          echo form_open('organisateur/creation_compte_org');
      ?>
        <div class="form-row">
          <div class="form-group col-md">
            <label for="inputEmail4">Pseudo</label>
            <input type="text" class="form-control" id="inputEmail4" maxlength="20" required placeholder="Pseudo" name="pseudo">
            <small class="form-text text-danger"><?php echo form_error('pseudo'); ?></small>
          </div>
          <div class="form-group col-md-4">
            <label for="inputAddress2">e-mail</label>
            <input type="email" class="form-control" id="inputAddress2" maxlength="45" required placeholder="e-mail" name="mail">
            <small class="form-text text-danger"><?php echo form_error('mail'); ?></small>
          </div>
          <div class="form-group col-md-4">
            <label for="inputAddress2">Mot de passe</label>
            <input type="password" class="form-control" id="inputPassword4" minlength="5" required placeholder="Mot de passe" name="password">
            <small class="form-text text-danger"><?php echo form_error('password'); ?></small>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group col-md">
            <label for="inputPassword4">Nom</label>
            <input type="text" class="form-control" id="inputnom" maxlength="45" required placeholder="Nom" name="nom">
            <small class="form-text text-danger"><?php echo form_error('nom'); ?></small>
          </div>
          <div class="form-group col-md">
            <label for="inputAddress">Prenom</label>
            <input type="text" class="form-control" id="inputAddress" maxlength="45" required placeholder="Prenom" name="prenom">
            <small class="form-text text-danger"><?php echo form_error('prenom'); ?></small>
          </div>
          <div class="form-group col-md-1">
            <label for="inputState">Etat</label>
            <select id="inputState" class="form-control" required name="etat" >
              <option selected value="D">D</option>
              <option value="A">A</option>
            </select>
            <small class="form-text text-danger"><?php echo form_error('etat'); ?></small>
          </div>
        </div>
        <button type="submit" class="btn btn-primary">Ajouter Compte</button>
        <a href="<?php echo base_url().'index.php/organisateur/creation_compte' ?>" class="btn btn-danger">Annuler</a>
      </form>
    </div> <!-- fin card body -->
  </div> <!-- fin de card -->
</div> <!-- fin container -->


<?php } ?>