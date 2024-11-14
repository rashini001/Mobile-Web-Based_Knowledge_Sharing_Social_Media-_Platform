<?php

include '../components/connect.php';

if(isset($_POST['submit'])){

   $id = unique_id();
   $name = $_POST['name'];
   $name = filter_var($name, FILTER_SANITIZE_STRING);
   $profession = $_POST['profession'];
   $profession = filter_var($profession, FILTER_SANITIZE_STRING);
   $email = $_POST['email'];
   $email = filter_var($email, FILTER_SANITIZE_EMAIL);
   $pass = $_POST['pass'];
   $cpass = $_POST['cpass'];

   // Validate name (alphabetical characters only)
   if (!preg_match("/^[a-zA-Z\s]+$/", $name)) {
      $message[] = 'Name can only contain letters and spaces!';
   }

   // Validate email format
   if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      $message[] = 'Invalid email format!';
   }

   // Validate password length (minimum 8 characters)
   if (strlen($pass) < 8) {
      $message[] = 'Password must be at least 8 characters long!';
   }

   // Validate password strength (letters, numbers, and special characters)
   if (!preg_match("/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/", $pass)) {
      $message[] = 'Password must include at least one letter, one number, and one special character!';
   }

   // Hash and sanitize passwords
   $pass = sha1($pass);
   $pass = filter_var($pass, FILTER_SANITIZE_STRING);
   $cpass = sha1($cpass);
   $cpass = filter_var($cpass, FILTER_SANITIZE_STRING);

   $image = $_FILES['image']['name'];
   $image = filter_var($image, FILTER_SANITIZE_STRING);
   $ext = pathinfo($image, PATHINFO_EXTENSION);
   $rename = unique_id().'.'.$ext;
   $image_size = $_FILES['image']['size'];
   $image_tmp_name = $_FILES['image']['tmp_name'];
   $image_folder = '../uploaded_files/'.$rename;

   // Validate image extension
   $allowed_extensions = ['jpg', 'jpeg', 'png', 'gif'];
   if (!in_array(strtolower($ext), $allowed_extensions)) {
      $message[] = 'Invalid image format! Only JPG, JPEG, PNG, and GIF are allowed.';
   }

   // Validate image size (limit to 2MB)
   if ($image_size > 2 * 1024 * 1024) {
      $message[] = 'Image size should not exceed 2MB!';
   }

   // Check if there are any validation errors
   if (!isset($message)) {
      $select_tutor = $conn->prepare("SELECT * FROM `tutors` WHERE email = ?");
      $select_tutor->execute([$email]);

      if($select_tutor->rowCount() > 0){
         $message[] = 'Email already taken!';
      } else {
         if($pass != $cpass){
            $message[] = 'Confirm password not matched!';
         } else {
            $insert_tutor = $conn->prepare("INSERT INTO `tutors`(id, name, profession, email, password, image) VALUES(?,?,?,?,?,?)");
            $insert_tutor->execute([$id, $name, $profession, $email, $cpass, $rename]);
            move_uploaded_file($image_tmp_name, $image_folder);
            $message[] = 'New tutor registered! Please login now';
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
   <link rel="stylesheet" href="../css/admin_style.css">
</head>
<body style="padding-left: 0;">

<?php
if(isset($message)){
   foreach($message as $message){
      echo '
      <div class="message form">
         <span>'.$message.'</span>
         <i class="fas fa-times" onclick="this.parentElement.remove();"></i>
      </div>
      ';
   }
}
?>

<!-- register section starts  -->

<section class="form-container">
   <form class="register" action="" method="post" enctype="multipart/form-data">
      <h3>Register Here</h3>
      <div class="flex">
         <div class="col">
            <p>Your name</p>
            <input type="text" name="name" placeholder="Enter your name" maxlength="50" required class="box">
            <p>Your profession</p>
            <select name="profession" class="box" required>
               <option value="" disabled selected>-- Select your profession --</option>
               <option value="developer">Developer</option>
               <option value="designer">UI/UX Designer</option>
               <option value="mobile">Mobile Developer</option>
               <option value="front">Front-end</option>
               <option value="back">Back-end</option>
               <option value="full">Fullstack</option>
               <option value="network">Network</option>
               <option value="cloud">Cloud Engineer</option>
            </select>
            <p>Your email</p>
            <input type="email" name="email" placeholder="Enter your email" maxlength="50" required class="box">
         </div>
         <div class="col">
            <p>Your password</p>
            <input type="password" name="pass" placeholder="Enter your password" minlength="8" maxlength="20" required class="box">
            <p>Confirm password</p>
            <input type="password" name="cpass" placeholder="Confirm your password" minlength="8" maxlength="20" required class="box">
            <p>Select image</p>
            <input type="file" name="image" accept="image/*" required class="box">
         </div>
      </div>
      <p class="link">Already have an account? <a href="login.php">Login now</a></p>
      <input type="submit" name="submit" value="Register now" class="btn">
   </form>
</section>

<script>
let darkMode = localStorage.getItem('dark-mode');
let body = document.body;

const enableDarkMode = () => {
   body.classList.add('dark');
   localStorage.setItem('dark-mode', 'enabled');
}

const disableDarkMode = () => {
   body.classList.remove('dark');
   localStorage.setItem('dark-mode', 'disabled');
}

if (darkMode === 'enabled') {
   enableDarkMode();
} else {
   disableDarkMode();
}
</script>
   
</body>
</html>
