<?php
session_start();
include('conf/config.php'); // Get configuration file

if (isset($_POST['login'])) {
    $email = $_POST['email'];
    $password = sha1(md5($_POST['password'])); // Double encrypt to increase security

    // Update the query to check if the client is active
    $stmt = $mysqli->prepare("SELECT email, password, client_id FROM iB_clients WHERE email=? AND password=? AND is_active=1");
    $stmt->bind_param('ss', $email, $password); // Bind fetched parameters
    $stmt->execute(); // Execute bind
    $stmt->bind_result($email, $password, $client_id); // Bind result
    $rs = $stmt->fetch();

    if ($rs) { // If it's successful
        $_SESSION['client_id'] = $client_id; // Assign session to client ID
        header("location:pages_dashboard.php");
    } else {
        // Display error if credentials are incorrect or account is inactive
        $err = "Access Denied. Check your credentials or ensure your account is active.";
    }
}

/* Persist System Settings On Brand */
$ret = "SELECT * FROM `iB_SystemSettings` ";
$stmt = $mysqli->prepare($ret);
$stmt->execute(); // OK
$res = $stmt->get_result();
while ($auth = $res->fetch_object()) {
?>
<!DOCTYPE html>
<html>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<?php include("dist/_partials/head.php"); ?>

<body class="hold-transition login-page">
    <div class="login-box">
        <div class="login-logo">
            <p><?php echo $auth->sys_name; ?></p>
        </div>
        <!-- /.login-logo -->
        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">Log In To Start Client Session</p>

                <?php if (isset($err)) { ?>
                    <div class="alert alert-danger"><?php echo $err; ?></div>
                <?php } ?>

                <form method="post">
                    <div class="input-group mb-3">
                        <input type="email" name="email" class="form-control" placeholder="Email" required>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-envelope"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" name="password" class="form-control" placeholder="Password" required>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <input type="checkbox" id="remember">
                                <label for="remember">Remember Me</label>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-4">
                            <button type="submit" name="login" class="btn btn-success btn-block">Log In</button>
                        </div>
                        <!-- /.col -->
                    </div>
                </form>

                <p class="mb-1">
                    <a href="pages_reset_pwd.php">I forgot my password</a>
                </p>
                <p class="mb-0">
                    <a href="pages_client_signup.php" class="text-center">Register a new account</a>
                </p>
            </div>
            <!-- /.login-card-body -->
        </div>
    </div>
    <!-- /.login-box -->

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
</body>
</html>
<?php
}
?>
