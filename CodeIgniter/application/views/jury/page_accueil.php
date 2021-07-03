<div class="container-fluid" style="width: 85%;">
	<div class="card border-left-primary shadow my-3">
		<div class="card-body">
			<div class="h6 font-weight-bold text-primary text-uppercase mb-3"><?php echo $titre; ?></div>
			<div class="h3 font-weight-bold text-dark my-2">
				<?php echo "Bonjour ".$compte->cpt_nom." ".$compte->cpt_prenom; ?> 
			</div>
		</div>
	</div>

	<div class="row">
		<!-- Profil -->
		<div class="col-xl-3 col-md-6 mb-4">
			<a style="text-decoration: none;" href="<?php echo base_url();?>index.php/jury/informations_compte">
				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Profil</div>
								<div class="h8 mb-0 text-gray-800">Mes informations</div>
							</div>
							<div class="col-auto">
								<i class="far fa-user-circle fa-2x text-gray-300"></i>
							</div>
						</div>
					</div>
				</div>
			</a>
		</div>

		<!-- Concours -->
		<div class="col-xl-3 col-md-6 mb-4">
			<a style="text-decoration: none;" href="<?php echo base_url();?>index.php/jury/afficher_concours">
				<div class="card border-left-warning shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Concours</div>
								<div class="h8 mb-0 text-gray-800">Tous les concours</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-medal fa-2x text-gray-300"></i>
							</div>
						</div>
					</div>
				</div>
			</a>
		</div>
		

	</div>




</div>