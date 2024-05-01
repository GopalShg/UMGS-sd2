-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: May 01, 2024 at 06:16 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `UNIVERSITY`
--

-- --------------------------------------------------------

--
-- Table structure for table `Course`
--

CREATE TABLE `Course` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Course`
--

INSERT INTO `Course` (`id`, `name`, `description`) VALUES
(1, 'Introduction to Programming', 'A beginner-friendly course on programming fundamentals'),
(2, 'Database Management Systems', 'Learn the concepts and practices of relational database management'),
(3, 'Cyber Security', 'Cybersecurity is a fast-paced and ever-evolving field, which means you\'ll need to stay updated on the latest trends, technologies, and threats.'),
(4, 'Computer System', 'computer system is a combination of hardware, software, and data. Users interact with it through input devices. Together, these elements allow computers to process information, store data, and perform various tasks. From personal laptops to massive servers, computer systems are integral to modern life, enabling everything from work and communication to entertainment and research.'),
(5, 'Web Development', 'Web development involves creating websites and web applications for the Internet. It includes frontend development, backend development, full-stack development, web design, responsive design, performance optimization, and security. It\'s essential for establishing an online presence and involves a variety of skills and technologies.'),
(6, 'AV Resources', 'AV (Audio-Visual) resources refer to tools and materials that combine both sound and visual elements for communication or presentation purposes. They enhance learning, entertainment, and communication experiences by engaging multiple senses simultaneously');

-- --------------------------------------------------------

--
-- Table structure for table `Enrollments`
--

CREATE TABLE `Enrollments` (
  `enrollment_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Enrollments`
--

INSERT INTO `Enrollments` (`enrollment_id`, `student_id`, `course_id`) VALUES
(1, 1, 2),
(2, 1, 5),
(3, 1, 6),
(4, 2, 1),
(5, 2, 3),
(6, 3, 3),
(7, 3, 4),
(8, 3, 6),
(9, 4, 3),
(10, 4, 5),
(11, 5, 3),
(12, 5, 2),
(13, 5, 6);

-- --------------------------------------------------------

--
-- Table structure for table `Result`
--

CREATE TABLE `Result` (
  `id` int NOT NULL,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `grade` varchar(10) NOT NULL,
  `Remarks` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Result`
--

INSERT INTO `Result` (`id`, `student_id`, `course_id`, `grade`, `Remarks`) VALUES
(1, 1, 1, 'A', 'Pass'),
(2, 2, 2, 'B+', 'Pass.\nNeed more hard work'),
(3, 3, 2, 'B+', 'Pass\nNeed more hard work.'),
(4, 4, 1, 'B', 'Pass\nWork hard.'),
(5, 5, 1, 'A++', 'Pass\nVery good.');

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `Courselevel` int DEFAULT NULL,
  `Academic_year` varchar(29) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`id`, `name`, `email`, `Courselevel`, `Academic_year`) VALUES
(1, 'John Doe', 'john.doe@example.com', 7, '2024'),
(2, 'Jane Smith', 'jane.smith@example.com', 6, '2023'),
(3, 'Lucy Smith', 'example@3hotmail.com', 6, '2024'),
(4, 'Mattius marsh', 'example@4hotmail.com', 7, '2023'),
(5, 'Kristy Morocco', 'example@5hotmail.com', 6, '2022');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Course`
--
ALTER TABLE `Course`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Enrollments`
--
ALTER TABLE `Enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `Result`
--
ALTER TABLE `Result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Course`
--
ALTER TABLE `Course`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Enrollments`
--
ALTER TABLE `Enrollments`
  MODIFY `enrollment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `Result`
--
ALTER TABLE `Result`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Student`
--
ALTER TABLE `Student`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Enrollments`
--
ALTER TABLE `Enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `Student` (`id`),
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `Course` (`id`);

--
-- Constraints for table `Result`
--
ALTER TABLE `Result`
  ADD CONSTRAINT `result_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `Student` (`id`),
  ADD CONSTRAINT `result_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `Course` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
