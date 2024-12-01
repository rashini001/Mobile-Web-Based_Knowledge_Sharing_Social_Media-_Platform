<?php
include 'components/connect.php';

if (isset($_COOKIE['user_id'])) {
    $user_id = $_COOKIE['user_id'];
} else {
    $user_id = '';
}

if (isset($_GET['get_id'])) {
    $get_id = $_GET['get_id'];
} else {
    $get_id = '';
    header('location:home.php'); // If no 'get_id', redirect to home
}

// Define the path for uploaded files
$upload_dir = 'uploaded_submissions/';

// Check if the form is submitted and a file is uploaded
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['assignment_file']) && isset($_POST['assignment_id'])) {
    $assignment_id = $_POST['assignment_id'];

    // Check if the uploaded file is not empty
    if ($_FILES['assignment_file']['error'] == UPLOAD_ERR_OK) {
        $file_tmp = $_FILES['assignment_file']['tmp_name'];
        $file_name = uniqid() . '-' . $_FILES['assignment_file']['name'];
        $file_path = $upload_dir . basename($file_name);

        // Ensure the directory exists, if not, create it
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0777, true);  // Create the directory if it doesn't exist
        }

        // Check if the user has already submitted the assignment
        $check_submission = $conn->prepare("SELECT * FROM `submissions` WHERE `assignment_id` = ? AND `user_id` = ?");
        $check_submission->execute([$assignment_id, $user_id]);

        if ($check_submission->rowCount() > 0) {
            // If a submission already exists, notify the user
            echo "<script>alert('You have already submitted this assignment!');</script>";
        } else {
            // Move the uploaded file to the desired location
            if (move_uploaded_file($file_tmp, $file_path)) {
                // File uploaded successfully, insert into database
                $insert_submission = $conn->prepare("INSERT INTO `submissions` (`assignment_id`, `user_id`, `file`) VALUES (?, ?, ?)");
                $insert_submission->execute([$assignment_id, $user_id, $file_name]);

                echo "<script>alert('Assignment uploaded successfully!');</script>";
            } else {
                echo "<script>alert('Failed to move uploaded file.');</script>";
            }
        }
    } else {
        echo "<script>alert('Error in file upload!');</script>";
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

   <!-- font awesome cdn link -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link -->
   <link rel="stylesheet" href="css/style.css">
   <style>
       .description {
           color: gray;
           font-size: 1.8rem;
       }
       label[for="assignment_file"] {
           color: gray;
           display: block; 
           margin-top: 10px;
           font-size: 1.5rem; 
       }
       .button {
           background-color: #e74c3c;
       }
       .box {
           padding: 20px;
           margin-bottom: 20px;
           border-radius: 8px;
           box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
       }
   </style>
</head>
<body>

<?php include 'components/user_header.php'; ?>

<!-- assignments section starts -->
<section class="courses">

   <h1 class="heading">Assignments</h1>

   <div class="box-container">

      <?php
         // Query the database for assignments related to this playlist_id
         $select_assignment = $conn->prepare("SELECT * FROM `assignments` WHERE playlist_id = ?");
         $select_assignment->execute([$get_id]);

         // Check if there are any results
         if ($select_assignment->rowCount() > 0) {
            // Loop through each assignment and display the data
            while ($fetch_assignment = $select_assignment->fetch(PDO::FETCH_ASSOC)) {
                $assignment_id = $fetch_assignment['id'];
                $title = $fetch_assignment['title'];
                $description = $fetch_assignment['description'];
                $pdf = $fetch_assignment['pdf'];

                echo '<div class="box">'; // Open box div
                echo '<h3 class="title">' . htmlspecialchars($title) . '</h3>';
                echo '<p class="description">' . htmlspecialchars($description) . '</p>';
                echo '<a href="uploaded_files/' . htmlspecialchars($pdf) . '" class="btn" target="_blank">Download Assignment PDF</a>';

                // Check if the user has already submitted the current assignment
                $check_submission = $conn->prepare("SELECT * FROM `submissions` WHERE `assignment_id` = ? AND `user_id` = ?");
                $check_submission->execute([$assignment_id, $user_id]);

                if ($check_submission->rowCount() > 0) {
                    $submission_data = $check_submission->fetch(PDO::FETCH_ASSOC);
                    $grade = $submission_data['grade'];

                    echo '<p class="empty">You have already submitted this assignment.</p>';
                    echo '<a href="#" class="delete-btn">View Score: ' . (!empty($grade) ? htmlspecialchars($grade) : 'Not graded yet') . '</a>';
                } else {
                    echo '<form action="view_assignment.php?get_id=' . htmlspecialchars($get_id) . '" method="POST" enctype="multipart/form-data">';
                    echo '<input type="hidden" name="assignment_id" value="' . htmlspecialchars($assignment_id) . '">';
                    echo '<label for="assignment_file">Upload your assignment</label>';
                    echo '<input type="file" name="assignment_file" required>';
                    echo '<button type="submit" class="option-btn">Submit Assignment</button>';
                    echo '</form>';
                }
                echo '</div>'; // Close box div
            }
         } else {
            // If no assignments found for this playlist, show message
            echo '<p class="empty">No assignments found for this playlist!</p>';
         }
      ?>

   </div>

</section>
<!-- assignments section ends -->

<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>
</body>
</html>
