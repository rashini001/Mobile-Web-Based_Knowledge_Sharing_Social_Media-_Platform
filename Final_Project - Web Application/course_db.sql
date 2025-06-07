-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 14, 2025 at 04:50 AM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `course_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
CREATE TABLE IF NOT EXISTS `assignments` (
  `id` varchar(50) NOT NULL,
  `playlist_id` varchar(50) DEFAULT NULL,
  `tutor_id` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `file` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `pdf` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `playlist_id` (`playlist_id`),
  KEY `tutor_id` (`tutor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assignments`
--

INSERT INTO `assignments` (`id`, `playlist_id`, `tutor_id`, `title`, `description`, `file`, `image`, `pdf`, `created_at`, `updated_at`) VALUES
('iqu2GrABjncSsVS56npb', 'RN2tIRCbVF7KAKGIBuGZ', 'Mm1xBmE6b6lee2cEkSxa', 'What is Machine Learning', 'Create Report about Evalaution of Machine Learning', NULL, 'lorP2tpaMsxGgx8IxTY2.png', 'IoX5gOekRZEjolvMxQxF.pdf', '2024-11-26 14:47:18', '2024-11-26 15:28:14'),
('9uOPh90YoLvTbwEF4hKA', 'Mgkk3WnKfsaaYxSheYSI', 'iwh8V7GPh7BvyjZGq53g', '1st Mobile Application', 'Create simple mobile application using flutter and firebase', NULL, 'ISOgbhP0LFGhBbNv1RlE.jpg', 'iw69h7GHylzFsroHLys0.pdf', '2024-12-05 16:17:10', '2024-12-05 16:17:28');

-- --------------------------------------------------------

--
-- Table structure for table `bookmark`
--

DROP TABLE IF EXISTS `bookmark`;
CREATE TABLE IF NOT EXISTS `bookmark` (
  `user_id` varchar(20) NOT NULL,
  `playlist_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bookmark`
--

INSERT INTO `bookmark` (`user_id`, `playlist_id`) VALUES
('nTwO1dhNU0NuChjdIyqh', 'KRv8RlPgI1cu3iC3OTHY'),
('nTwO1dhNU0NuChjdIyqh', 'C2emXGpAbhc2Hnev0wTI'),
('bHU82BQLJsxMbK634lmF', 'KRv8RlPgI1cu3iC3OTHY');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` varchar(20) NOT NULL,
  `content_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `tutor_id` varchar(20) NOT NULL,
  `comment` text NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `content_id` (`content_id`),
  KEY `user_id` (`user_id`),
  KEY `tutor_id` (`tutor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `content_id`, `user_id`, `tutor_id`, `comment`, `date`) VALUES
('OfDIzcgS6MqKtLEXV3t4', '1', 'RkG7dItVcWSSBzFymAeZ', 'iwh8V7GPh7BvyjZGq53g', 'Good Explenation', '2024-12-05 16:27:26');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `number` int NOT NULL,
  `message` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`name`, `email`, `number`, `message`) VALUES
('rashini', 'rashini453@gmail.com', 915904695, 'i want to enroll new course.how it do'),
('rashini', 'rashini453@gmail.com', 915904695, 'Hello'),
('rashini', 'rashini453@gmail.com', 935904695, 'hii'),
('rashini', 'rashini453@gmail.com', 915904695, 'hii'),
('amali', 'amali@gmail.com', 912345678, 'hello'),
('rashini', 'rashini453@gmail.com', 912345678, 'Hello'),
('rashini', 'rashini453@gmail.com', 935904695, 'helloooo'),
('rashini', 'rashini453@gmail.com', 913452345, 'i want to know about new java course');

-- --------------------------------------------------------

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
CREATE TABLE IF NOT EXISTS `content` (
  `id` varchar(20) NOT NULL,
  `tutor_id` varchar(20) NOT NULL,
  `playlist_id` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `video` varchar(100) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `date` int NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'deactive'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `content`
--

INSERT INTO `content` (`id`, `tutor_id`, `playlist_id`, `title`, `description`, `video`, `thumb`, `date`, `status`) VALUES
('1', 'iwh8V7GPh7BvyjZGq53g', 'Mgkk3WnKfsaaYxSheYSI', '1st Mobile Application', 'Create a Simple Mobile Application ', '', '6zW1FuCeAhPNEdG1FrYk.jpg', 0, 'active'),
('fAxPUzsFbWlatGzg4mV1', 'zh12PwMcbfYptFuYkoLG', 'gJ8n2Dplnpg5on2ObRV8', '1st module', 'create simple mobile application', 'hbnFmLUXf9Ubthv7tkKF.mp4', 'EVP7O2GbyFvHBKGhq2XG.jpg', 0, 'deactive');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
CREATE TABLE IF NOT EXISTS `enrollments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `playlist_id` varchar(20) NOT NULL,
  `status` enum('pending','approved') DEFAULT 'pending',
  `requested_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `approved_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `playlist_id` (`playlist_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`id`, `user_id`, `playlist_id`, `status`, `requested_at`, `approved_at`) VALUES
