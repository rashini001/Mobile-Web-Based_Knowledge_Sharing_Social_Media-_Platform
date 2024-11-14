<?php

include 'components/connect.php';

if(isset($_COOKIE['user_id'])){
   $user_id = $_COOKIE['user_id'];
}else{
   $user_id = '';
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>resource people</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">

</head>
<body>

<?php include 'components/user_header.php'; ?>

<!-- teachers section -->
<section class="teachers">

   <h1 class="heading">Experties</h1>

   <form action="search_tutor.php" method="post" class="search-tutor">
      <input type="text" name="search_tutor" maxlength="100" placeholder="search resource person..." required>
      <button type="submit" name="search_tutor_btn" class="fas fa-search"></button>
   </form>

   <div class="box-container">

      <div class="box offer">
         <h3>Become A Resource Person</h3>
         <p>"Join Us and Inspire the Next Generation of Software Engineers!"
Become a part of our growing community of experts dedicated to sharing knowledge and shaping future tech leaders. Let’s work together to bridge the gap between theory and practice, empowering learners to achieve their career goals. Start making an impact today!</p>
         <a href="admin/register.php" class="inline-btn">Get Access</a>
      </div>

   </div>

</section>


<?php include 'components/footer.php'; ?>    
<script src="js/script.js"></script>
   
</body>
</html>