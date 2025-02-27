<?php
session_start();
include 'backend/db.php'; 

$search_query = '';
$products = [];
if (isset($_GET['search'])) {
    $search_query = htmlspecialchars($_GET['search']);
    $query = $pdo->prepare("SELECT * FROM products WHERE name LIKE :search OR brand LIKE :search");
    $query->execute(['search' => '%' . $search_query . '%']);
    $products = $query->fetchAll(PDO::FETCH_ASSOC);
} elseif (isset($_GET['shop'])) {
    $query = $pdo->query("SELECT * FROM products");
    $products = $query->fetchAll(PDO::FETCH_ASSOC);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobiz Store - Mobile Ordering System</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            height: 100vh; 
            background-image: url('background.jpg'); 
            background-size: cover;
            margin: 0;
            padding: 0;
            color: #fff;
            display: flex;
            flex-direction: column;
        }

        .content {
            flex: 1;
        }

        header {
            background: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 20px 0;
            text-align: center;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        nav {
            margin-top: 10px;
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background 0.3s ease, color 0.3s ease;
        }

        nav a:hover {
            background: #FFD700;
            color: #333;
        }

        .hero {
            text-align: center;
            padding: 100px 20px;
        }

        .hero h2 {
            font-size: 48px;
            color: #fff;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.7);
        }

        .hero p {
            font-size: 24px;
            color: #ddd;
            max-width: 600px;
            margin: 0 auto;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.5);
        }

        .btn {
            display: inline-block;
            padding: 15px 30px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .product-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            padding: 40px 20px;
        }

        .product {
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            color: #333;
        }

        .product:hover {
            transform: scale(1.05);
        }

        .product img {
            max-width: 100%;
            border-bottom: 1px solid #ddd;
        }

        .product h2 {
            font-size: 22px;
            color: #333;
            padding: 15px 20px;
        }

        .product p {
            color: #777;
            padding: 0 20px 15px;
            font-size: 16px;
        }

        footer {
            background: rgba(0, 0, 0, 0.7);
            color: white;
            text-align: center;
            padding: 20px;
        }

        .search-form {
            margin: 20px 0;
            text-align: center;
        }

        .search-form input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .search-form button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .search-form button:hover {
            background-color: #45a049;
        }

        .product-actions {
            display: flex;
            justify-content: space-between;
            padding: 0 20px 15px;
        }
    </style>
</head>
<body>
    <div class="content">
        <header>
            <h1>Welcome to Mobiz Store</h1>
            <p>Your one-stop destination for the latest mobile phones</p>
            <nav>
                <a href="index.php">Home</a>
                <a href="cart.php">Cart</a>
                <a href="checkout.php">Checkout</a>
                <?php if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true): ?>
                    <a href="logout.php">Logout</a>
                <?php else: ?>
                    <a href="login.php">Login</a>
                <?php endif; ?>
            </nav>
        </header>

        <section class="hero">
            <div class="hero-content">
                <h2>Discover the Best Deals on Mobile Phones</h2>
                <p>Browse through our extensive collection and grab the best deals today!</p>
                <a href="index.php?shop=true" class="btn">Shop Now</a>
            </div>
        </section>

        <div class="search-form">
            <form action="index.php" method="GET">
                <input type="text" name="search" placeholder="Search for products..." value="<?php echo htmlspecialchars($search_query); ?>">
                <button type="submit">Search</button>
            </form>
        </div>

        <?php if (count($products) > 0): ?>
            <section id="products" class="product-list">
                <?php foreach ($products as $product): ?>
                    <div class="product">
                        <img src="assets/images/<?php echo htmlspecialchars($product['image']); ?>" alt="Product Image">
                        <h2><?php echo htmlspecialchars($product['name']); ?></h2>
                        <p>Brand: <?php echo htmlspecialchars($product['brand']); ?></p>
                        <p>Price: Rs<?php echo number_format($product['price'], 2); ?></p>
                        <div class="product-actions">
                            <a href="product_details.php?id=<?php echo $product['id']; ?>" class="btn">View Details</a>
                            <form action="add_to_cart.php" method="POST">
                                <input type="hidden" name="product_id" value="<?php echo $product['id']; ?>">
                                <button type="submit" class="btn">Add to Cart</button>
                            </form>
                        </div>
                    </div>
                <?php endforeach; ?>
            </section>
        <?php else: ?>
            <?php if ($search_query || isset($_GET['shop'])): ?>
                <p style="text-align: center;">No products found.</p>
            <?php endif; ?>
        <?php endif; ?>
    </div>
    <footer>
        <p>&copy; 2024 Mobiz Store. All Rights Reserved.</p>
    </footer>
</body>
</html>