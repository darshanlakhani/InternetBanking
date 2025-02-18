<?php
session_start();
include('conf/config.php');

// Function to generate a random client number
function generateClientNumber() {
    $length = 4;
    return 'iBank-CLIENT-' . substr(str_shuffle('0123456789'), 1, $length);
}

// Function to validate email
function validateEmail($email) {
    return filter_var($email, FILTER_VALIDATE_EMAIL);
}

// Function to validate client contact number
function validatePhoneNumber($phone) {
    // You can adjust the regular expression based on your requirements
    return preg_match("/^\d{10}$/", $phone); // 10-digit phone number validation
}

// Function to validate password strength
function validatePassword($password) {
    // Minimum length requirement
    $min_length = 8;
    
    // Regular expressions to check for uppercase, lowercase, numbers, and special characters
    $uppercase_regex = '/[A-Z]/';
    $lowercase_regex = '/[a-z]/';
    $number_regex = '/[0-9]/';
    $special_char_regex = '/[^A-Za-z0-9]/'; // Matches any character that is not alphanumeric
    
    // Check if the password meets the minimum length requirement
    if (strlen($password) < $min_length) {
        return "Password must be at least $min_length characters long";
    }
    
    // Check if the password contains at least one uppercase letter
    if (!preg_match($uppercase_regex, $password)) {
        return "Password must contain at least one uppercase letter";
    }
    
    // Check if the password contains at least one lowercase letter
    if (!preg_match($lowercase_regex, $password)) {
        return "Password must contain at least one lowercase letter";
    }
    
    // Check if the password contains at least one number
    if (!preg_match($number_regex, $password)) {
        return "Password must contain at least one number";
    }
    
    // Check if the password contains at least one special character
    if (!preg_match($special_char_regex, $password)) {
        return "Password must contain at least one special character";
    }
    
    // Password meets all criteria
    return true;
}

// Register new account
if (isset($_POST['create_account'])) {
    // Register Client
    $name = $_POST['name'];
    $phone = $_POST['phone'];
    $email = $_POST['email'];
    $password = sha1(md5($_POST['password'])); // Note: Consider using a more secure hashing algorithm
    $address  = $_POST['address'];
    $client_number = generateClientNumber();

    // Validate email and phone number
    if (!validateEmail($email)) {
        $err = "Invalid email address";
    } elseif (!validatePhoneNumber($phone)) {
        $err = "Invalid client contact number. Please enter a 10-digit phone number.";
    } else {
        // Validate password
        $password_validation = validatePassword($_POST['password']);
        if ($password_validation !== true) {
            $err = $password_validation;
        } else {
            // Insert Captured information to a database table
            $query = "INSERT INTO iB_clients (name, client_number, phone, email, password, address) VALUES (?,?,?,?,?,?)";
            $stmt = $mysqli->prepare($query);
            // Bind parameters
            $stmt->bind_param('ssssss', $name, $client_number, $phone, $email, $password, $address);
            if ($stmt->execute()) {
                $success = "Account Created";
            } else {
                $err = "Please Try Again Or Try Later";
            }
        }
    }
}

// Retrieve system settings
$ret = "SELECT * FROM iB_SystemSettings ";
$stmt = $mysqli->prepare($ret);
$stmt->execute();
$res = $stmt->get_result();
while ($auth = $res->fetch_object()) {
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo $auth->sys_name; ?> - Sign Up</title>
    <!-- Add Bootstrap CSS link -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Custom CSS for form styling */
        .login-box {
            width: 400px;
            margin: auto;
            margin-top: 100px;
        }
        .login-logo {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }
        .login-card-body {
            padding: 20px;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <div class="login-logo">
            <?php echo $auth->sys_name; ?> - Sign Up
        </div>
        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">Sign Up</p>
                <?php if(isset($err)) { ?>
                    <div class="alert alert-danger"><?php echo $err; ?></div>
                <?php } ?>
                <?php if(isset($success)) { ?>
                    <div class="alert alert-success"><?php echo $success; ?></div>
                <?php } ?>
                <form method="post">
                    <div class="input-group mb-3">
                        <input type="text" name="name" required class="form-control" placeholder="Full Name">
                    </div>
                   
                    <div class="input-group mb-3">
                        <input type="text" name="phone" required class="form-control" placeholder="Phone Number">
                    </div>
                    <div class="input-group mb-3">
                        <input type="text" name="address" required class="form-control" placeholder="Address">
                    </div>
                    <div class="input-group mb-3">
                        <input type="email" name="email" required class="form-control" placeholder="Email Id">
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" name="password" required class="form-control" placeholder="Password">
                    </div>
                    <div class="row">
                        <div class="col-8">
                        </div>
                        <div class="col-4">
                            <button type="submit" name="create_account" class="btn btn-success btn-block">Sign Up</button>
                        </div>
                    </div>
                </form>
                <p class="mb-0">
                    <a href="pages_client_index.php" class="text-center">Login</a>
                </p>
            </div>
        </div>
    </div>
    <!-- Add Bootstrap JS link -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<?php
} // End of while loop
?>
\