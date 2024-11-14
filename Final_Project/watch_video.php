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
    header('location:home.php');
    exit();
}

// Check if the user has access to the course
$access_granted = false;

if ($user_id != '') {
    $check_access = $conn->prepare("SELECT * FROM `course_access_requests` WHERE user_id = ? AND content_id = ? AND status = 'approved' LIMIT 1");
    $check_access->execute([$user_id, $get_id]);

    if ($check_access->rowCount() > 0) {
        $access_granted = true;
    }
}

if (isset($_POST['request_access'])) {
    if ($user_id != '') {
        // Check if the request already exists
        $check_request = $conn->prepare("SELECT * FROM `course_access_requests` WHERE user_id = ? AND content_id = ? LIMIT 1");
        $check_request->execute([$user_id, $get_id]);

        if ($check_request->rowCount() > 0) {
            $message[] = 'You have already requested access for this course.';
        } else {
            // Insert the access request
            $insert_request = $conn->prepare("INSERT INTO `course_access_requests` (user_id, content_id) VALUES (?, ?)");
            $insert_request->execute([$user_id, $get_id]);
            $message[] = 'Your request for course access has been submitted.';
        }
    } else {
        $message[] = 'Please login to request access.';
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Watch Video</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<?php include 'components/user_header.php'; ?>

<section class="watch-video">

    <?php if ($access_granted): ?>
        <?php
            $select_content = $conn->prepare("SELECT * FROM `content` WHERE id = ? AND status = ?");
            $select_content->execute([$get_id, 'active']);
            if ($select_content->rowCount() > 0) {
                while ($fetch_content = $select_content->fetch(PDO::FETCH_ASSOC)) {
                    $content_id = $fetch_content['id'];

                    $select_likes = $conn->prepare("SELECT * FROM `likes` WHERE content_id = ?");
                    $select_likes->execute([$content_id]);
                    $total_likes = $select_likes->rowCount();  

                    $verify_likes = $conn->prepare("SELECT * FROM `likes` WHERE user_id = ? AND content_id = ?");
                    $verify_likes->execute([$user_id, $content_id]);

                    $select_tutor = $conn->prepare("SELECT * FROM `tutors` WHERE id = ? LIMIT 1");
                    $select_tutor->execute([$fetch_content['tutor_id']]);
                    $fetch_tutor = $select_tutor->fetch(PDO::FETCH_ASSOC);
        ?>
        <div class="video-details">
            <video src="uploaded_files/<?= $fetch_content['video']; ?>" class="video" poster="uploaded_files/<?= $fetch_content['thumb']; ?>" controls autoplay></video>
            <h3 class="title"><?= $fetch_content['title']; ?></h3>
            <div class="info">
                <p><i class="fas fa-calendar"></i><span><?= $fetch_content['date']; ?></span></p>
                <p><i class="fas fa-heart"></i><span><?= $total_likes; ?> likes</span></p>
            </div>
            <div class="tutor">
                <img src="uploaded_files/<?= $fetch_tutor['image']; ?>" alt="">
                <div>
                    <h3><?= $fetch_tutor['name']; ?></h3>
                    <span><?= $fetch_tutor['profession']; ?></span>
                </div>
            </div>
            <form action="" method="post" class="flex">
                <input type="hidden" name="content_id" value="<?= $content_id; ?>">
                <a href="playlist.php?get_id=<?= $fetch_content['playlist_id']; ?>" class="inline-btn">view playlist</a>
                <?php if ($verify_likes->rowCount() > 0): ?>
                    <button type="submit" name="like_content"><i class="fas fa-heart"></i><span>liked</span></button>
                <?php else: ?>
                    <button type="submit" name="like_content"><i class="far fa-heart"></i><span>like</span></button>
                <?php endif; ?>
            </form>
            <div class="description"><p><?= $fetch_content['description']; ?></p></div>
        </div>
        <?php
                }
            } else {
                echo '<p class="empty">No videos added yet!</p>';
            }
        ?>
    <?php else: ?>
        <div class="access-denied">
            <p>You do not have access to this course content. Please request access.</p>
            <form action="" method="post">
                <button type="submit" name="request_access" class="inline-btn">Request Access</button>
            </form>
        </div>
    <?php endif; ?>

</section>

<?php include 'components/footer.php'; ?>
<script src="js/script.js"></script>
</body>
</html>
