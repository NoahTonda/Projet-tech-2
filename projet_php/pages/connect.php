<div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
        Connexion
    </button>
    <form action="<?php print $_SERVER['PHP_SELF'];?>" method="get">
        <div class="mb-3 row">
            <label for="login" class="col-sm-2 col-form-label">Login</label>
            <div class="col-sm-10">
                <input type="text" readonly class="form-control-plaintext" id="login">
            </div>
        </div>
        <div class="mb-3 row">
            <label for="password" class="col-sm-2 col-form-label">Mot de passe</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" id="password">
            </div>
        </div>
    </form>
</div>
