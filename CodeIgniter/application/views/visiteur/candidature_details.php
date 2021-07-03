<div class="container-fluid" style="width: 85%;">
  <!-- Outer Row -->
  <div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 font-weight-bold text-primary"><?php echo $titre; ?></h1>
  </div>

  <div class="row mb-3">
    <div class="card border-left-primary shadow h-100 w-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Etat de votre candidature :</div>
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" style="margin: 0px;width: 100%;" cellspacing="0">
                <thead>
                  <th>N° de Dossier</th>
                  <th>N° de Candidature</th>
                  <th>Date de candidature</th>
                  <th>Concours</th>
                  <th>Catégorie</th>
                  <th>Etat de Candidature</th>
                  <th>Supprimer ma candidature</th>
                </thead>
                <tbody>
                  <tr style="text-align: center;">
                    <td style="vertical-align: middle;"><?php echo $cand->cnd_numDossier ?></td>
                    <td style="vertical-align: middle;"><?php echo $cand->cnd_numCandidat ?></td>
                    <td style="vertical-align: middle;"><?php echo $cand->cnd_dateCandidature ?></td>
                    <td style="vertical-align: middle;"><?php echo $cand->cnc_nom ?></td>
                    <td style="vertical-align: middle;"><?php echo $cand->cat_nom ?></td>
                    <td style="vertical-align: middle;"><?php if($cand->cnd_etat == 'P') 
                                                              { 
                                                                echo "Préselectionnée";
                                                              }
                                                              elseif ($cand->cnd_etat == 'T') {
                                                                echo "En Cours de Traitement";
                                                              }
                                                              elseif($cand->cnd_etat == 'A')
                                                              {
                                                                echo "Annulée";
                                                              }
                                                        ?>
                  </td>
                  <td style="text-align: center;">
                      <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#exampleModal">Supprimer</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="row mb-3">

  <div class="col-lg-6 pl-0">
    <div class="card border-left-primary shadow h-100 w-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Informtions Personnelles :</div>
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" style="margin: 0px;" width="100%" cellspacing="0">
                  <tr>
                    <th>Nom</th>
                    <td><?php echo $cand->cnd_nom ?></td>
                  </tr>
                  <tr>
                    <th>Prenom</th>
                    <td><?php echo $cand->cnd_prenom ?></td>
                  </tr>
                  <tr>
                    <th>Mail</th>
                    <td><?php echo $cand->cnd_mail ?></td>
                  </tr>
                  <tr>
                    <th>Biographie</th>
                    <td><?php echo $cand->cnd_biographie ?></td>
                  </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>

  <div class="col-lg-6 px-0">
    <div class="card border-left-primary shadow h-100 w-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Les documents :</div>
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" style="margin: 0px;" width="100%" cellspacing="0">
                <thead>
                  <th>Document</th>
                  <th width="30%">Lien</th>
                </thead>
                <tbody>
            <?php if($cand->nb_doc != 0)
                  {
                    foreach ($docs as $doc) 
                    {  ?>
                      <tr>
                        <td><?php echo $doc["doc_titre"]; ?></td>
                        <td style="text-align: center;">
                          <a href='<?php echo base_url()."style/docs/".$doc["doc_url"];?>' target="_blank">
                            <button type="button" class="btn btn-primary btn-sm">Visualiser</button>
                          </a>
                        </td>
                      </tr>
            <?php   }
                  } 
                  else
                  { ?>
                    <tr>
                      <td colspan="2">Pas de documents pour cette candidature</td>
                    </tr>
            <?php } 
                    if($cand->nb_doc < 3)
                      { ?>
                    <tr>
                      <td colspan="2" style="text-align: center;">
                        <a href='<?php echo base_url()."index.php/visiteur/upload_file/".$cand->cnd_numDossier."/".$cand->cnd_numCandidat?>' target="_blank">
                          <button type="button" class="btn btn-primary btn-sm">Ajouter un document</button>
                        </a>
                      </td>
                    </tr>
                  <?php } ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
</div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title h4 font-weight-bold text-primary" id="exampleModalLabel">Suppression de votre candidature</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="alert alert-warning" role="alert">
          Vous êtes sur le point de supprimer votre candidature. Confirmer votre choix.
        </div>
        <?php echo form_open('visiteur/supprimer_candidature'); ?>
          <div class="form-group">
            <label class="font-weight-bold text-primary">Numero de dossier :</label>
            <input value="<?php echo $cand->cnd_numDossier ?>" name="numDossiercnf" hidden>
            <input type="text" name="numDossier" placeholder="Enter N° de dossier" value="<?php echo $cand->cnd_numDossier ?>" readonly maxlength="20" class="form-control" style="border-radius: 1rem;" >
            <small class="form-text text-danger"><?php echo form_error('numDossier');?></small>
          </div>
          <div class="form-group">
            <label class="font-weight-bold text-primary">Numero de candidature :</label >
            <input value="<?php echo $cand->cnd_numCandidat ?>" name="numCandidatcnf" hidden>
            <input type="text" name="numCand" placeholder="Enter N° de candidature" value="<?php echo $cand->cnd_numCandidat ?>" readonly maxlength="8" class="form-control" style="border-radius: 1rem;" >
            <small class="form-text text-danger"><?php echo form_error('numCand'); ?></small>
          </div>
          <input type="submit" value="Supprimer" class="btn btn-danger btn-user btn-block font-weight-bold" style="border-radius: 1rem;font-size: 16px;padding: 0.5rem 1rem;"/>
          </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
      </div>
    </div>
  </div>
</div>