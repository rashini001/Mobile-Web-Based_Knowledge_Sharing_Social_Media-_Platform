<?php
include 'components/connect.php';

if(isset($_COOKIE['user_id'])){
   $user_id = $_COOKIE['user_id'];
}else{
   $user_id = '';
   header('location:login.php');
}

if(isset($_GET['get_id'])){
   $course_id = $_GET['get_id'];
} else {
   header('location:courses.php');
}

if($_SERVER['REQUEST_METHOD'] == 'POST'){
   $check_request = $conn->prepare("SELECT * FROM `enrollments` WHERE user_id = ? AND playlist_id = ?");
   $check_request->execute([$user_id, $course_id]);

   if($check_request->rowCount() > 0){
      $message[] = 'You have already requested enrollment!';
   } else {
      $request = $conn->prepare("INSERT INTO `enrollments` (user_id, playlist_id) VALUES (?, ?)");
      $request->execute([$user_id, $course_id]);
      $message[] = 'Enrollment request sent successfully!';
   }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Request Enrollment</title>
   <link rel="stylesheet" href="css/style.css">
</head>
<body>
<?php include 'components/user_header.php'; ?>
<section class="request-enrollment">
   <h1 class="heading">Request Enrollment</h1>
   <form action="" method="post" >
      <p class="empty">Are you sure you want to request enrollment for this course?</p>
      <button type="submit" class="inline-btn">Confirm Request</button>
   </form>
</section>
<?php include 'components/footer.php'; ?>
<script src="js/script.js"></script>
</body>
</html>
