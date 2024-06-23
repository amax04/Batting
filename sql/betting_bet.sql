-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: betting
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bet`
--

DROP TABLE IF EXISTS `bet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bet` (
  `bet_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `purchase_amount` decimal(10,2) DEFAULT NULL,
  `earning_amount` decimal(10,2) DEFAULT NULL,
  `daily_profit_percentage` decimal(5,2) DEFAULT NULL,
  `invest_start_date` date DEFAULT NULL,
  `invest_end_date` date DEFAULT NULL,
  `invest_duration` int DEFAULT NULL,
  `invest_status` enum('processing','completed','rejected') DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bet_id`),
  KEY `product_id` (`product_id`),
  KEY `username` (`username`),
  CONSTRAINT `bet_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `bet_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bet`
--

LOCK TABLES `bet` WRITE;
/*!40000 ALTER TABLE `bet` DISABLE KEYS */;
INSERT INTO `bet` VALUES (2,1,1000.00,22.50,2.25,'2023-12-06','2023-12-07',1,'completed','fund A','user1'),(3,1,1000.00,22.50,2.25,'2023-12-06','2023-12-07',1,'rejected','fund A','user1'),(4,1,1000.00,22.50,2.25,'2023-12-07','2023-12-08',1,'rejected','fund A','user1'),(5,1,1000.00,22.50,2.25,'2023-12-08','2023-12-09',1,'completed','fund A','aman'),(6,5,2000.00,45.00,2.25,'2023-12-08','2023-12-09',1,'processing','fund C','aman'),(7,6,10000.00,500.00,5.00,'2023-12-08','2023-12-09',1,'processing','fund D','aman');
/*!40000 ALTER TABLE `bet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 11:20:08
