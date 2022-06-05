-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: db
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `userType` varchar(50) DEFAULT NULL,
  `clgName` varchar(100) DEFAULT NULL,
  `username` varchar(10) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `Active` int(1) NOT NULL DEFAULT 0,
  `otp` int(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (14,'Subbu Admin','Admin','Jawaharlal Nehru Technological University Kakinada','Subbu123','dsubbu7661@gmail.com','pbkdf2:sha256:260000$9YdOev0VtBAPwY0N$b9f7eceb28c0470ef6694d55c0cc32e9050c1243dda73375ee0a72c9448d8d25',1,0),(40,'Sreya ','Admin','Jawaharlal Nehru Technological University,kakinada','Sreya12','lakshmisreya1227@gmail.com','sha256$snkijzL8fDr1PbnB$a0915858d9a5af6edb3247b8cbf452679383a581defa68636e3b345f258ee851',1,0),(41,'Sarayu','Admin','Jawaharlal Nehru Technological University,kakinada','Jntuk12','gsreesarayu1818@gmail.com','sha256$njSTuWfo5l69xBMT$5b3ce5cce7233d6a4f7de134902e71475963173408232d2e6ffcbc1b20d67020',1,0),(70,'Subbu Verifier','Verifier','Jawaharlal Nehru Technological University,kakinada','Subbu134','dsubbu7661@gmail.com','sha256$2ihQLdZWbCvXD1ab$baafc61f76a135d310d44ddfcae1eb6481838075aab7c917629da0ca26baf6c3',1,0),(71,'Rahul KITE','User','KITE ENGINEERING COLLEGE','Rahul111','dsubbu7661@gmail.com','sha256$nJPk8VEZ5ge1DY6H$805b56d99faf75022d6f842b455046eb458fce014f6a58fbe5ca8d93c9abdb7c',0,0),(73,'Rahul GITE','User','GITE ENGINEERING COLLEGE','Rahul222','dsubbu7661@gmail.com','sha256$tU9Pv91RB7DEqagE$b957a4e9b21236633ae1c64afd8c2e9826e48dcd4a5bde222230e7511e213b2c',0,0),(74,'Rahul ADITYA','User','ADITYA ENGINEERING COLLEGE','Rahul333','dsubbu7661@gmail.com','sha256$BO5zezm7DtTQcdG5$553da3170284585a221f22e0a288156fd226c71cbea9dedbb30a9f7098495205',0,0),(75,'Rahul GEETHAM','User','GEETHAM ENGINEERING COLLEGE','Rahul444','dsubbu7661@gmail.com','sha256$KhpHgpuMNYEy9vYF$f66cfd3797de249b018c4afd137533d144cff09cdf8ca255b6cb41f0f5a52098',0,0),(76,'Subbu User','User','KITE ENGINEERING COLLEGE','Subbu145','dsubbu7661@gmail.com','sha256$kr9hBxOmhA8d32ha$4576aebbba97d6794c4f37d4b933952c70c987fbf0c207be3976f5dabe29bc52',1,0),(77,'Clerk1','Verifier','Jawaharlal Nehru Technological University,kakinada','Clerk01','gsreesarayu1818@gmail.com','pbkdf2:sha256:260000$lSmRAXfGZxy4Cgrv$83f8e625b00a11ce6c96779fc7817a7c85b0fbc850b77327739ebe4d5595a038',1,0),(79,'Jntuk Admin','Admin','Jawaharlal Nehru Technological University,kakinada','Jntuk13','gsreesarayu1818@gmail.com','sha256$v1dbk6HqSL1BGyRh$409035faa079e48b80ecad663f3321132c9180054ecbb2c4c01b94983340da54',1,0),(82,'Rahul IDEAL','User','IDEAL ENGINEERING COLLEGE','Rahul555','dsubbu7661@gmail.com','sha256$Qqj3khttvJLsXoQ6$b7a40de2da94e589a2f5a2eef669ca99cf3c86160b0ebd3339ccfb264593feee',0,0);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clerk_colleges`
--

DROP TABLE IF EXISTS `clerk_colleges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clerk_colleges` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `clerk_id` int(10) NOT NULL,
  `clgName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clerk_colleges`
--

LOCK TABLES `clerk_colleges` WRITE;
/*!40000 ALTER TABLE `clerk_colleges` DISABLE KEYS */;
INSERT INTO `clerk_colleges` VALUES (6,70,'IDEAL ENGINEERING COLLEGE'),(7,70,'KITE ENGINEERING COLLEGE'),(8,70,'ADITYA ENGINEERING COLLEGE'),(9,77,'GITE ENGINEERING COLLEGE'),(10,77,'GEETHAM ENGINEERING COLLEGE');
/*!40000 ALTER TABLE `clerk_colleges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colleges`
--

DROP TABLE IF EXISTS `colleges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colleges` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `clgCode` varchar(100) NOT NULL,
  `clgName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colleges`
--

LOCK TABLES `colleges` WRITE;
/*!40000 ALTER TABLE `colleges` DISABLE KEYS */;
INSERT INTO `colleges` VALUES (1,'IDEAL','IDEAL ENGINEERING COLLEGE'),(2,'KITE','KITE ENGINEERING COLLEGE'),(3,'GITE','GITE ENGINEERING COLLEGE'),(4,'ADITYA','ADITYA ENGINEERING COLLEGE'),(5,'GEETHAM','GEETHAM ENGINEERING COLLEGE');
/*!40000 ALTER TABLE `colleges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `id` tinyint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `roll_no` varchar(12) DEFAULT NULL,
  `acaYear` varchar(10) NOT NULL,
  `clgName` varchar(500) DEFAULT NULL,
  `emcet` int(10) DEFAULT NULL,
  `ssc` int(10) NOT NULL,
  `inter` int(10) NOT NULL,
  `branch` varchar(10) NOT NULL,
  `reservation` varchar(10) NOT NULL,
  `whitecard` tinyint(1) NOT NULL,
  `reason` varchar(1000) NOT NULL,
  `docStatus` varchar(20) NOT NULL,
  `Certificates` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roll_no` (`roll_no`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (4,'Mugada Rama Krishna','19025A0504','2020-24','KITE ENGINEERING COLLEGE',99,89,77,'CE','BC-A',0,'Fake','Rejected','./static/files/Certificates//19025A0504.pdf'),(5,'Boddi Kumar','19025A0505','2019-23','KITE ENGINEERING COLLEGE',98,78,89,'ECE','BC-B',0,'','Pending','./static/files/Certificates//19025A0505.pdf'),(6,'Magapu Manoj','19025A0506','2020-24','KITE ENGINEERING COLLEGE',456,90,98,'PCE','BC-B',0,'','Pending','./static/files/Certificates//19025A0506.pdf'),(7,'Kishka Krish','19025A0507','2019-23','GITE ENGINEERING COLLEGE',976,76,62,'MECH','BC-C',0,'','Success','./static/files/Certificates//19025A0507.pdf'),(8,'Rahul Ramakrishna','19025A0508','2021-25','GITE ENGINEERING COLLEGE',789,98,59,'CE','BC-A',0,'','Success','./static/files/Certificates//19025A0508.pdf'),(9,'Dasari Likitha','19025A0509','2020-24','GITE ENGINEERING COLLEGE',788,98,78,'ECE','ST',0,'FAKE 10TH ','Rejected','./static/files/Certificates//19025A0509.pdf'),(10,'Ragam Raju','19025A0510','2020-24','ADITYA ENGINEERING COLLEGE',90,75,89,'EEE','ST',0,'','Pending','./static/files/Certificates//19025A0510.pdf'),(11,'Rapara Rekha','19025A0511','2018-22','ADITYA ENGINEERING COLLEGE',879,78,94,'MECH','SC',0,'','Pending','./static/files/Certificates//19025A0511.pdf'),(12,'Ganga Gowthami','19025A0512','2019-23','ADITYA ENGINEERING COLLEGE',908,87,99,'EEE','BC-C',0,'','Pending','./static/files/Certificates//19025A0512.pdf'),(13,'Vadha Vandana','19025A0513','2019-23','GEETHAM ENGINEERING COLLEGE',890,78,89,'CE','BC-E',0,'','Pending','./static/files/Certificates//19025A0513.pdf'),(14,'Gandam Raghuram','19025A0514','2018-22','GEETHAM ENGINEERING COLLEGE',989,78,89,'CE','ST',0,'','Pending','./static/files/Certificates//19025A0514.pdf'),(15,'Satya Dev Achari','19025A0515','2021-25','GEETHAM ENGINEERING COLLEGE',980,78,83,'MECH','BC-C',0,'','Pending','./static/files/Certificates//19025A0515.pdf'),(16,'Magapu Anusha','19025A0501','2018-22','IDEAL ENGINEERING COLLEGE',890,87,78,'CSE','BC-B',0,'','Pending','./static/files/Certificates//19025A0501.pdf'),(17,'Manda Akhila','19025A0502','2018-22','IDEAL ENGINEERING COLLEGE',890,87,98,'ECE','SC',0,'','Pending','./static/files/Certificates//19025A0502.pdf'),(18,'Rahul Ram Raju','19025A0503','2020-24','IDEAL ENGINEERING COLLEGE',980,79,98,'ECE','ST',0,'','Pending','./static/files/Certificates//19025A0503.pdf'),(19,'Rekha Surekha','19025A0516','2018-22','KITE ENGINEERING COLLEGE',898,87,76,'EEE','BC-D',0,'','Success','./static/files/Certificates//19025A0516.pdf'),(20,'Raja Vikramarkha','19025A0517','2018-22','KITE ENGINEERING COLLEGE',768,98,84,'PCE','ST',0,'','Pending','./static/files/Certificates//19025A0517.pdf'),(21,'Nikhil Kurian','18021A0520','2020-24','GEETHAM ENGINEERING COLLEGE',7895,89,89,'CSE','OC',0,'Inter cert missing','Rejected','./static/files/Certificates//18021A0520.pdf'),(22,'Aadita','19025A0555','2018-22','IDEAL ENGINEERING COLLEGE',3036,55,41,'CSE','BC-A',0,'','Pending','./static/files/Certificates//19025A0555.pdf'),(23,'Aakarsha','19025A0556','2019-23','IDEAL ENGINEERING COLLEGE',13068,65,51,'MECH','ST',1,'','Pending','./static/files/Certificates//19025A0556.pdf'),(24,'Ramu','19025A0557','2020-24','IDEAL ENGINEERING COLLEGE',18890,41,75,'EEE','BC-A',0,'','Pending','./static/files/Certificates//19025A0557.pdf'),(25,'Raju','19025A0558','2021-25','IDEAL ENGINEERING COLLEGE',4627,83,81,'ECE','OC',1,'','Pending','./static/files/Certificates//19025A0558.pdf'),(26,'Rahul','19025A0559','2018-22','IDEAL ENGINEERING COLLEGE',17510,54,46,'MECH','SC',0,'','Pending','./static/files/Certificates//19025A0559.pdf'),(27,'Brahmi','19025A0560','2019-23','IDEAL ENGINEERING COLLEGE',6524,44,55,'CE','ST',0,'','Pending','./static/files/Certificates//19025A0560.pdf'),(28,'Bhanu','19025A0561','2020-24','IDEAL ENGINEERING COLLEGE',2968,95,79,'PCE','BC-A',1,'','Pending','./static/files/Certificates//19025A0561.pdf'),(29,'Bhavani','19025A0562','2021-25','IDEAL ENGINEERING COLLEGE',4072,89,45,'CSE','ST',0,'','Pending','./static/files/Certificates//19025A0562.pdf'),(30,'Bhargavi','19025A0563','2018-22','IDEAL ENGINEERING COLLEGE',11859,73,53,'MECH','BC-A',1,'','Pending','./static/files/Certificates//19025A0563.pdf'),(31,'Bharath','19025A0564','2019-23','IDEAL ENGINEERING COLLEGE',149,98,90,'EEE','BC-B',1,'','Pending','./static/files/Certificates//19025A0564.pdf'),(32,'Challa Sai','19025A0565','2020-24','IDEAL ENGINEERING COLLEGE',12938,41,47,'CE','BC-C',0,'','Pending','./static/files/Certificates//19025A0565.pdf'),(33,'Rakesh','19025A0566','2021-25','IDEAL ENGINEERING COLLEGE',1355,94,63,'CSE','BC-D',1,'','Pending','./static/files/Certificates//19025A0566.pdf'),(34,'Rahul','19025A0567','2018-22','IDEAL ENGINEERING COLLEGE',3965,52,93,'ECE','BC-E',0,'','Pending','./static/files/Certificates//19025A0567.pdf'),(35,'Rambabu','19025A0568','2019-23','IDEAL ENGINEERING COLLEGE',18909,70,75,'PCE','BC-A',1,'','Pending','./static/files/Certificates//19025A0568.pdf'),(36,'Radhika','19025A0569','2020-24','IDEAL ENGINEERING COLLEGE',14039,86,96,'CSE','ST',1,'','Pending','./static/files/Certificates//19025A0569.pdf'),(37,'Chaitanya','19025A0570','2021-25','IDEAL ENGINEERING COLLEGE',13511,69,79,'MECH','BC-A',0,'','Pending','./static/files/Certificates//19025A0570.pdf'),(38,'Samba','19025A0571','2018-22','IDEAL ENGINEERING COLLEGE',13793,94,81,'EEE','OC',1,'','Pending','./static/files/Certificates//19025A0571.pdf'),(39,'Mahesh Babu','19025A0572','2019-23','IDEAL ENGINEERING COLLEGE',12460,73,57,'ECE','SC',0,'','Pending','./static/files/Certificates//19025A0572.pdf'),(40,'Radha Gopalam','19025A0573','2020-24','IDEAL ENGINEERING COLLEGE',2306,74,68,'MECH','ST',1,'','Pending','./static/files/Certificates//19025A0573.pdf'),(41,'Ragava','19025A0574','2021-25','KITE ENGINEERING COLLEGE',11343,40,90,'CE','BC-A',0,'','Pending','./static/files/Certificates//19025A0574.pdf'),(42,'Radhika Apte','19025A0575','2018-22','KITE ENGINEERING COLLEGE',403,43,83,'PCE','ST',1,'','Pending','./static/files/Certificates//19025A0575.pdf'),(43,'Karthik','19025A0576','2019-23','KITE ENGINEERING COLLEGE',10157,92,92,'CSE','BC-A',0,'','Pending','./static/files/Certificates//19025A0576.pdf'),(44,'Kamakshi','19025A0577','2020-24','KITE ENGINEERING COLLEGE',15974,89,41,'MECH','BC-B',0,'','Pending','./static/files/Certificates//19025A0577.pdf'),(45,'Harini','19025A0578','2021-25','KITE ENGINEERING COLLEGE',18975,51,49,'EEE','BC-C',1,'','Pending','./static/files/Certificates//19025A0578.pdf'),(46,'Surekha','19025A0579','2018-22','KITE ENGINEERING COLLEGE',6592,56,40,'CE','BC-D',0,'','Pending','./static/files/Certificates//19025A0579.pdf'),(47,'Suseela','19025A0580','2019-23','KITE ENGINEERING COLLEGE',17049,57,53,'CSE','BC-E',1,'','Pending','./static/files/Certificates//19025A0580.pdf'),(48,'Sumanth','19025A0581','2020-24','KITE ENGINEERING COLLEGE',3788,92,45,'ECE','OC',1,'','Pending','./static/files/Certificates//19025A0581.pdf'),(49,'Sudheer','19025A0582','2021-25','KITE ENGINEERING COLLEGE',3630,58,85,'PCE','SC',0,'','Pending','./static/files/Certificates//19025A0582.pdf'),(50,'Surendra','19025A0583','2018-22','KITE ENGINEERING COLLEGE',14328,45,57,'PCE','ST',1,'','Pending','./static/files/Certificates//19025A0583.pdf'),(51,'Subrahmanyam','19025A0584','2019-23','KITE ENGINEERING COLLEGE',2963,97,83,'CSE','BC-A',0,'','Pending','./static/files/Certificates//19025A0584.pdf'),(52,'Sumanth','19025A0585','2020-24','KITE ENGINEERING COLLEGE',5901,57,91,'MECH','ST',1,'','Pending','./static/files/Certificates//19025A0585.pdf'),(53,'Anusha','19025A0586','2021-25','KITE ENGINEERING COLLEGE',7553,55,97,'EEE','BC-A',1,'','Pending','./static/files/Certificates//19025A0586.pdf'),(54,'Akhila','19025A0587','2018-22','KITE ENGINEERING COLLEGE',5942,51,44,'CE','BC-B',0,'','Pending','./static/files/Certificates//19025A0587.pdf'),(55,'Chanukya','19025A0588','2019-23','KITE ENGINEERING COLLEGE',16381,69,95,'CSE','BC-C',1,'','Pending','./static/files/Certificates//19025A0588.pdf'),(56,'Dhakshani','19025A0589','2020-24','KITE ENGINEERING COLLEGE',17840,78,77,'ECE','BC-D',0,'','Pending','./static/files/Certificates//19025A0589.pdf'),(57,'Pushpa','19025A0590','2021-25','KITE ENGINEERING COLLEGE',17199,63,52,'PCE','BC-E',1,'','Pending','./static/files/Certificates//19025A0590.pdf'),(58,'Devi','19025A0591','2018-22','KITE ENGINEERING COLLEGE',19911,94,80,'ECE','BC-B',0,'','Pending','./static/files/Certificates//19025A0591.pdf'),(59,'Sree','19025A0592','2019-23','KITE ENGINEERING COLLEGE',10825,44,62,'MECH','BC-C',0,'','Pending','./static/files/Certificates//19025A0592.pdf'),(60,'Avni','19025A0593','2020-24','KITE ENGINEERING COLLEGE',19197,79,70,'CE','BC-D',1,'','Pending','./static/files/Certificates//19025A0593.pdf'),(61,'Richa','19025A0594','2021-25','GITE ENGINEERING COLLEGE',17809,94,48,'PCE','OC',0,'','Pending','./static/files/Certificates//19025A0594.pdf'),(62,'Swathi','19025A0595','2018-22','GITE ENGINEERING COLLEGE',17543,68,51,'CSE','SC',1,'','Pending','./static/files/Certificates//19025A0595.pdf'),(63,'Nithisa','19025A0596','2019-23','GITE ENGINEERING COLLEGE',14882,50,71,'MECH','ST',0,'','Pending','./static/files/Certificates//19025A0596.pdf'),(64,'Annusha K','19025A0597','2020-24','GITE ENGINEERING COLLEGE',14783,48,89,'EEE','BC-A',1,'','Pending','./static/files/Certificates//19025A0597.pdf'),(65,'Arma','19025A0598','2021-25','GITE ENGINEERING COLLEGE',9203,56,95,'CE','ST',0,'','Pending','./static/files/Certificates//19025A0598.pdf'),(66,'Amala','19025A0599','2018-22','GITE ENGINEERING COLLEGE',19643,91,96,'CSE','BC-A',1,'','Pending','./static/files/Certificates//19025A0599.pdf'),(67,'Kajal','19025A0600','2019-23','GITE ENGINEERING COLLEGE',7183,87,78,'ECE','BC-B',0,'','Pending','./static/files/Certificates//19025A0600.pdf'),(68,'Kamkshi','19025A0601','2020-24','GITE ENGINEERING COLLEGE',7776,40,97,'PCE','BC-C',0,'','Pending','./static/files/Certificates//19025A0601.pdf'),(69,'Kaloshh','19025A0602','2021-25','GITE ENGINEERING COLLEGE',18315,46,54,'CSE','BC-D',1,'','Pending','./static/files/Certificates//19025A0602.pdf'),(70,'Dhruv','19025A0603','2018-22','GITE ENGINEERING COLLEGE',9394,53,62,'MECH','BC-E',0,'','Pending','./static/files/Certificates//19025A0603.pdf'),(71,'David','19025A0604','2019-23','GITE ENGINEERING COLLEGE',18641,70,84,'EEE','OC',1,'','Pending','./static/files/Certificates//19025A0604.pdf'),(72,'Damruk','19025A0605','2020-24','GITE ENGINEERING COLLEGE',7978,67,75,'ECE','SC',1,'','Pending','./static/files/Certificates//19025A0605.pdf'),(73,'Eeron','19025A0606','2021-25','GITE ENGINEERING COLLEGE',19107,61,86,'MECH','ST',0,'','Pending','./static/files/Certificates//19025A0606.pdf'),(74,'Farak','19025A0607','2018-22','GITE ENGINEERING COLLEGE',4051,61,71,'CE','BC-A',1,'','Pending','./static/files/Certificates//19025A0607.pdf'),(75,'ghani','19025A0608','2019-23','GITE ENGINEERING COLLEGE',8779,92,45,'PCE','ST',0,'','Pending','./static/files/Certificates//19025A0608.pdf'),(76,'Ganesh','19025A0609','2020-24','GITE ENGINEERING COLLEGE',13130,59,52,'CSE','BC-A',0,'','Pending','./static/files/Certificates//19025A0609.pdf'),(77,'Jagadeesh','19025A0610','2021-25','GITE ENGINEERING COLLEGE',10395,63,56,'MECH','BC-B',1,'','Pending','./static/files/Certificates//19025A0610.pdf'),(78,'Durga Prasad','19025A0611','2018-22','GITE ENGINEERING COLLEGE',2750,99,76,'EEE','BC-C',0,'','Pending','./static/files/Certificates//19025A0611.pdf'),(79,'Chinna Babu','19025A0612','2019-23','GITE ENGINEERING COLLEGE',4111,63,48,'CE','BC-D',1,'','Pending','./static/files/Certificates//19025A0612.pdf'),(80,'Rahul Dravid','19025A0613','2020-24','GITE ENGINEERING COLLEGE',7110,94,81,'CSE','BC-E',0,'','Pending','./static/files/Certificates//19025A0613.pdf'),(81,'Sachin','19025A0614','2021-25','ADITYA ENGINEERING COLLEGE',19935,98,90,'ECE','BC-A',0,'','Pending','./static/files/Certificates//19025A0614.pdf'),(82,'Dhoni','19025A0615','2018-22','ADITYA ENGINEERING COLLEGE',2040,59,44,'MECH','BC-B',1,'','Pending','./static/files/Certificates//19025A0615.pdf'),(83,'Amruth Sir','19025A0616','2019-23','ADITYA ENGINEERING COLLEGE',16640,53,96,'EEE','BC-C',0,'','Pending','./static/files/Certificates//19025A0616.pdf'),(84,'Kalpana','19025A0617','2020-24','ADITYA ENGINEERING COLLEGE',11392,76,90,'CE','BC-D',1,'','Pending','./static/files/Certificates//19025A0617.pdf'),(85,'Kamakshi Kanupu','19025A0618','2021-25','ADITYA ENGINEERING COLLEGE',14906,59,78,'CSE','BC-E',1,'','Pending','./static/files/Certificates//19025A0618.pdf'),(86,'Kusuma','19025A0619','2018-22','ADITYA ENGINEERING COLLEGE',17404,73,73,'ECE','OC',0,'','Pending','./static/files/Certificates//19025A0619.pdf'),(87,'Kaveri','19025A0620','2019-23','ADITYA ENGINEERING COLLEGE',3369,52,71,'PCE','SC',1,'','Pending','./static/files/Certificates//19025A0620.pdf'),(88,'Karuna','19025A0621','2020-24','ADITYA ENGINEERING COLLEGE',18110,44,100,'CSE','ST',0,'','Pending','./static/files/Certificates//19025A0621.pdf'),(89,'Sruthi','19025A0622','2021-25','ADITYA ENGINEERING COLLEGE',16945,67,79,'MECH','BC-A',1,'','Pending','./static/files/Certificates//19025A0622.pdf'),(90,'Nikhil','19025A0623','2018-22','ADITYA ENGINEERING COLLEGE',14861,58,43,'EEE','ST',0,'','Pending','./static/files/Certificates//19025A0623.pdf'),(91,'Prateekh','19025A0624','2019-23','ADITYA ENGINEERING COLLEGE',11125,92,86,'ECE','BC-A',1,'','Pending','./static/files/Certificates//19025A0624.pdf'),(92,'Fouzia','19025A0625','2020-24','ADITYA ENGINEERING COLLEGE',14020,65,94,'MECH','BC-B',0,'','Pending','./static/files/Certificates//19025A0625.pdf'),(93,'Sreya','19025A0626','2021-25','ADITYA ENGINEERING COLLEGE',8375,81,100,'CE','BC-C',1,'','Pending','./static/files/Certificates//19025A0626.pdf'),(94,'Sarayu','19025A0627','2018-22','ADITYA ENGINEERING COLLEGE',18417,85,85,'PCE','BC-D',0,'','Pending','./static/files/Certificates//19025A0627.pdf'),(95,'Sahashh','19025A0628','2019-23','ADITYA ENGINEERING COLLEGE',9240,80,65,'CSE','BC-E',0,'','Pending','./static/files/Certificates//19025A0628.pdf'),(96,'Samudran','19025A0629','2020-24','ADITYA ENGINEERING COLLEGE',2010,73,52,'MECH','BC-E',1,'','Pending','./static/files/Certificates//19025A0629.pdf'),(97,'Sachinvalay','19025A0630','2021-25','ADITYA ENGINEERING COLLEGE',3525,62,55,'EEE','OC',0,'','Pending','./static/files/Certificates//19025A0630.pdf'),(98,'Samukth','19025A0631','2018-22','ADITYA ENGINEERING COLLEGE',5710,78,68,'CE','SC',1,'','Pending','./static/files/Certificates//19025A0631.pdf'),(99,'Raghava','19025A0632','2019-23','ADITYA ENGINEERING COLLEGE',15361,71,67,'CSE','ST',1,'','Pending','./static/files/Certificates//19025A0632.pdf'),(100,'Chiranjeevji','19025A0633','2020-24','ADITYA ENGINEERING COLLEGE',11862,78,93,'ECE','BC-A',0,'','Pending','./static/files/Certificates//19025A0633.pdf'),(101,'Nagarjuna','19025A0634','2021-25','GEETHAM ENGINEERING COLLEGE',13722,83,67,'MECH','ST',1,'','Pending','./static/files/Certificates//19025A0634.pdf'),(102,'Ram Charan','19025A0635','2018-22','GEETHAM ENGINEERING COLLEGE',13378,54,76,'CE','BC-A',0,'','Pending','./static/files/Certificates//19025A0635.pdf'),(103,'Mahesg Babu G','19025A0636','2019-23','GEETHAM ENGINEERING COLLEGE',15516,57,95,'PCE','BC-B',1,'','Pending','./static/files/Certificates//19025A0636.pdf'),(104,'Venkatesh','19025A0637','2020-24','GEETHAM ENGINEERING COLLEGE',14676,74,81,'CSE','BC-C',0,'','Pending','./static/files/Certificates//19025A0637.pdf'),(105,'Naresh','19025A0638','2021-25','GEETHAM ENGINEERING COLLEGE',16916,96,72,'MECH','OC',1,'','Pending','./static/files/Certificates//19025A0638.pdf'),(106,'Sampurnesh','19025A0639','2018-22','GEETHAM ENGINEERING COLLEGE',6385,55,97,'EEE','SC',0,'','Pending','./static/files/Certificates//19025A0639.pdf'),(107,'Karthil','19025A0640','2019-23','GEETHAM ENGINEERING COLLEGE',9738,94,60,'CE','OC',0,'','Pending','./static/files/Certificates//19025A0640.pdf'),(108,'Nani','19025A0641','2020-24','GEETHAM ENGINEERING COLLEGE',2978,88,71,'CSE','SC',1,'','Pending','./static/files/Certificates//19025A0641.pdf'),(109,'Nayantara','19025A0642','2021-25','GEETHAM ENGINEERING COLLEGE',3204,47,45,'ECE','ST',0,'','Pending','./static/files/Certificates//19025A0642.pdf'),(110,'Tamanna','19025A0643','2018-22','GEETHAM ENGINEERING COLLEGE',9911,87,88,'MECH','BC-A',1,'','Pending','./static/files/Certificates//19025A0643.pdf'),(111,'Chandana','19025A0644','2019-23','GEETHAM ENGINEERING COLLEGE',12251,43,61,'EEE','ST',1,'','Pending','./static/files/Certificates//19025A0644.pdf'),(112,'Yashaswi','19025A0645','2020-24','GEETHAM ENGINEERING COLLEGE',8359,74,95,'CE','BC-A',0,'','Pending','./static/files/Certificates//19025A0645.pdf'),(113,'Meghana','19025A0646','2021-25','GEETHAM ENGINEERING COLLEGE',9472,42,82,'CSE','BC-B',1,'','Pending','./static/files/Certificates//19025A0646.pdf'),(114,'Poojitha','19025A0647','2018-22','GEETHAM ENGINEERING COLLEGE',12617,98,92,'ECE','BC-C',0,'','Pending','./static/files/Certificates//19025A0647.pdf'),(115,'Prajwal','19025A0648','2019-23','GEETHAM ENGINEERING COLLEGE',9776,92,72,'PCE','BC-D',1,'','Pending','./static/files/Certificates//19025A0648.pdf'),(116,'Anil','19025A0649','2020-24','GEETHAM ENGINEERING COLLEGE',1002,74,88,'CSE','BC-E',0,'','Pending','./static/files/Certificates//19025A0649.pdf'),(117,'Ashok','19025A0650','2021-25','GEETHAM ENGINEERING COLLEGE',10780,94,95,'MECH','OC',1,'','Pending','./static/files/Certificates//19025A0650.pdf'),(118,'Uday','19025A0651','2018-22','GEETHAM ENGINEERING COLLEGE',15732,59,48,'EEE','SC',0,'','Pending','./static/files/Certificates//19025A0651.pdf'),(119,'Phanindra','19025A0652','2019-23','GEETHAM ENGINEERING COLLEGE',10930,80,56,'ECE','ST',1,'','Pending','./static/files/Certificates//19025A0652.pdf'),(120,'Prabhudeva','19025A0653','2020-24','GEETHAM ENGINEERING COLLEGE',18434,99,91,'MECH','BC-A',0,'','Pending','./static/files/Certificates//19025A0653.pdf');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-02 22:52:25
