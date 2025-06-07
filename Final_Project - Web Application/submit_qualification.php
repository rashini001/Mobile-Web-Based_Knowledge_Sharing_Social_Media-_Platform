<?php
include 'components/connect.php'; // assumes this file connects to your DB

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $fullname = htmlspecialchars(trim($_POST['fullname']));
    $email = htmlspecialchars(trim($_POST['email']));
    $expertise = htmlspecialchars(trim($_POST['expertise']));

    // File upload settings
    $uploadDir = 'uploads/cvs/';
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0777, true); // create folder if not exists
    }

    $cvFile = $_FILES['cv'];
    $cvName = basename($cvFile['name']);
    $cvTmp = $cvFile['tmp_name'];
    $cvExt = strtolower(pathinfo($cvName, PATHINFO_EXTENSION));
    $allowedExts = ['pdf'];

    if (!in_array($cvExt, $allowedExts)) {
        echo "Only PDF files are allowed.";
        exit;
    }

    $newFilename = uniqid('cv_', true) . '.' . $cvExt;
    $targetPath = $uploadDir . $newFilename;

    if (move_uploaded_file($cvTmp, $targetPath)) {
        // Insert into DB
        $stmt = $conn->prepare("INSERT INTO resource_people (fullname, email, expertise, cv_filename) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $fullname, $email, $expertise, $newFilename);

        if ($stmt->execute()) {
            echo "<script>alert('Application submitted successfully!'); window.location.href='resource_people.php';</script>";
        } else {
            echo "Database error: " . $conn->error;
        }

        $stmt->close();
    } else {
        echo "File upload failed.";
    }

    $conn->close();
} else {
    header("Location: resource_form.php");
    exit;
}
