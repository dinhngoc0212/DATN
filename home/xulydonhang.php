<div></div>
<?php
    session_start();
    include("../connect.php");
    include("component/css.php");
    include("component/js.php");
    $username = $_SESSION['UserName'];

    $sql = "select * from user where username ='$username'";
    $result = mysqli_query($con, $sql);
    $row = mysqli_fetch_assoc($result);
    if($row['active']==0)
        header("Location: ../login.php");
    else{
        $online_check = isset($_GET['vnp_SecureHash']);
        if (isset($_SESSION['Google_login_id'])) {
            $keySession = $_SESSION['Google_login_id'];
        } else {
            $keySession = $_SESSION['user_id'];
        }
        try {
            list($name, $address, $phone, $seo, $payment, $date, $point, $cart) = getData($online_check, $keySession);
            if ($payment == 1 && !$online_check) {
                $total = (int)$_SESSION['Cart']['total'];
                setData($keySession);
                header("Location: ../home/api/checkout_vn_pay.php?total=$total");
                die();
            }
            if ($online_check) {
                if ((int)$_GET['vnp_TransactionStatus'] !== 00) {
                    ?>
                    <script>
                        Swal.fire({
                            icon: 'error',
                            title: 'Đặt hàng không thàng công!',
                            text: 'Vui lòng kiểm tra lại thông tin giao dịch!!'
                        }).then((result) => {
                            location.href = "order.php";
                        })
                    </script>
<?php
                    unset($_SESSION['Cart']);
                    unset($_SESSION[$keySession]);
                    die;
                }
                $dataBankVnPay['amount'] = $_GET['vnp_Amount'];
                $dataBankVnPay['bankCode'] = $_GET['vnp_BankCode']; 
                $dataBankVnPay['code'] = $_GET['vnp_BankTranNo']; 
                $dataBankVnPay['type'] = $_GET['vnp_CardType'];
                $dataBankVnPay = json_encode($dataBankVnPay); 
            } else {
                $dataBankVnPay = null;
            }
            $sql = "UPDATE user SET name = '$name', phone = '$phone' WHERE  username = '$username'";
            mysqli_query($con,$sql);
    
            $sql = "SELECT ID FROM user WHERE username = '$username'";
            $id = mysqli_query($con,$sql);
            $id = mysqli_fetch_assoc($id);
            $id = $id['ID'];
    
            $sql = "INSERT INTO ordered VALUES (NULL, '$id', '$date', '$address', '$payment', '1', '$point', 0)";
            mysqli_query($con,$sql);
            $order_id = mysqli_insert_id($con);
    
            foreach ($cart as $key => $value) {
                if ($key !== 'total') {
                    $sql = "INSERT INTO orderdetail VALUES (NULL, '$order_id', '".$value['mahang']."', '".$value['masize']."', '".$value['soluong']."', '".$dataBankVnPay."')";
                    mysqli_query($con,$sql);
                }
            }
            unset($_SESSION['Cart']);
    
            $sql = "UPDATE user SET point = point - $point WHERE username = '$username'";
            mysqli_query($con,$sql);
            if ($online_check) {
                unset($_SESSION[$keySession]);
            }
        } catch (exception $e ){
            echo 'Caught exception: ',  $e->getMessage(), "\n";
        }
?>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Đặt hàng thàng công!',
        text: 'Vui lòng kiểm tra lại trong mục đơn hàng!'
    }).then((result) => {
        location.href = "order.php";
    })
</script>
<?php } 
    function getData ($online_check = false, $keySession) {
        $date = date('Y-m-d');
        if ($online_check) {
            $name = $_SESSION[$keySession]['name'] ?? null;
            $address =  $_SESSION[$keySession]['address']  ?? null;
            $phone = $_SESSION[$keySession]['phone']  ?? null;
            $seo =   $_SESSION[$keySession]['seo']  ?? null;
            $payment = $_SESSION[$keySession]['payment']  ?? null;
            $point = $_SESSION[$keySession]['point']  ?? null;
            $cart = $_SESSION[$keySession]['cart']  ?? null;
        } else {
            $name = $_POST['name'];
            $address = $_POST["address"];
            $phone = $_POST["phone"];
            $seo = url_slug($name);
            $payment = $_POST["payment"];
            $point = $_POST["point"];
            $cart = $_SESSION['Cart'];
        }
        return [$name, $address, $phone, $seo, $payment, $date, $point, $cart];
    }

    function setData ($keySession) {
        $_SESSION[$keySession]['name'] = $_POST['name'];
        $_SESSION[$keySession]['address'] = $_POST["address"];
        $_SESSION[$keySession]['seo'] = url_slug($_POST['name']);
        $_SESSION[$keySession]['phone'] = $_POST["phone"];
        $_SESSION[$keySession]['payment'] = $_POST["payment"];
        $_SESSION[$keySession]['point'] = $_POST["point"];
        $_SESSION[$keySession]['cart'] = $_SESSION['Cart'];
    }

?>