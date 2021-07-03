<div class="container-fluid">
	<div class="card shadow mx-auto w-50 ">
		<div class="card-header py-3">
			<h4 class="m-0 font-weight-bold text-primary">Choix de statut de compte à créer</h4>
		</div>
		<div class="card-body">
				<?php echo form_open("organisateur/creation_compte"); ?>
				<div class="form-row">
					<div class="form-group mx-auto">
						<label for="inputState">Choix de statut:</label>
						<select id="inputState" class="form-control" required name="choix" >
							<option selected value="jury">Jury</option>
							<option value="org">Organisateur</option>
						</select>
						<small class="form-text text-danger"><?php echo form_error('choix'); ?></small>
						<button type="submit" class="btn btn-primary btn-sm mt-2 form-control">Valider</button>
						<a href="<?php echo base_url().'index.php/organisateur/lister_comptes' ?>" class="btn btn-danger btn-sm mt-2 form-control">Annuler</a>
					</div>
				</div>
			</form>
	</div>
</div>
</div>