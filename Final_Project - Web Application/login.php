<?php

include 'components/connect.php';

if(isset($_COOKIE['user_id'])){
   $user_id = $_COOKIE['user_id'];
}else{
   $user_id = '';
}

// Function to implement rate limiting
function isRateLimited($conn, $email, $timeLimit = 300, $maxAttempts = 3) {
   $currentTime = time();
   
   // Check for recent failed login attempts within the time window
   $stmt = $conn->prepare("SELECT COUNT(*) as attempt_count FROM `login_attempts` WHERE email = ? AND attempt_time > ?");
   $stmt->execute([$email, $currentTime - $timeLimit]);
   $result = $stmt->fetch(PDO::FETCH_ASSOC);

   return $result['attempt_count'] >= $maxAttempts;
}

// Log failed login attempt
function logFailedAttempt($conn, $email) {
   $currentTime = time();
   $stmt = $conn->prepare("INSERT INTO `login_attempts` (email, attempt_time) VALUES (?, ?)");
   $stmt->execute([$email, $currentTime]);
}

// Get the number of failed attempts
function getFailedAttempts($conn, $email, $timeLimit = 300) {
   $currentTime = time();
   $stmt = $conn->prepare("SELECT COUNT(*) as attempt_count FROM `login_attempts` WHERE email = ? AND attempt_time > ?");
   $stmt->execute([$email, $currentTime - $timeLimit]);
   $result = $stmt->fetch(PDO::FETCH_ASSOC);

   return $result['attempt_count'];
}

if(isset($_POST['submit'])){

   $email = $_POST['email'];
   $email = filter_var($email, FILTER_SANITIZE_STRING);
   $pass = sha1($_POST['pass']);
   $pass = filter_var($pass, FILTER_SANITIZE_STRING);

   // Check if the user is rate-limited
   if (isRateLimited($conn, $email)) {
      $message[] = 'Too many failed login attempts. Your account is temporarily locked. Please try again later.';
   } else {
      $select_user = $conn->prepare("SELECT * FROM `users` WHERE email = ? AND password = ? LIMIT 1");
      $select_user->execute([$email, $pass]);
      $row = $select_user->fetch(PDO::FETCH_ASSOC);
      
      if($select_user->rowCount() > 0){
         // Successful login, set cookies
         setcookie('user_id', $row['id'], time() + 60*60*24*30, '/');  // User ID cookie for 30 days
         setcookie('user_name', $row['name'], time() + 60*60*24*30, '/');  // User Name cookie for 30 days
         
         header('location:home.php');
         exit();
      }else{
         // Log the failed attempt
         logFailedAttempt($conn, $email);
         $attemptsLeft = 5 - getFailedAttempts($conn, $email);

         if ($attemptsLeft > 0) {
            $message[] = 'Incorrect email or password! You have ' . $attemptsLeft . ' more attempt(s) before your account is temporarily locked.';
         } else {
            $message[] = 'Incorrect email or password! Your account is now locked due to too many failed attempts. Please try again later.';
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
   <title>Login</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">
</head>
<body>

<?php include 'components/user_header.php'; ?>

<section class="form-container">

   <form action="" method="post" enctype="multipart/form-data" class="login">
      <h3>Welcome back!</h3>
      <p>Your email</p>
      <input type="email" name="email" placeholder="Enter your email" maxlength="50" required class="box">
      <p>Your password</p>
      <input type="password" name="pass" placeholder="Enter your password" maxlength="20" required class="box">
      <p class="link">Don't have an account? <a href="register.php">Register now</a></p>
      <input type="submit" name="submit" value="Login now" class="btn">
   </form>

   <?php
      if(!empty($message) && is_array($message)){
         foreach($message as $msg){
            echo '<p class="error-msg">'.htmlspecialchars($msg).'</p>';
         }
      }
   ?>

</section>

<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>
   
</body>
</html>
