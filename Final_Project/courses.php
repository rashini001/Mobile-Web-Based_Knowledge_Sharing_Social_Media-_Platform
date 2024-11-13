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
   <title>courses</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">

</head>
<body>

<?php include 'components/user_header.php'; ?>

<!-- courses section-->

<section class="courses">

   <h1 class="heading">All Courses</h1>

   <div class="box-container">
      <div class="box">
      <?php
        
         echo '<p class="empty">no courses added yet!</p>';
     
      ?>

   </div>

</section>


<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>
   
</body>
</html>