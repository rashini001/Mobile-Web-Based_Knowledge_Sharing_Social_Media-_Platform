<?php
include 'components/connect.php';

if(isset($_COOKIE['user_id']) && isset($_COOKIE['user_name'])){
   $user_id = $_COOKIE['user_id'];
   $user_name = $_COOKIE['user_name'];  // Fetch user_name from cookies
}else{
   $user_id = '';
   $user_name = '';
}

$select_likes = $conn->prepare("SELECT * FROM `likes` WHERE user_id = ?");
$select_likes->execute([$user_id]);
$total_likes = $select_likes->rowCount();

$select_comments = $conn->prepare("SELECT * FROM `comment` WHERE user_id = ?");
$select_comments->execute([$user_id]);
$total_comments = $select_comments->rowCount();

$select_bookmark = $conn->prepare("SELECT * FROM `bookmark` WHERE user_id = ?");
$select_bookmark->execute([$user_id]);
$total_bookmarked = $select_bookmark->rowCount();

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
   <style>
      /* Notification styling */
      .welcome-notification {
         position: fixed;
         top: 10%;
         left: 50%;
         transform: translateX(-50%);
         background-color: #003a4d;
         color: white;
         padding: 15px 30px;
         border-radius: 5px;
         font-size: 18px;
         z-index: 1000;
         display: none;
         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
         animation: slide-in 1s ease-out forwards, fade-out 3s 4s forwards;
      }

      @keyframes slide-in {
         0% { transform: translateX(-50%) translateY(-100px); }
         100% { transform: translateX(-50%) translateY(0); }
      }

      @keyframes fade-out {
         0% { opacity: 1; }
         100% { opacity: 0; }
      }

      .quick-select {
         margin-top: 30px;
      }
   </style>
</head>
<body>

<?php include 'components/user_header.php'; ?>

<!-- Welcome Notification -->
<?php
   if($user_id != '' && $user_name != ''){  
      echo "<div class='welcome-notification'>Welcome, " . htmlspecialchars($user_name) . ". Enjoy Your New Journey with Us!</div>";
   }
?>

<section class="quick-select">

   <h1 class="heading">Quick Options</h1>

   <div class="box-container">

      <?php
         if($user_id != '' && $user_name != ''){  // Ensure both cookies are set
      ?>
      <div class="box">
         <h3 class="title"><i class="fa-solid fa-smile-beam"></i> Welcome, <?= htmlspecialchars($user_name); ?>!</h3>  
         <p>Your learning journey continues here! Dive into your content and make today count.</p>
      </div>
      <?php
         } else { 
      ?>
      <div class="box" style="text-align: center;">
         <h3 class="title">Please login or register</h3>
         <div class="flex-btn" style="padding-top: .5rem;">
            <a href="login.php" class="option-btn">Login</a>
            <a href="register.php" class="option-btn">Register</a>
         </div>
      </div>
      <?php
      }
      ?>

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
            <a href="#"><i class="fab fa-js"></i><span>Javascript</span></a>
            <a href="#"><i class="fab fa-react"></i><span>React</span></a>
            <a href="#"><i class="fab fa-php"></i><span>PHP</span></a>
            <a href="#"><i class="fab fa-java"></i><span>Java</span></a>
         </div>
      </div>

   </div>

</section>

<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>

<script>
   // Show the welcome notification when the page loads
   document.addEventListener('DOMContentLoaded', function() {
      const notification = document.querySelector('.welcome-notification');
      if(notification) {
         notification.style.display = 'block';
      }
   });
</script>
   
</body>
</html>
