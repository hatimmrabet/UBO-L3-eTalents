<div class="container">
  <div class="card shadow mb-4 mt-4">

    <div class="card-header py-3">
      <h4 class="m-0 font-weight-bold text-primary"><?php echo $titre ?></h4>
    </div>

    <div class="card-body">
      <?php if ($this->session->flashdata("err") != null)
            {
              echo $this->session->flashdata("err");
            }
      
          echo form_open('visiteur/inscription/'.$id);
      ?>
      <div class="alert alert-warning mb-3" style="text-align: center;" role="alert">
        Aprés votre inscription vous pouvez ajouter vos documents dans la ribrique "suivi candidature".
      </div>
      <h6 class="m-0 font-weight-bold text-primary mb-2">Ajoutez vos informations :</h6>
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
          <div class="form-group col-md-4">
            <label for="inputAddress2">e-mail</label>
            <input type="email" class="form-control" id="inputAddress2" maxlength="45" required placeholder="e-mail" name="mail">
            <small class="form-text text-danger"><?php echo form_error('mail'); ?></small>
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-8">
            <label for="inputCity">Biographie</label>
            <textarea type="textarea" class="form-control" maxlength="256" id="inputCity" required placeholder="Biographie" name="bio"></textarea>
            <small class="form-text text-danger"><?php echo form_error('bio'); ?></small>
          </div>
          <div class="form-group col-md-4">
            <label for="inputState">Catégorie</label>
            <select id="inputState" class="form-control" required name="categorie" >
              <option selected value="">Choisissez une catégorie</option>
              <?php foreach ($cats as $cat) { ?>
                <option value="<?php echo $cat["cat_id"] ?>"><?php echo $cat["cat_nom"] ?></option>
              <?php } ?>
            </select>
            <small class="form-text text-danger"><?php echo form_error('categorie'); ?></small>
          </div>
        </div>
        <button type="submit" class="btn btn-primary">Valider</button>
      </form>
    </div> <!-- fin card body -->
  </div> <!-- fin de card -->
</div> <!-- fin container -->