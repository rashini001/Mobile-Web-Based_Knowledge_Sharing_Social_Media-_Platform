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
   <title>Dashboard</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">

</head>
<body>

<?php include 'components/user_header.php'; ?>
<!-- quick select-->

<section class="quick-select">
   <h1 class="heading">Quick Options</h1>
   <div class="box-container">
      <div class="box" style="text-align: center;">
         <h3 class="title">please login or register</h3>
         <div class="flex-btn" style="padding-top: .5rem;">
            <a href="login.php" class="option-btn">Login</a>
            <a href="register.php" class="option-btn">Register</a>
         </div>
      </div>

      <div class="box">
         <h3 class="title">Top Categories</h3>
         <div class="flex">
            <a href="search_course.php?"><span>DevOps</span></a>
            <a href="#"><span>FullStack</span></a>
            <a href="#"><span>Mobile</span></a>
            <a href="#"><span>UI/UX</span></a>
            <a href="#"><span>Cloud</span></a>
            <a href="#"><span>BackEnd</span></a>
            <a href="#"><span>FrontEnd</span></a>
            <a href="#"><span>Networking</span></a>
         </div>
      </div>

      <div class="box">
         <h3 class="title">Popular Topics</h3>
         <div class="flex">
            <a href="#"><i class="fab fa-html5"></i><span>HTML</span></a>
            <a href="#"><i class="fab fa-css3"></i><span>CSS</span></a>
            <a href="#"><i class="fab fa-js"></i><span>javascript</span></a>
            <a href="#"><i class="fab fa-react"></i><span>react</span></a>
            <a href="#"><i class="fab fa-php"></i><span>PHP</span></a>
            <a href="#"><i class="fab fa-bootstrap"></i><span>bootstrap</span></a>
         </div>
      </div>

      <div class="box tutor">
         <h3 class="title">Become A Resource Person</h3>
         <p>"Join Us and Inspire the Next Generation of Software Engineers!"
Become a part of our growing community of experts dedicated to sharing knowledge and shaping future tech leaders. Let’s work together to bridge the gap between theory and practice, empowering learners to achieve their career goals. Start making an impact today!</p>
         <a href="admin/register.php" class="inline-btn">Get Access</a>
      </div>

   </div>

</section>

<!-- courses section -->

<section class="courses">

   <h1 class="heading">Latest Courses</h1>

   <div class="box-container">

      <p class="empty">no courses added yet!</p>

   </div>

   <div class="more-btn">
      <a href="courses.php" class="inline-option-btn">See More</a>
   </div>

</section>

<!-- footer section -->
<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>
   
</body>
</html>
