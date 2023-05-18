-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2023 at 04:39 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ivymodal`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `ID` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `desc` text NOT NULL,
  `seo` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`ID`, `name`, `desc`, `seo`, `status`) VALUES
(6, 'Điện thoại', 'Điện thoại', 'dien-thoai-987505269', 1),
(7, 'Phụ kiện công nghệ', 'Phụ kiện công nghệ', 'phu-kien-cong-nghe-1494328167', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orderdetail`
--

CREATE TABLE `orderdetail` (
  `ID` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `orderdetail`
--

INSERT INTO `orderdetail` (`ID`, `order_id`, `product_id`, `size_id`, `quantity`) VALUES
(38, 25, 53, 1, 2),
(41, 28, 53, 1, 1),
(42, 29, 53, 1, 1),
(43, 29, 52, 1, 1),
(44, 30, 52, 1, 2),
(45, 31, 52, 2, 1),
(46, 32, 52, 1, 1),
(47, 33, 50, 1, 1),
(48, 34, 53, 1, 1);

--
-- Triggers `orderdetail`
--
DELIMITER $$
CREATE TRIGGER `new_order` AFTER INSERT ON `orderdetail` FOR EACH ROW UPDATE storage
                    SET quantity = quantity - NEW.quantity
                    WHERE product_id = NEW.product_id AND size_id = NEW.size_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `remove_order` AFTER DELETE ON `orderdetail` FOR EACH ROW UPDATE storage
SET quantity = quantity + OLD.quantity
WHERE product_id = OLD.product_id AND size_id = OLD.size_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ordered`
--

CREATE TABLE `ordered` (
  `ID` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` date NOT NULL DEFAULT current_timestamp(),
  `address` varchar(1000) NOT NULL,
  `method` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `point` decimal(13,0) NOT NULL DEFAULT 0,
  `pointplus` decimal(10,0) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `ordered`
--

INSERT INTO `ordered` (`ID`, `user_id`, `order_date`, `address`, `method`, `status`, `point`, `pointplus`) VALUES
(9, 1, '2022-06-15', 'Số nhà 28/52, Chùa Vẽ, Đông Hải 1, Hải An, Hải Phòng', 1, 4, 0, 500000),
(10, 1, '2022-06-15', 'Số nhà 28/52, Chùa Vẽ, Đông Hải 1, Hải An, Hải Phòng', 2, 4, 0, 2736000),
(11, 1, '2022-05-18', 'Số nhà 28/52, Chùa Vẽ, Đông Hải 1, Hải An, Hải Phòng', 1, 3, 0, 0),
(25, 2, '2023-04-30', 'An Lão, Hải Phòng', 1, 4, 0, 163200),
(28, 1, '2023-05-01', 'Số nhà 28/52, Chùa Vẽ, Đông Hải 1, Hải An, Hải Phòng', 1, 1, 0, 0),
(29, 1, '2023-05-01', 'Số nhà 28/52, Chùa Vẽ, Đông Hải 1, Hải An, Hải Phòng', 1, 3, 0, 0),
(30, 1, '2023-05-01', 'Số nhà 28/52, Chùa Vẽ, Đông Hải 1, Hải An, Hải Phòng', 3, 4, 0, 183600),
(31, 51, '2023-05-04', 'nam dịnh', 3, 4, 0, 91800),
(32, 51, '2023-05-04', 'nam dịnh hhfad', 3, 1, 0, 0),
(33, 46, '2023-05-04', 'nam dịnh', 3, 1, 0, 0),
(34, 46, '2023-05-04', 'nam dịnh', 3, 4, 0, 81600);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `ID` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `price` decimal(13,0) NOT NULL,
  `price_sale` decimal(13,0) NOT NULL,
  `image` varchar(1000) NOT NULL,
  `desc` text NOT NULL,
  `seo` varchar(1000) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`ID`, `sub_category_id`, `name`, `price`, `price_sale`, `image`, `desc`, `seo`, `status`) VALUES
