<?php
include 'components/connect.php';

if(isset($_COOKIE['user_id'])){
   $user_id = $_COOKIE['user_id'];
}else{
   $user_id = '';
   header('location:login.php');
   exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Application Submitted Successfully</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">
   <link rel="stylesheet" href="css/form_style.css">

</head>
<body>

<?php include 'components/user_header.php'; ?>

<section class="success-container">
   <div class="success-box">
      <div class="checkmark-circle">
         <div class="checkmark"></div>
      </div>
      <h2>Application Submitted Successfully!</h2>
      <p>Thank you for applying to become a Resource Person. Our admin team will review your qualifications and get back to you soon.</p>
      
      <div class="admin-message">
         <h3>What happens next?</h3>
         <p>Our admin team will:</p>
         <ul>
            <li>Review your qualifications and experience</li>
            <li>Verify your documents</li>
            <li>Assess your expertise area</li>
         </ul>
         <p>We'll notify you when the review is complete. If approved, you can become a resource person and start sharing your knowledge.</p>
      </div>
      
      <a href="index.php" class="btn">Return to Home</a>
   </div>
</section>

<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>

</body>
</html>