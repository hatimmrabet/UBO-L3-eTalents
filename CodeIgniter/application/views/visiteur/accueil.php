<div class="container-fluid" style="width: 85%;">
  <div class="card shadow mb-4 mt-4">

    <div class="card-header py-3">
      <h4 class="m-0 font-weight-bold text-primary"><?php echo $titre ?></h4>
    </div>

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
          <?php if($actu != NULL){ ?>
            <thead>
              <tr>
                <th scope="col" style="width: 12%;">Concours</th>
                <th scope="col">Texte</th>
                <th scope="col" style="width: 10%;">Publié le:</th>
                <th scope="col">Par</th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($actu as $data) { ?>
                <tr>
                  <th scope="row"><?php echo $data["cnc_nom"] ?></th>
                  <td><?php echo $data["act_text"] ?></td>
                  <td><?php echo $data["act_date"] ?></td>
                  <td><?php echo $data["cpt_pseudo"] ?></td>
                </tr>
              <?php } } else { ?>
                <th> Aucune actualité pour l'instant ! </th>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </div>

    </div>
  </div>
<!-- /.container-fluid -->