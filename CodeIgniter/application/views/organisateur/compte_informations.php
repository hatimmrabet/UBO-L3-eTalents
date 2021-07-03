<div class="container-fluid" style="width: 85%;">
  <div class="card border-left-primary shadow my-3">
    <div class="card-body">
      <div class="h6 font-weight-bold text-primary text-uppercase mb-2">Informations Personnelles :</div>
      <div class="table-responsive">
        <table class="table " id="dataTable" width="100%" cellspacing="0">
          <tr>
            <th style="width: 40%;">Pseudo</th>
            <td><?php echo $compte->cpt_pseudo; ?></td>
          </tr>
          <tr>
            <th style="width: 40%;">Nom</th>
            <td><?php echo $compte->cpt_nom; ?></td>
          </tr>
          <tr>
            <th style="width: 40%;">Prenom</th>
            <td><?php echo $compte->cpt_prenom; ?></td>
          </tr>
          <tr>
            <th style="width: 40%;">e-mail</th>
            <td><?php echo $compte->cpt_mail; ?></td>
          </tr>
          <tr>
            <th style="width: 40%;">Statut</th>
            <td><?php echo $compte->statut; ?></td>
          </tr>
        <tr>
          <td style="text-align: center;" colspan="2">
            <a href='<?php echo base_url()."index.php/organisateur/modif_mdp_compte" ?>'>
              <button type="button" class="btn btn-primary btn-sm">Modifier le mot de passe</button>
            </a>
          </td>
        </tr>
      </table>
    </div>
  </div>
</div>
</div>