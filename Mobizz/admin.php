<?php
session_start();
include 'backend/db.php'; 
error_reporting(E_ALL);
ini_set('display_errors', 1);
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true || $_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit();
}
try {
    $query = $pdo->query("SELECT * FROM products");
    $products = $query->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Error fetching products: " . $e->getMessage());
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['delete_product'])) {
    $product_id = $_POST['id'];
    try {
        $query = $pdo->prepare("DELETE FROM products WHERE id = ?");
        $query->execute([$product_id]);
        header("Location: admin.php");
        exit();
    } catch (PDOException $e) {
        die("Error deleting product: " . $e->getMessage());
    }
}
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update_product'])) {
    $product_id = $_POST['id'];
    $name = $_POST['name'];
    $brand = $_POST['brand'];
    $price = $_POST['price'];
    $description = $_POST['description'];
    $image = $_FILES['image']['name'];

    try {
        if ($image) {
            $target_dir = "assets/images/";
            $target_file = $target_dir . basename($image);
            if (move_uploaded_file($_FILES['image']['tmp_name'], $target_file)) {
                $query = $pdo->prepare("UPDATE products SET name = ?, brand = ?, price = ?, description = ?, image = ? WHERE id = ?");
                $query->execute([$name, $brand, $price, $description, $image, $product_id]);
            } else {
                echo "Error uploading image.";
            }
        } else {
            $query = $pdo->prepare("UPDATE products SET name = ?, brand = ?, price = ?, description = ? WHERE id = ?");
            $query->execute([$name, $brand, $price, $description, $product_id]);
        }
        header("Location: admin.php");
        exit();
    } catch (PDOException $e) {
        die("Error updating product: " . $e->getMessage());
    }
}
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['add_product'])) {
    $name = $_POST['name'];
    $brand = $_POST['brand'];
    $price = $_POST['price'];
    $description = $_POST['description'];
    $image = $_FILES['image']['name'];

    try {
        if ($image) {
            $target_dir = "assets/images/";
            $target_file = $target_dir . basename($image);
            if (move_uploaded_file($_FILES['image']['tmp_name'], $target_file)) {
                $query = $pdo->prepare("INSERT INTO products (name, brand, price, description, image) VALUES (?, ?, ?, ?, ?)");
                $query->execute([$name, $brand, $price, $description, $image]);
            } else {
                echo "Error uploading image.";
            }
        } else {
            $query = $pdo->prepare("INSERT INTO products (name, brand, price, description) VALUES (?, ?, ?, ?)");
            $query->execute([$name, $brand, $price, $description]);
        }
        header("Location: admin.php");
        exit();
    } catch (PDOException $e) {
        die("Error adding product: " . $e->getMessage());
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Mobiz Store</title>
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
            max-width: 1000px;
            margin-top: 20px;
        }
        h2, h3 {
            margin-bottom: 20px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .btn, .logout {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }
        .btn:hover, .logout:hover {
            background-color: #45a049;
        }
        .logout {
            background-color: #f44336;
        }
        .logout:hover {
            background-color: #e53935;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Panel</h2>
        <a href="admin_order.php" class="btn">View Customer Orders</a>
        <h3>Manage Products</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($products as $product): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($product['id']); ?></td>
                        <td><?php echo htmlspecialchars($product['name']); ?></td>
                        <td><?php echo htmlspecialchars($product['brand']); ?></td>
                        <td>Rs. <?php echo number_format($product['price'], 2); ?></td>
                        <td><?php echo htmlspecialchars($product['description']); ?></td>
                        <td><img src="assets/images/<?php echo htmlspecialchars($product['image']); ?>" alt="Product Image" width="50"></td>
                        <td>
                            <form action="admin.php" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<?php echo $product['id']; ?>">
                                <button type="submit" name="delete_product" class="btn btn-remove">Delete</button>
                            </form>
                            <button class="btn" onclick="editProduct(<?php echo htmlspecialchars(json_encode($product)); ?>)">Edit</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>

        <h3>Add New Product</h3>
        <form action="admin.php" method="POST" enctype="multipart/form-data">
            <div class="form-group">
                <label for="add_name">Product Name:</label>
                <input type="text" name="name" id="add_name" required>
            </div>
            <div class="form-group">
                <label for="add_brand">Brand:</label>
                <input type="text" name="brand" id="add_brand" required>
            </div>
            <div class="form-group">
                <label for="add_price">Price:</label>
                <input type="number" name="price" id="add_price" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="add_description">Description:</label>
                <textarea name="description" id="add_description" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="add_image">Image:</label>
                <input type="file" name="image" id="add_image">
            </div>
            <button type="submit" name="add_product" class="btn">Add Product</button>
        </form>

        <h3>Edit Product</h3>
        <form id="editForm" action="admin.php" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="id" id="edit_id">
            <div class="form-group">
                <label for="edit_name">Product Name:</label>
                <input type="text" name="name" id="edit_name" required>
            </div>
            <div class="form-group">
                <label for="edit_brand">Brand:</label>
                <input type="text" name="brand" id="edit_brand" required>
            </div>
            <div class="form-group">
                <label for="edit_price">Price:</label>
                <input type="number" name="price" id="edit_price" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="edit_description">Description:</label>
                <textarea name="description" id="edit_description" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="edit_image">Image:</label>
                <input type="file" name="image" id="edit_image">
            </div>
            <button type="submit" name="update_product" class="btn">Update Product</button>
        </form>
        <a href="logout.php" class="logout">Logout</a>
    </div>

    <script>
        function editProduct(product) {
            document.getElementById('edit_id').value = product.id;
            document.getElementById('edit_name').value = product.name;
            document.getElementById('edit_brand').value = product.brand;
            document.getElementById('edit_price').value = product.price;
            document.getElementById('edit_description').value = product.description;
            document.getElementById('edit_image').value = '';
            document.getElementById('editForm').scrollIntoView();
        }
    </script>
</body>
</html>