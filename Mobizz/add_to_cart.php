<?php
session_start();
include 'backend/db.php'; 

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $product_id = $_POST['product_id'];
    $quantity = 1; 

    
    $query = $pdo->prepare("SELECT * FROM products WHERE id = :id");
    $query->execute(['id' => $product_id]);
    $product = $query->fetch(PDO::FETCH_ASSOC);

    if ($product) {
        
        if (!isset($_SESSION['cart'])) {
            $_SESSION['cart'] = [];
        }

        
        $found = false;
        foreach ($_SESSION['cart'] as &$item) {
            if ($item['id'] == $product_id) {
                $item['quantity'] += $quantity;
                $found = true;
                break;
            }
        }

        
        if (!$found) {
            $product['quantity'] = $quantity;
            $_SESSION['cart'][] = $product;
        }

        
        header("Location: cart.php");
        exit();
    } else {
       
        header("Location: index.php");
        exit();
    }
}
?>