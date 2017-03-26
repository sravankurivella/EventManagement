-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 08, 2015 at 07:15 AM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eventmanagementsystem`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_transaction`(IN `evid` INT, IN `customerid` INT, IN `numtkts` INT)
    MODIFIES SQL DATA
BEGIN
  DECLARE totalcost FLOAT;
  DECLARE cost FLOAT;
 DECLARE exit handler for sqlexception,SQLWARNING
  BEGIN
    -- ERROR
  ROLLBACK;
END;
 SELECT price from event_venue where id = evid INTO cost;
  SET totalcost = cost*numtkts;
  IF ROW_COUNT() <> -1
  THEN SELECT "INVALID EVENT_VENUE. NO ROW FOUND FOR PRICE SELECTION";
  -- END IF;
ELSE 
START TRANSACTION;
INSERT INTO booking (id, customer_id,number_of_tickets,price,booking_flag) values (evid, customerid, numtkts, totalcost, 1);
IF ROW_COUNT() = 1 THEN
  UPDATE event_venue set available_seats = available_seats - numtkts where id = evid;
  IF ROW_COUNT() = 1 THEN
  SELECT 1;
  ELSE
  SELECT 0;
  END IF;
  ELSE
  SELECT 0;
  END IF;
  COMMIT;
  END IF;
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_transaction1`(IN `evid` INT, IN `customerid` INT, IN `numtkts` INT)
    MODIFIES SQL DATA
exe: BEGIN
  DECLARE totalcost FLOAT;
  DECLARE cost FLOAT;
  DECLARE available_now INT;
 DECLARE exit handler for sqlexception,SQLWARNING
  BEGIN
    -- ERROR
  ROLLBACK;
END;
 SELECT count(price) from event_venue where id = evid INTO cost;
  IF cost <> 1
  THEN SELECT 'INVALID EVENT ID';
  LEAVE exe;
 END IF;
 
 SELECT available_seats from event_venue where id = evid into available_now;
 IF available_now = 0 THEN
 SELECT 'SORRY!! WE ARE SOLD OUT :(';
 LEAVE exe;
 END IF;

 IF available_now < numtkts THEN
 SELECT 'ENOUGH TICKETS NOT AVILABLE. PLEASE TRY BOOKING LESS NUMBER OF TICKETS';
 LEAVE exe;
 END IF;
 
 SELECT price from event_venue where id = evid INTO cost;
  SET totalcost = cost*numtkts;
  
   
START TRANSACTION;
INSERT INTO booking (id, customer_id,number_of_tickets,price,booking_flag) values (evid, customerid, numtkts, totalcost, 1);
IF ROW_COUNT() = 1 THEN
  UPDATE event_venue set available_seats = available_seats - numtkts where id = evid;
  IF ROW_COUNT() = 1 THEN
  SELECT 'BOOKING SUCCESSFUL' ;
  ELSE
  SELECT 0 ;
  END IF;
  ELSE
  SELECT 0 ;
  END IF;
  COMMIT;
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cancellation_transaction`(`bookingid` INT)
    MODIFIES SQL DATA
BEGIN
DECLARE eventvenueid INT;
DECLARE number_of_tkts INT;
 DECLARE exit handler for sqlexception,SQLWARNING
  BEGIN
    -- ERROR
  ROLLBACK;
END;
SELECT id from booking where booking_id = bookingid INTO eventvenueid;
SELECT number_of_tickets from booking where booking_id = bookingid INTO number_of_tkts;
START TRANSACTION;
UPDATE booking set booking_flag = 0 where booking_id = bookingid;
UPDATE event_venue set available_seats = available_seats + number_of_tkts where id = eventvenueid; 
COMMIT;
SELECT 'BOOKING CANCELLED SUCCESSFULLY';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test`()
BEGIN
DECLARE status FLOAT;
SELECT price from event_venue where id = 4 INTO status;
SELECT ROW_COUNT();
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE IF NOT EXISTS `booking` (
  `booking_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `number_of_tickets` int(11) NOT NULL,
  `price` float NOT NULL,
  `booking_flag` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `id`, `customer_id`, `number_of_tickets`, `price`, `booking_flag`) VALUES
