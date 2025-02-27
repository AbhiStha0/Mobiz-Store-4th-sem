-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2025 at 11:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobiz_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','shipped','delivered') DEFAULT 'pending',
  `total_amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `product_id`, `quantity`, `total_price`, `order_date`, `status`, `total_amount`, `created_at`) VALUES
(14, 2, NULL, NULL, NULL, '2025-02-27 10:01:30', 'pending', 199999.00, '2025-02-27 10:01:30'),
(15, 2, NULL, NULL, NULL, '2025-02-27 10:08:22', 'pending', 119999.00, '2025-02-27 10:08:22');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(16, 14, 3, 1, 199999.00),
(17, 15, 4, 1, 119999.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `brand`, `price`, `description`, `image`, `stock`) VALUES
(1, 'iPhone 15 Pro', 'Apple', 150000.00, 'Dimension: 146.6 x 70.6 x 8.25mm, 187 grams\r\nDisplay: 6.1‑inch OLED, Super Retina XDR with 120Hz ProMotion\r\nResolution: 2556  x 1179 pixels, 460 ppi\r\nChipset: A17 Pro (3nm) processor, 6 CPU cores + 6 GPU cores, 16-core Neural Engine\r\nStorage: 128/256/512GB/1TB (non-upgradeable)\r\nOperating System: iOS 17\r\nBack Camera: Triple:\r\n– 48MP f/1.78 primary camera (sensor-shift OIS)\r\n– 12MP f/2.2 ultra-wide camera\r\n– 3x optical zoom telephoto, 12MP f/2.8 camera\r\nFront Camera: 12MP f/1.9 camera\r\nSecurity: TrueDepth camera for FaceID facial recognition\r\nConnectivity: 5G (sub-6GHz and mmWave), WiFi 6E, Bluetooth 5.3, NFC, GPS with Glonass, Galileo, QZSS, and Beidou, NFC, UWB\r\nOther features: Water and dust resistance (IP68), Stereo speakers\r\nBattery: Up to 23 hours of video playback (same as the iPhone 14 Pro), 20W USB-C charging, 7.5W Qi Wireless Charging, 15W MagSafe Wireless Charger (No adapter included in the box) ', 'iphone14pro.jpg', 20),
(2, 'Samsung Galaxy S23 Ultra', 'Samsung', 184999.00, 'Body: 163.4 x 78.1 x 8.9mm, 233 grams, IP68 rated, Gorilla Glass Victus 2, Aluminum frame, S-pen support\r\nDisplay: 6.8-inches Dynamic AMOLED 2X Infinity-O, Gorilla Glass Victus 2, Adaptive 120Hz refresh rate, Vision Booster\r\nResolution: QHD+ (3088 x 1440 pixels)\r\nChipset: Snapdragon 8 Gen 2 for Galaxy (4nm Mobile platform)\r\nCPU: Octa-core (1x Cortex-X3 + 2x Cortex-A715 + 2x Cortex-1710 + 3x Cortex-A510)\r\nGPU: Adreno 740\r\nRAM: 8/12GB LPDDR5\r\nStorage: 256/512GB/1TB UFS 4.0\r\nSoftware & UI: One UI 5.1 on top of Android 13\r\nRear Camera: Quad (with LED flash)\r\n– 200MP primary lens, OIS, PDAF\r\n– 12MP ultra-wide-angle lens, 120º FOV\r\n– 10MP telephoto lens, 3x optical zoom\r\n– 10MP telephoto lens, 10x optical zoom\r\nSecurity: Ultrasonic fingerprint sensor\r\nBattery: 5000mAh with 45W fast charging, 15W wireless charging\r\nConnectivity: Satellite communication, 5G, Wi-Fi 6E, Bluetooth 5.2, Ultra Wide Band', 's23ultra.jpg', 15),
(3, 'Google Pixel 7 Pro', 'Google', 199999.00, 'Body: 162.9 x 76.6 x 8.9mm, 212 gm\r\nDisplay: 6.7-inches LTPO OLED panel, 120Hz refresh rate, HDR, Gorilla Glass Victus\r\nResolution: QHD+ (3120 x 1440 pixels), 19.5:9 aspect ratio\r\nChipset: Google Tensor G2 (4nm), Titan M2 security coprocessor\r\nMemory: 12GB LPDDR5 RAM, 128/256GB/512GB UFS 3.1 storage\r\nSoftware & UI: Android 13\r\nRear Camera: Triple (LED flash);\r\n– 50MP f/1.85 primary, OIS\r\n– 12MP f/2.2 ultrawide, 125.8-degree FoV, autofocus\r\n– 48MP f/3.5 telephoto, 5x optical zoom, Super Res Zoom up to 30x, OIS\r\nFront Camera: 10.8MP f/2.0 ultrawide, 92.8-degree FoV (punch-hole cutout)\r\nAudio: Stereo speaker setup\r\nSecurity: In-display fingerprint sensor (optical), Face Unlock\r\nSensors: Accelerometer, Ambient Light, Barometer, Gyro, Magnetometer, Proximity\r\nConnectivity: Dual-SIM (Nano, eSIM), WiFi 6E (802.11ax) with 2.4/5/6GHz, Bluetooth 5.2, NFC, GPS / GLONASS / Galileo / QZSS, USB Type-C, 4G LTE, 5G, Google Cast\r\nBattery: 5000mAh with fast charging, wireless and reverse wireless charging (no adapter provided)', 'pixel7pro.jpg', 25),
(4, 'OnePlus 11', 'OnePlus', 119999.00, 'Display: 6.7-inch E4 AMOLED, LTPO 3.0, 120Hz, Dolby Vision\r\nResolution: QHD+ (3216 x 1440 pixels)\r\nSoC: Snapdragon 8 Gen 2 (4nm)\r\nOS: OxygenOS 13 based on Android 13\r\nMemory: Up to 16GB LPDDR5X RAM, 512GB UFS 5.0 storage\r\nRear Camera: Triple;\r\n– 50MP Sony IMX890 primary, OIS\r\n– 48MP Sony IMX581 ultrawide\r\n– 32MP Sony IMX709 Telephoto, 2x Optical zoom\r\nSelfie: 16MP\r\nBattery: 5000mAh\r\nCharging: 100W\r\nBiometric: Fingerprint (in-display)\r\nAudio: Dual-speakers\r\nHaptics: Bionic vibrating motor (600 sq. mm)', 'oneplus11.jpg', 30),
(5, 'Xiaomi 13 Pro', 'Xiaomi', 999999.00, 'Body: 162.9 x 74.6 x 8.38/8.7mm, 229/210 gm; IP68 rating\r\nDisplay: 6.73″ E6 AMOLED curved panel, 120Hz LTPO refresh rate, Up to 240Hz touch sampling rate, Dolby Vision, HDR10+, 1900 nits peak brightness, 10-bit colors\r\nResolution: WQHD+ (3200 x 1440 pixels)\r\nDisplay Protection: Corning Gorilla Glass Victus\r\nChipset: Qualcomm Snapdragon 8 Gen 2 (4nm Mobile Platform)\r\nMemory: 8/12GB LPDDR5X RAM, 128/256/512GB UFS 4 storage (fixed)\r\nSoftware & UI: Android 13 with Xiaomi’s MIUI 14 on top\r\nRear Camera: Triple (with LED flash);\r\n– 50MP Sony IMX989, OIS\r\n– 50MP f/2.2 ultra-wide lens, 115º FOV\r\n– 50M f/2 telephoto lens, OIS\r\nFront Camera: 32MP sensor (punch-hole cutout)\r\nAudio: Dual speaker setup, Dolby Atmos, Hi-Res & Hi-Res Wireless\r\nSecurity: In-display fingerprint sensor, Face unlock\r\nBattery: 4820mAh (single-cell)\r\nCharging: 120W wired, 50W wireless, 10W reverse wireless', 'xiaomi13pro.jpg', 18),
(6, 'Samsung Galaxy Z Fold 4', 'Samsung', 250000.00, 'Body: 263 grams, IPX8 water-resistant, Corning Gorilla Glass Victus+, Armor Aluminum frame\r\nFolded: 155.1 x 67.1 x 14.2 – 15.8mm\r\nUnfolded: 155.1 x 130.1 x 6.3mm\r\nDisplay:\r\nCover: 6.2″ Dynamic AMOLED 2X, 120Hz adaptive refresh rate (48-120Hz)\r\nMain: 7.6″ Dynamic AMOLED 2X, 120Hz adaptive refresh rate (LTPO)\r\nResolution:\r\nCover: HD+ (2316 x 904 pixels), 23.1:9 aspect ratio\r\nMain: QXGA+ (2176 x 1812 pixels), 21.6:18 aspect ratio\r\nOther Properties: Corning Gorilla Glass Victus+ (Cover display), HDR10+\r\nChipset: Qualcomm Snapdragon 8+ Gen 1 5G (4nm Mobile Platform)\r\nCPU: Octa-core:\r\n– 1x Cortex-X2 (3.19 GHz)\r\n– 3x Cortex-A710 (2.75 GHz)\r\n– 4x Cortex-A510 (1.80 GHz)\r\nGPU: Adreno 730\r\nMemory: 12GB LPDDR5 RAM, 256/512GB/1TB UFS 3.1 storage (fixed)\r\nSoftware & UI: Android 12L with Samsung’s One UI 4.1.1 on top\r\nRear Camera: Triple (with LED flash);\r\n– Primary: 50MP f/1.8 sensor, DPAF, OIS\r\n– Ultrawide: 12MP f/2.2 sensor, 123º FOV\r\n– Telephoto: 10MP f/2.4 sensor, 3x optical zoom, OIS\r\nSelfie Camera:\r\n– Outer: 10MP f/2.2 sensor\r\n– Inner: 4MP f/1.8, second-gen Under-Display Camera (UDC)\r\nAudio: Stereo speaker with Dolby Atmos audio, No headphone jack\r\nSecurity: Side-mounted (capacitive), Face unlock\r\nSensors: Accelerometer, Barometer, Gyro, Geomagnetic, Hall, Proximity, Light\r\nConnectivity: Dual-SIM (Nano + eSIM), Wi-Fi 6E a/b/g/n/ac/ax (dual-band), Bluetooth 5.2, GPS / Galileo / Glonass / BeiDou, NFC, UWB, 4G LTE (VoLTE), 5G\r\nBattery: 4400mAh battery with 25W wired charging (no power adapter provided)\r\nWireless Charging: Yes (10W), 4.5W reverse wireless charging', 'zfold4.jpg', 10),
(7, 'iPhone 13', 'Apple', 117999.00, 'Dimension: 146.7 x 71.5 x 7.65mm, 174 grams\r\nDisplay: 6.1-inch (2532 × 1170 pixels) OLED, 460 PPI, Super Retina XDR\r\nChipset: Six-core A15 Bionic 64-bit processor, 16-core Neural Engine\r\nStorage: 128/256/512GB\r\nOperating System: iOS 16\r\nSIM: Dual SIM (nano + eSIM), dual eSIM support\r\nBack Camera: Dual:\r\n– 12MP wide-angle f/1.6 primary camera, 7-elements lens, sensor-shift OIS, True Tone flash with Slow Sync, 4K Dolby Vision video recording at 60 fps,\r\n– 12MP 120° ultra-wide f/2.4 camera, 5-elements lens\r\nFront Camera: 12MP front camera with f/2.2 aperture, 1080p video recording, Retina Flash, Dolby Vision HDR recording up to 30 fps, 4K video recording at 60 fps, Slo‑mo 1080p at 120 fps\r\nSecurity: TrueDepth camera for FaceID facial recognition\r\nConnectivity: 5G (sub-6GHz and mmWave), Gigabit LTE with 4×4 MIMO and LAA, 802.11ax Wi‑Fi 6 with 2×2 MIMO, Bluetooth 5.0, NFC, GPS with GLONASS, GLONASS, Galileo, QZSS, and Beidou\r\nOther features: Water and dust resistance (IP68), Stereo speakers\r\nBattery: 3,240mAh, 20W fast charging, 7.5W Qi Wireless Charging, 15W MagSafe Wireless Charger (No adapter included in the box)', 'iphone13.jpg', 40),
(8, 'Nothing Phone (2)', 'Nothing', 75999.00, 'Body: 76.4 x 162.1 x 8.6mm, 201.2gm, Glass back, Aluminum frames, IP54 dust/splash resistant\r\nDisplay: 6.55-inches Flexible OLED LTPO panel, 120Hz refresh rate, 240Hz touch sampling rate, Gorilla Glass\r\nOther Properties: HDR10+, 1600 nits peak brightness, 10-bit color depth\r\nResolution: FHD+ (2412 x 1080 pixels), 394 PPI\r\nChipset: Qualcomm Snapdragon 8+ Gen 1 5G (4nm mobile platform)\r\nMemory: 8/12GB LPDDR5 RAM, 128/256GB UFS 3.1 storage (fixed)\r\nSoftware & UI: Android 14 with Nothing OS 2.53 on top\r\nRear Camera: Dual (with LED flash);\r\n– 50MP, f/1.88 Sony IMX890 primary sensor, OIS + EIS\r\n– 50MP, f/2.2 Samsung JN1 ultrawide sensor, 114° FoV, 4cm macro\r\nFront Camera: 32MP, f/2.45 Sony IMX615 sensor (hole-punch cutout)\r\nAudio: Stereo speaker, 3 high definition mics, No headphone jack\r\nSecurity: In-display fingerprint sensor (Optical)\r\nConnectivity: Dual-SIM (Nano), WiFi 6 a/b/g/n/ac/ax (Dual-band), Bluetooth 5.3, GPS / AGPS / Galileo / Glonass / QZSS / BDS / NsvIC / SBAS, USB Type-C, NFC, 4G LTE (VoLTE), 5G\r\nBattery: 4700mAh with 45W PPS 3.3 charging, 15W Qi Wireless charging, 5W reverse charging', 'nothingphone2.jpg', 35),
(9, 'Realme GT 3', 'Realme', 91999.00, 'Display: 6.7-inches AMOLED panel, 144Hz refresh rate, 1500Hz Touch Sampling, HDR 10+\r\nResolution: 1.5K (2772 x 1240 pixels)\r\nChipset: Qualcomm Snapdragon 8+ Gen 1 (4nm TSMC)\r\nMemory: Up to 16GB RAM, Up to 1TB Storage\r\nSoftware & UI: Android 13 with Realme UI 4.0 on top\r\nRear Camera: Triple (with LED flash);\r\n– 50MP Sony IMX890 primary sensor (OIS)\r\n– 8MP ultra-wide camera, 112º FOV\r\n– 2MP macro lens (4cm focus)\r\nFront Camera: 16MP sensor (punch-hole cutout)\r\nBattery: 4,600mAh\r\nCharging: 240W Fast Charging', 'realmegt3.jpg', 20),
(10, 'Sony Xperia 1 IV', 'Sony', 55000.00, 'Display: 6.5-inch OLED, 120Hz refresh rate, 240Hz touch sampling rate, 21:9 aspect ratio\r\nResolution: 4K (1644×3840 pixels)\r\nProcessor: Snapdragon 8 Gen 1 (4nm)\r\nMemory: 12GB RAM\r\nStorage: 256/512GB\r\nOS: Android 12\r\nRear Camera: Quad, 12MP , f/1.7, 24mm (OIS) + 12MP ultra-wide+ 12MP telephoto, 80-128mm ( 3.5x-5.2x optical continuous zoom, OIS), ToF 3D sensor\r\nFront camera: 12MP, f/2.0, 20mm\r\nSecurity: Fingerprint (side-mounted)\r\nBattery: 5000mAh, 30W fast charging, wireless charging, reverse wireless charging', 'xperia1iv.jpg', 12),
(14, 'rog 9 pro ', 'asus', 155999.00, 'Display: 6.78-inch AMOLED LTPO, Full-HD+ (1080×2400), 165Hz refresh rate, 2500 nits peak brightness, HDR10+ support\r\nChipset: Qualcomm Snapdragon 8 Elite\r\nRAM: Up to 24GB LPDDR5X\r\nStorage: 1TB UFS 4.0\r\nCooling System: GameCool 9, with optional AeroActive Cooler X Pro\r\nRear Cameras: 50MP main (Sony Lytia 700, hybrid gimbal stabilization), 13MP ultra-wide (120° FOV), 32MP telephoto (3x optical zoom, OIS)\r\nFront Camera: 32MP RGBW sensor\r\nBattery: 5800mAh, 65W wired fast charging, 15W wireless charging\r\nAudio: Dual front-firing stereo speakers, 3.5mm headphone jack, Dirac tuning\r\nConnectivity: Wi-Fi 7, Bluetooth 5.4, 5G, NFC, dual USB-C ports\r\nOS: Android 15 with ROG UI\r\nWater and Dust Resistance: IP68\r\nWeight: 245g\r\nColors: Phantom Black, Storm White', 'asus-rog-phone-9-pro.jpg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`) VALUES
(1, 'bishesh ', 'bisace@gmail.com', '$2y$10$8Nhce5Cn9OyQ2P6taCDZEuq2/ZbuxQ0lpRheOW5NSy6rn1xbMshZu', 'user'),
(2, 'Ram', 'ram@gmail.com', '$2y$10$b1ObwUZyD9GcTpqCnzyeQO.SHNaPw9tqn8D3zYMwU2uWRDGF9wJuW', 'user'),
(3, 'Manish', 'manish@gmail.com', '$2y$10$sX57qHHUgzn2TgloaSbgiOIBfcNy80oKJZXahu/CieA1E2RCAb8Pq', 'user'),
(4, 'Abhi', 'stha@gmail.com', '$2y$10$SIxOxvAsv0AG.n7Hxt.QiOOzwos5jpjEeGTpQIQMWfqAHoG8r4JOG', 'admin'),
(5, 'Admin', 'admin@example.com', 'admin123', 'admin'),
(6, 'rijan', 'rijanrai@gmail.com', '$2y$10$.XlVqphwuAsSvclu2bcL4O1WI5SD.1VTyAOh/dxhbOlhFtHg5z6uO', ''),
(7, 'Czan Shrestha', 'czan@gmail.com', '$2y$10$TjVIIeQmGVkmAqQzMCrAKObe9.xzDJJ82HHSNKO3zRKkxlYosk0Q6', ''),
(8, 'Aadil Miya', 'aadil@gmail.com', '$2y$10$ytEb66moo6g5aA0qj97fK.hgMbG4dcq6rlfWfird3VTNR/DrYudyW', ''),
(9, '+-123', '123@100.com', '$2y$10$PnL7yG3ZceBU7qrW4acjXuXMlhTfA60haOBN1Tk/23dkGmbo04Ho.', ''),
(10, '+-123', '123@900.com', '$2y$10$.ASAHcKmdVsfYQMOhhXlc.A5F11hp0iWhL5VdzfQ5sr5TC2b0pI4O', ''),
(11, '+-1235', '999@222.com', '$2y$10$E6Lan6z4ZkrQNMHNQNxt1uOT9nx81PxL2LtBoJF80/Kj5Vm.xF04S', ''),
(12, '---+++***', '896@555.com', '$2y$10$wAV3x9PocY/QeJ7oCip4KeBCNHg0UNOLhzsxz3i00UVbzACkpZSUG', ''),
(13, 'Rijan', 'rijann@gmail.com', '$2y$10$gZo1Bb3ywBaGFu4Wq6DXN.tIqEjbPKcuN/Gbr98MEJd28zfoYkyA6', ''),
(14, '+-123', '123@1800.com', '$2y$10$vW1yrmjvOe5I5OOraRLDx.dppROcvJCEpRrAq1pXhvOZ.4naVl4F.', ''),
(15, 'abhi', '123@gmail.com', '$2y$10$ehgvLHi35lhT1LGEDjIqw.PmTyjRANfzTYif4cKnrR29vcA4Qgb/2', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
