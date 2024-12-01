<?php

include '../components/connect.php';

if(isset($_COOKIE['tutor_id'])){
   $tutor_id = $_COOKIE['tutor_id'];
}else{
   $tutor_id = '';
   header('location:login.php');
}

if(isset($_POST['delete'])){
   $delete_id = $_POST['assignment_id'];
   $delete_id = filter_var($delete_id, FILTER_SANITIZE_STRING);

   $verify_assignment = $conn->prepare("SELECT * FROM `assignments` WHERE id = ? AND tutor_id = ? LIMIT 1");
   $verify_assignment->execute([$delete_id, $tutor_id]);

   if($verify_assignment->rowCount() > 0){
      $delete_assignment_file = $conn->prepare("SELECT * FROM `assignments` WHERE id = ? LIMIT 1");
      $delete_assignment_file->execute([$delete_id]);
      $fetch_file = $delete_assignment_file->fetch(PDO::FETCH_ASSOC);
      
      // Check if the 'file' field exists before trying to unlink it
      if(isset($fetch_file['file']) && !empty($fetch_file['file'])){
          unlink('../uploaded_files/'.$fetch_file['file']);
      }
      $delete_assignment = $conn->prepare("DELETE FROM `assignments` WHERE id = ?");
      $delete_assignment->execute([$delete_id]);
      $message[] = 'Assignment deleted!';
   }else{
      $message[] = 'Assignment already deleted!';
   }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Assignments</title>

   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="../css/admin_style.css">

</head>
<body>

<?php include '../components/admin_header.php'; ?>

<section class="playlists">

   <h1 class="heading">Added Assignments</h1>

   <div class="box-container">
   
      <div class="box" style="text-align: center;">
         <h3 class="title" style="margin-bottom: .5rem;">Create New Assignment</h3>
         <a href="add_assignment.php" class="btn">Add Assignment</a>
      </div>

      <?php
         $select_assignments = $conn->prepare("SELECT * FROM `assignments` WHERE tutor_id = ? ORDER BY created_at DESC");
         $select_assignments->execute([$tutor_id]);
         if($select_assignments->rowCount() > 0){
         while($fetch_assignment = $select_assignments->fetch(PDO::FETCH_ASSOC)){
      ?>
      <div class="box">
         <div class="flex">
            <div><i class="fas fa-calendar"></i><span><?= $fetch_assignment['created_at']; ?></span></div>
         </div>
         <div class="file">
            <?php if(isset($fetch_assignment['file']) && !empty($fetch_assignment['file'])): ?>
                <a href="../uploaded_files/<?= $fetch_assignment['file']; ?>" target="_blank">Download File</a>
            <?php endif; ?>
         </div>
         <h3 class="title"><?= $fetch_assignment['title']; ?></h3>
         <p class="description"><?= $fetch_assignment['description']; ?></p>
         <form action="" method="post" class="flex-btn">
            <input type="hidden" name="assignment_id" value="<?= $fetch_assignment['id']; ?>">
            <a href="update_assignment.php?get_id=<?= $fetch_assignment['id']; ?>" class="option-btn">Update</a>
            <input type="submit" value="delete" class="delete-btn" onclick="return confirm('Delete this assignment?');" name="delete">
         </form>
         <a href="view_assignment.php?get_id=<?= $fetch_assignment['id']; ?>" class="btn">View Assignment</a>
      </div>
      <?php
         } 
      }      ?>

   </div>

</section>

<?php include '../components/footer.php'; ?>

<script src="../js/admin_script.js"></script>

</body>
</html>