(29, 4, 1, 5, 75, 0),
(31, 4, 1, 5, 75, 0),
(34, 4, 2, 1, 15, 1),
(35, 5, 1, 1, 100, 1),
(36, 4, 1, 1, 15, 1),
(37, 7, 2, 1, 10, 0),
(38, 4, 2, 1, 15, 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `event_id` int(11) NOT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`event_id`, `category`) VALUES
(1, 'Action'),
(1, 'Science Fiction'),
(2, 'Thriller');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `cc_number` int(16) NOT NULL,
  `cc_name` varchar(25) NOT NULL,
  `cc_month` int(2) NOT NULL,
  `cc_year` int(2) NOT NULL,
  `cc_cvv` int(3) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `email`, `password`, `cc_number`, `cc_name`, `cc_month`, `cc_year`, `cc_cvv`) VALUES
(1, 'Anil', 'Zack', 'az@uncc.edu', 'az', 2345, 'azz', 12, 2019, 123),
(2, 'zoey', 'xavier', 'zx@uncc.edu', 'zx', 5678, 'cgscxs', 9, 2019, 678);

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE IF NOT EXISTS `event` (
  `event_id` int(11) NOT NULL,
  `event_name` varchar(1000) NOT NULL,
  `type` varchar(20) NOT NULL,
  `description` varchar(300) NOT NULL,
  `duration` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`event_id`, `event_name`, `type`, `description`, `duration`) VALUES
(1, 'Star Wars: Episode VII', 'Movie', 'Thirty years after defeating the Galactic Empire, Han Solo (Harrison Ford) and his allies face a new threat from the evil Kylo Ren (Adam Driver) and his army of Stormtroopers.', 2.16),
(2, 'Star Trek', 'Movie', 'The crew of the Starship Enterprise returns home after an act of terrorism within its own organization destroys most of Starfleet and what it represents, leaving Earth in a state of crisis. With a personal score to settle, Capt. James T. Kirk (Chris Pine) leads his people (Zachary Quinto, Karl Urban', 1.2),
(3, 'Batman vs Superman', 'Movie', 'Son of Krypton vs. Bat of Gotham', 2),
(4, 'New Year Party', 'Party', 'New Year Party at Label Charlotte', 5);

-- --------------------------------------------------------

--
-- Table structure for table `event_venue`
--

CREATE TABLE IF NOT EXISTS `event_venue` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `venue_id` int(11) NOT NULL,
  `play_date` date NOT NULL,
  `play_time` time NOT NULL,
  `price` float NOT NULL,
  `available_seats` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event_venue`
--

INSERT INTO `event_venue` (`id`, `event_id`, `venue_id`, `play_date`, `play_time`, `price`, `available_seats`) VALUES
(4, 1, 4, '2015-12-16', '16:00:00', 15, 22),
(5, 4, 7, '2015-12-31', '20:00:00', 100, 199),
(6, 2, 5, '2015-12-24', '15:14:00', 10, 50),
(7, 1, 4, '2015-12-16', '17:00:00', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `featuring`
--

CREATE TABLE IF NOT EXISTS `featuring` (
  `event_id` int(11) NOT NULL,
  `feat_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `featuring`
--

