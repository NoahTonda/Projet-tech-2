<?php
//Nous sommes dans l'index admin
if(file_exists('./lib/php/dbPgConnect.php')){
    require 'lib/php/dbPgConnect.php';
    require 'lib/php/classes/Autoloader.class.php';
    Autoloader::register();
    $cnx = Connexion::getInstance($dsn,$user,$password);
}else {

    if(file_exists('./admin/lib/php/dbPgConnect.php')){
        require 'admin/lib/php/dbPgConnect.php';
        require 'admin/lib/php/classes/Autoloader.class.php';
        Autoloader::register();
        $cnx = Connexion::getInstance($dsn,$user,$password);
    }
}