<?php

class PizzaBD extends Pizza
{
    private $_db;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_db = $cnx;
    }

    public function editPizza($champ, $id, $valeur)
    {
        try {
            $query = "update pizza set $champ ='$valeur' where id_pizza='$id'";
            $res = $this->_db->prepare($query);
            $res->execute();

        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    public function addPizza($champ, $valeur){
        try {
            $query = "insert into pizza (nom_pizza,prix) values ('',0,)";
            $res = $this->_db->prepare($query);            
            $res->execute();
            $query = "";
            $res = $this->_db->prepare($query);
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    public function deletePizza($id)
    {
        try {
            $query = "delete from pizza where id_pizza = :id";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id', $id);
            $res->execute();
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    public function getPizzaById($id)
    {
        try {
            $query = "select * from pizza where id_pizza = :id";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id', $id);
            $res->execute();
            $data = $res->fetch();
            return $data;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    public function getVueAllPizza()
    {
        try {
            $query = "select * from pizza order by id_pizza";
            $res = $this->_db->prepare($query);
            $res->execute();

            while ($data = $res->fetch()) {
                $_array[] = new Pizza($data);
            }
            if (!empty($_array)) {
                return $_array;
            } else {
                return null;
            }


        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

}
