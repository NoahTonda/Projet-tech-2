<?php
class AdminBD extends Admin {
    private $_db;
    private $_array = array();

    public function __construct($cnx){
        $this->_db = $cnx;
    }

    public function isAdmin($login, $password){
        try{
            $query = "select verifier_connexion(:login,:password) as retour";
            $res = $this->_db->prepare($query);
            $res->bindValue(':login',$login);
            $res->bindValue(':password',$password);
            $res->execute();
            return $res->fetchColumn(0);

        }catch(PDOException $e){
            print "<br>Echec : ".$e->getMessage();
        }
    }

    public function getAdmin($login,$password)
    {
        try {
            $query = "select * from admin where login=:login and password = :password";
            $res = $this->_db->prepare($query);
            $res->bindValue(':login', $login);
            $res->bindValue(':password', $password);
            $res->execute();
            $data = $res->fetch();
            if (!empty($data)) {
                $_array[] = new Admin($data);
                // var_dump($_array);
                return $_array;
            } else {
                return null;
            }

        } catch (PDOException $e) {
            print "<br>Echec : " . $e->getMessage();
        }
    }

}