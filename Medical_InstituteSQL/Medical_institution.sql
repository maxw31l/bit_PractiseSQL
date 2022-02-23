-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 23, 2022 at 09:44 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Medical institution`
--

-- --------------------------------------------------------

--
-- Table structure for table `Pacient`
--

CREATE TABLE `Pacient` (
  `Id` int(255) NOT NULL,
  `Visit_Id` int(255) NOT NULL,
  `User_id` int(255) NOT NULL,
  `History_book_id` int(255) NOT NULL,
  `First_name` varchar(255) NOT NULL,
  `Last_name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Last_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Role`
--

CREATE TABLE `Role` (
  `Id` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Level` varchar(255) NOT NULL,
  `Last_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Scheedule`
--

CREATE TABLE `Scheedule` (
  `Id` int(11) NOT NULL,
  `User_Id` int(11) NOT NULL,
  `Work_date` date NOT NULL,
  `Start_work_hour` datetime NOT NULL,
  `End_work_hour` datetime NOT NULL,
  `Even_day` tinyint(1) NOT NULL,
  `Odd_day` tinyint(1) NOT NULL,
  `Last_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Service`
--

CREATE TABLE `Service` (
  `Id` int(255) NOT NULL,
  `Visit_Id` int(255) NOT NULL,
  `Service_type_name` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `Id` int(255) NOT NULL,
  `Role_Id` int(255) NOT NULL,
  `Access_level_Id` int(255) NOT NULL,
  `Scheedule_Id` int(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `First_Name` varchar(255) NOT NULL,
  `Last_Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Visit`
--

CREATE TABLE `Visit` (
  `Id` int(255) NOT NULL,
  `Pacient_Id` int(255) NOT NULL,
  `Service_Id` int(255) NOT NULL,
  `Date` date NOT NULL,
  `Start_time` datetime NOT NULL,
  `End_time` datetime NOT NULL,
  `Expected_price` float NOT NULL,
  `Full_price` float NOT NULL,
  `Discount` float NOT NULL,
  `Final_price` float NOT NULL,
  `Cancelled` tinyint(1) NOT NULL,
  `Cancellation_reason` varchar(255) NOT NULL,
  `Last_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `visit_service`
--

CREATE TABLE `visit_service` (
  `Id` int(255) NOT NULL,
  `Visit_Id` int(255) NOT NULL,
  `Service_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Pacient`
--
ALTER TABLE `Pacient`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `User_id` (`User_id`),
  ADD UNIQUE KEY `Visit_Id` (`Visit_Id`);

--
-- Indexes for table `Role`
--
ALTER TABLE `Role`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `Scheedule`
--
ALTER TABLE `Scheedule`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `User_Id` (`User_Id`);

--
-- Indexes for table `Service`
--
ALTER TABLE `Service`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Type_of_service_id` (`Service_type_name`),
  ADD UNIQUE KEY `Visit_Id` (`Visit_Id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Role_Id` (`Role_Id`),
  ADD UNIQUE KEY `Access_level_Id` (`Access_level_Id`),
  ADD UNIQUE KEY `Scheedule_Id` (`Scheedule_Id`),
  ADD UNIQUE KEY `Access_level_Id_2` (`Access_level_Id`),
  ADD KEY `Access_level_Id_3` (`Access_level_Id`);

--
-- Indexes for table `Visit`
--
ALTER TABLE `Visit`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Service_Id` (`Service_Id`),
  ADD UNIQUE KEY `Pacient_Id` (`Pacient_Id`);

--
-- Indexes for table `visit_service`
--
ALTER TABLE `visit_service`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Visit_Id` (`Visit_Id`,`Service_id`),
  ADD KEY `Service_id` (`Service_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Pacient`
--
ALTER TABLE `Pacient`
  ADD CONSTRAINT `Pacient_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `User` (`Id`);

--
-- Constraints for table `Service`
--
ALTER TABLE `Service`
  ADD CONSTRAINT `Service_ibfk_1` FOREIGN KEY (`Service_type_name`) REFERENCES `Service_type` (`Id`),
  ADD CONSTRAINT `Service_ibfk_2` FOREIGN KEY (`Id`) REFERENCES `visit_service` (`Service_id`);

--
-- Constraints for table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `User_ibfk_1` FOREIGN KEY (`Role_Id`) REFERENCES `Role` (`Id`),
  ADD CONSTRAINT `User_ibfk_2` FOREIGN KEY (`Access_level_Id`) REFERENCES `Access_level` (`Id`),
  ADD CONSTRAINT `User_ibfk_3` FOREIGN KEY (`Scheedule_Id`) REFERENCES `Scheedule` (`Id`);

--
-- Constraints for table `Visit`
--
ALTER TABLE `Visit`
  ADD CONSTRAINT `Visit_ibfk_1` FOREIGN KEY (`Pacient_Id`) REFERENCES `Pacient` (`Id`);

--
-- Constraints for table `visit_service`
--
ALTER TABLE `visit_service`
  ADD CONSTRAINT `visit_service_ibfk_1` FOREIGN KEY (`Visit_Id`) REFERENCES `Visit` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