(47, 11, 'Điện thoại iPhone 14 Pro Max 128GB ', 27090000, 26090000, '../assets/images/product/dien-thoai-iphone-14-pro-max-128gb--797719512.png', '<p class=\"parameter__title\" style=\"margin-top: 15px; margin-block: 0px; text-rendering: geometricprecision; font-size: 20px; font-weight: bold; line-height: 1.3; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif;\">Cấu hình Điện thoại iPhone 14 Pro Max 128GB</p><div class=\"parameter\" style=\"padding-top: 15px; padding-bottom: 15px; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif; font-size: 14px;\"><ul class=\"parameter__list 251192 active\" style=\"margin-bottom: 15px; list-style-position: initial; list-style-image: initial;\"><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Màn hình:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">OLED</span><span class=\"comma\">6.7\"</span><span class=\"\">Super Retina XDR</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Hệ điều hành:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">iOS 16</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Camera sau:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">Chính 48 MP & Phụ 12 MP, 12 MP</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Camera trước:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">12 MP</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Chip:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">Apple A16 Bionic</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">RAM:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">6 GB</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Dung lượng lưu trữ:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">128 GB</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">SIM:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">1 Nano SIM & 1 eSIM</span><span class=\"\">Hỗ trợ 5G</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Pin, Sạc:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">4323 mAh</span><span class=\"\">20 W</span></div></li></ul></div>', 'dien-thoai-iphone-14-pro-max-128gb--797719512', 1),
(48, 11, 'Điện thoại iPhone 14 128GB ', 19490000, 19390000, '../assets/images/product/dien-thoai-iphone-14-128gb--88082835.png', '<p class=\"parameter__title\" style=\"margin-top: 15px; margin-block: 0px; text-rendering: geometricprecision; font-size: 20px; font-weight: bold; line-height: 1.3; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif;\">Cấu hình Điện thoại iPhone 14 128GB</p><div class=\"parameter\" style=\"padding-top: 15px; padding-bottom: 15px; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif; font-size: 14px;\"><ul class=\"parameter__list 240259 active\" style=\"margin-bottom: 15px; list-style-position: initial; list-style-image: initial;\"><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Màn hình:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">OLED</span><span class=\"comma\">6.1\"</span><span class=\"\">Super Retina XDR</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Hệ điều hành:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">iOS 16</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Camera sau:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">2 camera 12 MP</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Camera trước:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">12 MP</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Chip:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">Apple A15 Bionic</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">RAM:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">6 GB</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Dung lượng lưu trữ:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">128 GB</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">SIM:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">1 Nano SIM & 1 eSIM</span><span class=\"\">Hỗ trợ 5G</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Pin, Sạc:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">3279 mAh</span><span class=\"\">20 W</span></div></li></ul></div>', 'dien-thoai-iphone-14-128gb--88082835', 1),
(49, 10, 'Điện thoại Samsung Galaxy S23+ 5G 256GB', 22190000, 22190000, '../assets/images/product/dien-thoai-samsung-galaxy-s23-5g-256gb-1901991802.png', '<p class=\"parameter__title\" style=\"margin-top: 15px; margin-block: 0px; text-rendering: geometricprecision; font-size: 20px; font-weight: bold; line-height: 1.3; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif;\">Cấu hình Điện thoại Samsung Galaxy S23+ 5G 256GB</p><div class=\"parameter\" style=\"padding-top: 15px; padding-bottom: 15px; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif; font-size: 14px;\"><ul class=\"parameter__list 290829 active\" style=\"margin-bottom: 15px; list-style-position: initial; list-style-image: initial;\"><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Màn hình:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">Dynamic AMOLED 2X</span><span class=\"comma\">6.6\"</span><span class=\"\">Full HD+</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Hệ điều hành:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">Android 13</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Camera sau:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">Chính 50 MP & Phụ 12 MP, 10 MP</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Camera trước:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">12 MP</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Chip:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">Snapdragon 8 Gen 2 8 nhân</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">RAM:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">8 GB</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Dung lượng lưu trữ:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">256 GB</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">SIM:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">2 Nano SIM hoặc 1 Nano SIM + 1 eSIM</span><span class=\"\">Hỗ trợ 5G</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Pin, Sạc:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">4700 mAh</span><span class=\"\">45 W</span></div></li></ul></div>', 'dien-thoai-samsung-galaxy-s23-5g-256gb-1901991802', 1),
(50, 10, 'Điện thoại Samsung Galaxy Z Flip4 128GB', 19990000, 19990000, '../assets/images/product/dien-thoai-samsung-galaxy-z-flip4-128gb-2118003682.png', '<p class=\"parameter__title\" style=\"margin-top: 15px; margin-block: 0px; text-rendering: geometricprecision; font-size: 20px; font-weight: bold; line-height: 1.3; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif;\">Cấu hình Điện thoại Samsung Galaxy Z Flip4 128GB</p><div class=\"parameter\" style=\"padding-top: 15px; padding-bottom: 15px; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif; font-size: 14px;\"><ul class=\"parameter__list 258047 active\" style=\"margin-bottom: 15px; list-style-position: initial; list-style-image: initial;\"><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Màn hình:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">Chính: Dynamic AMOLED 2X, Phụ: Super AMOLED</span><span class=\"comma\">Chính 6.7\" &amp; Phụ 1.9\"</span><span class=\"\">Full HD+</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Hệ điều hành:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">Android 12</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Camera sau:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">2 camera 12 MP</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Camera trước:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">10 MP</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Chip:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">Snapdragon 8+ Gen 1</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">RAM:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">8 GB</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Dung lượng lưu trữ:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"\">128 GB</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex;\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">SIM:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">1 Nano SIM &amp; 1 eSIM</span><span class=\"\">Hỗ trợ 5G</span></div></li><li data-index=\"0\" data-prop=\"0\" style=\"padding: 10px; align-items: flex-start; display: flex; background-color: rgb(245, 245, 245);\"><p class=\"lileft\" style=\"margin-block: 0px; text-rendering: geometricprecision; width: 140px;\">Pin, Sạc:</p><div class=\"liright\" style=\"padding-right: 15px; padding-left: 50px; width: calc(100% - 140px);\"><span class=\"comma\">3700 mAh</span><span class=\"\">25 W</span></div></li></ul></div>', 'dien-thoai-samsung-galaxy-z-flip4-128gb-2118003682', 1),
(51, 12, 'Tai nghe SteelSeries Arctis Nova Booster Pack', 870000, 870000, '../assets/images/product/tai-nghe-steelseries-arctis-nova-booster-pack-2091670490.png', '<h1 itemprop=\"name\" class=\"product_title entry-title\" style=\"margin-bottom: 0.48em; font-size: 1.786em; font-family: &quot;Open Sans&quot;, HelveticaNeue-Light, &quot;Helvetica Neue Light&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-serif; line-height: 1.28em; color: rgb(51, 62, 72); letter-spacing: -0.14px;\">SteelSeries Arctis Nova Booster Pack</h1><div itemprop=\"description\" class=\"description-box\" style=\"overflow: hidden; line-height: 1.5em; color: rgb(125, 125, 125); margin-bottom: 3.214em; font-family: &quot;Open Sans&quot;, HelveticaNeue-Light, &quot;Helvetica Neue Light&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-serif; font-size: 14px; letter-spacing: -0.14px;\"><ul style=\"margin-bottom: 1rem; line-height: 25px;\"><li><span style=\"font-weight: 700;\">Tên sản phẩm:</span>&nbsp;SteelSeries&nbsp;Arctis Nova Booster Pack</li><li><span style=\"font-weight: 700;\">Thương hiệu:</span>&nbsp;SteelSeries&nbsp;</li><li><span style=\"font-weight: 700;\">Chức&nbsp;năng:</span>&nbsp;Thay đổi Headband và&nbsp;speaker plates theo sở thích với nhiều sự lựa chọn về màu sắc khác nhau.</li><li><span style=\"font-weight: 700;\">Màu:&nbsp;</span>Hồng, đỏ, tím, xanh lá</li><li><span style=\"font-weight: 700;\">Tương thích với:</span>&nbsp;Arctis Nova 7, Arctis Nova 7X, Arctis Nova 7P, Arctis Nova Pro, Arctis Nova Pro for Xbox, Arctis Nova Pro Wireless, Arctis Nova Pro Wireless for Xbox, Arctis Nova Pro Wireless for PlayStation</li><li><br></li></ul></div>', 'tai-nghe-steelseries-arctis-nova-booster-pack-2091670490', 1),
(52, 12, 'Tai nghe SteelSeries Arctis Nova 7 - New 2023', 5590000, 4590000, '../assets/images/product/tai-nghe-steelseries-arctis-nova-7-new-2023-59828047.png', '<h1 itemprop=\"name\" class=\"product_title entry-title\" style=\"margin-bottom: 0.48em; font-size: 1.786em; font-family: &quot;Open Sans&quot;, HelveticaNeue-Light, &quot;Helvetica Neue Light&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-serif; line-height: 1.28em; color: rgb(51, 62, 72); letter-spacing: -0.14px;\">Tai nghe SteelSeries Arctis Nova 7 - New 2023</h1><div itemprop=\"description\" class=\"description-box\" style=\"overflow: hidden; line-height: 1.5em; color: rgb(125, 125, 125); margin-bottom: 3.214em; font-family: &quot;Open Sans&quot;, HelveticaNeue-Light, &quot;Helvetica Neue Light&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Lucida Grande&quot;, sans-serif; font-size: 14px; letter-spacing: -0.14px;\"><ul style=\"margin-bottom: 1rem; line-height: 25px;\"><li><span style=\"font-weight: 700;\">Tên sản phẩm:&nbsp;</span>SteelSeries Artis Nova 7</li><li><span style=\"font-weight: 700;\">Thương hiệu:&nbsp;</span>SteelSeries</li><li><span style=\"font-weight: 700;\">Kiểu tai nghe:</span>&nbsp;Over-ear</li><li><span style=\"font-weight: 700;\">Màu:&nbsp;</span>Đen</li><li><span style=\"font-weight: 700;\">Âm thanh 360 độ:&nbsp;</span>có hỗ trợ</li><li><span style=\"font-weight: 700;\">Hình thức kết nối:</span>&nbsp;Không dây 2.4GHz</li><li><span style=\"font-weight: 700;\">Thời lương Pin:&nbsp;</span>38&nbsp;giờ</li><li><span style=\"font-weight: 700;\">Sạch nhanh:</span>&nbsp;6 giờ sử dụng chỉ trong 15 phút sạc</li><li><span style=\"font-weight: 700;\">Phạm vi kết nối:&nbsp;</span>12m</li><li><span style=\"font-weight: 700;\">Khung tai nghe:&nbsp;</span>Kim loại</li><li><span style=\"font-weight: 700;\">Công nghệ Microphone:&nbsp;</span>Khử tiếng ồn hai chiều Clearcast Gen 2</li><li><span style=\"font-weight: 700;\">Kích thước Driver:&nbsp;</span>40mm</li><li><span style=\"font-weight: 700;\">Trọng lượng:</span>&nbsp;354g</li><li><span style=\"font-weight: 700;\">Tương thích với:</span>&nbsp;PC, PS4, PS5,&nbsp;Nintendo Switch, MAC...</li></ul></div>', 'tai-nghe-steelseries-arctis-nova-7-new-2023-59828047', 1),
(53, 13, 'Keycap ABS Mix Màu không giới hạn, dùng để gắn vào bàn phím cơ, Profile OEM, phù hợp mọi layout Big ', 4090000, 4080000, '../assets/images/product/keycap-abs-mix-mau-khong-gioi-han-dung-de-gan-vao-ban-phim-co-profile-oem-phu-hop-moi-layout-big-cat-shop-406137242.png', '<p><span style=\"color: rgba(0, 0, 0, 0.8); font-family: \"Helvetica Neue\", Helvetica, Arial, 文泉驛正黑, \"WenQuanYi Zen Hei\", \"Hiragino Sans GB\", \"儷黑 Pro\", \"LiHei Pro\", \"Heiti TC\", 微軟正黑體, \"Microsoft JhengHei UI\", \"Microsoft JhengHei\", sans-serif; font-size: 14px; white-space: pre-wrap;\">Keycap ABS mix màu không giới hạn, dùng để gắn vào bàn phím cơ, Profile OEM, phù hợp các loại bàn phím layout chuẩn Ansi/Iso 60-87-104-108 keys\r\n\r\nĐây là keycap không phải bàn phím \r\n\r\n✪ Khách hàng có thể mix màu tùy theo ý muốn, sở thích bằng cách chọn màu viền ngoài và màu lõi bên trong\r\n✪ Chất liệu: Nhựa ABS chất lượng cao\r\n✪ Profile: OEM\r\n✪ Chất liệu in: Double Shot rõ ràng, xuyên led tốt, bền, không bị bay kí tự\r\n</span></p><div><span style=\"color: rgba(0, 0, 0, 0.8); font-family: \"Helvetica Neue\", Helvetica, Arial, 文泉驛正黑, \"WenQuanYi Zen Hei\", \"Hiragino Sans GB\", \"儷黑 Pro\", \"LiHei Pro\", \"Heiti TC\", 微軟正黑體, \"Microsoft JhengHei UI\", \"Microsoft JhengHei\", sans-serif; font-size: 14px; white-space: pre-wrap;\"><br></span></div>', 'keycap-abs-mix-mau-khong-gioi-han-dung-de-gan-vao-ban-phim-co-profile-oem-phu-hop-moi-layout-big-cat-shop-406137242', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_image`
--

CREATE TABLE `product_image` (
  `ID` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `product_image`
--

INSERT INTO `product_image` (`ID`, `product_id`, `name`) VALUES
(152, 47, '../assets/images/product/dien-thoai-iphone-14-pro-max-128gb--797719512-152.png'),
(154, 47, '../assets/images/product/dien-thoai-iphone-14-pro-max-128gb--797719512-154.png'),
(155, 47, '../assets/images/product/dien-thoai-iphone-14-pro-max-128gb--797719512-155.png'),
(156, 47, '../assets/images/product/dien-thoai-iphone-14-pro-max-128gb--797719512-156.png'),
(157, 47, '../assets/images/product/dien-thoai-iphone-14-pro-max-128gb--797719512-157.png'),
(158, 48, '../assets/images/product/dien-thoai-iphone-14-128gb--88082835-158.png'),
(165, 48, '../assets/images/product/dien-thoai-iphone-14-128gb--88082835-165.png'),
(166, 49, '../assets/images/product/dien-thoai-samsung-galaxy-s23-5g-256gb-1901991802-166.png'),
(167, 49, '../assets/images/product/dien-thoai-samsung-galaxy-s23-5g-256gb-1901991802-167.png'),
(169, 49, '../assets/images/product/dien-thoai-samsung-galaxy-s23-5g-256gb-1901991802-169.png'),
(170, 50, '../assets/images/product/dien-thoai-samsung-galaxy-z-flip4-128gb-2118003682-170.png'),
(171, 50, '../assets/images/product/dien-thoai-samsung-galaxy-z-flip4-128gb-2118003682-171.png'),
(172, 50, '../assets/images/product/dien-thoai-samsung-galaxy-z-flip4-128gb-2118003682-172.png'),
(173, 50, '../assets/images/product/dien-thoai-samsung-galaxy-z-flip4-128gb-2118003682-173.png'),
(174, 51, '../assets/images/product/tai-nghe-steelseries-arctis-nova-booster-pack-2091670490-174.png'),
(175, 51, '../assets/images/product/tai-nghe-steelseries-arctis-nova-booster-pack-2091670490-175.png'),
(176, 52, '../assets/images/product/tai-nghe-steelseries-arctis-nova-7-new-2023-59828047-176.png'),
(177, 52, '../assets/images/product/tai-nghe-steelseries-arctis-nova-7-new-2023-59828047-177.png'),
(178, 53, '../assets/images/product/keycap-abs-mix-mau-khong-gioi-han-dung-de-gan-vao-ban-phim-co-profile-oem-phu-hop-moi-layout-big-cat-shop-406137242-178.png'),
(179, 53, '../assets/images/product/keycap-abs-mix-mau-khong-gioi-han-dung-de-gan-vao-ban-phim-co-profile-oem-phu-hop-moi-layout-big-cat-shop-406137242-179.png'),
(180, 53, '../assets/images/product/keycap-abs-mix-mau-khong-gioi-han-dung-de-gan-vao-ban-phim-co-profile-oem-phu-hop-moi-layout-big-cat-shop-406137242-180.png');

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `ID` int(11) NOT NULL,
  `title` varchar(10000) NOT NULL,
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`ID`, `title`, `answer`) VALUES
(2, '[Khách hàng mới ] Làm sao tôi biết được khi nào sẽ giao hàng tới nơi?', '<p class=\"MsoNormal\" align=\"left\" style=\"margin-bottom: 0cm; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:\r\n16.0pt;font-family:Roboto;mso-fareast-font-family:&quot;Times New Roman&quot;;color:#333333;\r\nmso-bidi-font-weight:bold\">Khi nào đơn hàng của quý khách được giao đến nơi\r\nshiper sẽ gọi&nbsp; điện cho quý khách để\r\nthông báo nhận hàng. Trước khi trả tiền cho shiper quý khách có thể kiểm tra\r\nhàng trước trả để đảm bảo mẫu giày đúng hoặc có thể tiện yêu cầu trả hàng hoặc\r\nđổi hàng mà không mất thêm phí ship.<o:p></o:p></span></p>'),
(3, 'Tôi Muốn Kiểm Tra Sản Phẩm Trước Khi Nhận Hàng Có Được Hay Không?', '<p style=\"margin: 0cm 0cm 15.6pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;font-family:\"Arial\",sans-serif;\r\ncolor:black\">Bạn hoàn toàn có thể thực hiện kiểm tra sản phẩm trước khi nhận\r\nhàng </span><b><span style=\"font-size:16.0pt;font-family:\"Arial\",sans-serif;\r\ncolor:#C45911;mso-themecolor:accent2;mso-themeshade:191\">NikeStore </span></b><span style=\"font-size:16.0pt;font-family:\"Arial\",sans-serif;color:black\">khuyến\r\nkhích bạn áp dụng giải pháp này để có thể nhận được sản phẩm đúng như mình đặt\r\nmua.<o:p></o:p></span></p>'),
(4, 'Khi đặt hàng thành công thì trong bao lâu sẽ nhận được hàng?', '<p style=\"margin: 0cm 0cm 15.6pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;color:black\">Đối với khu\r\nvực trung tâm Hà Nội : Thời gian giao hàng dự kiến khoảng 60 phút.<o:p></o:p></span></p><p style=\"margin: 0cm 0cm 15.6pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;color:black\">Khu vực ngoại\r\nthành: Thời gian giao hàng dự kiến khoảng 60 phút – 120 phút.<o:p></o:p></span></p><p style=\"margin: 0cm 0cm 15.6pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;color:black\">Đối với các\r\ntỉnh thành trên cả nước: Thời gian giao hàng dự kiến từ 2-3 ngày, các khu vực\r\nvùng sâu, vùng xa thời gian có thể lâu hơn khoảng từ 3-5 ngày.</span><span style=\"font-size:16.0pt;color:black;mso-bidi-font-weight:normal\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"left\" style=\"margin-bottom: 0cm; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:\r\n16.0pt;font-family:Roboto;mso-fareast-font-family:&quot;Times New Roman&quot;;color:#333333\">Tùy\r\nvài khu vực nơi khách hàng đặt chúng\r\ntôi sẽ gọi điện xác nhận thời gian giao hàng chính xác hơn.<o:p></o:p></span></p><p>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n</p><p class=\"MsoNormal\" align=\"left\" style=\"margin-bottom: 0cm; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:\r\n16.0pt;font-family:Roboto;mso-fareast-font-family:&quot;Times New Roman&quot;;color:#333333\">Lưu\r\ný: Trong những dịp nghỉ lễ lớn thì thời\r\ngian giao hàng có thể chậm hơn bình thường do các đơn vị giao nhận nghỉ\r\nlễ.<o:p></o:p></span></p>'),
(5, 'Tôi muốn thay đổi địa chỉ nhận hàng có được không?', '<p class=\"MsoNormal\" align=\"left\" style=\"margin-bottom: 0cm; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:\r\n16.0pt;mso-fareast-font-family:&quot;Times New Roman&quot;;color:#333333;mso-bidi-font-weight:\r\nbold\">Khách hàng có thể thay đổi địa chỉ giao hàng được</span><span style=\"font-size:16.0pt;mso-fareast-font-family:&quot;Times New Roman&quot;;color:#333333\">.\r\nNếu quý khách mua hàng online thì hãy liên hệ ngay với Hotline : 0932.053.055. <o:p></o:p></span></p><p>\r\n\r\n</p><p class=\"MsoNormal\" align=\"left\" style=\"margin-bottom: 0cm; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:\r\n16.0pt;mso-fareast-font-family:&quot;Times New Roman&quot;;color:#333333\">Trước khi giao\r\nhàng nhân viên giao nhận sẽ gọi điện\r\ncho quý khách xác nhận thời gian và địa chỉ giao hàng lần cuối.<o:p></o:p></span></p>'),
(6, 'Thời gian làm việc của NikeStore như thế nào?', '<p class=\"MsoNormal\" align=\"left\" style=\"margin: 0cm 0cm 0cm 0; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;font-family:\r\nRoboto;mso-fareast-font-family:&quot;Times New Roman&quot;;color:#333333\">Nikestore mở\r\ncửa phục vụ quý khách hàng 7 ngày trên\r\ntuần, kể cả ngày lễ và chủ nhật (Trừ Tết Nguyên Đán)<o:p></o:p></span></p><p>\r\n\r\n</p><p class=\"MsoNormal\" align=\"left\" style=\"margin: 0cm 0cm 0cm 0; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;font-family:\r\nRoboto;mso-fareast-font-family:&quot;Times New Roman&quot;;color:#333333\">Thời gian làm\r\nviệc từ 9h’ – 19h’ tất cả các ngày trong tuần.<o:p></o:p></span></p>'),
(7, 'Đơn hàng bao nhiêu tiên được freeship ?', '<p class=\"MsoNormal\" align=\"left\" style=\"margin: 0cm 0cm 0cm 0; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;mso-fareast-font-family:\r\n&quot;Times New Roman&quot;;color:#333333\">Đơn hàng trên 1 triệu bên mình freeship nội\r\nthành hà nội nhé ạ <o:p></o:p></span></p><p class=\"MsoNormal\" align=\"left\" style=\"margin: 0cm 0cm 0cm 0; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;mso-fareast-font-family:\r\n&quot;Times New Roman&quot;;color:#333333\">( các đơn hàng lẻ ạ , đơn hàng sỉ không được\r\ntính ạ ) <o:p></o:p></span></p><p class=\"MsoNormal\" align=\"left\" style=\"margin: 0cm 0cm 0cm 0; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;mso-fareast-font-family:\r\n&quot;Times New Roman&quot;;color:#333333\">Shop nhận ship tận nhà với các đơn nội thành\r\nhà nội các bạn nhé<o:p></o:p></span></p><p>\r\n\r\n\r\n\r\n\r\n\r\n</p><p class=\"MsoNormal\" align=\"left\" style=\"margin: 0cm 0cm 0cm 0; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;mso-fareast-font-family:\r\n&quot;Times New Roman&quot;;color:#333333\">tuy nhiên do bên mình phải thuê ship nên các\r\nbạn phải thanh toán tiền ship ạ<o:p></o:p></span></p>'),
(8, 'Nếu khi nhận hàng mà size giày khách chọn bị bé hoặc to hơn so với chân thì shop có cho đổi không?', '<p class=\"MsoNormal\" align=\"left\" style=\"margin: 0cm 0cm 0cm 0; text-indent: 0cm; line-height: normal; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-size:16.0pt;mso-fareast-font-family:\r\n\" times=\"\" new=\"\" roman\";color:#333333;mso-bidi-font-weight:bold\"=\"\">Nếu trong trường hợp</span><span style=\"font-size:16.0pt;mso-fareast-font-family:\" times=\"\" new=\"\" roman\";color:#333333\"=\"\">\r\nmà size khách chọn bị bé hoặc to hơn mà sản phẩm vẫn còn nguyên tem mác không bị ảnh hưởng đến chất lượng sản phẩm không bóp méo thì khách hàng\r\nsẽ gửi mail cho Nike kèm hình\r\nảnh sản phẩm gửi lại cho cửa hàng va đổi lại size khác mà khách hàng sẽ\r\nphải chịu hoàn toàn phí ship.<o:p></o:p></span></p>'),
(11, 'qưe', '<p>dsv dv ss sa nj</p>');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`ID`, `name`) VALUES
(1, 'Admin'),
(2, 'Nhân viên quản lý sản phẩm'),
(3, 'Khách hàng'),
(4, 'Nhân viên quản lý đơn hàng'),
(5, 'Nhân viên chăm sóc khách hàng');

-- --------------------------------------------------------

--
-- Table structure for table `size`
--

CREATE TABLE `size` (
  `ID` int(11) NOT NULL,
  `name` varchar(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `size`
--

INSERT INTO `size` (`ID`, `name`, `status`) VALUES
(1, 'xanh', 1),
(2, 'đỏ', 1),
(3, 'trắng', 0),
(4, 'đen', 1),
(5, 'tím', 1);

-- --------------------------------------------------------

--
-- Table structure for table `storage`
--

CREATE TABLE `storage` (
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `storage`
--

INSERT INTO `storage` (`product_id`, `size_id`, `quantity`, `status`) VALUES
(47, 1, 10, 1),
(47, 2, 4, 1),
(47, 4, 45, 1),
(48, 1, 13, 1),
(48, 4, 56, 1),
(49, 1, 2, 1),
(50, 1, 44, 1),
(51, 1, 3, 1),
(52, 1, 52, 1),
(52, 2, 33, 1),
(53, 1, 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

CREATE TABLE `sub_category` (
  `ID` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `desc` text NOT NULL,
  `seo` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`ID`, `category_id`, `name`, `desc`, `seo`, `status`) VALUES
(10, 6, 'SamSung', 'SamSung', 'samsung-33030858', 1),
(11, 6, 'IPhone', 'IPhone', 'iphone-608913174', 1),
(12, 7, 'Tai nghe', 'Tai nghe', 'tai-nghe-1594240740', 1),
(13, 7, 'KeyCap', 'KeyCap', 'keycap-2074799529', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `point` decimal(13,0) DEFAULT 0,
  `avatar` varchar(1000) NOT NULL,
  `seo` varchar(100) NOT NULL,
  `active` tinyint(11) DEFAULT 1,
  `google_id` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID`, `role_id`, `username`, `password`, `name`, `email`, `phone`, `address`, `point`, `avatar`, `seo`, `active`, `google_id`) VALUES
