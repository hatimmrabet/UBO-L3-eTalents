<div class="container-fluid">
<div class="card shadow mb-4 mt-4">

<div class="card-header py-3">
	<h4 class="m-0 font-weight-bold text-primary"><?php echo $titre ?></h4>
</div>

<div class="card-body">
<div class="table-responsive">
<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	<?php if($concours != NULL){ ?>
	<thead>
		<tr>
			<th>Concours</th>
			<th>Date Début</th>
			<th>Phase Actuelle</th>
			<th>Organisateur</th>
			<th style="width: 11%">Catégories</th>
			<th>Membres de jury</th>
			<th style="width: 10%">Informations</th>
		</tr>
	</thead>
	<tbody>
		<?php 
		foreach ($concours as $cnc) 
		{
			if (!isset($traite[$cnc["cnc_id"]]))
			{
		?>
		<tr>
			<th scope="row"><?php echo $cnc["cnc_nom"] ?></th>
			<td><?php echo $cnc["cnc_dateDebut"] ?></td>
			<td><?php echo $cnc["phase"] ?></td>
			<td><?php echo $cnc["org"] ?></td>
			<td>
				<ul style="padding-left: 15%;">
			<?php 
			foreach ($concours as $cat)
			{
				if ($cnc["cnc_id"] == $cat["cnc_id"] && !isset($traite[$cnc["cnc_id"]][$cat["cat_id"]]))
				{ 	
					if($cat["cat_id"]== null && !isset($traite[$cnc["cnc_id"]]["cat_null"]))
					{
			?>
						<li style="list-style: none;">Aucune catégorie</li>
			<?php 	
						$traite[$cnc["cnc_id"]]["cat_null"]=1;
					} elseif(isset($cat["cat_id"])) {
			?>
						<li><?php echo $cat["cat_nom"] ?></li>
			<?php 	
						$traite[$cnc["cnc_id"]][$cat["cat_id"]] = 1;	//cat de meme concours s'affiche une fois
					}
				} 	
			} 
			?>
				</ul>
			</td>
			<td>
				<ul style="padding-left: 7%;">
			<?php 
			foreach ($concours as $jury)
			{
				if ($cnc["cnc_id"] == $jury["cnc_id"] && !isset($traite[$cnc["cnc_id"]][$jury["jury"]]))
				{ 	
					if(!isset($jury["jury"]) && !isset($traite[$cnc["cnc_id"]]["jury_null"]))
					{
			?>
						<li style="list-style: none;">Aucun membre du jury</li>
			<?php 
						$traite[$cnc["cnc_id"]]["jury_null"] = 1;
					} elseif(isset($jury["jury"])) {
			?>
						<li><?php echo $jury["cpt_nom"] ." ". $jury["cpt_prenom"]." : ".$jury["jury_discipline"] ?></li>
			<?php 	
						$traite[$cnc["cnc_id"]][$jury["jury"]] = 1;	//cat de meme concours s'affiche une fois
					}
				}
			}
			?>
				</ul>
			</td>
			<td><a class="btn btn-dark btn-sm btn-block" href="<?php echo base_url()."index.php/organisateur/afficher_details_concours/".$cnc["cnc_id"]?>" role="button">Plus d'info...</a>
				<?php if($cnc["phase"]=="Candidature" && $cnc["nbCnd"] != 0) { ?>
					<a class="btn btn-primary btn-sm btn-block" href="<?php echo base_url()."index.php/organisateur/afficher_toutes_candidatures/".$cnc["cnc_id"]?>" role="button">Candidatures</a>

				<?php } if($cnc["phase"]=="Préselection" && $cnc["nbCnd"] != 0) { ?>
					<a class="btn btn-primary btn-sm btn-block" href="<?php echo base_url()."index.php/organisateur/afficher_toutes_candidatures/".$cnc["cnc_id"]?>" role="button">Candidatures</a>

				<?php } if($cnc["phase"]=="Evaluation") { ?>
					<a class="btn btn-primary btn-sm btn-block" href="<?php echo base_url()."index.php/organisateur/afficher_toutes_candidatures/".$cnc["cnc_id"]?>" role="button">Candidatures</a>
					<a class="btn btn-warning btn-sm btn-block" href="<?php echo base_url()."index.php/organisateur/afficher_preselection/".$cnc["cnc_id"]?>" role="button">Candidats Présélectionnés</a>

				<?php } if($cnc["phase"]=="Terminé") { ?>
					<a class="btn btn-primary btn-sm btn-block" href="<?php echo base_url()."index.php/organisateur/afficher_toutes_candidatures/".$cnc["cnc_id"]?>" role="button">Candidatures</a>
					<a class="btn btn-warning btn-sm btn-block" href="<?php echo base_url()."index.php/organisateur/afficher_preselection/".$cnc["cnc_id"]?>" role="button">Candidats Présélectionnés</a>
					<a class="btn btn-success btn-sm btn-block" href="#" role="button">Palmares</a>
				<?php } ?>
			</td>

		</tr>
		<?php $traite[$cnc["cnc_id"]]=1; }
		 }
		} else { ?>
			<th>Aucun Concours pour l'instant ! </th>
		<?php } ?>
	</tbody>
</table>
</div>
</div>

</div>
</div>
