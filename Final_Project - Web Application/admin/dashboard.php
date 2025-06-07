<?php

include '../components/connect.php';

if (isset($_COOKIE['tutor_id'])) {
    $tutor_id = $_COOKIE['tutor_id'];
} else {
    $tutor_id = '';
    header('location:login.php');
    exit();
}

// Fetch tutor profile
$select_profile = $conn->prepare("SELECT name FROM `tutors` WHERE id = ?");
$select_profile->execute([$tutor_id]);
$fetch_profile = $select_profile->fetch(PDO::FETCH_ASSOC);

if (!$fetch_profile) {
    header('location:login.php'); // Redirect if no profile found
    exit();
}

// Fetch counts for dashboard
$select_contents = $conn->prepare("SELECT COUNT(*) FROM `content` WHERE tutor_id = ?");
$select_contents->execute([$tutor_id]);
$total_contents = $select_contents->fetchColumn();

$select_comments = $conn->prepare("SELECT COUNT(*) FROM `comment` WHERE tutor_id = ?");
$select_comments->execute([$tutor_id]);
$total_comments = $select_comments->fetchColumn();

$select_playlists = $conn->prepare("SELECT COUNT(*) FROM `playlist` WHERE tutor_id = ?");
$select_playlists->execute([$tutor_id]);
$total_playlists = $select_playlists->fetchColumn();

$select_likes = $conn->prepare("
    SELECT COUNT(*) 
    FROM `enrollments` 
    WHERE playlist_id IN (SELECT id FROM `playlist` WHERE tutor_id = ?)
");
$select_likes->execute([$tutor_id]);
$total_likes = $select_likes->fetchColumn();

$select_pending_requests = $conn->prepare("
    SELECT COUNT(*) 
    AS pending_requests 
    FROM `enrollments` 
    WHERE status = 'pending' AND playlist_id IN (SELECT id FROM `playlist` WHERE tutor_id = ?)
");
$select_pending_requests->execute([$tutor_id]);
$pending_requests = $select_pending_requests->fetchColumn();

$select_submissions = $conn->prepare("
    SELECT COUNT(*) 
    FROM `submissions` 
    WHERE assignment_id IN (SELECT id FROM `assignments` WHERE tutor_id = ?)
");
$select_submissions->execute([$tutor_id]);
$total_submissions = $select_submissions->fetchColumn();

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Dashboard</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="../css/admin_style.css">

</head>
<body>

<?php include '../components/admin_header.php'; ?>
   
<section class="dashboard">

   <h1 class="heading">Dashboard</h1>

   <div class="box-container">

      <div class="box welcome-box">
         <h3><i class="fa-solid fa-smile-beam"></i> Welcome Back, <?= htmlspecialchars($fetch_profile['name']); ?>!</h3>
         <p>We hope you have a productive day managing your content and engaging with your audience.</p>
         <a href="profile.php" class="btn">View Profile</a>
      </div>

      <div class="box">
         <h3><?= $total_contents; ?></h3>
         <p>Total Contents</p>
         <a href="add_content.php" class="btn">Add New Content</a>
      </div>

      <div class="box">
         <h3><?= $total_playlists; ?></h3>
         <p>Total Playlists</p>
         <a href="add_playlist.php" class="btn">Add New Playlist</a>
      </div>

      <div class="box">
         <h3><?= $total_submissions; ?></h3>
         <p>Total Submissions</p>
         <a href="view_submission.php" class="btn">View Submissions</a>
      </div>

      <div class="box">
         <h3><?= $pending_requests; ?></h3>
         <p>Pending Requests</p>
         <a href="manage_requests.php" class="btn">View Requests</a>
      </div>
      <div class="box">
         <h3><?= $total_comments; ?></h3>
         <p>Total Comments</p>
         <a href="comments.php" class="btn">View Comments</a>
      </div>

      <div class="box">
         <h3>Quick Select</h3>
         <p>Login or Register</p>
         <div class="flex-btn">
            <a href="login.php" class="option-btn">Login</a>
            <a href="register.php" class="option-btn">Register</a>
         </div>
      </div>

   </div>

</section>

<?php include '../components/footer.php'; ?>

<script src="../js/admin_script.js"></script>

</body>
</html>