(1, 3, 'manh123', 'fd8896e0f8a98e08a553437f09a6daaf', 'Nguyễn Tiến Mạnh', 'oresanjo123@gmail.com', '0705657315', 'Số nhà 28/52, Chùa Vẽ, Đông Hải 1, Hải An, Hải Phòng', 504379600, '../assets/images/avatar/manh123.png', 'nguyen-tien-manh', 1, ''),
(2, 2, 'dat123', '2e678024cabebdfe17a5aeef0163fe6d', 'Ngô Tiến Đạt', 'ngod7707@gmail.com', '0867697890', 'An Lão, Hải Phòng', 163200, '', 'ngo-tien-dat', 1, ''),
(42, 3, 'Tuấn Nghiêm Minh', '', 'Tuấn Nghiêm Minh', 'meoteo147@gmail.com', NULL, NULL, 0, 'https://lh3.googleusercontent.com/a/AGNmyxZszRrZxoYe974_ccTq6TCpr-z7Ss-5eibEjVeO=s96-c', 'tuan-nghiem-minh', 1, '110490848478780175729'),
(46, 1, 'ngoc123', '7bfe8ed9fc8127bfc322b6b24fd13e4d', 'ngoc dinh', 'ngockin0212@gmail.com', '0832262620', 'nam dịnh', 81600, '../assets/images/avatar/avatar.png', 'ngoc-dinh', 1, ''),
(51, 3, 'Đinh Ngọc', '', 'Đinh Ngọc', 'ngockin02@gmail.com', '02314672324', NULL, 91800, 'https://lh3.googleusercontent.com/a/AGNmyxYfa599b8RahXS_F1IRC8WV6RUMfd_xa9BWBDh-=s96-c', 'dinh-ngoc', 1, '108030950954742358840');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `orderdetail_order` (`order_id`),
  ADD KEY `orderdetail_product` (`product_id`),
  ADD KEY `orderdetail_size` (`size_id`);

