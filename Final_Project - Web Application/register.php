<?php

include 'components/connect.php';

if(isset($_COOKIE['user_id'])){
   $user_id = $_COOKIE['user_id'];
}else{
   $user_id = '';
}

$message = []; // Ensure $message is initialized as an array

if(isset($_POST['submit'])){

   $id = unique_id();
   $name = trim($_POST['name']);
   $name = filter_var($name, FILTER_SANITIZE_STRING);

   if(strlen($name) < 3 || strlen($name) > 50) {
      $message[] = 'Name must be between 3 and 50 characters.';
   }

   $email = trim($_POST['email']);
   $email = filter_var($email, FILTER_VALIDATE_EMAIL);
   if(!$email) {
      $message[] = 'Invalid email format.';
   }

   $pass = $_POST['pass'];
   $cpass = $_POST['cpass'];

   if(strlen($pass) < 8 || !preg_match("/^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@\$!%*?&#])[A-Za-z\d@\$!%*?&#]{8,}$/", $pass)) {
      $message[] = 'Password must be at least 8 characters, include one uppercase letter, one number, and one special character.';
   }

   $pass_hashed = sha1($pass);
   $pass_hashed = filter_var($pass_hashed, FILTER_SANITIZE_STRING);

   $cpass_hashed = sha1($cpass);
   $cpass_hashed = filter_var($cpass_hashed, FILTER_SANITIZE_STRING);

   if($pass !== $cpass) {
      $message[] = 'Passwords do not match.';
   }

   $image = $_FILES['image']['name'];
   $image = filter_var($image, FILTER_SANITIZE_STRING);
   $allowed_extensions = ['jpg', 'jpeg', 'png', 'gif'];
   $ext = pathinfo($image, PATHINFO_EXTENSION);

   if(!in_array($ext, $allowed_extensions)) {
      $message[] = 'Only JPG, JPEG, PNG, and GIF files are allowed.';
   }

   $rename = unique_id().'.'.$ext;
   $image_size = $_FILES['image']['size'];
   $image_tmp_name = $_FILES['image']['tmp_name'];
   $image_folder = 'uploaded_files/'.$rename;

   if($image_size > 2 * 1024 * 1024) { // 2MB limit
      $message[] = 'Image size should not exceed 2MB.';
   }

   if(empty($message)) {
      $select_user = $conn->prepare("SELECT * FROM `users` WHERE email = ?");
      $select_user->execute([$email]);

      if($select_user->rowCount() > 0) {
         $message[] = 'Email already taken!';
      } else {
         $insert_user = $conn->prepare("INSERT INTO `users`(id, name, email, password, image) VALUES(?,?,?,?,?)");
         $insert_user->execute([$id, $name, $email, $pass_hashed, $rename]);
         
         if(move_uploaded_file($image_tmp_name, $image_folder)) {
            $verify_user = $conn->prepare("SELECT * FROM `users` WHERE email = ? AND password = ? LIMIT 1");
            $verify_user->execute([$email, $pass_hashed]);
            $row = $verify_user->fetch(PDO::FETCH_ASSOC);

            if($verify_user->rowCount() > 0) {
               setcookie('user_id', $row['id'], time() + 60*60*24*30, '/');
               header('location:home.php');
            } else {
               $message[] = 'Registration failed. Please try again.';
            }
         } else {
            $message[] = 'Failed to upload the image.';
         }
      }
   }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Register</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">
</head>
<body>

<?php include 'components/user_header.php'; ?>

<section class="form-container">

   <form class="register" action="" method="post" enctype="multipart/form-data">
      <h3>Create your account</h3>
      <?php
      if(!empty($message) && is_array($message)){
         foreach($message as $msg){
            echo '<p class="error-msg">'.htmlspecialchars($msg).'</p>';
         }
      }
      ?>
      <div class="flex">
         <div class="col">
            <p>Your name </p>
            <input type="text" name="name" placeholder="Enter your name" maxlength="50" required class="box">
            <p>Your email </p>
            <input type="email" name="email" placeholder="Enter your email" maxlength="50" required class="box">
         </div>
         <div class="col">
            <p>Your password </p>
            <input type="password" name="pass" placeholder="Enter your password" maxlength="20" required class="box">
            <p>Confirm password </p>
            <input type="password" name="cpass" placeholder="Confirm your password" maxlength="20" required class="box">
         </div>
      </div>
      <p>Select image </p>
      <input type="file" name="image" accept="image/*" required class="box">
      <p class="link">Already have an account? <a href="login.php">Login now</a></p>
      <input type="submit" name="submit" value="Register now" class="btn">
   </form>

</section>

<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>
   
</body>
</html>
