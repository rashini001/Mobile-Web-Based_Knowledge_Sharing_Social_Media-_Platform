<?php
session_start();

// Check if manager is logged in
if (!isset($_SESSION['manager_id'])) {
    header('Location: manager_login.php');
    exit();
}

// Database configuration
define('DB_HOST', 'localhost');
define('DB_USER', 'user');
define('DB_PASS', 'Ra1shi**');
define('DB_NAME', 'course_db');

// Connect to database
try {
    $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Fetch all pending resource person applications
$stmt = $pdo->query("SELECT id, name, email, expertise, profession, status FROM resource_applications WHERE status = 'pending'");
$applications = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Handle application decision
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && isset($_POST['application_id'])) {
    $applicationId = $_POST['application_id'];
    $action = $_POST['action'];

    if ($action === 'accept' || $action === 'reject') {
        $newStatus = $action === 'accept' ? 'approved' : 'rejected';

        // Update application status
        $stmt = $pdo->prepare("UPDATE resource_applications SET status = ? WHERE id = ?");
        $stmt->execute([$newStatus, $applicationId]);

        // Fetch user_id of the applicant
        $stmt = $pdo->prepare("SELECT user_id FROM resource_applications WHERE id = ?");
        $stmt->execute([$applicationId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

     if ($user) {
    $userId = $user['user_id'];
    
   

    $message = $newStatus === 'approved'
        ? '🎉 Congratulations! You have been approved as a resource person.'
        : '⚠️ We regret to inform you that your resource person application was not approved.';

    // Insert notification
    $stmt = $pdo->prepare("INSERT INTO notifications (user_id, message, type, is_read, created_at, link) VALUES (?, ?, 'update', 0, NOW(), 'view_application.php?id=$applicationId')");
    $stmt->execute([$userId, $message]);
}


        // Redirect to refresh
        header("Location: manager_dashboard.php");
        exit();
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Management Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="../css/manager_style.css">

</head>
<body>

    <div class="manager-dashboard">
        <header class="dashboard-header">
            <h1 class="welcome-heading">
                <span class="emoji">👋</span>Welcome, <?= htmlspecialchars($_SESSION['manager_name']) ?>!
            </h1>
            <a href="logout.php" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </header>
        
        <div class="dashboard-description">
            <h2>Academic Management Dashboard</h2>
            <p>This portal provides comprehensive tools for managing your academic resources. As an administrator, you can oversee faculty members, course materials, and institutional resources. The system allows you to maintain academic standards, manage resource personnel, and ensure smooth operation of educational programs.</p>
        </div>
        
        <div class="resource-people-container">
            <div class="resource-people-header">
                <h2><i class="fas fa-chalkboard-teacher"></i> Pending Resource Person Applications</h2>
            </div>
            
            <?php if (empty($applications)): ?>
                <p>No pending applications at this time.</p>
            <?php else: ?>
                <table class="resource-table">
                    <thead>
                        <tr>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Expertise Area</th>
                            <th>Professional Title</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($applications as $application): ?>
                            <tr>
                                <td><?= htmlspecialchars($application['name']) ?></td>
                                <td><?= htmlspecialchars($application['email']) ?></td>
                                <td><?= htmlspecialchars($application['expertise']) ?></td>
                                <td><?= htmlspecialchars($application['profession']) ?></td>
                                <td><?= ucfirst($application['status']) ?></td>
                                <td>
                                    <button class="action-btn view-btn" onclick="openApplicationModal(<?= $application['id'] ?>)">
                                        <i class="fas fa-eye"></i> View
                                    </button>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>
    </div>

    <!-- Application Details Modal -->
    <div id="applicationModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <h2>Resource Person Application Details</h2>
            <div id="applicationDetails" class="application-details">
                <!-- Content will be loaded via AJAX -->
            </div>
        </div>
    </div>

    <script>
        // Function to open modal with application details
        function openApplicationModal(applicationId) {
            // Fetch application details via AJAX
            fetch('get_application_details.php?id=' + applicationId)
                .then(response => response.text())
                .then(data => {
                    document.getElementById('applicationDetails').innerHTML = data;
                    document.getElementById('applicationModal').style.display = 'block';
                })
                .catch(error => console.error('Error:', error));
        }

        // Function to close modal
        function closeModal() {
            document.getElementById('applicationModal').style.display = 'none';
        }

        // Close modal when clicking outside of it
        window.onclick = function(event) {
            const modal = document.getElementById('applicationModal');
            if (event.target === modal) {
                closeModal();
            }
        }

    </script>
    <footer class="footer">
        Copyright © 2025. All rights reserved.
</footer>  


</body>
</html>