--
-- Indexes for table `ordered`
--
ALTER TABLE `ordered`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `order_user` (`user_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `product_subcategory` (`sub_category_id`);

--
-- Indexes for table `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `product_image_product` (`product_id`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `size`
--
ALTER TABLE `size`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `storage`
--
ALTER TABLE `storage`
  ADD PRIMARY KEY (`product_id`,`size_id`),
  ADD KEY `storage_size` (`size_id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `subcategory_category` (`category_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orderdetail`
--
ALTER TABLE `orderdetail`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `ordered`
--
ALTER TABLE `ordered`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `size`
--
ALTER TABLE `size`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD CONSTRAINT `orderdetail_order` FOREIGN KEY (`order_id`) REFERENCES `ordered` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetail_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetail_size` FOREIGN KEY (`size_id`) REFERENCES `size` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ordered`
--
ALTER TABLE `ordered`
  ADD CONSTRAINT `order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_subcategory` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_category` (`ID`);

--
-- Constraints for table `product_image`
--
ALTER TABLE `product_image`
  ADD CONSTRAINT `product_image_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `storage`
--
ALTER TABLE `storage`
  ADD CONSTRAINT `storage_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `storage_size` FOREIGN KEY (`size_id`) REFERENCES `size` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD CONSTRAINT `subcategory_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
