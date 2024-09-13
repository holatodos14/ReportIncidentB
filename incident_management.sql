-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------

--
-- Table structure for table `Comment`
--

CREATE TABLE `Comment` (
  `idComment` int(11) NOT NULL,
  `content` text NOT NULL,
  `comment_date` datetime DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL,
  `incident_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Comment`
--

INSERT INTO `Comment` (`idComment`, `content`, `comment_date`, `user_id`, `incident_id`) VALUES
(1, 'Please fix this as soon as possible.', '2024-09-03 13:17:04', 1, 1),
(2, 'The electrician is working on it.', '2024-09-03 13:17:04', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Image`
--

CREATE TABLE `Image` (
  `id_image` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `incident_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Image`
--

INSERT INTO `Image` (`id_image`, `image_path`, `incident_id`) VALUES
(1, '/images/water_leak_bathroom.jpg', 1),
(2, '/images/flickering_light_hallway.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `Incident`
--

CREATE TABLE `Incident` (
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
-- Dumping data for table `Incident`
--

INSERT INTO `Incident` (`idIncident`, `subject`, `incident_type`, `description`, `location`, `report_date`, `status`, `user_id`, `image`) VALUES
(1, 'Water Leak', 'Plumbing', 'There is a water leak in the bathroom on the third floor.', 'Bathroom - Third Floor', '2024-09-03 13:16:37', 'Resolved', 1, NULL),
(2, 'Flickering Light', 'Electrical', 'The hallway light flickers constantly.', 'Hallway - Second Floor', '2024-09-03 13:16:37', 'In Progress', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `id_user` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('resident','administrator') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`id_user`, `first_name`, `last_name`, `email`, `password`, `user_type`) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 'hashed_password1', 'resident'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password2', 'resident');

-- --------------------------------------------------------

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Comment`
--
ALTER TABLE `Comment`
  ADD PRIMARY KEY (`idComment`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `incident_id` (`incident_id`);

--
-- Indexes for table `Image`
--
ALTER TABLE `Image`
  ADD PRIMARY KEY (`id_image`),
  ADD KEY `incident_id` (`incident_id`);

--
-- Indexes for table `Incident`
--
ALTER TABLE `Incident`
  ADD PRIMARY KEY (`idIncident`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Comment`
--
ALTER TABLE `Comment`
  MODIFY `idComment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Image`
--
ALTER TABLE `Image`
  MODIFY `id_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Incident`
--
ALTER TABLE `Incident`
  MODIFY `idIncident` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Comment`
--
ALTER TABLE `Comment`
  ADD CONSTRAINT `Comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `Comment_ibfk_2` FOREIGN KEY (`incident_id`) REFERENCES `Incident` (`idIncident`) ON DELETE CASCADE;

--
-- Constraints for table `Image`
--
ALTER TABLE `Image`
  ADD CONSTRAINT `Image_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `Incident` (`idIncident`) ON DELETE CASCADE;

--
-- Constraints for table `Incident`
--
ALTER TABLE `Incident`
  ADD CONSTRAINT `Incident_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`id_user`) ON DELETE CASCADE;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;
