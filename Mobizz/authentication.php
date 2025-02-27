<?php
$host = "localhost";
$dbname = "mobiz_store"; 
$username = "root";  
$password = "";      


try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}


function registerUser($name, $email, $password) {
    global $pdo;
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
    try {
        $stmt = $pdo->prepare("INSERT INTO users (name, email, password) VALUES (?, ?, ?)");
        $stmt->execute([$name, $email, $hashedPassword]);
        return true;
    } catch (PDOException $e) {
        return false;
    }
}


function loginUser($email, $password) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user['password'])) {
        $_SESSION['loggedin'] = true;
        $_SESSION['user'] = $user['email'];
        return true;
    }
    return false;
}


function logoutUser() {
    session_start();
    session_unset();
    session_destroy();
    header("Location: login.php");
    exit();
}
?>