(1, 'bHU82BQLJsxMbK634lmF', 'f9Gl7PgN3kJdfykaAoFB', 'approved', '2024-12-05 11:52:19', '2024-12-05 11:54:30'),
(2, 'bHU82BQLJsxMbK634lmF', 'Mgkk3WnKfsaaYxSheYSI', 'approved', '2024-12-05 11:54:26', '2024-12-05 11:55:10'),
(3, 'bHU82BQLJsxMbK634lmF', 'C2emXGpAbhc2Hnev0wTI', 'pending', '2024-12-05 11:59:16', NULL),
(4, 'TeqkJrUlEniOtUH76nml', 'f9Gl7PgN3kJdfykaAoFB', 'approved', '2024-12-05 12:10:31', '2024-12-05 21:34:42'),
(5, 'TeqkJrUlEniOtUH76nml', 'Mgkk3WnKfsaaYxSheYSI', 'approved', '2024-12-05 12:10:38', '2024-12-05 12:11:37'),
(6, 'RkG7dItVcWSSBzFymAeZ', 'f9Gl7PgN3kJdfykaAoFB', 'approved', '2024-12-05 21:19:23', '2024-12-05 21:34:45'),
(7, 'RkG7dItVcWSSBzFymAeZ', 'Mgkk3WnKfsaaYxSheYSI', 'approved', '2024-12-05 21:51:36', '2024-12-05 22:01:01'),
(8, 'Inq9P71Dd8yXgq6BSHqZ', 'f9Gl7PgN3kJdfykaAoFB', 'approved', '2024-12-09 13:17:36', '2024-12-09 13:21:46');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `tutor_id` varchar(20) NOT NULL,
  `content_id` varchar(20) NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `tutor_id` (`tutor_id`),
  KEY `content_id` (`content_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `tutor_id`, `content_id`, `date`) VALUES
(1, 'RkG7dItVcWSSBzFymAeZ', 'iwh8V7GPh7BvyjZGq53g', '1', '2024-12-05 16:27:58');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `attempt_time` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  KEY `attempt_time` (`attempt_time`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `email`, `attempt_time`) VALUES
(1, 'rashini@gmail.com', 1733381282),
(2, 'rashini@gmail.com', 1733381296),
(3, 'rashini@gmail.com', 1733381376),
(4, 'kaveesha@gmail.com', 1733730351),
(5, 'kaveesha@gmail.com', 1733730379);

-- --------------------------------------------------------

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
CREATE TABLE IF NOT EXISTS `playlist` (
  `id` varchar(20) NOT NULL,
  `tutor_id` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `date` int NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'deactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `playlist`
--

INSERT INTO `playlist` (`id`, `tutor_id`, `title`, `description`, `thumb`, `date`, `status`) VALUES
('KRv8RlPgI1cu3iC3OTHY', '5DTd3Zyjd0UOYz295GuK', 'iot', 'iot playlist', 'W4Hd5f5ktc50ZnoKVTsF.jpg', 0, 'active'),
('C2emXGpAbhc2Hnev0wTI', 'am6ShOa8t0wpmc5qTekW', 'become a desginer', '.............', '3W3t42UWnG3z1HENSM9M.png', 0, 'active'),
('RN2tIRCbVF7KAKGIBuGZ', 'Mm1xBmE6b6lee2cEkSxa', 'Machine Learning', 'Learn about machine learning', 'dmXqALYv89cbop6vVTzy.png', 0, 'deactive'),
('Mgkk3WnKfsaaYxSheYSI', 'iwh8V7GPh7BvyjZGq53g', 'Mobile Application', 'Learning how to develop mobile applications is an exciting journey that combines creativity and technology.It involves coding, designing user-friendly interfaces, and using tools to make apps work smoothly. With practice, you can build apps that solve problems or entertain users.\r\n\r\n\r\n\r\n\r\n\r\n\r\n', '6zW1FuCeAhPNEdG1FrYk.jpg', 0, 'active'),
('f9Gl7PgN3kJdfykaAoFB', 'iwh8V7GPh7BvyjZGq53g', 'ui/ux', '1st UI design&#39;&#39;&#39;&#39;', 'hASvrczUwn8IqGWByt0x.jpg', 0, 'active'),
('LKF4RdenZxBUwWrHhtOg', 'RL4bkjaTiQ7oqI7k7VdQ', 'Full-stack Journey', 'Be a Good Developer.....', 'ubVVuDwtNbz1nphLOHD8.png', 0, 'active'),
('gJ8n2Dplnpg5on2ObRV8', 'zh12PwMcbfYptFuYkoLG', 'mobile', '....', '7akGdPkAFkbrBrdjDeki.png', 0, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
CREATE TABLE IF NOT EXISTS `submissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assignment_id` varchar(50) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `file` varchar(255) NOT NULL,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `grade` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assignment_id` (`assignment_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`id`, `assignment_id`, `user_id`, `file`, `submitted_at`, `grade`) VALUES
(1, 'C2emXGpAbhc2Hnev0wTI', 'bHU82BQLJsxMbK634lmF', 'wGheVe2gz2cpYydjvtvp.pdf', '2024-11-27 12:02:20', NULL),
(2, 'C2emXGpAbhc2Hnev0wTI', 'bHU82BQLJsxMbK634lmF', 'wGheVe2gz2cpYydjvtvp.pdf', '2024-11-27 12:03:19', NULL),
(3, 'C2emXGpAbhc2Hnev0wTI', 'bHU82BQLJsxMbK634lmF', 'wGheVe2gz2cpYydjvtvp.pdf', '2024-11-27 12:08:09', NULL),
(4, 'AJ2bL7m6UvhodeqsPfis', 'bHU82BQLJsxMbK634lmF', 'Jo Confirmation Application.pdf', '2024-11-27 16:49:10', '50.5'),
(5, '2GXTPHoM9lwu6Jvue1qI', 'bHU82BQLJsxMbK634lmF', 'IoX5gOekRZEjolvMxQxF (1).pdf', '2024-11-27 16:51:36', NULL),
(6, 'yDL17Hk09q9NMrlDcx6l', 'bHU82BQLJsxMbK634lmF', '67489db029c32-Jo Confirmation Application (1).pdf', '2024-11-28 16:43:28', '23.9'),
(7, 'Cc9HY176oB9LS6mdzadi', 'bHU82BQLJsxMbK634lmF', '67489e39bd713-Trainee Guideline Document.pdf', '2024-11-28 16:45:45', '34'),
(8, 'gCwf7DebZcwYRAJc2LPf', 'bHU82BQLJsxMbK634lmF', '674a948cb717b-University Letter.pdf', '2024-11-30 04:29:00', '50'),
(9, 'CCmdFcr2ls5ebBoXNlIr', 'bHU82BQLJsxMbK634lmF', '674aab87bcb5a-Jo Confirmation Application.pdf', '2024-11-30 06:07:03', '45'),
(10, 'PAc8gjvrDjMdB5tknSeu', 'Inq9P71Dd8yXgq6BSHqZ', '674beac08116c-Technology Subject for Middle School_ Let\'s Celebrate Happy Techies Day! by Slidesgo (1).pptx', '2024-12-01 04:49:04', '70'),
(11, 'Meh0m3WdjPqMbHANgNZg', 'Inq9P71Dd8yXgq6BSHqZ', '674c20ecc3983-Trainee Guideline Document.pdf', '2024-12-01 08:40:12', '85'),
(12, '9uOPh90YoLvTbwEF4hKA', 'RkG7dItVcWSSBzFymAeZ', '6751d61a54090-Diploma Result Sheet.jpeg', '2024-12-05 16:34:34', '56.8');

-- --------------------------------------------------------

--
-- Table structure for table `tutors`
--

DROP TABLE IF EXISTS `tutors`;
CREATE TABLE IF NOT EXISTS `tutors` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `profession` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `failed_attempts` int DEFAULT '0',
  `last_failed_time` int DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `user_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tutors`
--

INSERT INTO `tutors` (`id`, `name`, `profession`, `email`, `password`, `failed_attempts`, `last_failed_time`, `image`, `user_id`) VALUES
('5DTd3Zyjd0UOYz295GuK', 'imangana kodithuwakku', 'engineer', 'imanganakodi@gmail.c', '5f1186820eb292ecae44776678d1f3c0851805d8', 1, 1732724338, 'muWtFIjSnhesWJoooN87.jpeg', '0'),
('am6ShOa8t0wpmc5qTekW', 'sandani', 'desginer', 'sandaniheshara659@gm', '7a21ecc2060d586e1d4bb1364420501ee4ed2fa1', 0, NULL, 'bWosP0mg9uWDlIRJVFCx.jpg', '0'),
('XNcrG8c8UtXwZ8H4Ptk1', 'nimal', 'mobile', 'nimal@gmail.com', 'da1f7491b26a2816d0cb3dceab5149418da42e97', 2, 1736746159, '5yKttKQtAFxHilHDhTTn.jpeg', '0'),
('QGPEADWrqAFlB55IEfrl', 'Imangana', 'designer', 'ima@gmail.com', 'a663a2924eec49ca341e2193a0835e2d991709fb', 0, NULL, 'Ws6t3qZJZx4M3lt0RHpe.jpg', '0'),
('Mm1xBmE6b6lee2cEkSxa', 'Sanduni', 'mobile', 'sandani@gmail.com', 'eb7246d3820102d833ce2d6c7b1f6bc8d95ff6a5', 0, 1733367185, 'g4oFR03dn2zznrhS2FRc.jpeg', '0'),
('iwh8V7GPh7BvyjZGq53g', 'pathumi', 'desginer', 'pathumi@gmail.com', '75a60bb1f53f39a6b890028c9bebefe6a70a2386', 0, 1733730580, 'D0sm6aPnCiXHWnlWKqQZ.png', '0'),
('RL4bkjaTiQ7oqI7k7VdQ', 'Nadun', 'full', 'nadun@gmail.com', '6fb2fc7258459966c85b074e34805b4becdc9c30', 0, 1733413898, 'Qer5pfzPcQCAh0XJ0kuQ.jpg', ''),
('zh12PwMcbfYptFuYkoLG', 'nethu', 'mobile', 'nethu@gmail.com', '60e0d6f2c6048bafb813d33b2831eb0401a86dc0', 0, NULL, 'raWziGVRSBkeAhjLQ2mL.png', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `image`) VALUES
('LqdhMdrdoPX4MNJUF6xb', 'rashini', 'rashini453@gmail.com', 'fa23015d2a3c85ef529954c7d82173eb139addfa', 'XlgyZ8ttobT0UhcY3nKT.jpeg'),
('nTwO1dhNU0NuChjdIyqh', 'rashini', 'umali@gmail.com', 'b638de3267702e4eb9b9d76419de92760bc9550f', 'bQVzYS69ThFVzO5BsD7r.jpg'),
('5v9oxSmGDL6IZsKwwIFL', 'anuki', 'anuki@gmail.com', '0ce8c49bdc4355e8666be5eef01ae8a8707bae30', 'JRLwGD1iaktR3Wnl47D8.jpg'),
('drMe3Njck3HSJqfCQwXF', 'ra', 'rashini453@gmailcom', '759e627b134feab257528d7bd2b4ea89fed723a3', 'ph2RGU34cbQbnOXlQ5Rj.jpeg'),
('kYFQDlLDyBPhELFVOXTx', 'Amali', 'amali@gmail.com', 'fd4a758cda7375482344c4f2a6890c8ac2a59185', 'hMnXWU5nGVrqoRpUtX6E.jpeg'),
('bHU82BQLJsxMbK634lmF', 'rashini', 'rashini@gmail.com', 'b638de3267702e4eb9b9d76419de92760bc9550f', 'UQN7d0xvllDtlvR78sxC.jpg'),
('jbf2TRPrs3ejl59uyhDp', 'rashini', 'rashini1@gmail.com', 'b638de3267702e4eb9b9d76419de92760bc9550f', 'umVft9eNRyfe9ehxwhMK.jpg'),
('6tAaL09iytSCV7tbnTn1', 'rashini shehana', 'rash1@gmail.com', 'c8c7a026affe6c588b662fe54d21d2e27c0a0f09', '6eBjeODP9ASXKggGgv6D.jpg'),
('TeqkJrUlEniOtUH76nml', 'Shehana', 'shehana@gmail.com', 'ab8facb51474849565406bfa15b7e1b71203dc58', 'eeceUoEmdt1LWftdrjY0.jpeg'),
('Inq9P71Dd8yXgq6BSHqZ', 'Kaveesha Chamodi', 'kaveesha@gmail.com', '716154c09f81db694c019e9fd75942377e45523c', 'dFUW4IpeSbNEXRpAWTxa.jpg'),
('RkG7dItVcWSSBzFymAeZ', 'Amaya', 'amaya@gmail.com', '3c61a2fce7a51116abc723b64ae40ece0062e347', 'Mswvk40NaoLZigPRPwK7.jpg');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
