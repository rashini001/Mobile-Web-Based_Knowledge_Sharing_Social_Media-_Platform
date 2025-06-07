-<?php
include 'components/connect.php';

if(isset($_COOKIE['user_id'])){
   $user_id = $_COOKIE['user_id'];
}else{
   $user_id = '';
   header('location:login.php');
   exit();
}
$notifications = [];
$stmt = $conn->prepare("SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC");
$stmt->execute([$user_id]);
$notifications = $stmt->fetchAll();


?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Notifications</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">
  
</head>
<body>

<?php include 'components/user_header.php'; ?>

<!-- notifications section starts  -->
<section class="notifications">

   <h1 class="heading">Your Notifications</h1>
   

   <div class="box-container">

      <?php if(empty($notifications)): ?>
         <div class="empty">
            <img src="images/empty-notification.png" alt="">
            <p>No notifications yet!</p>
         </div>
      <?php else: ?>
         <?php foreach($notifications as $notification): ?>
            <div class="box <?= $notification['is_read'] ? '' : 'unread' ?>">
               <div class="icon">
                  <?php 
                     switch($notification['type']){
                        case 'message': echo '<i class="fas fa-envelope"></i>'; break;
                        case 'alert': echo '<i class="fas fa-exclamation-circle"></i>'; break;
                        case 'update': echo '<i class="fas fa-bell"></i>'; break;
                        default: echo '<i class="fas fa-bell"></i>';
                     }
                  ?>
               </div>
               <div class="content">
                  <p><?= htmlspecialchars($notification['message']) ?></p>
                  <span class="date"><i class="fas fa-clock"></i> <?= $notification['created_at'] ?></span>
               </div>

              <?php if (strpos($notification['message'], 'Congratulations! You have been approved as a resource person.') !== false): ?>
                 <a href="admin/register.php" class="inline-btn register-btn">Register</a>
                <?php endif; ?>
            </div>
         <?php endforeach; ?>
      <?php endif; ?>
   </div>
</section>



<?php include 'components/footer.php'; ?>  
<script src="js/script.js"></script>

</body>
</html>