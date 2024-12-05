<?php
include '../components/connect.php';

if (isset($_COOKIE['tutor_id'])) {
    $tutor_id = $_COOKIE['tutor_id'];
} else {
    $tutor_id = '';
    header('location:login.php');
}

// Handle enrollment approval
if (isset($_GET['approve_id'])) {
    $enrollment_id = $_GET['approve_id'];
    $approve = $conn->prepare("UPDATE `enrollments` SET status = 'approved', approved_at = NOW() WHERE id = ?");
    $approve->execute([$enrollment_id]);
    $message[] = 'Enrollment approved successfully!';
}

// Fetch pending enrollment requests
$select_requests = $conn->prepare("
    SELECT 
        e.id AS enrollment_id,
        u.id AS user_id,
        u.name AS user_name,
        p.id AS playlist_id,
        p.title AS course_title,
        e.requested_at
    FROM enrollments e
    INNER JOIN users u ON e.user_id = u.id
    INNER JOIN playlist p ON e.playlist_id = p.id
    WHERE e.status = 'pending' AND p.tutor_id = ?
    ORDER BY e.requested_at DESC
");
$select_requests->execute([$tutor_id]);

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="../css/admin_style.css">
</head>
<body>

<?php include '../components/admin_header.php'; ?>

<section class="dashboard">
    <h1 class="heading">Enrollment Requests</h1>

    <div class="box-container">
        <?php
        if ($select_requests->rowCount() > 0) {
            while ($request = $select_requests->fetch(PDO::FETCH_ASSOC)) {
                ?>
                <div class="box">
                    <p><strong>User:</strong> <?= $request['user_name']; ?></p>
                    <p><strong>Course:</strong> <?= $request['course_title']; ?></p>
                    <p><strong>Requested At:</strong> <?= $request['requested_at']; ?></p>
                    <a href="manage_requests.php?approve_id=<?= $request['enrollment_id']; ?>" class="inline-btn">Approve</a>
                </div>
                <?php
            }
        } else {
            echo '<p class="empty">No pending enrollment requests!</p>';
        }
        ?>
    </div>
</section>

<?php include '../components/footer.php'; ?>
<script src="../js/admin_script.js"></script>
</body>
</html>
