<?php

include '../components/connect.php';

session_start();
$max_attempts = 3;
$lockout_time = 300; // 5 minutes in seconds

if (isset($_POST['submit'])) {

    $email = $_POST['email'];
    $email = filter_var($email, FILTER_SANITIZE_STRING);
    $pass = sha1($_POST['pass']);
    $pass = filter_var($pass, FILTER_SANITIZE_STRING);

    // Check if user exists and get failed attempts
    $select_tutor = $conn->prepare("SELECT * FROM `tutors` WHERE email = ? LIMIT 1");
    $select_tutor->execute([$email]);
    $row = $select_tutor->fetch(PDO::FETCH_ASSOC);

    if ($row) {
        $failed_attempts = $row['failed_attempts'];
        $last_failed_time = $row['last_failed_time'];
        $current_time = time();

        if ($failed_attempts >= $max_attempts && ($current_time - $last_failed_time) < $lockout_time) {
            $message[] = 'Your account is temporarily locked. Please try again later.';
        } else {
            if ($row['password'] === $pass) {
                // Reset failed attempts on successful login
                $reset_attempts = $conn->prepare("UPDATE `tutors` SET failed_attempts = 0 WHERE email = ?");
                $reset_attempts->execute([$email]);

                setcookie('tutor_id', $row['id'], time() + 60 * 60 * 24 * 30, '/');
                header('location:dashboard.php');
            } else {
                // Increment failed attempts and update last failed time
                if ($failed_attempts < $max_attempts) {
                    $failed_attempts++;
                    $update_attempts = $conn->prepare("UPDATE `tutors` SET failed_attempts = ?, last_failed_time = ? WHERE email = ?");
                    $update_attempts->execute([$failed_attempts, $current_time, $email]);

                    if ($failed_attempts == 2) {
                        $message[] = 'Warning: One more failed attempt will lock your account.';
                    } else {
                        $message[] = 'Incorrect email or password!';
                    }
                } else {
                    // Lock the account if the max attempts are reached
                    $update_attempts = $conn->prepare("UPDATE `tutors` SET last_failed_time = ? WHERE email = ?");
                    $update_attempts->execute([$current_time, $email]);
                    $message[] = 'Your account is temporarily locked. Please try again later.';
                }
            }
        }
    } else {
        $message[] = 'Incorrect email or password!';
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Login</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <link rel="stylesheet" href="../css/admin_style.css">
</head>
<body style="padding-left: 0;">

<?php
if (isset($message)) {
   foreach ($message as $message) {
      echo '<div class="message form">';
      echo '<span>' . $message . '</span>';
      echo '<i class="fas fa-times" onclick="this.parentElement.remove();"></i>';
      echo '</div>';
   }
}
?>

<section class="form-container">
   <form action="" method="post" enctype="multipart/form-data" class="login">
      <h3>welcome back!</h3>
      <p>your email </p>
      <input type="email" name="email" placeholder="enter your email" maxlength="20" required class="box">
      <p>your password </p>
      <input type="password" name="pass" placeholder="enter your password" maxlength="20" required class="box">
      <p class="link">don't have an account? <a href="register.php">register new</a></p>
      <input type="submit" name="submit" value="login now" class="btn">
   </form>
</section>

<script>
let darkMode = localStorage.getItem('dark-mode');
let body = document.body;

const enabelDarkMode = () => {
   body.classList.add('dark');
   localStorage.setItem('dark-mode', 'enabled');
}

const disableDarkMode = () => {
   body.classList.remove('dark');
   localStorage.setItem('dark-mode', 'disabled');
}

if (darkMode === 'enabled') {
   enabelDarkMode();
} else {
   disableDarkMode();
}
</script>

</body>
</html>
