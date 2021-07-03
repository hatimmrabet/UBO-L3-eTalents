<div class="container-fluid">

<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 font-weight-bold text-primary"><?php echo $titre;?></h1>
</div>
<?php if ($this->session->flashdata("success") != null)
    {
      echo $this->session->flashdata("success");
    }
?>
<?php foreach ($cats as $cat) {
	if($cat["nbcand_cat"] == 0)
	{
		echo '<div class="card shadow mb-4 mt-4">
				<div class="card-header py-3">
					<h4 class="m-0 font-weight-bold text-primary">'.$cat["cat_nom"].'</h4>
				</div>
				<div class="card-body">
					Aucune candidature pour cette categorie
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
								<th>Informations du Candidature</th>
								<th>Informations Personnelles</th>
								<th style="width: 11%">Biographie</th>
								<th>Documents</th>
								<th style="width: 12%;">Annulation de candidature</th>
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
									<td>
										<ul style="padding-left: 8%;">
											<?php 	
												echo '<li> N° Dossier : '.$cnd["cnd_numDossier"].'</li>';
											 	echo '<li> N° Candidat : '.$cnd["cnd_numCandidat"].'</li>';
											 	echo '<li> Etat : ';
													if($cnd["cnd_etat"]=='T'){echo "En cours de Traitement";}
													if($cnd["cnd_etat"]=='P'){echo "Préselctionnée";}
													if($cnd["cnd_etat"]=='A'){echo "Annulée";}
												echo '</li>';
												echo '<li> Date : '.$cnd["cnd_dateCandidature"].'</li>';
											?>
										</ul>
									</td>
									<td>
										<ul style="padding-left: 8%;">
											<li><?php echo "Nom 	: ".$cnd["cnd_nom"]; ?></li>
											<li><?php echo "Prenom 	: ".$cnd["cnd_prenom"]; ?></li>
											<li><?php echo "e-mail 	: ".$cnd["cnd_mail"]; ?></li>
										</ul>
									</td>
									<td><?php echo $cnd["cnd_biographie"]; ?></td>
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
									<td style="vertical-align: middle;">
										<?php echo form_open('organisateur/annuler_candidature') ?>
										<input type="text" name="cndid" value="<?php echo $cnd["cnd_id"] ?>" readonly hidden>
										<input type="text" name="cncid" value="<?php echo $cnd["cnc_id"] ?>" readonly hidden>
										<button class="btn btn-danger btn-sm" type="submit" role="button">Annuler Candidature</button>
										</form>
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
