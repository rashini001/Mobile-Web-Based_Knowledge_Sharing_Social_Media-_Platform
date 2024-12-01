<?php

include '../components/connect.php';

if (isset($_COOKIE['tutor_id'])) {
    $tutor_id = $_COOKIE['tutor_id'];
} else {
    $tutor_id = '';
    header('location:login.php');
    exit;
}

if (isset($_GET['get_id'])) {
    $get_id = $_GET['get_id'];
} else {
    $get_id = '';
    header('location:assignment.php');
    exit;
}

if (isset($_POST['submit'])) {
    $title = $_POST['title'];
    $title = filter_var($title, FILTER_SANITIZE_STRING);
    $description = $_POST['description'];
    $description = filter_var($description, FILTER_SANITIZE_STRING);

    // Update title and description
    $update_assignment = $conn->prepare("UPDATE `assignments` SET title = ?, description = ? WHERE id = ?");
    $update_assignment->execute([$title, $description, $get_id]);

    // Handle file upload
    $old_file = $_POST['old_file'];
    $old_file = filter_var($old_file, FILTER_SANITIZE_STRING);

    if (isset($_FILES['file']) && !empty($_FILES['file']['name'])) {
        $file = $_FILES['file']['name'];
        $file = filter_var($file, FILTER_SANITIZE_STRING);
        $ext = pathinfo($file, PATHINFO_EXTENSION);
        $rename = unique_id() . '.' . $ext;
        $file_tmp_name = $_FILES['file']['tmp_name'];
        $file_folder = '../uploaded_files/' . $rename;

        if (move_uploaded_file($file_tmp_name, $file_folder)) {
            $update_file = $conn->prepare("UPDATE `assignments` SET file = ? WHERE id = ?");
            $update_file->execute([$rename, $get_id]);

            // Delete old file if it exists
            if (!empty($old_file) && $old_file != $rename) {
                unlink('../uploaded_files/' . $old_file);
            }
        }
    }

    $message[] = 'Assignment updated!';
}

if (isset($_POST['delete'])) {
    $delete_id = $_POST['assignment_id'];
    $delete_id = filter_var($delete_id, FILTER_SANITIZE_STRING);

    // Get file information
    $delete_assignment_file = $conn->prepare("SELECT file FROM `assignments` WHERE id = ? LIMIT 1");
    $delete_assignment_file->execute([$delete_id]);
    $fetch_file = $delete_assignment_file->fetch(PDO::FETCH_ASSOC);

    // Delete file if it exists
    if (!empty($fetch_file['file'])) {
        unlink('../uploaded_files/' . $fetch_file['file']);
    }

    // Delete assignment
    $delete_assignment = $conn->prepare("DELETE FROM `assignments` WHERE id = ?");
    $delete_assignment->execute([$delete_id]);

    header('location:assignment.php');
    exit;
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Assignment</title>

    <!-- font awesome cdn link  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <!-- custom css file link  -->
    <link rel="stylesheet" href="../css/admin_style.css">
</head>
<body>

<?php include '../components/admin_header.php'; ?>
   
<section class="playlist-form">

    <h1 class="heading">Update Assignment</h1>

    <?php
    $select_assignment = $conn->prepare("SELECT * FROM `assignments` WHERE id = ?");
    $select_assignment->execute([$get_id]);
    if ($select_assignment->rowCount() > 0) {
        while ($fetch_assignment = $select_assignment->fetch(PDO::FETCH_ASSOC)) {
    ?>
    <form action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="old_file" value="<?= $fetch_assignment['file']; ?>">
        <p>Assignment Title <span>*</span></p>
        <input type="text" name="title" maxlength="100" required placeholder="Enter assignment title" value="<?= $fetch_assignment['title']; ?>" class="box">
        <p>Assignment Description <span>*</span></p>
        <textarea name="description" class="box" required placeholder="Write description" maxlength="1000" cols="30" rows="10"><?= $fetch_assignment['description']; ?></textarea>
        <p>Uploaded File</p>
        <div class="file">
            <?php if (!empty($fetch_assignment['file'])): ?>
                <a href="../uploaded_files/<?= $fetch_assignment['file']; ?>" target="_blank">View File</a>
            <?php endif; ?>
        </div>
        <input type="file" name="file" accept=".pdf,.doc,.docx,.txt" class="box">
        <input type="submit" value="Update Assignment" name="submit" class="btn">
        <div class="flex-btn">
            <input type="hidden" name="assignment_id" value="<?= $fetch_assignment['id']; ?>">
            <input type="submit" value="Delete" class="delete-btn" onclick="return confirm('Delete this assignment?');" name="delete">
        </div>
    </form>
    <?php
        }
    } else {
        echo '<p class="empty">No assignment found!</p>';
    }
    ?>

</section>

<?php include '../components/footer.php'; ?>

<script src="../js/admin_script.js"></script>

</body>
</html>
