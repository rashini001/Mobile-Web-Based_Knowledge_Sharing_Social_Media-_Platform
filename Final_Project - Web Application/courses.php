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

<section class="courses">
   <h1 class="heading">All Courses</h1>
   <div class="box-container">
      <?php
         $select_courses = $conn->prepare("SELECT * FROM `playlist` WHERE status = ? ORDER BY date DESC");
         $select_courses->execute(['active']);
         if($select_courses->rowCount() > 0){
            while($fetch_course = $select_courses->fetch(PDO::FETCH_ASSOC)){
               $course_id = $fetch_course['id'];

               $select_tutor = $conn->prepare("SELECT * FROM `tutors` WHERE id = ?");
               $select_tutor->execute([$fetch_course['tutor_id']]);
               $fetch_tutor = $select_tutor->fetch(PDO::FETCH_ASSOC);

               // Check enrollment
               $check_enrollment = $conn->prepare("SELECT * FROM `enrollments` WHERE user_id = ? AND playlist_id = ? AND status = 'approved'");
               $check_enrollment->execute([$user_id, $course_id]);
               $is_enrolled = $check_enrollment->rowCount() > 0;
      ?>
      <div class="box">
         <div class="tutor">
            <img src="uploaded_files/<?= $fetch_tutor['image']; ?>" alt="">
            <div>
               <h3><?= $fetch_tutor['name']; ?></h3>
               <span><?= $fetch_course['date']; ?></span>
            </div>
         </div>
         <img src="uploaded_files/<?= $fetch_course['thumb']; ?>" class="thumb" alt="">
         <h3 class="title"><?= $fetch_course['title']; ?></h3>
         <div class="flex-btn">
            
            <?php if ($is_enrolled): ?>
               <a href="playlist.php?get_id=<?= $course_id; ?>" class="inline-btn">View Playlist</a>
               <a href="view_assignment.php?get_id=<?= $course_id; ?>" class="inline-btn">View Assignments</a>
            <?php else: ?>
               <a href="request_enrollment.php?get_id=<?= $course_id; ?>" class="inline-btn">Request Enrollment</a>
            <?php endif; ?>
         </div>
      </div>
      <?php
            }
         } else {
            echo '<p class="empty">No courses added yet!</p>';
         }
      ?>
   </div>
</section>

<?php include 'components/footer.php'; ?>
<script src="js/script.js"></script>
</body>
</html>
