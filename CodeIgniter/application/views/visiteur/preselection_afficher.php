<div class="container">

<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 font-weight-bold text-primary"><?php echo $titre;?></h1>
</div>

<?php 
if($info["nbPre"] == 0)
{
	echo '<div class="card shadow mb-4 mt-4">
			<div class="card-header py-3">
				<h4 class="m-0 font-weight-bold text-primary">Aucune candidature Préselctionnée</h4>
			</div>
			<div class="card-body">
				Aucune candidature Préselctionnée pour ce concours.
			</div>
		</div>';
}
else
{
foreach ($cats as $cat) {
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
			<div class="row row-cols-1 row-cols-md-5 g-4">
			<?php foreach ($cands as $cnd){ 
				if($cnd["cat_id"] == $cat["cat_id"])
				{
					if(!isset($traite[$cat["cat_id"]][$cnd["cnd_id"]]))
					{
			?>
					<div class="col">
						<div class="card">
					<?php 	if($cnd["nbImg"] != 0){
								foreach ($imgs as $img) {
									if(!isset($traite[$cat["cat_id"]][$cnd["cnd_id"]][$img["cnd_id"]]) && $cnd["cnd_id"] == $img['cnd_id'])
									{
										echo '<img src="'.base_url().'style/docs/'.$img["doc_url"].'" class="card-img-top" alt="img">';
										$traite[$cat["cat_id"]][$cnd["cnd_id"]][$img["cnd_id"]] = 1;
									}
								} 
							}else{ 	?>
								<img src="<?php echo base_url().'style/img/candidat_img.jpg'?>" class="card-img-top" alt="img">
							<?php } ?>
							<div class="card-body">
								<p class="card-text font-weight-bold" style="text-align: center;">
									<?php echo strtoupper($cnd["cnd_nom"])." ".strtolower($cnd["cnd_prenom"]); ?>
								</p>
							</div>
						</div>
					</div>
		<?php 			$traite[$cat["cat_id"]][$cnd["cnd_id"]] = 1;
					} //candidature non traité
				}	//candidature de cette categorie
			} //boucle des candidature ?>
		</div>
		</div>
	</div>
<?php 	} //categories avec candidatures
} //toutes les categories 
}	//else
?>
</div>