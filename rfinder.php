<?php 
require_once ('dbconnection.php');

class rfinder{

    private $conn;
    public function __construct($connection){
        
        $this->conn = $connection;
    }

    public function getNumbers(){
        $query = "select *from numbers where group_id is NULL";
        $stmt = $this->conn->prepare($query);
        
        if($stmt->execute()){
            $numbers = $stmt->fetchAll(PDO::FETCH_ASSOC);

            return $numbers;
        }else{ return NULL; }


    }
    public function getNumberByGroup($id){
        $query = "select *from numbers where group_id = '$id'";
        $stmt = $this->conn->prepare($query);
        
        if($stmt->execute()){
            $numbers = $stmt->fetchAll(PDO::FETCH_ASSOC);

            return $numbers;
        }else{ return NULL; }


    }
 
    public function getGroupIdByName($groupName){

        $query = "select group_id from groups where group_name = :group_name";
        $stmt = $this->conn->prepare($query);
         
        $stmt->bindParam(':group_name',$groupName,PDO::PARAM_STR);
        if($stmt->execute()){
            $group_id = $stmt->fetchAll(PDO::FETCH_ASSOC);

            return $group_id;
        }else{ return NULL; }
    }

    public function updateNumber($number, $group_id){

        $query = " update numbers set group_id = :group_id where number = :number";

        $stmt = $this->conn->prepare($query);
    
        $stmt->bindParam(':number',$number,PDO::PARAM_INT);
        $stmt->bindParam(':group_id',$group_id,PDO::PARAM_INT);

        if($stmt->execute()){return true;  
        }else{ return false;}
    }
    public function validateNumber($number){

        $query = "select *from numbers where number =:number";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':number',$number,PDO::PARAM_STR);
        if($stmt->execute()){
            $numbers = $stmt->fetchAll(PDO::FETCH_ASSOC);
            return $numbers;
        }

    }
    public function addNumber($number){
        $stmt = $this->conn->prepare("insert into numbers (number) values (:number)");
        $stmt->bindParam(':number', $number);
       if($stmt->execute()){
        return true;
       }
    }

    public function validateEmail($email){

        $query = "select *from users where email =:email";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':email',$email,PDO::PARAM_STR);
        if($stmt->execute()){
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            return $result;
        }

    }
    public function register($email , $password ,$full_name ,$phone){

        $stmt = $this->conn->prepare("insert into  users (email ,password,full_name ,phone) values (:email ,:password ,:full_name ,:phone)");
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password', $password);
        $stmt->bindParam(':full_name', $full_name);
        $stmt->bindParam(':phone', $phone);
       if($stmt->execute()){
        return true;
       }
    }



}




?>