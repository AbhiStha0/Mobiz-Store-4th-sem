<?php
function placeOrder($userId, $productId, $quantity) {
    include 'db.php';
    $stmt = $pdo->prepare("INSERT INTO orders (user_id, product_id, quantity) VALUES (?, ?, ?)");
    $stmt->execute([$userId, $productId, $quantity]);
}
?>
