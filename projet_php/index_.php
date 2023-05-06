<!doctype html>
<?php
//index public
session_start();
include ('./admin/lib/php/admin_liste_include.php');

//include ('./admin/lib/php/admin_liste_include.php');
//$cnx = Connexion::getInstance($dsn,$user,$password);
?>
<html>
<head>
    <style>
        body {
            background-image: url('./admin/images/pizza.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
            color: white;
        }
    </style>
    <title>Takeaway pizza</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="./admin/lib/js/fonctions_jquery.js"></script>
    <link rel="stylesheet" href="admin/lib/css/style.css"/>
    <link rel="stylesheet" href="admin/lib/css/custom.css"/>
</head>

<body>
<div id="page" class="container">
    <header class="img_header"></header>
    <section id="colGauche">
        <nav>
            <?php
            $path = "./lib/php/menu_public.php";
            if (file_exists($path)) {
                include ($path);
            }
            ?>
        </nav>
    </section>
    <section id="contenu">
        <div id="main">
            <?php
            if (!isset($_SESSION['page'])) {
                $_SESSION['page'] = "accueil.php";
            }
            if (isset($_GET['page'])) {
                $_SESSION['page'] = $_GET['page'];
            }
            $path = "./pages/" . $_SESSION['page'];
            if (file_exists($path)) {
                include ($path);
            } else {
                include ("./pages/page404.php");
            }
            ?>
        </div>
    </section>

</div>
<footer class="footer mt-auto py-3 bg-light">
    <div class="container">
        <span class="text-muted">Projet Noah</span>
    </div>
</footer>
</body>
</html>