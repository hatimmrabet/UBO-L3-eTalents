<div class="container-fluid" style="width: 85%;">
<div class="card shadow mb-4 mt-4">

<div class="card-header py-3">
	<?php if($concours != NULL){ ?>
		<h4 class="m-0 font-weight-bold text-primary"><?php echo $titre." ".$concours[0]["cnc_nom"] ?></h4>
		<?php } else { 
			echo '<h4 class="m-0 font-weight-bold text-primary">Aucun concours trouvé </h4>';
		 } ?>

</div>
<div class="card-body">
<div class="table-responsive">
<?php if($concours != NULL){ ?>
<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	<thead>
		<tr>
			<th>Discipline</th>
			<th>Organisateur</th>
			<th style="width: 30%">Texte d'introduction</th>
			<th style="width: 11%">Catégories</th>
			<th>Membres de jury</th>
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
			<td><?php echo $cnc["cnc_discipline"] ?></td>
			<td><?php echo $cnc["org"] ?></td>
			<td><?php echo $cnc["cnc_textIntro"] ?></td>
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
		<?php $traite[$cnc["cnc_id"]]=1; }
		 }
		?>
	</tbody>
</table>
<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	<thead>
		<tr>
			<th>Début de Candidature </th>
			<th>Début de Préselection </th>
			<th>Début d'Evaluation </th>
			<th>Affichage de Palmares </th>
			<th>Phase Actuelle</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><?php echo $concours[0]["cnc_dateDebut"] ?></td>
			<td><?php echo $concours[0]["preselection"] ?></td>
			<td><?php echo $concours[0]["eval"] ?></td>
			<td><?php echo $concours[0]["fin"] ?></td>
			<td><?php echo $concours[0]["phase"] ?></td>
		</tr>
	</tbody>
</table>
<?php } else {  echo "Aucun Concours pour l'instant !"; } ?>
</div>
</div>

</div>
</div>

<!-- Modal -->
<div class="modal fade bd-example-modal-lg" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg " role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">Membres de jury</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
    	<?php 
    	if(isset($concours["jury"]))
    	{
    		echo 'Aucun membre de jury';
    	}
    	else
    	{
    		echo '<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<th>Jury</th>
						<th>Information</th>
					</thead>
		        	<tbody>';
		foreach ($concours as $jury)
		{	?>
			<tr>
    			<th><?php echo $jury["cpt_nom"]." ".$jury["cpt_prenom"] ?></th>
    			<td>
    				<ul>
    					<li>e-mail 		: <?php echo $jury["cpt_mail"] ?></li>
    					<li>Discipline 	: <?php echo $jury["jury_discipline"] ?> </li>
						<li>Biographie 	: <?php echo $jury["jury_biographie"] ?> </li>
    					<li>Site web 	: <?php echo $jury["jury_url"] ?> </li>
    				</ul>
    			</td>
    		</tr>
		<?php 		
			}}
			?>
        </tbody>
        </table> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>