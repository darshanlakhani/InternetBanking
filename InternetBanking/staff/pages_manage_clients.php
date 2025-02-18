<?php
session_start();
include('conf/config.php');
include('conf/checklogin.php');
check_login();
$admin_id = $_SESSION['admin_id'];

// Enable/Disable Client
if (isset($_GET['toggleClient'])) {
    $id = intval($_GET['toggleClient']);
    $currentStatus = intval($_GET['status']);
    $newStatus = $currentStatus === 1 ? 0 : 1;

    $adn = "UPDATE ib_clients SET is_active = ? WHERE client_id = ?";
    $stmt = $mysqli->prepare($adn);
    $stmt->bind_param('ii', $newStatus, $id);
    $stmt->execute();
    $stmt->close();

    if ($stmt) {
        $info = $newStatus ? "Client account enabled" : "Client account disabled";
    } else {
        $err = "Failed to update client status. Please try again.";
    }
}

// Delete Client
if (isset($_GET['deleteClient'])) {
    $id = intval($_GET['deleteClient']);
    $adn = "DELETE FROM iB_clients WHERE client_id = ?";
    $stmt = $mysqli->prepare($adn);
    $stmt->bind_param('i', $id);
    $stmt->execute();
    $stmt->close();

    if ($stmt) {
        $info = "Client account deleted.";
    } else {
        $err = "Failed to delete client account. Please try again.";
    }
}
?>

<!-- Log on to codeastro.com for more projects! -->
<!DOCTYPE html>
<html>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<?php include("dist/_partials/head.php"); ?>

<body class="hold-transition sidebar-mini">
  <div class="wrapper">
    <!-- Navbar -->
    <?php include("dist/_partials/nav.php"); ?>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <?php include("dist/_partials/sidebar.php"); ?>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <section class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h1>iBanking Clients</h1>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="pages_dashboard.php">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="pages_manage_clients.php">iBank Staffs</a></li>
                <li class="breadcrumb-item active">Manage Clients</li>
              </ol>
            </div>
          </div>
        </div><!-- /.container-fluid -->
      </section>

      <!-- Main content -->
      <section class="content">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Select on any action options to manage your clients</h3>
              </div>
              <div class="card-body">
                <table id="example1" class="table table-hover table-bordered table-striped">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Name</th>
                      <th>Client Number</th>
                     
                      <th>Contact</th>
                      <th>Email</th>
                      <th>Address</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                  <tbody>
    <?php
    $ret = "SELECT * FROM iB_clients ORDER BY RAND()";
    $stmt = $mysqli->prepare($ret);
    $stmt->execute();
    $res = $stmt->get_result();
    $cnt = 1;
    while ($row = $res->fetch_object()) {
    ?>
        <tr>
            <td><?php echo $cnt; ?></td>
            <td><?php echo $row->name; ?></td>
            <td><?php echo $row->client_number; ?></td>
            <td><?php echo $row->phone; ?></td>
            <td><?php echo $row->email; ?></td>
            <td><?php echo $row->address; ?></td>
            <td>
                <a class="btn btn-success btn-sm" href="pages_view_client.php?client_number=<?php echo $row->client_number; ?>">
                    <i class="fas fa-cogs"></i> Manage
                </a>
                <a class="btn btn-<?php echo $row->is_active ? 'warning' : 'primary'; ?> btn-sm" 
                   href="pages_manage_clients.php?toggleClient=<?php echo $row->client_id; ?>&status=<?php echo $row->is_active; ?>"
                   onclick="return confirm('Are you sure you want to <?php echo $row->is_active ? 'disable' : 'enable'; ?> this client?');">
                    <i class="fas fa-<?php echo $row->is_active ? 'times' : 'check'; ?>"></i> 
                    <?php echo $row->is_active ? 'Disable' : 'Enable'; ?>
                </a>
                <a class="btn btn-danger btn-sm" href="pages_manage_clients.php?deleteClient=<?php echo $row->client_id; ?>"
                   onclick="return confirm('Are you sure you want to delete this client?');">
                    <i class="fas fa-trash"></i> Delete
                </a>
            </td>
        </tr>
    <?php $cnt++; } ?>
</tbody>

                    </tfoot>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </section>
      <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <?php include("dist/_partials/footer.php"); ?>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->
  </div>
  <!-- ./wrapper -->

  <!-- jQuery -->
  <script src="plugins/jquery/jquery.min.js"></script>
  <!-- Bootstrap 4 -->
  <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- DataTables -->
  <script src="plugins/datatables/jquery.dataTables.js"></script>
  <script src="plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
  <!-- AdminLTE App -->
  <script src="dist/js/adminlte.min.js"></script>
  <!-- AdminLTE for demo purposes -->
  <script src="dist/js/demo.js"></script>
  <!-- page script -->
  <script>
    $(function() {
      $("#example1").DataTable();
      $('#example2').DataTable({
        "paging": true,
        "lengthChange": false,
        "searching": false,
        "ordering": true,
        "info": true,
        "autoWidth": false,
      });
    });
  </script>
</body>

</html>