<?php

include '../components/connect.php';

if (isset($_COOKIE['tutor_id'])) {
    $tutor_id = $_COOKIE['tutor_id'];
} else {
    $tutor_id = '';
    header('location:login.php');
    exit();
}

if (isset($_GET['get_id'])) {
    $get_id = $_GET['get_id'];
} else {
    $get_id = '';
    header('location:assignment.php');
    exit();
}

// Delete assignment
if (isset($_POST['delete_assignment'])) {
    $delete_id = $_POST['assignment_id'];
    $delete_id = filter_var($delete_id, FILTER_SANITIZE_STRING);

    // Get assignment details
    $verify_assignment = $conn->prepare("SELECT * FROM `assignments` WHERE id = ? LIMIT 1");
    $verify_assignment->execute([$delete_id]);
    if ($verify_assignment->rowCount() > 0) {
        $fetch_assignment = $verify_assignment->fetch(PDO::FETCH_ASSOC);

        // Delete image file if exists
        if (!empty($fetch_assignment['image'])) {
            unlink('../uploaded_files/' . $fetch_assignment['image']);
        }

        // Delete PDF file if exists
        if (!empty($fetch_assignment['pdf'])) {
            unlink('../uploaded_files/' . $fetch_assignment['pdf']);
        }

        // Delete assignment from database
        $delete_assignment = $conn->prepare("DELETE FROM `assignments` WHERE id = ?");
        $delete_assignment->execute([$delete_id]);
        $message[] = 'Assignment deleted successfully!';
    } else {
        $message[] = 'Assignment not found!';
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignment Details</title>

    <!-- font awesome cdn link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <!-- custom css file link -->
    <link rel="stylesheet" href="../css/admin_style.css">

</head>
<body>

<?php include '../components/admin_header.php'; ?>

<section class="playlist-details">

    <h1 class="heading">Assignment Details</h1>

    <?php
    // Fetch the assignment details
    $select_assignment = $conn->prepare("SELECT * FROM `assignments` WHERE id = ? AND tutor_id = ?");
    $select_assignment->execute([$get_id, $tutor_id]);
    if ($select_assignment->rowCount() > 0) {
        while ($fetch_assignment = $select_assignment->fetch(PDO::FETCH_ASSOC)) {
            $assignment_id = $fetch_assignment['id'];

            // Get the associated playlist
            $get_playlist = $conn->prepare("SELECT title FROM `playlist` WHERE id = ?");
            $get_playlist->execute([$fetch_assignment['playlist_id']]);
            $playlist_title = $get_playlist->fetchColumn();
    ?>
    <div class="row">
        <div class="details">
            <h3 class="title">Assignment: <?= htmlspecialchars($fetch_assignment['title']); ?></h3>
            <div class="date"><i class="fas fa-calendar"></i><span><?= htmlspecialchars($fetch_assignment['created_at']); ?></span></div>
            <div class="description"><?= nl2br(htmlspecialchars($fetch_assignment['description'])); ?></div>
            <p class="description"><strong>Playlist:</strong> <?= htmlspecialchars($playlist_title); ?></p>

            <?php if (!empty($fetch_assignment['image'])) { ?>
            <p class="description"><strong>Image:</strong></p>
            <img src="../uploaded_files/<?= htmlspecialchars($fetch_assignment['image']); ?>" alt="Assignment Image" class="thumb">
            <?php } ?>

            <?php if (!empty($fetch_assignment['pdf'])) { ?>
            <p class="description"><strong>PDF:</strong> <a href="../uploaded_files/<?= htmlspecialchars($fetch_assignment['pdf']); ?>" download class="btn">Download PDF</a></p>
            <?php } ?>

            <form action="" method="post" class="flex-btn">
                <input type="hidden" name="assignment_id" value="<?= htmlspecialchars($assignment_id); ?>">
                <a href="update_assignment.php?get_id=<?= htmlspecialchars($assignment_id); ?>" class="option-btn">Update Assignment</a>
                <input type="submit" value="Delete Assignment" class="delete-btn" onclick="return confirm('Delete this assignment?');" name="delete_assignment">
            </form>
        </div>
    </div>
    <?php
        }
    } else {
        echo '<p class="empty">Assignment not found or you do not have permission to view it.</p>';
    }
    ?>
</section>

<section class="contents">

    <h1 class="heading">Assignments List</h1>

    <div class="box-container">

    <?php
    // Fetch all assignments for the tutor and playlist
    $select_assignments = $conn->prepare("SELECT * FROM `assignments` WHERE tutor_id = ? AND playlist_id = ?");
    $select_assignments->execute([$tutor_id, $get_id]);
    if ($select_assignments->rowCount() > 0) {
        while ($fetch_assignment = $select_assignments->fetch(PDO::FETCH_ASSOC)) {
            $assignment_id = $fetch_assignment['id'];
    ?>
        <div class="box">
            <div class="flex">
                <div><i class="fas fa-calendar"></i><span><?= htmlspecialchars($fetch_assignment['created_at']); ?></span></div>
            </div>
            <h3 class="title"><?= htmlspecialchars($fetch_assignment['title']); ?></h3>
            <p><?= nl2br(htmlspecialchars($fetch_assignment['description'])); ?></p>

            <?php if (!empty($fetch_assignment['image'])) { ?>
            <img src="../uploaded_files/<?= htmlspecialchars($fetch_assignment['image']); ?>" class="thumb" alt="Image">
            <?php } ?>

            <?php if (!empty($fetch_assignment['pdf'])) { ?>
            <p><a href="../uploaded_files/<?= htmlspecialchars($fetch_assignment['pdf']); ?>" download class="btn">Download PDF</a></p>
            <?php } ?>

            <form action="" method="post" class="flex-btn">
                <input type="hidden" name="assignment_id" value="<?= htmlspecialchars($assignment_id); ?>">
                <a href="update_assignment.php?get_id=<?= htmlspecialchars($assignment_id); ?>" class="option-btn">Update</a>
                <input type="submit" value="Delete" class="delete-btn" onclick="return confirm('Delete this assignment?');" name="delete_assignment">
            </form>
        </div>
    <?php
        }
    } 
    ?>

    </div>

</section>

<?php include '../components/footer.php'; ?>

<script src="../js/admin_script.js"></script>

</body>
</html>
