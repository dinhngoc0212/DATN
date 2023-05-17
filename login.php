<?php
    require 'google-api/vendor/autoload.php';

    session_start();
    include("connect.php");

    if(isset($_POST["UserName"])){
        $username = $_POST["UserName"];
        $password = $_POST["PassWord"];
        $password_db = md5($password);
        if(isset($_POST["remember_me"])) {
            setcookie("username",$username,time()+86400,'/','',0,0);
            setcookie("password",$password,time()+86400,'/','',0,0);
        }
        else{
            setcookie("username",$username,time()-86400,'/','',0,0);
            setcookie("password",$password,time()-86400,'/','',0,0);
        }
        $flag = true;
    }
    else{
        if(isset($_COOKIE["username"]) && isset($_COOKIE["password"])){
            $username = $_COOKIE["username"];
            $password = $_COOKIE["password"];
        }
        else{
            $username = null;
            $password = null;
        }
        if(isset($_GET["user"])){
            $username = $_GET["user"];
        }
    }
    // Creating new google client instance
    $client = new Google_Client();
    // Enter your Client ID
    $client->setClientId('373040687195-36q7gga5rddhs78ksjmgom0t4qtv1o4p.apps.googleusercontent.com');
    // Enter your Client Secrect
    $client->setClientSecret('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');
    // Enter the Redirect URL
    $client->setRedirectUri('http://localhost/IVYMODAL/login.php');
    // Adding those scopes which we want to get (email & profile Information)
    $client->addScope("email");
    $client->addScope("profile");
    if(isset($_GET['code'])){
        $token = $client->fetchAccessTokenWithAuthCode($_GET['code']);
        if(!isset($token["error"])){
            $client->setAccessToken($token['access_token']);
            // getting profile information
            $google_oauth = new Google_Service_Oauth2($client);
            $google_account_info = $google_oauth->userinfo->get();

            // Storing data into database
            $id = mysqli_real_escape_string($con, $google_account_info->id);
            $full_name = mysqli_real_escape_string($con, trim($google_account_info->name));
            $email = mysqli_real_escape_string($con, $google_account_info->email);
            $profile_pic = mysqli_real_escape_string($con, $google_account_info->picture);
            // checking user already exists or not
            $get_user = mysqli_query($con, "SELECT `google_id` FROM `user` WHERE `google_id`='$id'");
            if(mysqli_num_rows($get_user) > 0){
                $get_data_user = mysqli_query($con, "SELECT * FROM `user` WHERE `google_id`='$id'");
                $get_data_user = mysqli_fetch_assoc($get_data_user);
                $_SESSION['Permission'] = $get_data_user['role_id'];
                $_SESSION['Google_login_id'] = $id; 
                $_SESSION['UserName'] = $full_name;
                if (empty($get_data_user['favourite_products'])) {
                    $_SESSION['favourite_products'] = [];
                } else {
                    $_SESSION['favourite_products'] = json_decode($get_data_user['favourite_products'], true);
                }
                header('Location: home');
                exit;
            }
            else{
                $seo = url_slug($full_name);
                // if user not exists we will insert the user
                $insert = mysqli_query($con, "INSERT INTO `user`(`google_id`,`name`,`email`,`avatar`,`role_id`,`username`,`seo`) VALUES('$id','$full_name','$email','$profile_pic', 3, '$full_name', '$seo')");
                if($insert){
                    $_SESSION['Permission'] = 3;
                    $_SESSION['Google_login_id'] = $id; 
                    $_SESSION['UserName'] = $full_name;
                    $_SESSION['favourite_products'] = [];
                    header('Location: home');
                    exit;
                }
                else{
                    $message = "Sign up failed!(Something went wrong).";
                    echo "<script type='text/javascript'>alert('$message');</script>";
                }
            }
        }
        else{
            header('Location: login.php');
            exit;
        }
    } 
?>
<!doctype html>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Đăng nhập</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/png" href="assets/images/icon/favicon.ico">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/themify-icons.css">
    <link rel="stylesheet" href="assets/css/metisMenu.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/css/slicknav.min.css">
    <!-- amchart css -->
    <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
    <!-- others css -->
    <link rel="stylesheet" href="assets/css/typography.css">
    <link rel="stylesheet" href="assets/css/default-css.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="assets/css/responsive.css">
    <!-- modernizr css -->
    <script src="assets/js/vendor/modernizr-2.8.3.min.js"></script>
    <!-- sweetalert -->
    <script src="assets/js/sweetalert2.all.min.js"></script>
</head>

