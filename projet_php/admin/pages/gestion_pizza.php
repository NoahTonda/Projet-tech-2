<h2>Accueil</h2>

<?php
$fl = new PizzaBD($cnx);
$pizza = $fl->getVueAllPizza();
$nbr = count($pizza);

?>
<div class="subdivision">
    <div class="subdiv1">
        <input class="form-control" id="filtre" type="text" placeholder="Filtrer"><br/>
        <p id="ajouter_pizza" class="txtGras txtItalic red">Nouvelle pizza</p>
        <div id="nouveau_td"></div>
        <table class="table table-striped table-hover" id="tableau_pizza">
            <thead>
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Pizza</th>
                <th scope="col">Prix</th>

            </tr>
            </thead>
            <tbody  id="table_pizza">
            <?php

            for ($i = 0; $i < $nbr; $i++) {
                ?>

                <tr id="<?php print $pizza[$i]->id_pizza;?>">
                    <th scope="row"><?php print $pizza[$i]->id_pizza; ?></th>
                    <td contenteditable="true" id="<?php print $pizza[$i]->id_pizza; ?>"
                        name="nom_fleur"><?php print $pizza[$i]->nom_fleur; ?></td>
                    <td contenteditable="true" id="<?php print $pizza[$i]->id_pizza; ?>"
                        name="prix_fleur"><?php print $pizza[$i]->prix_fleur; ?></td>
                    <td><img class="delete" src="./images/delete.jpg" alt="delete" id="<?php print $pizza[$i]->id_pizza; ?>"></td>
                </tr>
                <?php
            }
            ?>

            </tbody>
        </table>
    </div>
    <div class="subdiv2">
        <span id="illustration"></span>
    </div>
</div>

