<?php
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
?>