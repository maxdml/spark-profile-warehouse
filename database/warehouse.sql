-- MySQL dump 10.15  Distrib 10.0.25-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: warehouse2
-- ------------------------------------------------------
-- Server version	10.0.25-MariaDB

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
-- Table structure for table `App_event`
--

DROP TABLE IF EXISTS `App_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `App_event` (
  `app_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  KEY `app_id` (`app_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `App_event_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `Application` (`id`),
  CONSTRAINT `App_event_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `App_event`
--

LOCK TABLES `App_event` WRITE;
/*!40000 ALTER TABLE `App_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `App_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `App_metric`
--

DROP TABLE IF EXISTS `App_metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `App_metric` (
  `app_id` int(11) DEFAULT NULL,
  `metric_id` int(11) DEFAULT NULL,
  KEY `app_id` (`app_id`),
  KEY `metric_id` (`metric_id`),
  CONSTRAINT `App_metric_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `Application` (`id`),
  CONSTRAINT `App_metric_ibfk_2` FOREIGN KEY (`metric_id`) REFERENCES `Metric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `App_metric`
--

LOCK TABLES `App_metric` WRITE;
/*!40000 ALTER TABLE `App_metric` DISABLE KEYS */;
/*!40000 ALTER TABLE `App_metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Application`
--

DROP TABLE IF EXISTS `Application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `app_name` char(100) DEFAULT NULL,
  `app_env` text,
  `app_submit` text,
  `app_dag` text,
  `app_master` int(11) DEFAULT NULL,
  `app_driver` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_master` (`app_master`),
  KEY `app_driver` (`app_driver`),
  CONSTRAINT `Application_ibfk_1` FOREIGN KEY (`app_master`) REFERENCES `Container` (`id`),
  CONSTRAINT `Application_ibfk_2` FOREIGN KEY (`app_driver`) REFERENCES `Container` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application`
--

LOCK TABLES `Application` WRITE;
/*!40000 ALTER TABLE `Application` DISABLE KEYS */;
/*!40000 ALTER TABLE `Application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Container`
--

DROP TABLE IF EXISTS `Container`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Container` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `container_id` int(11) DEFAULT NULL,
  `container_host` char(100) DEFAULT NULL,
  `container_type` char(100) DEFAULT NULL,
  `container_cores` int(11) DEFAULT NULL,
  `container_mem` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `container_env` text,
  `container_yarn_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  CONSTRAINT `Container_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `Application` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Container`
--

LOCK TABLES `Container` WRITE;
/*!40000 ALTER TABLE `Container` DISABLE KEYS */;
/*!40000 ALTER TABLE `Container` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Container_event`
--

DROP TABLE IF EXISTS `Container_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Container_event` (
  `cont_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  KEY `cont_id` (`cont_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Container_event_ibfk_1` FOREIGN KEY (`cont_id`) REFERENCES `Container` (`id`),
  CONSTRAINT `Container_event_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Container_event`
--

LOCK TABLES `Container_event` WRITE;
/*!40000 ALTER TABLE `Container_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Container_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Container_metric`
--

DROP TABLE IF EXISTS `Container_metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Container_metric` (
  `cont_id` int(11) DEFAULT NULL,
  `metric_id` int(11) DEFAULT NULL,
  KEY `cont_id` (`cont_id`),
  KEY `metric_id` (`metric_id`),
  CONSTRAINT `Container_metric_ibfk_1` FOREIGN KEY (`cont_id`) REFERENCES `Container` (`id`),
  CONSTRAINT `Container_metric_ibfk_2` FOREIGN KEY (`metric_id`) REFERENCES `Metric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Container_metric`
--

LOCK TABLES `Container_metric` WRITE;
/*!40000 ALTER TABLE `Container_metric` DISABLE KEYS */;
/*!40000 ALTER TABLE `Container_metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Event`
--

DROP TABLE IF EXISTS `Event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `event_type` char(100) DEFAULT NULL,
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `event_details` text,
  `event_trace` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event`
--

LOCK TABLES `Event` WRITE;
/*!40000 ALTER TABLE `Event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Job`
--

DROP TABLE IF EXISTS `Job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `job_name` char(100) DEFAULT NULL,
  `job_dag` text,
  `job_env` text,
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  CONSTRAINT `Job_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `Application` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Job`
--

LOCK TABLES `Job` WRITE;
/*!40000 ALTER TABLE `Job` DISABLE KEYS */;
/*!40000 ALTER TABLE `Job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Job_event`
--

DROP TABLE IF EXISTS `Job_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Job_event` (
  `job_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  KEY `job_id` (`job_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Job_event_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `Job` (`id`),
  CONSTRAINT `Job_event_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Job_event`
--

LOCK TABLES `Job_event` WRITE;
/*!40000 ALTER TABLE `Job_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Job_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Job_metric`
--

DROP TABLE IF EXISTS `Job_metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Job_metric` (
  `job_id` int(11) DEFAULT NULL,
  `metric_id` int(11) DEFAULT NULL,
  KEY `job_id` (`job_id`),
  KEY `metric_id` (`metric_id`),
  CONSTRAINT `Job_metric_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `Job` (`id`),
  CONSTRAINT `Job_metric_ibfk_2` FOREIGN KEY (`metric_id`) REFERENCES `Metric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Job_metric`
--

LOCK TABLES `Job_metric` WRITE;
/*!40000 ALTER TABLE `Job_metric` DISABLE KEYS */;
/*!40000 ALTER TABLE `Job_metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Metric`
--

DROP TABLE IF EXISTS `Metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Metric` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `metric_id` char(100) DEFAULT NULL,
  `metric_name` char(100) DEFAULT NULL,
  `metric_value` char(100) DEFAULT NULL,
  `metric_type` char(100) DEFAULT NULL,
  `metric_source` char(100) DEFAULT NULL,
  `metric_unit` char(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Metric`
--

LOCK TABLES `Metric` WRITE;
/*!40000 ALTER TABLE `Metric` DISABLE KEYS */;
/*!40000 ALTER TABLE `Metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pnode`
--

DROP TABLE IF EXISTS `Pnode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pnode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pnode_id` int(11) DEFAULT NULL,
  `pnode_hostname` char(100) DEFAULT NULL,
  `pnode_ip` char(100) DEFAULT NULL,
  `pnode_MAC` char(100) DEFAULT NULL,
  `pnode_HW` text,
  `pnode_type` char(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pnode`
--

LOCK TABLES `Pnode` WRITE;
/*!40000 ALTER TABLE `Pnode` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pnode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pnode_event`
--

DROP TABLE IF EXISTS `Pnode_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pnode_event` (
  `pnode_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  KEY `pnode_id` (`pnode_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Pnode_event_ibfk_1` FOREIGN KEY (`pnode_id`) REFERENCES `Pnode` (`id`),
  CONSTRAINT `Pnode_event_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pnode_event`
--

LOCK TABLES `Pnode_event` WRITE;
/*!40000 ALTER TABLE `Pnode_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pnode_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pnode_metric`
--

DROP TABLE IF EXISTS `Pnode_metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pnode_metric` (
  `pnode_id` int(11) DEFAULT NULL,
  `metric_id` int(11) DEFAULT NULL,
  KEY `pnode_id` (`pnode_id`),
  KEY `metric_id` (`metric_id`),
  CONSTRAINT `Pnode_metric_ibfk_1` FOREIGN KEY (`pnode_id`) REFERENCES `Pnode` (`id`),
  CONSTRAINT `Pnode_metric_ibfk_2` FOREIGN KEY (`metric_id`) REFERENCES `Metric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pnode_metric`
--

LOCK TABLES `Pnode_metric` WRITE;
/*!40000 ALTER TABLE `Pnode_metric` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pnode_metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stage`
--

DROP TABLE IF EXISTS `Stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `stage_id` int(11) DEFAULT NULL,
  `stage_name` char(100) DEFAULT NULL,
  `stage_dag` text,
  `stage_env` text,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  KEY `app_id` (`app_id`),
  CONSTRAINT `Stage_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `Job` (`id`),
  CONSTRAINT `Stage_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `Application` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stage`
--

LOCK TABLES `Stage` WRITE;
/*!40000 ALTER TABLE `Stage` DISABLE KEYS */;
/*!40000 ALTER TABLE `Stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stage_event`
--

DROP TABLE IF EXISTS `Stage_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stage_event` (
  `stage_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  KEY `stage_id` (`stage_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Stage_event_ibfk_1` FOREIGN KEY (`stage_id`) REFERENCES `Stage` (`id`),
  CONSTRAINT `Stage_event_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stage_event`
--

LOCK TABLES `Stage_event` WRITE;
/*!40000 ALTER TABLE `Stage_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Stage_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stage_metric`
--

DROP TABLE IF EXISTS `Stage_metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stage_metric` (
  `stage_id` int(11) DEFAULT NULL,
  `metric_id` int(11) DEFAULT NULL,
  KEY `stage_id` (`stage_id`),
  KEY `metric_id` (`metric_id`),
  CONSTRAINT `Stage_metric_ibfk_1` FOREIGN KEY (`stage_id`) REFERENCES `Stage` (`id`),
  CONSTRAINT `Stage_metric_ibfk_2` FOREIGN KEY (`metric_id`) REFERENCES `Metric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stage_metric`
--

LOCK TABLES `Stage_metric` WRITE;
/*!40000 ALTER TABLE `Stage_metric` DISABLE KEYS */;
/*!40000 ALTER TABLE `Stage_metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Task`
--

DROP TABLE IF EXISTS `Task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stage_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `task_name` char(100) DEFAULT NULL,
  `task_attempt` int(11) DEFAULT NULL,
  `container_id` int(11) DEFAULT NULL,
  `task_env` text,
  PRIMARY KEY (`id`),
  KEY `stage_id` (`stage_id`),
  KEY `job_id` (`job_id`),
  KEY `app_id` (`app_id`),
  KEY `container_id` (`container_id`),
  CONSTRAINT `Task_ibfk_1` FOREIGN KEY (`stage_id`) REFERENCES `Stage` (`id`),
  CONSTRAINT `Task_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `Job` (`id`),
  CONSTRAINT `Task_ibfk_3` FOREIGN KEY (`app_id`) REFERENCES `Application` (`id`),
  CONSTRAINT `Task_ibfk_4` FOREIGN KEY (`container_id`) REFERENCES `Container` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task`
--

LOCK TABLES `Task` WRITE;
/*!40000 ALTER TABLE `Task` DISABLE KEYS */;
/*!40000 ALTER TABLE `Task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Task_event`
--

DROP TABLE IF EXISTS `Task_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Task_event` (
  `task_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  KEY `task_id` (`task_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Task_event_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`),
  CONSTRAINT `Task_event_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task_event`
--

LOCK TABLES `Task_event` WRITE;
/*!40000 ALTER TABLE `Task_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Task_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Task_metric`
--

DROP TABLE IF EXISTS `Task_metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Task_metric` (
  `task_id` int(11) DEFAULT NULL,
  `metric_id` int(11) DEFAULT NULL,
  KEY `task_id` (`task_id`),
  KEY `metric_id` (`metric_id`),
  CONSTRAINT `Task_metric_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`),
  CONSTRAINT `Task_metric_ibfk_2` FOREIGN KEY (`metric_id`) REFERENCES `Metric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task_metric`
--

LOCK TABLES `Task_metric` WRITE;
/*!40000 ALTER TABLE `Task_metric` DISABLE KEYS */;
/*!40000 ALTER TABLE `Task_metric` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-13 12:35:05
