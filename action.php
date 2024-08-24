<?php
require_once("rfinder.php");
$register = new rfinder($connection);

if(isset($_POST["btn_login"]) && $_GET['form']=='login')
{
    print_r($_POST);
}



if(isset($_POST["btn_register"]) && $_GET['form']=='register')
{
$email = $_POST['email'];
$password = $_POST['password'];
$full_name = $_POST['fname'];
$phone = $_POST['contact'];

if(empty($register->validateEmail($email))){
    $register->register($email,$password,$full_name,$phone);

    header("location:login.php");

}else{

    echo " Email Already Exist";
}



}

?>