INSERT INTO `featuring` (`event_id`, `feat_name`) VALUES
(1, 'Harrison Ford'),
(1, 'Mark Hamill'),
(2, 'Benedict Cumberbatch'),
(2, 'Chris Pine'),
(2, 'Zachary Quinto'),
(3, 'Ben Affleck'),
(3, 'Henry Cavill'),
(3, 'Jesse Eisenberg');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE IF NOT EXISTS `feedback` (
  `customer_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `review` varchar(1000) DEFAULT NULL,
  `rating` enum('1','2','3','4','5') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`customer_id`, `event_id`, `review`, `rating`) VALUES
(1, 1, 'Awesome Movie! Must watch', '5'),
(2, 1, 'Awesome Movie! Must watch', '4');

-- --------------------------------------------------------

--
-- Table structure for table `venue`
--

CREATE TABLE IF NOT EXISTS `venue` (
  `venue_id` int(11) NOT NULL,
  `venue_name` varchar(20) NOT NULL,
  `Capacity` int(3) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `venue`
--

INSERT INTO `venue` (`venue_id`, `venue_name`, `Capacity`, `address`) VALUES
(4, 'Regal Cinemas 17', 50, 'Regal Cinemas, Charlotte, NC'),
(5, 'Regal Cinemas 18', 50, 'Regal Cinemas, Charlotte, NC'),
(7, 'Label', 200, 'Label Charlotte ');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_events_available1`
--
CREATE TABLE IF NOT EXISTS `view_events_available1` (
`event_id` int(11)
,`event_name` varchar(1000)
,`type` varchar(20)
,`description` varchar(300)
,`Featuring` text
,`duration` float
,`Average Rating` double
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_events_upcoming`
--
CREATE TABLE IF NOT EXISTS `view_events_upcoming` (
`event_id` bigint(11)
,`event_name` text
,`type` varchar(20)
,`description` varchar(300)
,`Featuring` text
,`duration` double
,`Average Rating` double
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_event_venues`
--
CREATE TABLE IF NOT EXISTS `view_event_venues` (
`event_id` int(11)
,`venue_id` int(11)
,`venue_name` varchar(20)
,`address` varchar(100)
,`play_date` date
,`play_time` time
,`available_seats` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `view_events_available1`
--
DROP TABLE IF EXISTS `view_events_available1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_events_available1` AS select `event`.`event_id` AS `event_id`,`event`.`event_name` AS `event_name`,`event`.`type` AS `type`,`event`.`description` AS `description`,group_concat(`featuring`.`feat_name` separator ',') AS `Featuring`,`event`.`duration` AS `duration`,(select avg(`f`.`rating`) from `feedback` `f` where (`f`.`event_id` = `event`.`event_id`)) AS `Average Rating` from (`event` left join `featuring` on((`event`.`event_id` = `featuring`.`event_id`))) where `event`.`event_id` in (select distinct `event_venue`.`event_id` from `event_venue` where (concat(`event_venue`.`play_date`,' ',`event_venue`.`play_time`) > now())) group by `event`.`event_id`;

-- --------------------------------------------------------

--
-- Structure for view `view_events_upcoming`
--
DROP TABLE IF EXISTS `view_events_upcoming`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_events_upcoming` AS select `event`.`event_id` AS `event_id`,`event`.`event_name` AS `event_name`,`event`.`type` AS `type`,`event`.`description` AS `description`,group_concat(`featuring`.`feat_name` separator ',') AS `Featuring`,`event`.`duration` AS `duration`,(select avg(`f`.`rating`) from `feedback` `f` where (`f`.`event_id` = `event`.`event_id`)) AS `Average Rating` from (`event` left join `featuring` on((`event`.`event_id` = `featuring`.`event_id`))) where (not(`event`.`event_id` in (select distinct `event_venue`.`event_id` from `event_venue`)));

-- --------------------------------------------------------

--
-- Structure for view `view_event_venues`
--
DROP TABLE IF EXISTS `view_event_venues`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_event_venues` AS select `event_venue`.`event_id` AS `event_id`,`event_venue`.`venue_id` AS `venue_id`,`venue`.`venue_name` AS `venue_name`,`venue`.`address` AS `address`,`event_venue`.`play_date` AS `play_date`,`event_venue`.`play_time` AS `play_time`,`event_venue`.`available_seats` AS `available_seats` from (`venue` join `event_venue`) where (`event_venue`.`venue_id` = `venue`.`venue_id`);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`event_id`,`category`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `event_venue`
--
ALTER TABLE `event_venue`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_const` (`event_id`,`play_date`,`play_time`,`venue_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `venue_id` (`venue_id`);

--
-- Indexes for table `featuring`
--
ALTER TABLE `featuring`
  ADD PRIMARY KEY (`event_id`,`feat_name`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`customer_id`,`event_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `venue`
--
ALTER TABLE `venue`
  ADD PRIMARY KEY (`venue_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `event_venue`
--
ALTER TABLE `event_venue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `venue`
--
ALTER TABLE `venue`
  MODIFY `venue_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`id`) REFERENCES `event_venue` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  ADD CONSTRAINT `category_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `event_venue`
--
ALTER TABLE `event_venue`
  ADD CONSTRAINT `event_venue_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_venue_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`venue_id`) ON DELETE CASCADE;

--
-- Constraints for table `featuring`
--
ALTER TABLE `featuring`
  ADD CONSTRAINT `featuring_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
