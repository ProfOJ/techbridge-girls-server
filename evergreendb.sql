CREATE DATABASE  IF NOT EXISTS `evergreendb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `evergreendb`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: evergreendb
-- ------------------------------------------------------
-- Server version	5.5.49-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banks` (
  `account` varchar(255) DEFAULT NULL,
  `routing` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_banks_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cards`
--

DROP TABLE IF EXISTS `cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cards` (
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `ccv` varchar(255) DEFAULT NULL,
  `expiration` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `fk_creditcards_supplier1_idx` (`user_id`),
  CONSTRAINT `fk_cards_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cards`
--

LOCK TABLES `cards` WRITE;
/*!40000 ALTER TABLE `cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `filename` varchar(255) NOT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `proposal_id` binary(16) NOT NULL,
  PRIMARY KEY (`filename`),
  UNIQUE KEY `filename_UNIQUE` (`filename`),
  KEY `fk_files_proposals1_idx` (`proposal_id`),
  CONSTRAINT `fk_files_proposals1` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES ('0177408ba1ed67f4e6324be3846ccbd9',0,'2017-02-06 23:49:03','2017-02-06 23:49:03','\�⍀\�	\�PY����'),('08361db2f4a1bdcfb8f7ab970134e851',1,'2017-02-07 13:33:29','2017-02-07 13:33:29','H�\�\�}櫞�O\n�s'),('18890e79b5596e41a1878180dd2866d4',0,'2017-01-29 15:42:26','2017-01-29 15:42:26','�3�\�|\��=\���\''),('255b89f083b171319734636b05d62192',0,'2017-01-30 15:59:30','2017-01-30 15:59:30','#�eP\�H\�\�\�O\��G'),('2575e197f0a13e8ec2e1feef06af62e9',1,'2017-02-02 18:49:24','2017-02-02 18:49:24','^\��\�\�\�I*_\n'),('29f7ebbab62a5ac56b9f14676bf1de72',0,'2017-01-29 15:40:13','2017-01-29 15:40:13','G�6�\�|\�췱[�/\�'),('2c3f0ae98baa45ecde62077145450905',0,'2017-01-30 16:02:24','2017-01-30 16:02:24','�l\�P\�H暩\�\Zs�\�'),('2cc785d4bc4374b17c2a348b45ae3e5f',1,'2017-02-06 21:04:51','2017-02-06 21:04:51','��ΐ\��\�u}\�W9S='),('306e7884ee07e418b2b5c216b40a7d27',0,'2017-02-07 13:34:31','2017-02-07 13:34:31','6�\�}\�4�\�+\n�'),('37f95a0e2ac4ccc226f8800e353ebfc8',1,'2017-02-07 13:32:26','2017-02-07 13:32:26','\�IѰ\�|\�m��V�'),('3b728226553f81de2def4fdd6452d1f1',0,'2017-01-29 15:49:36','2017-01-29 15:49:36','�4�\�}櫘�\�r�\n'),('4a55a0b9c2b6df87c2deb2e40b967b45',0,'2017-01-29 15:49:00','2017-01-29 15:49:00','�\�\\�\�}櫘�\�r�\n'),('4c0f3247885fb12ad82c8df7d9d8721d',1,'2017-02-07 13:34:31','2017-02-07 13:34:31','6�\�}\�4�\�+\n�'),('4e7ca392d67a6f9b3958f35df76786a0',1,'2017-02-06 23:49:03','2017-02-06 23:49:03','\�⍀\�	\�PY����'),('4e863e6866cedc58dfabe57e078fd6e4',0,'2017-02-07 00:30:42','2017-02-07 00:30:42','��\0\�\���7i�;'),('4ead6acdaf405fae13fe9e95ff076d46',0,'2017-02-06 21:04:51','2017-02-06 21:04:51','��ΐ\��\�u}\�W9S='),('5755b64c840f2ae8313315d2719b6226',0,'2017-02-06 23:46:36','2017-02-06 23:46:36','�`p\�	\�PY����'),('5a332573e1ec41a0369ae44c8a24cd1c',1,'2017-02-06 23:46:36','2017-02-06 23:46:36','�`p\�	\�PY����'),('5f1ed9e83a392a7c474ebaa48c7a5672',0,'2017-01-29 15:42:26','2017-01-29 15:42:26','�3�\�|\��=\���\''),('669525a7deeaa4ca673b5df5f018e4f4',1,'2017-02-07 13:31:44','2017-02-07 13:31:44','\�\\I\�\�|\�m��V�'),('713d58d88a70752afb71922eb32a31f5',1,'2017-02-07 00:38:49','2017-02-07 00:38:49','ؔ\�0\�\�\�5\�#_a�'),('7222b95666137fa39b70fc59abf111fa',0,'2017-02-07 13:31:44','2017-02-07 13:31:44','\�\\I\�\�|\�m��V�'),('82683ccc6c5e139c21b50b110b14c43c',0,'2017-01-29 15:40:13','2017-01-29 15:40:13','G�6�\�|\�췱[�/\�'),('83529d5c9ec2f34c6a158ad88123cc3c',0,'2017-02-07 13:33:29','2017-02-07 13:33:29','H�\�\�}櫞�O\n�s'),('8675e75c5a053bd112bd42f34fe1c625',1,'2017-02-07 13:39:43','2017-02-07 13:39:43','\��\�\�}演�f���'),('8b0e9a98835a2797c71b9aa2bc6d704b',1,'2017-02-07 00:19:41','2017-02-07 00:19:41',',\�\\\�橮���.:'),('8b8d395c7c0a6e0fc8da475b1bf54095',0,'2017-01-30 16:03:49','2017-01-30 16:03:49','�Ҩ\�\�H\��n�[�'),('91dcc9576683d1a2aefad78de4581912',0,'2017-02-01 19:23:19','2017-02-01 19:23:19','�y[�\��活\�\�IJ-'),('949b5ba9aaf0ebd16347811294956987',0,'2017-01-30 15:59:30','2017-01-30 15:59:30','#�eP\�H\�\�\�O\��G'),('9c13d26a10938f336977354b13c69e00',0,'2017-02-07 13:39:43','2017-02-07 13:39:43','\��\�\�}演�f���'),('9d6b07bf145b8322486ead97ffd89cf0',0,'2017-01-30 15:59:30','2017-01-30 15:59:30','#�eP\�H\�\�\�O\��G'),('9fe301f1a892808afc6a1b0072758dc3',1,'2017-02-01 19:23:19','2017-02-01 19:23:19','�y[�\��活\�\�IJ-'),('a83b4987a091320d6e40f414db3d9561',1,'2017-01-29 15:49:00','2017-01-29 15:49:00','�\�\\�\�}櫘�\�r�\n'),('ac5045f6631dec135825c7cbe545b81c',1,'2017-01-30 16:03:49','2017-01-30 16:03:49','�Ҩ\�\�H\��n�[�'),('ae9a1d5962466f3d212bb0ed78072544',0,'2017-01-29 15:49:36','2017-01-29 15:49:36','�4�\�}櫘�\�r�\n'),('afae612995bbcdfc0e76699686ad3f3f',0,'2017-02-07 13:32:26','2017-02-07 13:32:26','\�IѰ\�|\�m��V�'),('b207b13386d5fb6ac1143a5752002201',1,'2017-01-30 16:02:24','2017-01-30 16:02:24','�l\�P\�H暩\�\Zs�\�'),('bef99df137ab056ff2a0191ef539ebfb',0,'2017-02-07 00:19:41','2017-02-07 00:19:41',',\�\\\�橮���.:'),('c31095f7501a62f0a981a4e41e1db45f',1,'2017-02-02 17:16:12','2017-02-02 17:16:12','Y\�r�\�\�\�\�~\�4\�\�'),('c4ff0a351edf7d1ba982690c4cd4d5ac',0,'2017-02-02 17:16:12','2017-02-02 17:16:12','Y\�r�\�\�\�\�~\�4\�\�'),('c52b9b6f4109571a91ef06cbb1cfe3bd',1,'2017-01-29 15:49:36','2017-01-29 15:49:36','�4�\�}櫘�\�r�\n'),('c9f1656c6076444fdf535fb2325163c7',1,'2017-01-29 15:40:13','2017-01-29 15:40:13','G�6�\�|\�췱[�/\�'),('d00b232c4b6134318cc4c1497a6a1116',0,'2017-02-02 18:49:24','2017-02-02 18:49:24','^\��\�\�\�I*_\n'),('d25542e03d71971c074dbc4c0033e4ff',1,'2017-01-29 15:42:26','2017-01-29 15:42:26','�3�\�|\��=\���\''),('d38f16c9b0a2c5e0ec45d9d369778272',0,'2017-01-30 15:59:30','2017-01-30 15:59:30','#�eP\�H\�\�\�O\��G'),('d6dcfde584b6eb30c30a687925c0cb27',1,'2017-01-30 15:59:30','2017-01-30 15:59:30','#�eP\�H\�\�\�O\��G'),('e8642b65dfde9e602a3a4c9ed865ad57',0,'2017-02-07 13:27:31','2017-02-07 13:27:31',';\�ZP\�|溆\�2�@P!'),('ea982373552c2852c053a88860e00cdb',1,'2017-02-07 00:30:42','2017-02-07 00:30:42','��\0\�\���7i�;'),('ead3498d17fc65f7c87178f6aa23c19c',1,'2017-02-07 13:35:12','2017-02-07 13:35:12','N�M`\�}\�\�\�\��m'),('ee4127e0bd993039b5b2f6deca833337',0,'2017-02-06 23:49:03','2017-02-06 23:49:03','\�⍀\�	\�PY����'),('eef323095b04b5df9b942317f4b6bc78',1,'2017-02-07 13:27:31','2017-02-07 13:27:31',';\�ZP\�|溆\�2�@P!'),('f85f99eede4e86c468d25cb5831029cf',0,'2017-01-29 15:49:00','2017-01-29 15:49:00','�\�\\�\�}櫘�\�r�\n'),('fb3137ad62b21b27c9bd2078321cd8a6',0,'2017-02-07 00:38:49','2017-02-07 00:38:49','ؔ\�0\�\�\�5\�#_a�'),('fda4906e14ef9466d06cd8c9bb888868',0,'2017-02-07 13:35:12','2017-02-07 13:35:12','N�M`\�}\�\�\�\��m');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labors`
--

DROP TABLE IF EXISTS `labors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labors` (
  `id` binary(16) NOT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `labor` varchar(255) DEFAULT NULL,
  `time` decimal(12,6) DEFAULT NULL,
  `yield` decimal(5,2) DEFAULT NULL,
  `rate` decimal(12,6) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `proposal_id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_labors_offers1_idx` (`proposal_id`,`user_id`),
  CONSTRAINT `fk_labors_offers1` FOREIGN KEY (`proposal_id`, `user_id`) REFERENCES `offers` (`proposal_id`, `user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labors`
--

LOCK TABLES `labors` WRITE;
/*!40000 ALTER TABLE `labors` DISABLE KEYS */;
INSERT INTO `labors` VALUES ('4�F�\�~\�~�H\�|2',0,'5',145.000000,45.00,45.000000,45,'2017-01-29 15:53:02','2017-01-29 15:53:02','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('4��Q\�~\�~�H\�|2',0,'45',45.000000,45.00,45.000000,45,'2017-01-29 15:53:02','2017-01-29 15:53:02','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('7`\")\��斒�H\�|2',0,'Double Shot Molding 500T',32.000000,23.00,23.000000,23,'2017-02-06 21:13:40','2017-02-06 21:13:40','��ΐ\��\�u}\�W9S=','@q�\�\�~�H\�|2'),('7`9Q\��斒�H\�|2',1,'Mechanical Engineering',23.000000,23.00,3.000000,23,'2017-02-06 21:13:40','2017-02-06 21:13:40','��ΐ\��\�u}\�W9S=','@q�\�\�~�H\�|2'),('Cmf�\�\�~�H\�|2',0,'645',87897.000000,987.00,78.000000,5,'2017-01-29 16:07:45','2017-01-29 16:07:45','�3�\�|\��=\���\'','@q�\�\�~�H\�|2'),('Cmp\�\�\�~�H\�|2',0,'578',5.000000,78.00,658.000000,75,'2017-01-29 16:07:45','2017-01-29 16:07:45','�3�\�|\��=\���\'','@q�\�\�~�H\�|2'),('`\�v\�\�\�斒�H\�|2',1,'Inspection',34.000000,34.00,34.000000,34,'2017-02-06 17:04:17','2017-02-06 17:04:17','G�6�\�|\�췱[�/\�','\�eV�\�\�~�H\�|2'),('`\�w�\�\�斒�H\�|2',0,'Band Saw',34.000000,34.00,34.000000,34,'2017-02-06 17:04:17','2017-02-06 17:04:17','G�6�\�|\�췱[�/\�','\�eV�\�\�~�H\�|2'),('�gQ\�\�~�H\�|2',0,'83',383.000000,999.99,838.000000,12,'2017-01-29 16:09:36','2017-01-29 16:09:36','�4�\�}櫘�\�r�\n','@q�\�\�~�H\�|2'),('�gYS\�\�~�H\�|2',0,'13',213.000000,2.00,321.000000,2,'2017-01-29 16:09:36','2017-01-29 16:09:36','�4�\�}櫘�\�r�\n','@q�\�\�~�H\�|2');
/*!40000 ALTER TABLE `labors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materials` (
  `id` binary(16) NOT NULL,
  `material` varchar(255) DEFAULT NULL,
  `weight` decimal(12,6) DEFAULT NULL,
  `cost` decimal(12,6) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `proposal_id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_materials_offers1_idx` (`proposal_id`,`user_id`),
  CONSTRAINT `fk_materials_offers1` FOREIGN KEY (`proposal_id`, `user_id`) REFERENCES `offers` (`proposal_id`, `user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES ('4�7�\�~\�~�H\�|2','al',52.000000,213.000000,'2017-01-29 15:53:02','2017-01-29 15:53:02','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('7`\n\n\��斒�H\�|2','PE',32.000000,2.990000,'2017-02-06 21:13:40','2017-02-06 21:13:40','��ΐ\��\�u}\�W9S=','@q�\�\�~�H\�|2'),('Cl\��\�\�~�H\�|2','SD',78.000000,898976.000000,'2017-01-29 16:07:45','2017-01-29 16:07:45','�3�\�|\��=\���\'','@q�\�\�~�H\�|2'),('`\�v,\�\�斒�H\�|2','POM',3.000000,3.000000,'2017-02-06 17:04:17','2017-02-06 17:04:17','G�6�\�|\�췱[�/\�','\�eV�\�\�~�H\�|2'),('�gL \�\�~�H\�|2','Hydrogen',37.000000,9.000000,'2017-01-29 16:09:36','2017-01-29 16:09:36','�4�\�}櫘�\�r�\n','@q�\�\�~�H\�|2');
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` binary(16) NOT NULL,
  `message` text,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `proposal_id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_messages_proposals1_idx` (`proposal_id`),
  KEY `fk_messages_users1_idx` (`user_id`),
  CONSTRAINT `fk_messages_proposals1` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES ('\0\�\�\r\�\�~�H\�|2','okay',0,'2017-01-29 17:10:19','2017-01-29 17:10:19','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('��\�\�\�~�H\�|2','10101010',0,'2017-01-29 17:10:23','2017-01-29 17:10:23','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('\�l�\�\�\�G�;�R4F','hey',0,'2017-02-02 22:21:41','2017-02-02 22:21:41','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('&�� \�\�~�H\�|2','testet',0,'2017-01-29 17:11:22','2017-01-29 17:11:22','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('(��P\�\�~�H\�|2','okokoko',0,'2017-01-29 17:11:26','2017-01-29 17:11:26','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('+&!\�\�~�H\�|2','fkkkkk',0,'2017-01-29 17:04:20','2017-01-29 17:04:20','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('T*�\�\�~�H\�|2','bd',0,'2017-01-29 17:05:29','2017-01-29 17:05:29','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('xm̊\�\�~�H\�|2','testing',0,'2017-01-29 17:06:30','2017-01-29 17:06:30','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('~�:\�\�~�H\�|2','hi',0,'2017-01-29 17:06:40','2017-01-29 17:06:40','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('�\��\�\�~�H\�|2','why',0,'2017-01-29 17:14:10','2017-01-29 17:14:10','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('�\r7\�\�\�~�H\�|2','why not',0,'2017-01-29 17:14:16','2017-01-29 17:14:16','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('���F\�\�~�H\�|2','gas',0,'2017-01-29 17:00:10','2017-01-29 17:00:10','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('�v\"�\�\�\�\�-߂\��','check',0,'2017-02-02 22:25:47','2017-02-02 22:25:47','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('�\�ٌ\�\�~�H\�|2','lol',0,'2017-01-29 17:00:27','2017-01-29 17:00:27','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('\�d;\�\�\�\�w�\�\�}','test',0,'2017-01-29 17:17:16','2017-01-29 17:17:16','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('\���\�\�\�w�\�\�}','test',0,'2017-01-29 17:17:19','2017-01-29 17:17:19','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('\���\�\�\�w�\�\�}','with',0,'2017-01-29 17:17:20','2017-01-29 17:17:20','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('\�e�\0\�\�\�w�\�\�}','new',0,'2017-01-29 17:17:21','2017-01-29 17:17:21','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('\�5�\�\�\�w�\�\�}','uuid',0,'2017-01-29 17:17:22','2017-01-29 17:17:22','�\�\\�\�}櫘�\�r�\n','�\�o�\�z\�~�H\�|2'),('ߥ \�\�\�w�\�\�}','it w',0,'2017-01-29 17:17:31','2017-01-29 17:17:31','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('\�D@\�\�\�w�\�\�}','work',0,'2017-01-29 17:17:32','2017-01-29 17:17:32','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),('\�(0\�\�\�w�\�\�}','s',0,'2017-01-29 17:17:33','2017-01-29 17:17:33','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offers` (
  `status` tinyint(1) DEFAULT NULL,
  `sga` decimal(12,2) DEFAULT NULL,
  `tooling` decimal(12,2) DEFAULT NULL,
  `profit` decimal(12,2) DEFAULT NULL,
  `overhead` decimal(12,2) DEFAULT NULL,
  `total` decimal(12,2) DEFAULT NULL,
  `completion` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `proposal_id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`proposal_id`,`user_id`),
  KEY `fk_offer_proposals1_idx` (`proposal_id`),
  KEY `fk_offer_supplier1_idx` (`user_id`),
  CONSTRAINT `fk_offer_proposals1` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_supplier1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (0,NULL,NULL,NULL,NULL,NULL,NULL,'2017-02-06 17:14:06','2017-02-06 17:14:06','G�6�\�|\�췱[�/\�','@q�\�\�~�H\�|2'),(0,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-30 14:28:31','2017-01-30 14:28:31','G�6�\�|\�췱[�/\�','\���\�\�}\�~�H\�|2'),(1,34.00,34.00,34.00,34.00,34.00,NULL,'2017-02-06 17:03:13','2017-02-06 17:04:17','G�6�\�|\�췱[�/\�','\�eV�\�\�~�H\�|2'),(2,45.00,NULL,45.00,45.00,45.00,NULL,'2017-01-29 15:50:59','2017-01-29 15:54:39','�\�\\�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),(1,78.00,NULL,78.00,75.00,78.00,NULL,'2017-01-29 16:06:55','2017-01-29 16:07:45','�3�\�|\��=\���\'','@q�\�\�~�H\�|2'),(1,23.00,NULL,44.00,23.00,2312.00,NULL,'2017-01-29 16:08:48','2017-01-29 16:09:36','�4�\�}櫘�\�r�\n','@q�\�\�~�H\�|2'),(0,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-29 15:50:51','2017-01-29 15:50:51','�4�\�}櫘�\�r�\n','\���\�\�}\�~�H\�|2'),(1,23.00,32.00,23.00,23.00,23.00,'2017-02-23','2017-02-06 21:05:23','2017-02-06 21:13:40','��ΐ\��\�u}\�W9S=','@q�\�\�~�H\�|2');
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `processes`
--

DROP TABLE IF EXISTS `processes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processes` (
  `process` varchar(255) NOT NULL,
  PRIMARY KEY (`process`),
  UNIQUE KEY `process_UNIQUE` (`process`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `processes`
--

LOCK TABLES `processes` WRITE;
/*!40000 ALTER TABLE `processes` DISABLE KEYS */;
INSERT INTO `processes` VALUES ('Automation'),('Batch & Fill'),('Blow Molding'),('CNC'),('Cut & Sew'),('Die Casting'),('Die Cutting'),('Fiber Molding'),('Injection Molding'),('Laser Welding'),('Printing'),('Screen Printing'),('Thermaforming');
/*!40000 ALTER TABLE `processes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposal_processes`
--

DROP TABLE IF EXISTS `proposal_processes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposal_processes` (
  `process` varchar(255) NOT NULL,
  `proposal_id` binary(16) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`process`,`proposal_id`),
  KEY `fk_processes_has_proposals_proposals1_idx` (`proposal_id`),
  KEY `fk_processes_has_proposals_processes1_idx` (`process`),
  CONSTRAINT `fk_processes_has_proposals_processes1` FOREIGN KEY (`process`) REFERENCES `processes` (`process`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_processes_has_proposals_proposals1` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposal_processes`
--

LOCK TABLES `proposal_processes` WRITE;
/*!40000 ALTER TABLE `proposal_processes` DISABLE KEYS */;
INSERT INTO `proposal_processes` VALUES ('Automation','H�\�\�}櫞�O\n�s','2017-02-07 13:33:29','2017-02-07 13:33:29'),('Automation',',\�\\\�橮���.:','2017-02-07 00:19:41','2017-02-07 00:19:41'),('Automation',';\�ZP\�|溆\�2�@P!','2017-02-07 13:27:31','2017-02-07 13:27:31'),('Automation','N�M`\�}\�\�\�\��m','2017-02-07 13:35:12','2017-02-07 13:35:12'),('Automation','�`p\�	\�PY����','2017-02-06 23:46:36','2017-02-06 23:46:36'),('Automation','��\0\�\���7i�;','2017-02-07 00:30:42','2017-02-07 00:30:42'),('Automation','\�\\I\�\�|\�m��V�','2017-02-07 13:31:44','2017-02-07 13:31:44'),('Automation','ؔ\�0\�\�\�5\�#_a�','2017-02-07 00:38:49','2017-02-07 00:38:49'),('Automation','\�⍀\�	\�PY����','2017-02-06 23:49:03','2017-02-06 23:49:03'),('Automation','\�IѰ\�|\�m��V�','2017-02-07 13:32:26','2017-02-07 13:32:26'),('Automation','\��\�\�}演�f���','2017-02-07 13:39:43','2017-02-07 13:39:43'),('Automation','��ΐ\��\�u}\�W9S=','2017-02-06 21:04:51','2017-02-06 21:04:51'),('Batch & Fill','�\�\\�\�}櫘�\�r�\n','2017-01-29 15:49:00','2017-01-29 15:49:00'),('Batch & Fill','�y[�\��活\�\�IJ-','2017-02-01 19:23:19','2017-02-01 19:23:19'),('Blow Molding','#�eP\�H\�\�\�O\��G','2017-01-30 15:59:30','2017-01-30 15:59:30'),('Blow Molding','N�M`\�}\�\�\�\��m','2017-02-07 13:35:12','2017-02-07 13:35:12'),('Blow Molding','�\�\\�\�}櫘�\�r�\n','2017-01-29 15:49:00','2017-01-29 15:49:00'),('Blow Molding','�Ҩ\�\�H\��n�[�','2017-01-30 16:03:49','2017-01-30 16:03:49'),('Blow Molding','��ΐ\��\�u}\�W9S=','2017-02-06 21:04:51','2017-02-06 21:04:51'),('CNC','�l\�P\�H暩\�\Zs�\�','2017-01-30 16:02:24','2017-01-30 16:02:24'),('CNC','�`p\�	\�PY����','2017-02-06 23:46:36','2017-02-06 23:46:36'),('Cut & Sew','H�\�\�}櫞�O\n�s','2017-02-07 13:33:29','2017-02-07 13:33:29'),('Cut & Sew','#�eP\�H\�\�\�O\��G','2017-01-30 15:59:30','2017-01-30 15:59:30'),('Cut & Sew','Y\�r�\�\�\�\�~\�4\�\�','2017-02-02 17:16:12','2017-02-02 17:16:12'),('Cut & Sew','^\��\�\�\�I*_\n','2017-02-02 18:49:24','2017-02-02 18:49:24'),('Cut & Sew','��\0\�\���7i�;','2017-02-07 00:30:42','2017-02-07 00:30:42'),('Die Casting',';\�ZP\�|溆\�2�@P!','2017-02-07 13:27:31','2017-02-07 13:27:31'),('Die Casting','N�M`\�}\�\�\�\��m','2017-02-07 13:35:12','2017-02-07 13:35:12'),('Die Casting','�`p\�	\�PY����','2017-02-06 23:46:36','2017-02-06 23:46:36'),('Die Casting','ؔ\�0\�\�\�5\�#_a�','2017-02-07 00:38:49','2017-02-07 00:38:49'),('Die Casting','\�IѰ\�|\�m��V�','2017-02-07 13:32:26','2017-02-07 13:32:26'),('Die Casting','\��\�\�}演�f���','2017-02-07 13:39:43','2017-02-07 13:39:43'),('Die Casting','�y[�\��活\�\�IJ-','2017-02-01 19:23:19','2017-02-01 19:23:19'),('Die Cutting',',\�\\\�橮���.:','2017-02-07 00:19:41','2017-02-07 00:19:41'),('Die Cutting','^\��\�\�\�I*_\n','2017-02-02 18:49:24','2017-02-02 18:49:24'),('Die Cutting','�l\�P\�H暩\�\Zs�\�','2017-01-30 16:02:24','2017-01-30 16:02:24'),('Die Cutting','��ΐ\��\�u}\�W9S=','2017-02-06 21:04:51','2017-02-06 21:04:51'),('Fiber Molding','ؔ\�0\�\�\�5\�#_a�','2017-02-07 00:38:49','2017-02-07 00:38:49'),('Injection Molding','�4�\�}櫘�\�r�\n','2017-01-29 15:49:36','2017-01-29 15:49:36'),('Laser Welding','\�\\I\�\�|\�m��V�','2017-02-07 13:31:44','2017-02-07 13:31:44'),('Laser Welding','\��\�\�}演�f���','2017-02-07 13:39:43','2017-02-07 13:39:43'),('Printing',';\�ZP\�|溆\�2�@P!','2017-02-07 13:27:31','2017-02-07 13:27:31'),('Printing','�Ҩ\�\�H\��n�[�','2017-01-30 16:03:49','2017-01-30 16:03:49'),('Printing','\�⍀\�	\�PY����','2017-02-06 23:49:03','2017-02-06 23:49:03'),('Thermaforming','�4�\�}櫘�\�r�\n','2017-01-29 15:49:36','2017-01-29 15:49:36'),('Thermaforming','\�⍀\�	\�PY����','2017-02-06 23:49:03','2017-02-06 23:49:03');
/*!40000 ALTER TABLE `proposal_processes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposals`
--

DROP TABLE IF EXISTS `proposals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proposals` (
  `id` binary(16) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `completion` date DEFAULT NULL,
  `zip` char(5) DEFAULT NULL,
  `audience` tinyint(1) DEFAULT NULL,
  `info` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_proposals_users1_idx` (`user_id`),
  CONSTRAINT `fk_proposals_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposals`
--

LOCK TABLES `proposals` WRITE;
/*!40000 ALTER TABLE `proposals` DISABLE KEYS */;
INSERT INTO `proposals` VALUES ('H�\�\�}櫞�O\n�s',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 13:33:29','2017-02-07 13:33:29','�\�o�\�z\�~�H\�|2'),('#�eP\�H\�\�\�O\��G',0,'Laptops',9999,'2019-02-24','8923',0,'','2017-01-30 15:59:30','2017-01-30 15:59:30','�\�o�\�z\�~�H\�|2'),(',\�\\\�橮���.:',0,'Real product',75,'2017-09-22','95129',0,'adsadas','2017-02-07 00:19:41','2017-02-07 00:19:41','�\�o�\�z\�~�H\�|2'),('6�\�}\�4�\�+\n�',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 13:34:31','2017-02-07 13:34:31','�\�o�\�z\�~�H\�|2'),(';\�ZP\�|溆\�2�@P!',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 13:27:31','2017-02-07 13:27:31','�\�o�\�z\�~�H\�|2'),('G�6�\�|\�췱[�/\�',0,'sd',20,'2222-02-22','9123',0,'asd','2017-01-29 15:40:13','2017-01-29 15:40:13','�\�o�\�z\�~�H\�|2'),('N�M`\�}\�\�\�\��m',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 13:35:12','2017-02-07 13:35:12','�\�o�\�z\�~�H\�|2'),('Y\�r�\�\�\�\�~\�4\�\�',0,'Dildos',78337,'2017-02-04','94578',0,'For Elliot','2017-02-02 17:16:12','2017-02-02 17:16:12','�\�o�\�z\�~�H\�|2'),('^\��\�\�\�I*_\n',0,'forks',69,'2017-02-04','95121',0,'Cuz i like to fork elliot','2017-02-02 18:49:24','2017-02-02 18:49:24','�\�o�\�z\�~�H\�|2'),('�\�\\�\�}櫘�\�r�\n',2,'Wheels',521,'2019-02-22','512',0,'','2017-01-29 15:49:00','2017-01-29 15:54:39','�\�o�\�z\�~�H\�|2'),('�l\�P\�H暩\�\Zs�\�',0,'Monitors',839,'2019-06-03','59824',0,'','2017-01-30 16:02:24','2017-01-30 16:02:24','�\�o�\�z\�~�H\�|2'),('�`p\�	\�PY����',0,'TESTING FILE UPLOAD',200,'2017-09-19','95129',0,'test info','2017-02-06 23:46:36','2017-02-06 23:46:36','�\�o�\�z\�~�H\�|2'),('�3�\�|\��=\���\'',0,'sd',20,'2222-02-22','9123',0,'asd','2017-01-29 15:42:26','2017-01-29 15:42:26','�\�o�\�z\�~�H\�|2'),('�4�\�}櫘�\�r�\n',0,'756',64,'2017-01-31','73',0,'','2017-01-29 15:49:36','2017-01-29 15:49:36','�\�o�\�z\�~�H\�|2'),('���p\�|\�\�i~��\Z',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 13:30:24','2017-02-07 13:30:24','�\�o�\�z\�~�H\�|2'),('��\0\�\���7i�;',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 00:30:42','2017-02-07 00:30:42','�\�o�\�z\�~�H\�|2'),('�Ҩ\�\�H\��n�[�',0,'Hats',69,'2017-02-04','7683',0,'','2017-01-30 16:03:48','2017-01-30 16:03:48','�\�o�\�z\�~�H\�|2'),('\�\\I\�\�|\�m��V�',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 13:31:44','2017-02-07 13:31:44','�\�o�\�z\�~�H\�|2'),('ؔ\�0\�\�\�5\�#_a�',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 00:38:49','2017-02-07 00:38:49','�\�o�\�z\�~�H\�|2'),('\�⍀\�	\�PY����',0,'Test product 2',12,'2017-09-19','95129',0,'some test info','2017-02-06 23:49:03','2017-02-06 23:49:03','�\�o�\�z\�~�H\�|2'),('\�IѰ\�|\�m��V�',0,'Makers product',200,'2017-09-19','95129',0,'test info','2017-02-07 13:32:26','2017-02-07 13:32:26','�\�o�\�z\�~�H\�|2'),('\��\�\�}演�f���',0,'Makers product\'s\'a as',200,'2017-09-19','95129',0,'test infosa;\'av[p3s\'\'','2017-02-07 13:39:42','2017-02-07 13:39:42','�\�o�\�z\�~�H\�|2'),('�y[�\��活\�\�IJ-',0,'Mice',897,'2018-08-09','59125',0,'Need GAMING mouse. Like Hella','2017-02-01 19:23:19','2017-02-01 19:23:19','�\�o�\�z\�~�H\�|2'),('��ΐ\��\�u}\�W9S=',0,'Really long product name because **** you Elliot',200,'2017-09-19','95129',0,'test info','2017-02-06 21:04:51','2017-02-06 21:04:51','�\�o�\�z\�~�H\�|2');
/*!40000 ALTER TABLE `proposals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` binary(16) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `input` int(11) DEFAULT NULL,
  `output` int(11) DEFAULT NULL,
  `shipped` int(11) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` binary(16) NOT NULL,
  `proposal_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_reports_offers1_idx` (`user_id`,`proposal_id`),
  CONSTRAINT `fk_reports_offers1` FOREIGN KEY (`user_id`, `proposal_id`) REFERENCES `offers` (`user_id`, `proposal_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES ('F-)\0\�\�演߈J^k�',1,890,890,890,'Notes here','2017-02-01 16:19:34','2017-02-01 16:19:34','\���\�\�}\�~�H\�|2','�\�\\�\�}櫘�\�r�\n');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urls`
--

DROP TABLE IF EXISTS `urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urls` (
  `homepage` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `user_id` binary(16) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `supplier_id_UNIQUE` (`user_id`),
  KEY `fk_urls_suppliers1_idx` (`user_id`),
  CONSTRAINT `fk_urls_suppliers1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urls`
--

LOCK TABLES `urls` WRITE;
/*!40000 ALTER TABLE `urls` DISABLE KEYS */;
/*!40000 ALTER TABLE `urls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_processes`
--

DROP TABLE IF EXISTS `user_processes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_processes` (
  `process` varchar(255) NOT NULL,
  `user_id` binary(16) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`process`,`user_id`),
  KEY `fk_processes_has_users_users1_idx` (`user_id`),
  KEY `fk_processes_has_users_processes1_idx` (`process`),
  CONSTRAINT `fk_processes_has_users_processes1` FOREIGN KEY (`process`) REFERENCES `processes` (`process`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_processes_has_users_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_processes`
--

LOCK TABLES `user_processes` WRITE;
/*!40000 ALTER TABLE `user_processes` DISABLE KEYS */;
INSERT INTO `user_processes` VALUES ('Batch & Fill','@q�\�\�~�H\�|2','2017-01-29 16:06:41','2017-01-29 16:06:41'),('Batch & Fill','\���\�\�}\�~�H\�|2','2017-01-29 15:50:35','2017-01-29 15:50:35'),('Cut & Sew','@q�\�\�~�H\�|2','2017-01-29 16:06:41','2017-01-29 16:06:41'),('Cut & Sew','\���\�\�}\�~�H\�|2','2017-01-29 15:50:35','2017-01-29 15:50:35'),('Die Casting','\���\�\�}\�~�H\�|2','2017-01-29 15:50:35','2017-01-29 15:50:35'),('Injection Molding','@q�\�\�~�H\�|2','2017-01-29 16:06:41','2017-01-29 16:06:41');
/*!40000 ALTER TABLE `user_processes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` binary(16) NOT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `zip` char(5) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('@q�\�\�~�H\�|2',1,'Elliot & Co','Elliot','elliot@ec.com','$2a$10$MdllsaNzU0loVzQO3UbnPu4JuC1EWILseenr3N21iey385gpgGr7W',NULL,NULL,NULL,'2017-01-29 16:06:38','2017-01-29 16:06:38'),('�\�o�\�z\�~�H\�|2',0,'Maker','Mak','mak@maker.com','$2a$10$W1ximrjdK.yxCD2ZJ/dWUurEEFE/R4w0BUCqqMOKTiol/AZCiBPSC',NULL,NULL,NULL,'2017-01-29 15:27:20','2017-01-29 15:27:20'),('\���\�\�}\�~�H\�|2',1,'Supplier','Su','su@supplier.com','$2a$10$vB4CbF.qLWb.yDl6dOkB5uWXUtqfAmyh8/4bHla8qlBNMo2TrIkH6',NULL,NULL,NULL,'2017-01-29 15:50:31','2017-01-29 15:50:31'),('\�eV�\�\�~�H\�|2',1,'jk','njk','njk@njk.nk','$2a$10$GO5DfZ16Wu/WMHF1U3TsTefKwK5kjqY47Xrh5GGYhExaNtBqiooc6',NULL,NULL,NULL,'2017-01-29 17:23:54','2017-01-29 17:23:54');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-10  0:51:11
