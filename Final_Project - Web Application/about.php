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
   <title>about</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">

</head>
<body>

<?php include 'components/user_header.php'; ?>

<!-- about section -->

<section class="about">

   <div class="row">

      <div class="image">
         <img src="images/about-img.svg" alt="">
      </div>

      <div class="content">
         <h3>"Empowering Learning, Connecting Minds"</h3>
         <p>We are a vibrant knowledge-sharing platform where students and experts come together to learn, grow, and innovate. Our mission is to bridge the gap between education and real-world experience, fostering a collaborative community that encourages lifelong learning. Whether you're here to share your expertise or expand your skills, our platform offers the tools and connections you need to succeed in the ever-evolving world of software engineering.</p>
         <a href="courses.php" class="inline-btn">View Courses</a>
      </div>

   </div>

   <div class="box-container">

      <div class="box">
         <i class="fas fa-graduation-cap"></i>
         <div>
            <h3>+1k</h3>
            <span>Online Courses</span>
         </div>
      </div>

      <div class="box">
         <i class="fas fa-user-graduate"></i>
         <div>
            <h3>+25k</h3>
            <span>Brilliants Students</span>
         </div>
      </div>

      <div class="box">
         <i class="fas fa-chalkboard-user"></i>
         <div>
            <h3>+5k</h3>
            <span>Expert Resource People</span>
         </div>
      </div>

      <div class="box">
         <i class="fas fa-star"></i>
         <div>
            <h3>100%</h3>
            <span>Satisfication</span>
         </div>
      </div>

   </div>

</section>

<?php include 'components/footer.php'; ?>
<script src="js/script.js"></script>
   
</body>
</html>