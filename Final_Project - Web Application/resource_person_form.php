<?php
include 'components/connect.php';

if(isset($_COOKIE['user_id'])){
   $user_id = $_COOKIE['user_id'];
}else{
   $user_id = '';
   header('location:login.php');
   exit();
}

$message = []; // To store success/error messages

if(isset($_POST['submit'])){
   // Validate and sanitize inputs
   $name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);
   $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);
   $profession = filter_input(INPUT_POST, 'profession', FILTER_SANITIZE_STRING);
   $qualification = filter_input(INPUT_POST, 'qualification', FILTER_SANITIZE_STRING);
   $expertise = filter_input(INPUT_POST, 'expertise', FILTER_SANITIZE_STRING);
   $motivation = filter_input(INPUT_POST, 'motivation', FILTER_SANITIZE_STRING);
   $links = filter_input(INPUT_POST, 'links', FILTER_SANITIZE_STRING);
   
   // File upload handling
   $image = $_FILES['image']['name'];
   $image_tmp = $_FILES['image']['tmp_name'];
   $image_size = $_FILES['image']['size'];
   $image_ext = strtolower(pathinfo($image, PATHINFO_EXTENSION));
   
   $cv = $_FILES['cv']['name'];
   $cv_tmp = $_FILES['cv']['tmp_name'];
   $cv_size = $_FILES['cv']['size'];
   $cv_ext = strtolower(pathinfo($cv, PATHINFO_EXTENSION));
   
   // Validation
   if(empty($name) || empty($email) || empty($profession) || empty($qualification) || 
      empty($expertise) || empty($motivation) || empty($cv)) {
      $message[] = 'Please fill in all required fields!';
   } elseif(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      $message[] = 'Invalid email format!';
   } elseif($image && !in_array($image_ext, ['jpg', 'jpeg', 'png', 'gif'])) {
      $message[] = 'Image must be JPG, JPEG, PNG or GIF!';
   } elseif($image && $image_size > 2000000) {
      $message[] = 'Image size must be less than 2MB!';
   } elseif($cv_ext != 'pdf') {
      $message[] = 'CV must be a PDF file!';
   } elseif($cv_size > 5000000) {
      $message[] = 'CV size must be less than 5MB!';
   } else {
      // Generate unique filenames
      $unique_id = uniqid();
      $image_name = $image ? $unique_id . '.' . $image_ext : '';
      $cv_name = $unique_id . '_cv.' . $cv_ext;
      
      // Move uploaded files
      if($image) {
         move_uploaded_file($image_tmp, 'uploads/images/' . $image);
      }
      move_uploaded_file($cv_tmp, 'uploads/cv/' . $cv);
      
      try {
         // Check if user already applied
         $check_application = $conn->prepare("SELECT * FROM resource_applications WHERE user_id = ?");
         $check_application->execute([$user_id]);
         
         if($check_application->rowCount() > 0) {
            $message[] = 'You have already submitted an application!';
         } else {
            // Insert application into database
            $insert_application = $conn->prepare("INSERT INTO resource_applications 
               (user_id, name, email, profession, qualification, expertise, motivation, links, image, cv, status, applied_at) 
               VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', NOW())");
            
            $insert_application->execute([
               $user_id,
               $name,
               $email,
               $profession,
               $qualification,
               $expertise,
               $motivation,
               $links,
               $image,
               $cv
            ]);
            
            header('location:application_success.php');
            exit();
         }
      } catch(PDOException $e) {
         $message[] = 'Application failed: ' . $e->getMessage();
      }
   }
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Become a Resource Person</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="css/style.css">
   <link rel="stylesheet" href="css/form_style.css">
</head>
<body>

<?php include 'components/user_header.php'; ?>

<section class="form-container">
   <form action="" method="post" enctype="multipart/form-data" class="register">
      <h3>Resource Person Application</h3>
      <div class="flex">
         <div class="col">
            <p>Your Name <span>*</span></p>
            <input type="text" name="name" placeholder="Enter your full name" maxlength="50" required class="box">
            
            <p>Your Email <span>*</span></p>
            <input type="email" name="email" placeholder="Enter your email" maxlength="50" required class="box">
            
            <p>Your Profession <span>*</span></p>
            <input type="text" name="profession" placeholder="e.g. Senior Developer, Professor, etc." maxlength="100" required class="box">
            <p>Profile Picture</p>
            <input type="file" name="image" accept="image/*" class="box">
            </div>
         <div class="col">
            <p>Your Qualification <span>*</span></p>
            <select name="qualification" required class="box">
               <option value="" disabled selected>Select highest qualification</option>
               <option value="BSc">Bachelor's Degree</option>
               <option value="MSc">Master's Degree</option>
               <option value="PhD">PHD</option>
               <option value="Professional">Professional Certification</option>
               <option value="Other">Other</option>
            </select>
            
            <p>Expertise Area <span>*</span></p>
            <input type="text" name="expertise" placeholder="e.g. Web Development, Data Science" maxlength="100" required class="box">
            
            <p>Upload Your CV (PDF) <span>*</span></p>
            <input type="file" name="cv" accept=".pdf" required class="box">
            
            </div>
      </div>
      <p>Why do you want to become a resource person? <span>*</span></p>
      <textarea name="motivation" placeholder="Write your motivation here..." maxlength="1000" required class="box"></textarea>
      
      <p>Links to your professional profiles (LinkedIn, GitHub, etc.)</p>
      <input type="text" name="links" placeholder="Enter URLs separated by commas" maxlength="500" class="box">
      
      <input type="submit" name="submit" value="Submit Application" class="btn">
   </form>
</section>

<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>
<script src="js/form_validation.js"></script>

</body>
</html>