-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2024 at 07:35 PM
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
-- Database: `incident_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `idComment` int(11) NOT NULL,
  `content` text NOT NULL,
  `comment_date` datetime DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL,
  `incident_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`idComment`, `content`, `comment_date`, `user_id`, `incident_id`) VALUES
(1, 'Please fix this as soon as possible.', '2024-09-03 13:17:04', 1, 1),
(2, 'The electrician is working on it.', '2024-09-03 13:17:04', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `id_image` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `incident_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`id_image`, `image_path`, `incident_id`) VALUES
(1, '/images/water_leak_bathroom.jpg', 1),
(2, '/images/flickering_light_hallway.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `incident`
--

CREATE TABLE `incident` (
  `idIncident` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `incident_type` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `report_date` datetime DEFAULT current_timestamp(),
  `status` enum('Pending','In Progress','Resolved') NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `incident`
--

INSERT INTO `incident` (`idIncident`, `subject`, `incident_type`, `description`, `location`, `report_date`, `status`, `user_id`, `image`) VALUES
(1, 'Water Leak', 'Plumbing', 'There is a water leak in the bathroom on the third floor.', 'Bathroom - Third Floor', '2024-09-03 13:16:37', 'Resolved', 1, NULL),
(2, 'Flickering Light', 'Electrical', 'The hallway light flickers constantly.', 'Hallway - Second Floor', '2024-09-03 13:16:37', 'In Progress', 2, NULL),
(3, 'Quasi aut quibusdam ', 'Plumbing', 'Quas aute mollitia v', 'Esse enim id culpa ', '2024-09-13 05:54:03', 'Pending', NULL, NULL),
(4, 'Praesentium itaque e', 'Pests and Infestations', 'A quos culpa ad aut', 'Dolor doloremque bla', '2024-09-13 06:05:57', 'Pending', NULL, NULL),
(5, 'Esse officiis labor', 'Plumbing', 'Aut ex ut quae et', 'Velit corrupti qui', '2024-09-13 09:09:01', 'Pending', NULL, '1726236541225-456517175_8325861507472744_4289665094913733341_n.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('resident','administrator') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `first_name`, `last_name`, `email`, `password`, `user_type`) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 'hashed_password1', 'resident'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password2', 'resident'),
(3, 'david', 'cambeiro', 'cambeiro@example.com', '$2b$10$kGRJqIPcWtqOKBUSPmrjBe8xs9tIlHsLYH4SI5bVsHk4oopyrEIwK', 'administrator'),
(4, 'Harold', 'ElMasPacienteyPro', 'Harold@example.com', '$2b$10$MpezSCKt20/.lKRc3SCbLOWJa4dprOSpJZhG.rj5qxNCrKZ7VSyDe', 'resident');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`idComment`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `incident_id` (`incident_id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id_image`),
  ADD KEY `incident_id` (`incident_id`);

--
-- Indexes for table `incident`
--
ALTER TABLE `incident`
  ADD PRIMARY KEY (`idIncident`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `idComment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `id_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `incident`
--
ALTER TABLE `incident`
  MODIFY `idIncident` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `Comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `Comment_ibfk_2` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`idIncident`) ON DELETE CASCADE;

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `Image_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`idIncident`) ON DELETE CASCADE;

--
-- Constraints for table `incident`
--
ALTER TABLE `incident`
  ADD CONSTRAINT `Incident_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
