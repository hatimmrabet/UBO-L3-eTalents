<div class="container-fluid">
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
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<?php if($comptes != NULL){ ?>
						<thead>
							<tr>
								<th>Pseudo</th>
								<th>Nom</th>
								<th>Prénom</th>
								<th>e-mail</th>
								<th>Etat</th>
								<th>Statut</th>
							</tr>
						</thead>
						<tbody>
					<?php 
						foreach ($comptes as $compte) 
						{
					?>	<tr>
							<th scope="row"><?php echo $compte["cpt_pseudo"] ?></th>
							<td><?php echo $compte["cpt_nom"] ?></td>
							<td><?php echo $compte["cpt_prenom"] ?></td>
							<td><?php echo $compte["cpt_mail"] ?></td>
							<td><?php echo $compte["cpt_etat"] ?></td>
							<td><?php echo $compte["statut"] ?></td>
						</tr>
				<?php
						}
					} else { 
				?>		<th>Aucun Compte pour l'instant ! </th>
					<?php } ?>
						</tr>
					</tbody>
				</table>
			</div> <!-- fin div table responsibe -->
			<div class="row justify-content-center">
				<div class="col-3">
					<a class="btn btn-primary" href="<?php echo base_url().'index.php/organisateur/creation_compte' ?>" role="button">Ajouter un compte</a>
				</div>
			</div>
		</div>
	</div>
</div>
