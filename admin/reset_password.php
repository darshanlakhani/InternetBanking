<?php session_start();
if (!isset($_SESSION['verified']) || $_SESSION['verified'] !== true) {
    header("Location: forgot_password.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset Your Password</h2>
    <form action="update_password.php" method="post">
        <input type="password" name="password" placeholder="New Password" required>
        <button type="submit" name="reset_password">Reset Password</button>
    </form>
</body>
</html>