<body>
    <?php if(!isset($_POST['UserName'])){ ?>
        <div id="preloader">
            <div class="loader"></div>
        </div>
    <?php } ?>
    <!-- login area start -->
    <div class="login-area login-bg">
        <div class="container">
            <div class="login-box ptb--100">
                <form action="login.php?do=login" method="post" id="login-form">
                    <div class="login-form-head">
                        <h4>Đăng nhập</h4>
                        <p>Chào mừng đến với <a href="index.php">GEARSHOP</a></p>
                    </div>
                    <div class="login-form-body">
                        <div class="form-gp">
                            <label for="exampleInputUsername">Tên đăng nhập</label>
                            <input type="text" id="exampleInputUsername" name="UserName" field-name="tên đăng nhập" value="<?=$username?>">
                            <i class="ti-user"></i>
                            <p class="text-danger mt-2"></p>
                        </div>
                        <div class="form-gp">
                            <label for="exampleInputPassword">Mật khẩu</label>
                            <input type="password" id="exampleInputPassword" name="PassWord" field-name="mật khẩu" value="<?=$password?>">
                            <i class="ti-lock"></i>
                            <p class="text-danger mt-2">
                            <?php
                                if(isset($_POST["UserName"])){

                                    $sql = "select username, password from user where username = '$username'";
                                    $result = mysqli_query($con, $sql);

                                    if(mysqli_num_rows($result) == 0){
                                        echo "Tên đăng nhập không tồn tại. Vui lòng kiểm tra lại!";
                                        $flag = false;
                                    }
                                    else{
                                        $row = mysqli_fetch_assoc($result);
                                        if($password_db != $row['password']){
                                            echo "Mật khẩu không đúng. Vui lòng kiểm tra lại!";
                                            $flag = false;
                                        }
                                    }
                                }
                            ?>
                            </p>
                        </div>
                        <div class="row mb-4 rmber-area">
                            <div class="col-6">
                                <div class="custom-control custom-checkbox mr-sm-2">
                                    <input type="checkbox" class="custom-control-input" id="customControlAutosizing" name="remember_me" <?php if(isset($_COOKIE["username"])) echo "checked"?>>
                                    <label class="custom-control-label" for="customControlAutosizing">Lưu mật khẩu</label>
                                </div>
                            </div>
                            <div class="col-6 text-right">
                                <a href="forgot-password.php">Quên mật khẩu?</a>
                            </div>
                        </div>
                        <div class="submit-btn-area">
                            <button id="form_submit" type="button">Đăng nhập <i class="ti-arrow-right"></i></button>
                            <div class="login-other row mt-4">
                                <div class="col-6">
                                    <a class="fb-login" href="<?php echo $loginUrl ?>">Đăng nhập bằng <i class="fa fa-facebook"></i></a>
                                </div>
                                <div class="col-6">
                                    <a class="google-login" href="<?php echo $client->createAuthUrl(); ?>">Đăng nhập bằng <i class="fa fa-google"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="form-footer text-center mt-3">
                            <p class="text-muted">Chưa có tài khoản? <a href="register.php">Đăng ký</a></p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- login area end -->

    <!-- jquery latest version -->
    <script src="assets/js/vendor/jquery-2.2.4.min.js"></script>
    <!-- bootstrap 4 js -->
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/owl.carousel.min.js"></script>
    <script src="assets/js/metisMenu.min.js"></script>
    <script src="assets/js/jquery.slimscroll.min.js"></script>
    <script src="assets/js/jquery.slicknav.min.js"></script>
    
    <!-- others plugins -->
    <script src="assets/js/plugins.js"></script>
    <script src="assets/js/scripts.js"></script>
    <script src="assets/js/login.js"></script>

    <!-- php -->
    <?php    
        if(isset($_POST["UserName"])){
            if($flag){
                $_SESSION['UserName'] = $username;
                $sql = "select role_id, ID, favourite_products from user where username ='$username' and active = 1";
                $result = mysqli_query($con,$sql);
                $row = mysqli_fetch_assoc($result);
                if(mysqli_num_rows($result) > 0) {
                $_SESSION['Permission'] = $row["role_id"];
                $_SESSION['user_id'] = $row["ID"];
                if (empty($row['favourite_products'])) {
                    $_SESSION['favourite_products'] = [];
                } else {
                    $_SESSION['favourite_products'] = json_decode($row['favourite_products'], true);
                }
    ?>
    <script>
        Swal.fire(
            'Đăng nhập thành công',
            '',
            'success'
        )
        $(".swal2-confirm, .swal2-container").click( function(){
            <?php
                if($row["role_id"]==3){
            ?>
            location.href='home/index.php';
            <?php
                }
                else{
            ?>
            location.href='admin/index.php';
            <?php       
                }
            ?>
         });
    </script>
    <?php
                }
                else{
    ?>
    <script>
        Swal.fire(
            'Tài khoản đã bị khoá',
            '',
            'error'
        )
        $(".swal2-confirm, .swal2-container").click( function(){
            location.href='login.php';
        });
    </script>
    <?php
                }
            }
        }
    ?>

</body>

</html>