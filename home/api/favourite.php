<?php 
    session_start();
    include("../../connect.php");

     // config API 

    // Lấy method của request
    $method = $_SERVER['REQUEST_METHOD'];

    // Lấy đường dẫn (endpoint) và tách ra ID nếu có
    $path = $_SERVER['REQUEST_URI'];
    $parts = explode('api/', $path);
    $parts = isset($parts[1]) ? $parts[1] : null;

    // check user.
    $user_id = isset($_SESSION['Google_login_id']) ? $_SESSION['Google_login_id'] : ($_SESSION['user_id'] ?? null);
    if (is_null($user_id)) {
        http_response_code(400); // Created
        echo json_encode([
            'message' => 'Bạn phải đăng nhập để sử dụng tính năng này',
            'Code' => 400
        ]);
        die;
    }
    $sql = "select * from user where (ID ='$user_id' OR  google_id = '$user_id') and active = 1";
    $user = mysqli_fetch_assoc(mysqli_query($con, $sql));

    // Xử lý request
    if ($parts == 'favourite.php') {
        switch ($method) {
            case 'POST':
                $data = json_decode(file_get_contents('php://input'), true);
                $product_id =  $data['product_id'];

                if (empty($user['favourite_products'])) {
                    $data_favourite = [];
                } else {
                    $data_favourite = json_decode($user['favourite_products'], true);
                }

                if (in_array($product_id, $data_favourite)) {
                    $key = array_search($product_id, $data_favourite);
                    unset($data_favourite[$key]);
                    $favourite_pruduct = false;
                } else {
                    $data_favourite[$product_id] = $product_id;
                    $favourite_pruduct = true;
                }
                $data_favourite = json_encode($data_favourite);
                $sql = "UPDATE  user SET favourite_products = '$data_favourite' WHERE (ID ='$user_id' OR  google_id = '$user_id')";

                if (mysqli_query($con, $sql)) {
                    $_SESSION['favourite_products'] = json_decode($data_favourite);
                    http_response_code(200); // Created
                    echo json_encode([
                        'message' => 'Success',
                        'Code' => 200,
                        'favourite_pruduct' => $favourite_pruduct
                    ]);
                } else {
                    http_response_code(400); // Internal Server Error
                    echo json_encode(['error' => 'Internal Server Error']);
                }
                break;
        }
    }
?>