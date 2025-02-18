<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
include('conf/config.php');

if (isset($_GET['token'])) {
  $token = $_GET['token'];

  // Validate token
  $stmt = $mysqli->prepare("SELECT admin_id, expiry FROM password_resets WHERE token = ?");
  $stmt->bind_param('s', $token);
  $stmt->execute();
  $stmt->bind_result($admin_id, $expiry);
  $stmt->fetch();

  if ($admin_id && strtotime($expiry) > time()) {
    if (isset($_POST['update_password'])) {
      $new_password = sha1(md5($_POST['password']));

      // Update password
      $stmt = $mysqli->prepare("UPDATE iB_admin SET password = ? WHERE admin_id = ?");
      $stmt->bind_param('si', $new_password, $admin_id);
      $stmt->execute();

      // Delete token
      $stmt = $mysqli->prepare("DELETE FROM password_resets WHERE token = ?");
      $stmt->bind_param('s', $token);
      $stmt->execute();

      $success = "Password updated successfully. You can now log in.";
    }
  } else {
    $err = "Invalid or expired token.";
  }
} else {
  header("Location: forgot_password.php");
  exit();
}
?>

<!DOCTYPE html>
<html>
<head>
  <title>Reset Password</title>
  <?php include("dist/_partials/head.php"); ?>
</head>
<body>
<div class="login-box">
  <div class="login-logo">
    <a href="#"><b>Reset Password</b></a>
  </div>
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">Enter your new password</p>

      <?php if (isset($success)) { echo "<div class='alert alert-success'>$success</div>"; } ?>
      <?php if (isset($err)) { echo "<div class='alert alert-danger'>$err</div>"; } ?>

      <form method="post">
        <div class="input-group mb-3">
          <input type="password" name="password" class="form-control" placeholder="New Password" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <button type="submit" name="update_password" class="btn btn-success btn-block">Update Password</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
