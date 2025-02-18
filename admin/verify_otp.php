<?php session_start(); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Verify OTP</title>
</head>
<body>
    <h2>Enter OTP</h2>
    <form action="verify_otp_process.php" method="post">
        <input type="text" name="otp" placeholder="Enter OTP" required>
        <button type="submit" name="verify_otp">Verify OTP</button>
    </form>
</body>
</html>
