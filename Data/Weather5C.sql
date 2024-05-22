-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: weather_forecast
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `alex`
--

DROP TABLE IF EXISTS `alex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alex` (
  `location_id` int NOT NULL DEFAULT '1',
  `date` date NOT NULL,
  `temperature_max` float DEFAULT NULL,
  `temperature_min` float DEFAULT NULL,
  `temperature_mean` float DEFAULT NULL,
  `apparent_temperature_mean` float DEFAULT NULL,
  `sunrise` time DEFAULT NULL,
  `sunset` time DEFAULT NULL,
  `rain_sum` float DEFAULT NULL,
  `wind_speed_max` float DEFAULT NULL,
  PRIMARY KEY (`location_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='31.2018,29.9158 (coordinates)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alex`
--

LOCK TABLES `alex` WRITE;
/*!40000 ALTER TABLE `alex` DISABLE KEYS */;
INSERT INTO `alex` VALUES (1,'2024-04-22',28.36,24.68,24.68,24.25,'03:24:02','16:32:48',0,6.41),(1,'2024-04-24',36.31,20.56,26.36,26.36,'03:21:58','16:34:10',0,7.14),(1,'2024-04-25',19.97,18.64,19.2,19.06,'03:20:57','16:34:51',0,5.69),(1,'2024-04-26',23.31,17.79,20.19,19.86,'03:19:58','16:35:32',0,4.69),(1,'2024-04-27',21.48,17.44,18.18,17.91,'03:18:59','16:36:14',0,3.81),(1,'2024-04-28',21.11,17.46,19.38,19.28,'03:18:01','16:36:55',0,4.87),(1,'2024-04-30',22.89,18.65,19.17,19.23,'03:16:08','16:38:19',0,5.86),(1,'2024-05-01',23.5,18.82,20.72,20.7,'03:15:14','16:39:01',0,4.68),(1,'2024-05-05',23.31,18.86,20.62,20.38,'03:11:45','16:41:49',0,5.92),(1,'2024-05-06',22.46,17.98,18.46,17.8,'03:10:56','16:42:31',0,4.32),(1,'2024-05-07',21.25,15.49,17.29,16.64,'03:10:08','16:43:13',0,2.31),(1,'2024-05-08',24.31,16.73,19.96,19.63,'03:09:20','16:43:55',0,3.49),(1,'2024-05-09',30.31,21.44,24.81,24.73,'03:08:35','16:44:36',0,6.64),(1,'2024-05-10',23.31,19.16,20.99,20.71,'03:07:50','16:45:18',0,2.73),(1,'2024-05-11',21.61,18.71,19.07,19.04,'03:07:07','16:46:00',0,2.04),(1,'2024-05-12',19.71,21.15,18.84,18.24,'03:06:24','16:46:42',0,4.85),(1,'2024-05-15',20.2,22.68,18.5,18.05,'03:04:25','16:48:45',0,2.08),(1,'2024-05-16',25.15,21.53,20.51,19.95,'03:03:48','16:49:26',0,2.92);
/*!40000 ALTER TABLE `alex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aswan`
--

DROP TABLE IF EXISTS `aswan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aswan` (
  `location_id` int NOT NULL DEFAULT '2',
  `date` date NOT NULL,
  `temperature_max` float DEFAULT NULL,
  `temperature_min` float DEFAULT NULL,
  `temperature_mean` float DEFAULT NULL,
  `apparent_temperature_mean` float DEFAULT NULL,
  `sunrise` time DEFAULT NULL,
  `sunset` time DEFAULT NULL,
  `rain_sum` float DEFAULT NULL,
  `wind_speed_max` float DEFAULT NULL,
  PRIMARY KEY (`location_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='24.0908,32.8994 (coordinates)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aswan`
--

LOCK TABLES `aswan` WRITE;
/*!40000 ALTER TABLE `aswan` DISABLE KEYS */;
INSERT INTO `aswan` VALUES (2,'2024-04-22',37.17,34.13,34.13,31.57,'03:20:40','16:12:57',0,4.9),(2,'2024-04-24',42.32,30.9,37.23,34.22,'03:19:04','16:13:51',0,3.79),(2,'2024-04-25',34.94,27.57,30.92,29.48,'03:18:16','16:14:19',0,1.24),(2,'2024-04-26',42.32,31.16,35.37,33.12,'03:17:30','16:14:47',0,8.23),(2,'2024-04-27',35.65,25.02,27.65,26.39,'03:16:45','16:15:15',0,8.45),(2,'2024-04-28',34.89,24.73,29.48,27.73,'03:16:00','16:15:44',0,7.17),(2,'2024-04-30',35.84,26.72,29.4,27.67,'03:14:33','16:16:41',0,6.58),(2,'2024-05-01',34.44,25.51,29.09,27.43,'03:13:51','16:17:10',0,4.49),(2,'2024-05-05',36.63,27.69,32.81,30.51,'03:11:13','16:19:08',0,5.43),(2,'2024-05-06',32.89,22.33,24.49,23.6,'03:10:35','16:19:38',0,5.68),(2,'2024-05-07',29.76,20.41,22.14,20.91,'03:09:59','16:20:08',0,5.2),(2,'2024-05-08',33.32,23.4,27.78,26.53,'03:09:24','16:20:38',0,3.57),(2,'2024-05-09',36.32,29.91,33.1,30.72,'03:08:50','16:21:08',0,3.25),(2,'2024-05-10',39.32,27.77,32.56,30.23,'03:08:17','16:21:39',0,3.37),(2,'2024-05-11',39.84,26.71,28.81,27.32,'03:07:45','16:22:09',0,6.32),(2,'2024-05-12',29.96,27.6,23.63,22.83,'03:07:14','16:22:39',0,4.94),(2,'2024-05-15',28.32,26.21,23.88,23,'03:05:47','16:24:11',0,4.57),(2,'2024-05-16',29.66,27.61,25.18,24.35,'03:05:20','16:24:41',0,4.7);
/*!40000 ALTER TABLE `aswan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cairo`
--

DROP TABLE IF EXISTS `cairo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cairo` (
  `location_id` int NOT NULL DEFAULT '0',
  `date` date NOT NULL,
  `temperature_max` float DEFAULT NULL,
  `temperature_min` float DEFAULT NULL,
  `temperature_mean` float DEFAULT NULL,
  `apparent_temperature_mean` float DEFAULT NULL,
  `sunrise` time DEFAULT NULL,
  `sunset` time DEFAULT NULL,
  `rain_sum` float DEFAULT NULL,
  `wind_speed_max` float DEFAULT NULL,
  PRIMARY KEY (`location_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='30.0626,31.2497 (coordinates)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cairo`
--

LOCK TABLES `cairo` WRITE;
/*!40000 ALTER TABLE `cairo` DISABLE KEYS */;
INSERT INTO `cairo` VALUES (0,'2024-04-17',21.03,20.4,21.03,20.86,'03:25:19','16:22:54',0,1.54),(0,'2024-04-22',33.95,29.31,29.31,27.69,'03:20:06','16:26:05',0,6.42),(0,'2024-04-24',41.03,28.35,37.08,34.01,'03:18:07','16:27:22',0,1.28),(0,'2024-04-25',26.03,18.92,22.09,21.76,'03:17:08','16:28:01',0,6.56),(0,'2024-04-26',31.99,18.92,24.67,24.08,'03:16:11','16:28:40',0,7.52),(0,'2024-04-27',30.25,17.3,18.88,18.49,'03:15:14','16:29:20',0,5.39),(0,'2024-04-28',32.26,17.55,22.9,22.5,'03:14:19','16:29:59',0,5.71),(0,'2024-04-30',31.77,19.22,22.9,22.6,'03:12:30','16:31:18',0,7.47),(0,'2024-05-01',30.93,21.21,25.76,25.51,'03:11:38','16:31:58',0,7.34),(0,'2024-05-05',27.78,19.49,23.2,22.65,'03:08:18','16:34:37',0,7.33),(0,'2024-05-06',27.18,17.27,18.82,18.22,'03:07:30','16:35:17',0,5.67),(0,'2024-05-09',35.14,27.71,30.14,28.26,'03:05:15','16:37:17',0,3.77),(0,'2024-05-10',30.66,21.77,24.74,24.52,'03:04:33','16:37:57',0,4.58),(0,'2024-05-11',27.58,19.83,20.12,19.86,'03:03:51','16:38:37',0,4.01),(0,'2024-05-12',22.08,20.15,17.91,17.71,'03:03:11','16:39:16',0,3.13),(0,'2024-05-15',23.03,22.95,20.7,20.29,'03:01:17','16:41:15',0,3.79),(0,'2024-05-16',26.56,23.87,22.82,22.18,'03:00:42','16:41:54',0,4.16);
/*!40000 ALTER TABLE `cairo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sharm`
--

DROP TABLE IF EXISTS `sharm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sharm` (
  `location_id` int NOT NULL DEFAULT '3',
  `date` date NOT NULL,
  `temperature_max` float DEFAULT NULL,
  `temperature_min` float DEFAULT NULL,
  `temperature_mean` float DEFAULT NULL,
  `apparent_temperature_mean` float DEFAULT NULL,
  `sunrise` time DEFAULT NULL,
  `sunset` time DEFAULT NULL,
  `rain_sum` float DEFAULT NULL,
  `wind_speed_max` float DEFAULT NULL,
  PRIMARY KEY (`location_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sharm`
--

LOCK TABLES `sharm` WRITE;
/*!40000 ALTER TABLE `sharm` DISABLE KEYS */;
INSERT INTO `sharm` VALUES (3,'2024-04-22',29.44,27.46,27.46,26.85,'03:10:37','16:11:34',0,2.67),(3,'2024-04-24',40.49,29.02,33.32,31.02,'03:08:46','16:12:43',0,2.01),(3,'2024-04-25',29.17,25.74,27.66,26.66,'03:07:52','16:13:18',0,1.33),(3,'2024-04-26',35.49,27.81,31.1,29.66,'03:06:58','16:13:53',0,1.79),(3,'2024-04-27',29.87,24.3,25.83,25.57,'03:06:06','16:14:28',0,1.45),(3,'2024-04-28',29.35,24.74,27.35,27.02,'03:05:14','16:15:03',0,2.3),(3,'2024-04-30',28.43,25.81,26.38,26.38,'03:03:34','16:16:14',0.35,1.12),(3,'2024-05-01',28.49,25.91,27.15,26.97,'03:02:45','16:16:50',0,1.57),(3,'2024-05-05',32.49,24.53,28.35,27.1,'02:59:40','16:19:14',0,3.36),(3,'2024-05-06',27.7,21.16,22.09,21.4,'02:58:57','16:19:51',0,1.2),(3,'2024-05-07',24.84,21.49,22.17,21.33,'02:58:14','16:20:27',0,1.85),(3,'2024-05-08',29.49,22.85,25.66,25.06,'02:57:33','16:21:03',0,1.32),(3,'2024-05-09',35.49,26.18,30.4,28.57,'02:56:53','16:21:40',0,0.7),(3,'2024-05-10',30.49,25.25,27.06,26.5,'02:56:13','16:22:16',0,2.17),(3,'2024-05-11',29.51,23.52,24.91,24.58,'02:55:35','16:22:52',0,2.2),(3,'2024-05-12',25.55,24.13,21.78,21.42,'02:54:58','16:23:29',0,3.19),(3,'2024-05-15',26.49,25.48,23.36,22.8,'02:53:15','16:25:17',0,2.22),(3,'2024-05-16',28.45,26.8,25.78,25.2,'02:52:43','16:25:53',0,4.71);
/*!40000 ALTER TABLE `sharm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zagazig`
--

DROP TABLE IF EXISTS `zagazig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zagazig` (
  `location_id` int NOT NULL DEFAULT '4',
  `date` date NOT NULL,
  `temperature_max` float DEFAULT NULL,
  `temperature_min` float DEFAULT NULL,
  `temperature_mean` float DEFAULT NULL,
  `apparent_temperature_mean` float DEFAULT NULL,
  `sunrise` time DEFAULT NULL,
  `sunset` time DEFAULT NULL,
  `rain_sum` float DEFAULT NULL,
  `wind_speed_max` float DEFAULT NULL,
  PRIMARY KEY (`location_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='30.5877,31.502 (coordinates)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zagazig`
--

LOCK TABLES `zagazig` WRITE;
/*!40000 ALTER TABLE `zagazig` DISABLE KEYS */;
INSERT INTO `zagazig` VALUES (4,'2024-04-22',34.02,30.09,30.09,28.31,'03:18:40','16:26:01',0,5.87),(4,'2024-04-24',42.45,25.99,34.3,31.71,'03:16:38','16:27:21',0,1.38),(4,'2024-04-25',21.57,17.14,18.66,18.33,'03:15:38','16:28:01',0,3),(4,'2024-04-26',31.54,15.94,23.01,22.49,'03:14:40','16:28:41',0,5),(4,'2024-04-27',30.24,14.13,15.34,15.18,'03:13:42','16:29:21',0,2.85),(4,'2024-04-28',29.07,14.36,20.18,19.92,'03:12:45','16:30:02',0,2.58),(4,'2024-04-30',32.08,16.08,18.88,18.83,'03:10:55','16:31:23',0,5.1),(4,'2024-05-01',33.3,17.39,25.17,25.02,'03:10:01','16:32:04',0,4.49),(4,'2024-05-05',28.7,16.55,22.29,21.75,'03:06:37','16:34:47',0,5.3),(4,'2024-05-06',28,14.23,15.64,15.19,'03:05:48','16:35:28',0,3.06),(4,'2024-05-07',25.5,14.23,15.02,14.56,'03:05:01','16:36:09',0,2.14),(4,'2024-05-08',20.69,16.21,18.25,17.7,'03:04:15','16:36:50',0,3.35),(4,'2024-05-09',35.67,21.88,27.61,26.91,'03:03:30','16:37:31',0,5.55),(4,'2024-05-10',23.07,18.9,20.52,20.3,'03:02:47','16:38:12',0,2.11),(4,'2024-05-11',27.13,16.63,17.5,17.5,'03:02:04','16:38:53',0,1.64),(4,'2024-05-12',19.81,21.45,15.21,15.11,'03:01:23','16:39:33',0,2.22),(4,'2024-05-15',18.61,23.04,17.44,17.09,'02:59:27','16:41:34',0,2.07),(4,'2024-05-16',26.26,20.53,19.4,18.96,'02:58:50','16:42:14',0,2.85);
/*!40000 ALTER TABLE `zagazig` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-17 22:38:33
