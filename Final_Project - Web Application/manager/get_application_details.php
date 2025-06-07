<?php
session_start();
require_once 'db_config.php'; // Your database configuration file

if (!isset($_SESSION['manager_id'])) {
    die("Unauthorized access");
}

if (!isset($_GET['id'])) {
    die("No application ID provided");
}

$applicationId = $_GET['id'];

// Fetch the full application details
$stmt = $pdo->prepare("SELECT * FROM resource_applications WHERE id = ?");
$stmt->execute([$applicationId]);
$application = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$application) {
    die("Application not found");
}
?>


<div class="detail-row">
    <div class="detail-label">Full Name:</div>
    <div class="detail-value"><?= htmlspecialchars($application['name']) ?></div>
</div>

<div class="detail-row">
    <div class="detail-label">Highest Qualification:</div>
    <div class="detail-value"><?= htmlspecialchars($application['qualification']) ?></div>
</div>

<div class="detail-row">
    <div class="detail-label">Email:</div>
    <div class="detail-value"><?= htmlspecialchars($application['email']) ?></div>
</div>

<div class="detail-row">
    <div class="detail-label">Expertise Area:</div>
    <div class="detail-value"><?= htmlspecialchars($application['expertise']) ?></div>
</div>

<div class="detail-row">
    <div class="detail-label">Professional Title:</div>
    <div class="detail-value"><?= htmlspecialchars($application['profession']) ?></div>
</div>

<div class="detail-row">
    <div class="detail-label">CV File:</div>
    <div class="detail-value">
        <?php if (!empty($application['cv'])): ?>
            <a href="/project2/uploads/cv/<?= htmlspecialchars($application['cv']) ?>" target="_blank">View CV</a>

        <?php else: ?>
            No CV uploaded
        <?php endif; ?>
    </div>
</div>

<div class="detail-row">
    <div class="detail-label">Motivation:</div>
    <div class="detail-value"><?= nl2br(htmlspecialchars($application['motivation'])) ?></div>
</div>

<div class="detail-row">
    <div class="detail-label">Professional Profiles:</div>
    <div class="detail-value">
        <?php if (!empty($application['image'])): ?>
            <a href="/project2/uploads/images/<?= htmlspecialchars($application['image']) ?>" target="_blank">View Profile Image</a>
        <?php else: ?>
            No profile image provided
        <?php endif; ?>
    </div>
</div>
    </div>
</div>

<form method="POST" action="manager_dashboard.php" class="action-buttons">
    <input type="hidden" name="application_id" value="<?= $application['id'] ?>">
    <button type="submit" name="action" value="reject" class="reject-btn">
        <i class="fas fa-times"></i> Reject
    </button>
    <button type="submit" name="action" value="accept" class="accept-btn">
        <i class="fas fa-check"></i> Accept
    </button>
</form>