<?php
include '../components/connect.php';

if (!isset($conn)) {
    die('Database connection not established.');
}

// Ensure $message is an array
$message = [];

if (isset($_COOKIE['tutor_id'])) {
    $tutor_id = $_COOKIE['tutor_id'];
} else {
    $tutor_id = '';
    header('location:login.php');
    exit();
}

// Handle grading form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['submission_id']) && isset($_POST['grade'])) {
    $submission_id = filter_var($_POST['submission_id'], FILTER_SANITIZE_STRING);
    $grade = trim($_POST['grade']);

    // Validate grade input
    if (is_numeric($grade) && $grade >= 0 && $grade <= 100) { // Assuming grades are between 0-100
        try {
            // Update the grade in the database
            $update_grade = $conn->prepare("UPDATE `submissions` SET `grade` = ? WHERE `id` = ?");
            $update_grade->execute([$grade, $submission_id]);
            $message[] = 'Grade updated successfully!';
        } catch (PDOException $e) {
            $message[] = 'Failed to update grade: ' . $e->getMessage();
        }
    } else {
        $message[] = 'Invalid grade. Please enter a number between 0 and 100.';
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>View Submissions</title>

   <!-- font awesome cdn link -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link -->
   <link rel="stylesheet" href="../css/admin_style.css">
   <style>
       
       form.flex-btn label {
           color: black;
           font-weight: bold;
           font-size: 14px;
       }

       form.flex-btn input[type="text"] {
           color: black;
           font-weight: bold;
           border: 1px solid #ccc;
           padding: 5px;
           font-size: 14px;
           border-radius: 4px;
       }
   </style>
</head>
<body>

<?php include '../components/admin_header.php'; ?>

<!-- Display Messages -->
<?php if (!empty($message)) : ?>
    <div class="message">
        <?php foreach ($message as $item) : ?>
            <p><?= htmlspecialchars($item); ?></p>
        <?php endforeach; ?>
    </div>
<?php endif; ?>

<section class="playlists">
    <h1 class="heading">User Submissions</h1>

    <div class="box-container">
        <?php
        try {
            $select_submissions = $conn->prepare("SELECT 
                submissions.id AS submission_id,
                submissions.file AS submission_file,
                submissions.grade AS submission_grade,
                assignments.title AS assignment_title,
                users.name AS user_name,
                users.email AS user_email
            FROM submissions
            INNER JOIN assignments ON submissions.assignment_id = assignments.id
            INNER JOIN users ON submissions.user_id = users.id");
            $select_submissions->execute();

            if ($select_submissions->rowCount() > 0) {
                while ($fetch_submission = $select_submissions->fetch(PDO::FETCH_ASSOC)) {
                    $submission_id = $fetch_submission['submission_id'];
                    $assignment_title = $fetch_submission['assignment_title'];
                    $user_name = $fetch_submission['user_name'];
                    $user_email = $fetch_submission['user_email'];
                    $submission_file = $fetch_submission['submission_file'];
                    $submission_grade = $fetch_submission['submission_grade'];

                    $file_path = '../uploaded_submissions/' . $submission_file;
                    $download_link = is_file($file_path) ? $file_path : '#';
        ?>
                    <div class="box">
                        <div class="flex">
                            <div><i class="fas fa-user"></i> <span><?= htmlspecialchars($user_name); ?></span></div>
                            <div><i class="fas fa-envelope"></i> <span><?= htmlspecialchars($user_email); ?></span></div>
                        </div>
                        <h3 class="title">Assignment: <?= htmlspecialchars($assignment_title); ?></h3>
                        <?php if ($download_link !== '#') : ?>
                            <a href="<?= htmlspecialchars($download_link); ?>" class="btn" download>Download Submission</a>
                        <?php else : ?>
                            <p class="error">File not found for download.</p>
                        <?php endif; ?>
                        <form action="" method="POST" class="flex-btn">
                            <div>
                            <input type="hidden" name="submission_id" value="<?= htmlspecialchars($submission_id); ?>">
                            <label for="grade_<?= htmlspecialchars($submission_id); ?>">Grade:</label>
                            <input type="text" name="grade" id="grade_<?= htmlspecialchars($submission_id); ?>" value="<?= htmlspecialchars($submission_grade ?? ''); ?>" placeholder="Enter Grade (0-100)" required>
                            </div>
                            <button type="submit" class="delete-btn">Submit Grade</button>
                        </form>
                    </div>
        <?php
                }
            } else {
                echo '<p class="empty">No submissions found!</p>';
            }
        } catch (PDOException $e) {
            echo '<p class="error">Failed to fetch submissions: ' . $e->getMessage() . '</p>';
        }
        ?>
    </div>
</section>

<?php include '../components/footer.php'; ?>

<script src="../js/admin_script.js"></script>
</body>
</html>
