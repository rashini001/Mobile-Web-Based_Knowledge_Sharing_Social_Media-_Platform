
<?php
session_start();

// Database configuration - use your existing course_db credentials
define('DB_HOST', 'localhost');
define('DB_USER', 'user'); // Change to your database username
define('DB_PASS', 'Ra1shi**'); // Change to your database password
define('DB_NAME', 'course_db');

// Connect to database
try {
    $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Initialize variables
$message = [];
$email = '';

// Check if form is submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) {
    // Sanitize and validate inputs
    $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);
    $password = $_POST['pass'] ?? '';
    
    // Validate inputs
    if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $message[] = 'Please enter a valid email address.';
    }
    
    if (empty($password)) {
        $message[] = 'Please enter your password.';
    }
    
    // If no validation errors, proceed with login
    if (empty($message)) {
        try {
            // Check if manager exists
            $stmt = $pdo->prepare("SELECT * FROM managers WHERE email = ?");
            $stmt->execute([$email]);
            $manager = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($manager && password_verify($password, $manager['password'])) {
                // Login successful
                $_SESSION['manager_id'] = $manager['id'];
                $_SESSION['manager_email'] = $manager['email'];
                $_SESSION['manager_name'] = $manager['name'];
                
                // Redirect to manager dashboard
                header('Location: manager_dashboard.php');
                exit();
            } else {
                $message[] = 'Invalid email or password.';
            }
        } catch (PDOException $e) {
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
    <title>Learning Hub Manager Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="../css/manager_style.css">
</head>
<body>
    <div class="manager-login-container">
        <div class="manager-login-header">
            <i class="fas fa-university"></i>
            <h2>ACADEMIST</h2>
            <p>Manager Portal Login</p>
        </div>
        
        <?php if(!empty($message)): ?>
            <div class="error-msg">
                <i class="fas fa-exclamation-circle"></i>
                <?= htmlspecialchars($message[0]) ?>
            </div>
        <?php endif; ?>
        
        <form action="manager_login.php" method="post" class="manager-login-form">
            <div class="form-group">
                <label for="email">Manager Email</label>
                <input type="email" name="email" id="email" placeholder="Enter your manager email" 
                       value="<?= htmlspecialchars($email) ?>" required>
            </div>
            
            <div class="form-group">
                <label for="pass">Password</label>
                <input type="password" name="pass" id="pass" placeholder="Enter your password" required>
                <i class="fas fa-eye password-toggle" id="togglePassword"></i>
            </div>
            
            <button type="submit" name="submit" class="manager-login-btn">
                <i class="fas fa-sign-in-alt"></i> Login
            </button>
        </form>
        
        <div class="manager-login-footer">
            <p>Having trouble? <a href="mailto:support@learninghub.com">Contact support</a></p>
        </div>
    </div>

    <script>
        // Password visibility toggle
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('pass');
            const icon = this;
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        });
    </script>
     <footer class="footer">
        Copyright © 2025. All rights reserved.
     </footer>  
</body>
</html>