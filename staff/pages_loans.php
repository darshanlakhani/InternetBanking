<?php
// Enable error reporting (for debugging; disable in production)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();
include('conf/config.php');
include('conf/checklogin.php');
check_login();

// Ensure staff session is set
if (!isset($_SESSION['staff_id'])) {
    die("Staff ID is not set in session.");
}

$staff_id = $_SESSION['staff_id'];

// Ensure database connection is available
if (!isset($mysqli) || $mysqli->connect_error) {
    die("Database connection failed: " . ($mysqli->connect_error ?? "mysqli object not set"));
}

// Fetch loan applications including income/salary
$query = "SELECT la.*, lt.type_name, la.income_salary, COALESCE(ibs.name, 'N/A') AS reviewer_name
          FROM loan_applications la
          LEFT JOIN loan_types lt ON la.loan_type_id = lt.id
          LEFT JOIN ib_staff ibs ON la.reviewed_by = ibs.staff_id";

$loanResult = $mysqli->query($query);

if (!$loanResult) {
    die("SQL Error: " . $mysqli->error . "<br>Query: " . $query);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Loan Applications</title>
    <?php include("dist/_partials/head.php"); ?>
</head>

<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed">
    <div class="wrapper">
        <?php include("dist/_partials/nav.php"); ?>
        <?php include("dist/_partials/sidebar.php"); ?>

        <div class="content-wrapper">
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
                                            <th>Income/Salary</th> <!-- Added column -->
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
                          echo "<td>" . htmlspecialchars($row->applicant_name ?? '') . "</td>";
                          echo "<td>" . htmlspecialchars($row->type_name ?? '') . "</td>";
                          echo "<td>Rs. " . number_format($row->loan_amount, 2) . "</td>";
                          echo "<td>Rs. " . number_format($row->income_salary, 2) . "</td>"; // Display income
                          echo "<td>" . date('d/m/Y H:i', strtotime($row->application_date)) . "</td>";

                          $badgeClass = match ($row->status) {
                              'approved' => 'success',
                              'recommended' => 'warning',
                              'pending' => 'secondary',
                              'pending_admin' => 'warning',
                              default => 'danger',
                          };

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
                        echo "<tr><td colspan=\"9\" class=\"text-center\">No loan applications found.</td></tr>";
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
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="plugins/datatables/jquery.dataTables.js"></script>
    <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
    <script src="dist/js/adminlte.min.js"></script>
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
