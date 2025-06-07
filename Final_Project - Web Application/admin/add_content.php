<?php
include '../components/connect.php';

if (isset($_COOKIE['tutor_id'])) {
    $tutor_id = $_COOKIE['tutor_id'];
} else {
    header('location:login.php');
    exit();
}

if(isset($_POST['submit'])){
    $id = unique_id();
    $status = $_POST['status'];
    $title = $_POST['title'];
    $description = $_POST['description'];
    $playlist = $_POST['playlist'];

    $thumb = $_FILES['thumb']['name'];
    $thumb_ext = pathinfo($thumb, PATHINFO_EXTENSION);
    $rename_thumb = unique_id().'.'.$thumb_ext;
    $thumb_size = $_FILES['thumb']['size'];
    $thumb_tmp_name = $_FILES['thumb']['tmp_name'];
    $thumb_folder = '../uploaded_files/'.$rename_thumb;

    $video = $_FILES['video']['name'];
    $video_ext = pathinfo($video, PATHINFO_EXTENSION);
    $rename_video = unique_id().'.'.$video_ext;
    $video_tmp_name = $_FILES['video']['tmp_name'];
    $video_folder = '../uploaded_files/'.$rename_video;

    $message = [];

    // Create directory if it doesn't exist
    if (!is_dir('../uploaded_files/')) {
        mkdir('../uploaded_files/', 0777, true);
    }

    // Simple validation
    if($thumb_size > 2000000){
        $message[] = 'Image size is too large!';
    }else{
        try {
            // Move files
            move_uploaded_file($thumb_tmp_name, $thumb_folder);
            move_uploaded_file($video_tmp_name, $video_folder);

            // Database insert
            $add_playlist = $conn->prepare("INSERT INTO `content`(id, tutor_id, playlist_id, title, description, video, thumb, status) VALUES(?,?,?,?,?,?,?,?)");
            $add_playlist->execute([$id, $tutor_id, $playlist, $title, $description, $rename_video, $rename_thumb, $status]);
            
            $message[] = 'New content added!';
            header('location:view_content.php');
            exit();
        } catch(PDOException $e) {
            $message[] = 'Database error: ' . $e->getMessage();
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
    <title>Upload Video</title>
    <link rel="stylesheet" href="../css/admin_style.css">
</head>
<body>

<?php include '../components/admin_header.php'; ?>

<section class="video-form">
    <h1 class="heading">Upload Content</h1>
    <form action="" method="post" enctype="multipart/form-data">
        <p>Video Status <span>*</span></p>
        <select name="status" class="box" required>
            <option value="active">Active</option>
            <option value="deactive">Deactive</option>
        </select>
        
        <p>Video Title <span>*</span></p>
        <input type="text" name="title" maxlength="100" required placeholder="Enter video title" class="box">
        
        <p>Video Description <span>*</span></p>
        <textarea name="description" class="box" required placeholder="Write description" maxlength="1000" cols="30" rows="10"></textarea>
        
        <p>Video Playlist <span>*</span></p>
        <select name="playlist" class="box" required>
            <option value="" selected disabled>--Select playlist</option>
            <?php
            $select_playlists = $conn->prepare("SELECT * FROM `playlist` WHERE tutor_id = ?");
            $select_playlists->execute([$tutor_id]);
            if($select_playlists->rowCount() > 0){
                while($fetch_playlist = $select_playlists->fetch(PDO::FETCH_ASSOC)){
            ?>
            <option value="<?= $fetch_playlist['id']; ?>"><?= $fetch_playlist['title']; ?></option>
            <?php
                }
            ?>
            <?php
            }else{
                echo '<option value="" disabled>No playlist created yet!</option>';
            }
            ?>
        </select>
        
        <p>Select Thumbnail <span>*</span></p>
        <input type="file" name="thumb" accept="image/*" required class="box">
        
        <p>Select Video <span>*</span></p>
        <input type="file" name="video" accept="video/*" required class="box">
        
        <input type="submit" value="Upload content" name="submit" class="btn">
    </form>
</section>

<?php
if(isset($message)){
    foreach($message as $message){
        echo '
        <div class="message form">
            <span>'.$message.'</span>
        </div>
        ';
    }
}
?>



<?php include '../components/footer.php'; ?>

</body>
</html>