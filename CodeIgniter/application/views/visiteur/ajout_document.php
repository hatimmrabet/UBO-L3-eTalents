<div class="container">
    <div class="card shadow my-5 mx-auto w-50">
        <div class="card-header py-3">
            <h4 class="m-0 font-weight-bold text-primary"><?php echo $titre ?></h4>
        </div>
        <div class="card-body">
            <?php if ($this->session->flashdata("err") != null) {
                echo $this->session->flashdata("err");
            }
            if ($this->session->flashdata("success") != null) {
                echo $this->session->flashdata("success");
            }
            ?>

            <div class="alert alert-warning" role="alert">
                Vous avez le droit d'ajouter jusqu'à <b> 3 documents </b>au totale.<br>
                Vous avez déja ajouté <b><?php echo $cand->nb_doc ?>/3 document(s)</b>.
            </div>

            <?php if ($cand->nb_doc < 3) {
                echo form_open_multipart('visiteur/upload_file/' . $cand->cnd_numDossier . '/' . $cand->cnd_numCandidat); ?>
                <div class="form-group">
                    <label for="inputPassword4">Titre de fichier</label>
                    <input type="text" class="form-control" id="inputnom" maxlength="64" required placeholder="Titre de fichier" name="file_titre">
                    <small class="form-text text-danger"><?php echo form_error('file_titre'); ?></small>
                </div>
                <div class="form-group">
                    <label for="inputState">Document</label>
                    <div class="custom-file">
                        <input type="file" class="" id="customFile" name="fichier" required>
                    </div>
                    <small class="form-text text-danger"><?php echo form_error('fichier'); ?></small>
                </div>
                <input type="submit" value="Ajouter" class="btn btn-primary btn-user btn-block font-weight-bold" style="border-radius: 1rem;font-size: 16px;padding: 0.5rem 1rem;" />
                </form>
            <?php } else {
            ?>
                <div class="alert alert-danger" role="alert">
                    Vous ne pouvez pas ajouter un autre document.<br>
                    Vous avez déja ajouté <b><?php echo $cand->nb_doc ?> documents</b> (limite).
                </div>
            <?php } ?>
        </div>
    </div>
</div>