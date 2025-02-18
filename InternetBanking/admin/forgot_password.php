<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
include('conf/config.php');

if (isset($_POST['reset_password'])) {
    $email = $_POST['email'];
    
    // Check if email exists
    $stmt = $mysqli->prepare("SELECT admin_id FROM iB_admin WHERE email = ?");
    $stmt->bind_param('s', $email);
    $stmt->execute();
    $stmt->bind_result($admin_id);
    $stmt->fetch();
    $stmt->close(); // Close the statement to free resources
    
    if ($admin_id) {
        // Generate reset token
        $token = bin2hex(random_bytes(32));
        $expiry = date('Y-m-d H:i:s', strtotime('+1 hour'));

        // Store token in the database
        $stmt = $mysqli->prepare("INSERT INTO password_resets (admin_id, token, expiry) VALUES (?, ?, ?)");
        $stmt->bind_param('iss', $admin_id, $token, $expiry);
        $stmt->execute();
        $stmt->close(); // Close the statement
        
        // Send reset link via email
        $reset_link = "http://yourdomain.com/reset_password.php?token=$token";
        $subject = "Password Reset Request";
        $message = "Click the link below to reset your password:\n\n$reset_link";
        $headers = "From: no-reply@yourdomain.com";

        if (mail($email, $subject, $message, $headers)) {
            $success = "A password reset link has been sent to your email.";
        } else {
            $err = "Failed to send the email. Please try again later.";
        }
    } else {
        $err = "No account found with that email address.";
    }
}
?>


<!DOCTYPE html>
<html>
<head>
  <title>Forgot Password</title>
  <?php include("dist/_partials/head.php"); ?>
</head>
<body>
<div class="login-box">
  <div class="login-logo">
    <a href="#"><b>Forgot Password</b></a>
  </div>
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">Enter your email to reset your password</p>

      <?php if (isset($success)) { echo "<div class='alert alert-success'>$success</div>"; } ?>
      <?php if (isset($err)) { echo "<div class='alert alert-danger'>$err</div>"; } ?>

      <form method="post">
        <div class="input-group mb-3">
          <input type="email" name="email" class="form-control" placeholder="Email" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <button type="submit" name="reset_password" class="btn btn-primary btn-block">Send Reset Link</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
                                                                                                                                                                        