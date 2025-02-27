<?php
function getAllProducts() {
    include 'db.php';
    return $pdo->query("SELECT * FROM products")->fetchAll(PDO::FETCH_ASSOC);
}
?>
