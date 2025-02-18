<?php
// Enable error reporting (for development only; disable on production)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
include('conf/config.php');
include('conf/checklogin.php');
check_login();

// Ensure the session variable exists
if (!isset($_SESSION['staff_id'])) {
    die("Staff ID is not set in session.");
}

$staff_id = $_SESSION['staff_id'];

// Ensure the $mysqli connection object exists and is error-free.
if (!isset($mysqli) || $mysqli->connect_error) {
    die("Database connection failed: " . (isset($mysqli->connect_error) ? $mysqli->connect_error : "mysqli object not set"));
}

// Prepare the SQL query to fetch loan applications
$query = "SELECT la.*, lt.type_name, COALESCE(ibs.name, 'N/A') AS reviewer_name
          FROM loan_applications la
          LEFT JOIN loan_types lt ON la.loan_type_id = lt.id
          LEFT JOIN ib_staff ibs ON la.reviewed_by = ibs.staff_id";

// Execute the query and assign to a uniquely named variable to avoid conflicts
$loanResult = $mysqli->query($query);

// Check if the query was successful
if (!$loanResult) {
    die("SQL Error: " . $mysqli->error . "<br>Query: " . $query);
}
?>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Loan Applications</title>
    <?php include("dist/_partials/head.php"); ?>
</head>

<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed">
    <div class="wrapper">
        <!-- Navigation & Sidebar -->
        <?php include("dist/_partials/nav.php"); ?>
        <?php include("dist/_partials/sidebar.php"); ?>

        <div class="content-wrapper">
            <!-- Content Header -->
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Loan Applications</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="pages_dashboard.php">Dashboard</a></li>
                                <li class="breadcrumb-item active">Loan Applications</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Select any application to review</h3>
                            </div>
                            <div class="card-body">
                                <table id="example1" class="table table-bordered table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Applicant Name</th>
                                            <th>Loan Type</th>
                                            <th>Loan Amount</th>
                                            <th>Application Date</th>
                                            <th>Status</th>
                                            <th>Reviewed By</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                      $cnt = 1;
                      if ($loanResult->num_rows > 0) {
                        while ($row = $loanResult->fetch_object()) {
                          echo "<tr>";
                          echo "<td>" . $cnt . "</td>";
                          // Use null coalescing operator to ensure we pass a string to htmlspecialchars()
                          echo "<td>" . htmlspecialchars($row->applicant_name ?? '') . "</td>";
                          echo "<td>" . htmlspecialchars($row->type_name ?? '') . "</td>";
                          echo "<td>Rs. " . number_format($row->loan_amount, 2) . "</td>";
                          echo "<td>" . date('d/m/Y H:i', strtotime($row->application_date)) . "</td>";
                          
                          // Determine badge class based on status
                          $badgeClass = 'danger'; // default class
                          if ($row->status == 'approved') {
                              $badgeClass = 'success';
                          }
                          if ($row->status == 'recommended') {
                              $badgeClass = 'warning'; 
                          }
                          elseif ($row->status == 'pending') {
                              $badgeClass ='secondary';
                          }
                            elseif ($row->status == 'pending_admin') {
                              $badgeClass = 'warning';
                          }
                          echo "<td><span class=\"badge badge-$badgeClass\">" . ucfirst($row->status) . "</span></td>";
                          
                          echo "<td>" . htmlspecialchars($row->reviewer_name ?? '') . "</td>";
                          echo "<td>
                                  <a href=\"review_loan.php?id=" . $row->id . "\" class=\"btn btn-primary btn-sm\">
                                    <i class=\"fas fa-search\"></i> Review
                                  </a>
                                </td>";
                          echo "</tr>";
                          $cnt++;
                        }
                      } else {
                        echo "<tr><td colspan=\"8\">No loan applications found.</td></tr>";
                      }
                      ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <?php include("dist/_partials/footer.php"); ?>
    </div>

    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables -->
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- Page script -->
    <script>
    $(function() {
        $("#example1").DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": false,
        });
    });
    </script>
</body>

</html>