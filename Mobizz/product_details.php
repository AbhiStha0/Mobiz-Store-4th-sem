<?php
session_start();
include 'backend/db.php'; 

if (!isset($_GET['id'])) {
    header("Location: index.php");
    exit();
}

$product_id = $_GET['id'];
$query = $pdo->prepare("SELECT * FROM products WHERE id = :id");
$query->execute(['id' => $product_id]);
$product = $query->fetch(PDO::FETCH_ASSOC);

if (!$product) {
    header("Location: index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($product['name']); ?> - Mobiz Store</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0;
            padding: 20px;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 800px;
            margin-top: 20px;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .product-image {
            text-align: center;
            margin-bottom: 20px;
        }
        .product-image img {
            max-width: 100%;
            border-radius: 8px;
        }
        .product-details {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .product-details div {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .product-details div span {
            font-weight: bold;
            color: #333;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-cart {
            background-color:rgba(69, 160, 73,);
        }
        .btn-cart:hover {
            background-color:rgba(69, 160, 73,);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><?php echo htmlspecialchars($product['name']); ?></h2>
        <div class="product-image">
            <img src="assets/images/<?php echo htmlspecialchars($product['image']); ?>" alt="<?php echo htmlspecialchars($product['name']); ?>">
        </div>
        <div class="product-details">
            <div><span>Brand:</span> <?php echo htmlspecialchars($product['brand']); ?></div>
            <div><span>Price:</span> Rs<?php echo number_format($product['price'], 2); ?></div>
            <div><span>Description:</span> <?php echo nl2br(htmlspecialchars($product['description'])); ?></div>
        </div>
        <form action="add_to_cart.php" method="POST" style="margin-top: 20px;">
            <input type="hidden" name="product_id" value="<?php echo $product['id']; ?>">
            <label for="quantity">Quantity:</label>
            <input type="number" name="quantity" value="1" min="1" required>
            <button type="submit" class="btn btn-cart">Add to Cart</button>
        </form>
        <a href="index.php?shop=true" class="btn">Back to Homepage</a>
    </div>
</body>
</html>