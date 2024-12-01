<?php

include '../components/connect.php';

if(isset($_COOKIE['tutor_id'])){
   $tutor_id = $_COOKIE['tutor_id'];
}else{
   $tutor_id = '';
   header('location:login.php');
}

if(isset($_POST['submit'])){

   $id = unique_id();
   $playlist_id = $_POST['playlist_id'];
   $playlist_id = filter_var($playlist_id, FILTER_SANITIZE_STRING);
   $title = $_POST['title'];
   $title = filter_var($title, FILTER_SANITIZE_STRING);
   $description = $_POST['description'];
   $description = filter_var($description, FILTER_SANITIZE_STRING);

   // Handle image upload
   $image = $_FILES['image']['name'];
   $image = filter_var($image, FILTER_SANITIZE_STRING);
   $image_ext = pathinfo($image, PATHINFO_EXTENSION);
   $image_rename = unique_id().'.'.$image_ext;
   $image_tmp_name = $_FILES['image']['tmp_name'];
   $image_folder = '../uploaded_files/'.$image_rename;

   // Handle PDF upload
   $pdf = $_FILES['pdf']['name'];
   $pdf = filter_var($pdf, FILTER_SANITIZE_STRING);
   $pdf_ext = pathinfo($pdf, PATHINFO_EXTENSION);
   $pdf_rename = unique_id().'.'.$pdf_ext;
   $pdf_tmp_name = $_FILES['pdf']['tmp_name'];
   $pdf_folder = '../uploaded_files/'.$pdf_rename;

   // Insert data into the database
   $add_assignment = $conn->prepare("INSERT INTO `assignments`(id, playlist_id, tutor_id, title, description, image, pdf) VALUES(?,?,?,?,?,?,?)");
   $add_assignment->execute([$id, $playlist_id, $tutor_id, $title, $description, $image_rename, $pdf_rename]);

   // Move uploaded files
   move_uploaded_file($image_tmp_name, $image_folder);
   move_uploaded_file($pdf_tmp_name, $pdf_folder);

   $message[] = 'New assignment added!';
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Add Assignment</title>

   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="../css/admin_style.css">

</head>
<body>

<?php include '../components/admin_header.php'; ?>
   
<section class="playlist-form">

   <h1 class="heading">Add Assignment</h1>

   <form action="" method="post" enctype="multipart/form-data">
      <p>Select Playlist <span>*</span></p>
      <select name="playlist_id" class="box" required>
         <option value="" selected disabled>-- select playlist</option>
         <?php
            $select_playlists = $conn->prepare("SELECT * FROM `playlist` WHERE tutor_id = ?");
            $select_playlists->execute([$tutor_id]);
            while($fetch_playlist = $select_playlists->fetch(PDO::FETCH_ASSOC)){
               echo '<option value="'.$fetch_playlist['id'].'">'.$fetch_playlist['title'].'</option>';
            }
         ?>
      </select>
      <p>Assignment Title <span>*</span></p>
      <input type="text" name="title" maxlength="100" required placeholder="Enter assignment title" class="box">
      <p>Assignment Description <span>*</span></p>
      <textarea name="description" class="box" required placeholder="Write description" maxlength="1000" cols="30" rows="10"></textarea>
      <p>Assignment Image <span>*</span></p>
      <input type="file" name="image" accept="image/*" required class="box">
      <p>Assignment PDF <span>*</span></p>
      <input type="file" name="pdf" accept="application/pdf" required class="box">
      <input type="submit" value="Add Assignment" name="submit" class="btn">
   </form>

</section>

<?php include '../components/footer.php'; ?>

<script src="../js/admin_script.js"></script>

</body>
</html>
