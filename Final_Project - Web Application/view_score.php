<?php
include 'components/connect.php';

// Check if the user is logged in
if (isset($_COOKIE['user_id'])) {
    $user_id = $_COOKIE['user_id'];
} else {
    $user_id = '';
    header('location:login.php'); // Redirect to login if not logged in
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>My Grades</title>

   <!-- font awesome cdn link -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link -->
   <link rel="stylesheet" href="../css/admin_style.css">
</head>
<body>

<?php include '../components/admin_header.php'; ?>

<!-- grades section starts -->
<section class="courses">

   <h1 class="heading">My Grades</h1>

   <div class="box-container">

      <?php
         // Query to fetch user's submissions and grades
         $select_grades = $conn->prepare("SELECT 
            submissions.id AS submission_id,
            submissions.file AS submission_file,
            submissions.grade AS submission_grade,
            assignments.title AS assignment_title
         FROM submissions
         INNER JOIN assignments ON submissions.assignment_id = assignments.id
         WHERE submissions.user_id = ?");
         $select_grades->execute([$user_id]);

         // Check if there are any submissions
         if ($select_grades->rowCount() > 0) {
            // Loop through each submission and display the data
            while ($fetch_grade = $select_grades->fetch(PDO::FETCH_ASSOC)) {
                $assignment_title = $fetch_grade['assignment_title'];
                $submission_file = $fetch_grade['submission_file'];
                $submission_grade = $fetch_grade['submission_grade'];

                echo '
                <div class="box">
                    <h3 class="title">Assignment: ' . $assignment_title . '</h3>
                    <a href="uploaded_submissions/' . $submission_file . '" class="inline-btn" target="_blank">Download Submission</a>
                    <p><strong>Grade:</strong> ' . (!empty($submission_grade) ? $submission_grade : 'Not graded yet') . '</p>
                </div>';
            }
         } else {
            // If no submissions found, display a message
            echo '<p class="empty">No submissions found!</p>';
         }
      ?>

   </div>

</section>
<!-- grades section ends -->

<?php include '../components/footer.php'; ?>

<script src="../js/admin_script.js"></script>
</body>
</html>
