<div class="container-fluid">

<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 font-weight-bold text-primary"><?php echo $titre;?></h1>
</div>
<?php foreach ($cats as $cat) {
	if($cat["nbpre_cat"] == 0)
	{
		echo '<div class="card shadow mb-4 mt-4">
				<div class="card-header py-3">
					<h4 class="m-0 font-weight-bold text-primary">'.$cat["cat_nom"].'</h4>
				</div>
				<div class="card-body">
					Aucune candidature Préselctionnée pour cette categorie
				</div>
			   </div>';
	}
	else
	{
?>
	<div class="card shadow mb-4 mt-4">
		<div class="card-header py-3">
			<h4 class="m-0 font-weight-bold text-primary"><?php echo $cat["cat_nom"];?></h4>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>N° Dossier</th>
								<th>N° Candidat</th>
								<th>Informations</th>
								<th style="width: 11%">Biographie</th>
								<th>Date</th>
								<th>Etat</th>
								<th>Documents</th>
							</tr>
						</thead>
						<tbody>
							<?php foreach ($cands as $cnd){ 
								if($cnd["cat_id"] == $cat["cat_id"])
								{
									if(!isset($traite[$cat["cat_id"]][$cnd["cnd_id"]]))
										{
							?>
								<tr>
									<td><?php echo $cnd["cnd_numDossier"]; ?></td>
									<td><?php echo $cnd["cnd_numCandidat"]; ?></td>
									<td>
										<ul style="padding-left: 8%;">
											<li><?php echo "Nom 		: ".$cnd["cnd_nom"]; ?></li>
											<li><?php echo "Prenom 	: ".$cnd["cnd_prenom"]; ?></li>
											<li><?php echo "e-mail 	: ".$cnd["cnd_mail"]; ?></li>
										</ul>
									</td>
									<td><?php echo $cnd["cnd_biographie"]; ?></td>
									<td><?php echo $cnd["cnd_dateCandidature"]; ?></td>
									<td><?php 	if($cnd["cnd_etat"]=='T'){echo "En cours de Traitement";}
												if($cnd["cnd_etat"]=='P'){echo "Préselctionnée";}
												if($cnd["cnd_etat"]=='A'){echo "Annulée";}
									?>
									</td>
									<td>
										<ul style="padding-left: 8%;">
											<?php foreach ($cands as $doc){
												if($doc["cnd_id"] == $cnd["cnd_id"])
												{	
													if($doc["doc_id"] == null && !isset($traite[$cat["cat_id"]][$cnd["cnd_id"]]["doc_null"]))
													{
														echo '<li style="list-style: none;">Aucun document</li>';
														$traite[$cat["cat_id"]][$cnd["cnd_id"]]["doc_null"] = 1;
													}
													else if(!isset($traite[$cat["cat_id"]][$cnd["cnd_id"]][$doc["doc_id"]]))
													{
													?>
														<li><a href='<?php echo base_url()."style/docs/".$doc["doc_url"];?>' target="_blank"><?php echo $doc["doc_titre"] ?><a/>
														</li>
													<?php $traite[$cat["cat_id"]][$cnd["cnd_id"]][$doc["doc_id"]] =1;
													}
												} 	//condition affichage des documents 
											}	//boucle affichage docs
											?>
										</ul>
									</td>
									</tr>
									
						<?php 
									$traite[$cat["cat_id"]][$cnd["cnd_id"]] = 1;
									} //candidature non traité
								}	//candidature de cette categorie
						?>
						<?php } //boucle des candidature ?>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	<?php 
		} //categories avec canidatures
	} //toutes les categories ?>

</div>
