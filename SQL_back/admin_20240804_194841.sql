-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: admin
-- ------------------------------------------------------
-- Server version	8.0.29

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '22280e92-05be-11ef-ba69-80fa5b5f0ae3:1-15,
ef18a94f-0601-11ef-b34a-00155de60230:1-1927';

--
-- Table structure for table `apply_table`
--

DROP TABLE IF EXISTS `apply_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apply_table` (
  `ID` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '申请ID',
  `apply_id` varchar(255) NOT NULL COMMENT '申请人ID',
  `group_id` bigint DEFAULT NULL COMMENT '请求加入的组别ID',
  `apply_user_id` varchar(255) DEFAULT NULL COMMENT '请求成为好友的用户的ID',
  `time` varchar(255) DEFAULT NULL COMMENT '请求创立的时间',
  `agree_time` varchar(255) DEFAULT NULL COMMENT '请求通过时间',
  `status` varchar(255) DEFAULT NULL COMMENT '通过状态',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apply_table`
--

LOCK TABLES `apply_table` WRITE;
/*!40000 ALTER TABLE `apply_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `apply_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comic`
--

DROP TABLE IF EXISTS `comic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comic` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `work_name` varchar(255) NOT NULL COMMENT '漫画名称',
  `content_file_list` longtext COMMENT '图片路径',
  `belong_to_user` varchar(255) DEFAULT NULL COMMENT '作品作者',
  `belong_to_userid` varchar(255) DEFAULT NULL COMMENT '作品作者ID',
  `belong_to_avatar` varchar(255) DEFAULT NULL COMMENT '作者头像',
  `work_tags` longtext COMMENT '作品tag',
  `age_classification` varchar(255) DEFAULT NULL COMMENT '年龄分级',
  `brief_introduction` varchar(255) DEFAULT NULL COMMENT '作品简介',
  `create_time` varchar(255) DEFAULT NULL COMMENT '作品创建时间',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT '作品封面缩略图',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comic`
--

LOCK TABLES `comic` WRITE;
/*!40000 ALTER TABLE `comic` DISABLE KEYS */;
INSERT INTO `comic` VALUES (0000000001,'作品测测1','96950958_p0.png,117214493_p0_master1200.jpg','user1','ec6866d3-128c-4281-8fef-76beb6b29508','65014220_p0.jpg','tag1,tag2,tag3','16','this is a comic introduction','2024年6月27日18:39:06',NULL),(0000000002,'作品测试2','20240525175111_0c1ff93008904940bc4cdc681bde78b5.jpg,20240525174916_f4f4acc7280f4eabb9fc1712929c3ccc.png','user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','65896618_p0.jpg','tag2,tag3,tag1','18','this is a test2 to comic introduction','2024年6月27日18:40:33',NULL),(0000000003,'作品测试3','96680242_p0.png','user3','91771cc1-2fc2-474c-8748-c11c9f66b9e3','59748972_p1.jpg','tag1，标签2','18','这是一个作品的测试简介，','2024年6月27日18:42:17',NULL),(0000000004,'漫画上传测试','2433195936509560_p1.jpg,2433195936509560_p2.jpg,2433195936509560_p3.png','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'萝莉,白裤袜','16','漫画作品上传测试','2024-07-18T13:38:21',NULL),(0000000005,'漫画上传测试','6707269151560007_p1.jpg,6707269151560007_p2.jpg,6707269151560007_p3.jpg','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'裤袜,白裤袜,拆分','16','这是一个测试内容','2024-07-29T17:02:42',NULL);
/*!40000 ALTER TABLE `comic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `work_id` int NOT NULL COMMENT '评论区所属作品id',
  `work_type` varchar(255) DEFAULT NULL COMMENT '作品类型',
  `is_root_comment` varchar(255) DEFAULT NULL COMMENT '是否为主评论',
  `send_username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发送者昵称',
  `send_userid` char(36) NOT NULL COMMENT '发送者id',
  `content` longtext COMMENT '详细评论内容',
  `date` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发送时间',
  `main_username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '被回复的评论者昵称',
  `main_userid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '被回复的评论者id',
  `main_comment_index` varchar(255) DEFAULT NULL COMMENT '主评论索引',
  `main_comment_id` bigint unsigned DEFAULT NULL COMMENT '主评论id',
  `reply_comment_id` bigint unsigned DEFAULT NULL COMMENT '回复的评论的id',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (46,1,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123','2024-07-28T21:56:01',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(47,1,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','321','2024-07-28T21:56:06',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(48,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123','2024-07-28T21:56:58',NULL,NULL,NULL,47,47),(49,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123','2024-07-28T21:57:45',NULL,NULL,NULL,46,46),(50,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1234','2024-07-28T21:58:31',NULL,NULL,NULL,46,49),(53,1,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123321','2024-07-28T22:02:18',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(55,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','0','2024-07-28T22:05:40',NULL,NULL,NULL,53,53),(56,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123','2024-07-28T22:05:56',NULL,NULL,NULL,47,48),(57,5,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123321','2024-07-29T00:02:25',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(58,4,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1233211234567','2024-07-29T00:09:47',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(59,4,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','测试评论','2024-07-29T00:22:43',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(60,4,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','回复测试评论','2024-07-29T00:22:52',NULL,NULL,NULL,58,58),(61,3,'comic','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','小说评论测试','2024-07-29T16:01:14',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(62,2,'comic','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','评论发送测试','2024-07-29T16:17:49',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(63,10,'novel','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','这是第一条小说评论，这小说写的还不错','2024-08-01T22:58:14',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_like`
--

DROP TABLE IF EXISTS `comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_like` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `comment_id` bigint DEFAULT NULL COMMENT '被点赞的评论ID',
  `userid` varchar(255) DEFAULT NULL COMMENT '点赞的用户',
  `time` varchar(255) DEFAULT NULL COMMENT '点赞的时间',
  `work_type` varchar(255) DEFAULT NULL COMMENT '作品类型',
  `work_id` bigint DEFAULT NULL COMMENT '作品ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_like`
--

LOCK TABLES `comment_like` WRITE;
/*!40000 ALTER TABLE `comment_like` DISABLE KEYS */;
INSERT INTO `comment_like` VALUES (2,53,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-28T23:37:56','ill',1),(3,55,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-28T23:43:44','ill',1),(4,56,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-28T23:43:57','ill',1),(5,58,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-29T00:22:55','ill',4),(6,59,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-29T08:17:02','ill',4),(7,63,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-08-01T23:05:18','novel',10);
/*!40000 ALTER TABLE `comment_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_upload`
--

DROP TABLE IF EXISTS `default_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_upload` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `file_name` varchar(255) NOT NULL COMMENT '文件名称',
  `file_extension` varchar(255) DEFAULT NULL COMMENT '文件后缀',
  `time` datetime DEFAULT NULL COMMENT '上传时间',
  `upload_user` varchar(255) DEFAULT NULL COMMENT '上传用户',
  `upload_user_id` varchar(255) DEFAULT NULL COMMENT '上传用户ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_upload`
--

LOCK TABLES `default_upload` WRITE;
/*!40000 ALTER TABLE `default_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-06-25 06:30:20.220858'),(2,'auth','0001_initial','2024-06-25 06:30:20.696328'),(3,'admin','0001_initial','2024-06-25 06:30:20.807516'),(4,'admin','0002_logentry_remove_auto_add','2024-06-25 06:30:20.814029'),(5,'admin','0003_logentry_add_action_flag_choices','2024-06-25 06:30:20.821550'),(6,'contenttypes','0002_remove_content_type_name','2024-06-25 06:30:20.898682'),(7,'auth','0002_alter_permission_name_max_length','2024-06-25 06:30:20.950027'),(8,'auth','0003_alter_user_email_max_length','2024-06-25 06:30:21.011219'),(9,'auth','0004_alter_user_username_opts','2024-06-25 06:30:21.018732'),(10,'auth','0005_alter_user_last_login_null','2024-06-25 06:30:21.065867'),(11,'auth','0006_require_contenttypes_0002','2024-06-25 06:30:21.070383'),(12,'auth','0007_alter_validators_add_error_messages','2024-06-25 06:30:21.075928'),(13,'auth','0008_alter_user_username_max_length','2024-06-25 06:30:21.131078'),(14,'auth','0009_alter_user_last_name_max_length','2024-06-25 06:30:21.186664'),(15,'auth','0010_alter_group_name_max_length','2024-06-25 06:30:21.236082'),(16,'auth','0011_update_proxy_permissions','2024-06-25 06:30:21.244601'),(17,'auth','0012_alter_user_first_name_max_length','2024-06-25 06:30:21.297196'),(18,'sessions','0001_initial','2024-06-25 06:30:21.329284');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends_table`
--

DROP TABLE IF EXISTS `friends_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friends_table` (
  `id` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `friendid` varchar(255) NOT NULL COMMENT '好友ID',
  `become_friend_time` varchar(255) DEFAULT NULL COMMENT '成为好友的时间',
  `specially_concerned` varchar(255) DEFAULT NULL COMMENT '是否为特别关心',
  `notes` varchar(255) DEFAULT NULL COMMENT '好友备注',
  `username` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `friendname` varchar(255) DEFAULT NULL COMMENT '好友昵称',
  `type` varchar(255) DEFAULT NULL COMMENT 'friend',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends_table`
--

LOCK TABLES `friends_table` WRITE;
/*!40000 ALTER TABLE `friends_table` DISABLE KEYS */;
INSERT INTO `friends_table` VALUES (00000000000000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508','2024年6月29日12:27:33','是','测试用户1','admin','user1','friend'),(00000000000000000002,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','e661401c-bdda-46c0-b98c-eb4e019abf1c','2024年6月29日12:28:46','否',NULL,'admin','user2','friend'),(00000000000000000003,'ec6866d3-128c-4281-8fef-76beb6b29508','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024年6月29日17:22:01','是','管理员','user1','admin','friend'),(00000000000000000004,'ec6866d3-128c-4281-8fef-76beb6b29508','e661401c-bdda-46c0-b98c-eb4e019abf1c','2024年6月29日23:11:42','否',NULL,'user1','user2','friend');
/*!40000 ALTER TABLE `friends_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `id` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` varchar(255) NOT NULL COMMENT '组ID',
  `group_name` varchar(255) DEFAULT NULL COMMENT '组名称',
  `group_avatar` varchar(255) DEFAULT NULL COMMENT '群头像',
  `create_user_id` varchar(255) NOT NULL COMMENT '创建者ID',
  `userid` varchar(255) DEFAULT NULL COMMENT '加入该群的用户ID',
  `admin_id` varchar(255) DEFAULT NULL COMMENT '管理员ID',
  `create_time` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `member_id` longtext COMMENT '成员ID，使用逗号分隔每个人',
  `role` varchar(255) DEFAULT NULL COMMENT '权限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (00000000000000000001,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','admin','94955658_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'2024年7月1日17:02:47',NULL,'master'),(00000000000000000002,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','admin','94955658_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'2024年7月1日17:05:00',NULL,'admin'),(00000000000000000003,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','admin','94955658_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','e661401c-bdda-46c0-b98c-eb4e019abf1c',NULL,'2024年7月1日17:06:33',NULL,'member'),(00000000000000000004,'7c64c35a-6cd4-4c82-9062-33f004d49afa','官方群1','100213135_p1.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'2024年7月1日17:02:47',NULL,'master'),(00000000000000000005,'7c64c35a-6cd4-4c82-9062-33f004d49afa','官方群1','100213135_p1.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'2024年7月1日17:05:00',NULL,'admin'),(00000000000000000006,'7c64c35a-6cd4-4c82-9062-33f004d49afa','官方群1','100213135_p1.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','e661401c-bdda-46c0-b98c-eb4e019abf1c',NULL,'2024年7月1日17:06:33',NULL,'member');
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `illustration_work`
--

DROP TABLE IF EXISTS `illustration_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `illustration_work` (
  `Illustration_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '插画作品ID',
  `name` varchar(255) NOT NULL COMMENT '作品名称',
  `content_file_list` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '作品文件路径列表',
  `belong_to_user` varchar(255) DEFAULT NULL COMMENT '作品属于谁',
  `belong_to_user_avatar` varchar(255) DEFAULT NULL COMMENT '作者头像',
  `belong_to_user_id` varchar(255) DEFAULT NULL COMMENT '归属用户的ID',
  `work_tags` varchar(255) DEFAULT NULL COMMENT '作品的标签',
  `age_classification` varchar(255) DEFAULT NULL COMMENT '年龄分级',
  `brief_introduction` varchar(255) DEFAULT NULL COMMENT '作品简介',
  `create_time` varchar(255) DEFAULT NULL COMMENT '作品上传时间',
  `like_num` int DEFAULT NULL COMMENT '作品点赞数',
  `like_user_list` longtext COMMENT '作品点赞用户列表',
  `collected_num` int DEFAULT NULL COMMENT '作品收藏人数',
  `collected_user_list` longtext COMMENT '作品收藏用户列表',
  `views_num` int DEFAULT NULL COMMENT '作品浏览人数',
  `views_user_list` longtext COMMENT '作品浏览用户列表',
  `identification` varchar(255) DEFAULT NULL COMMENT '作品标识',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT '作品的缩略图',
  PRIMARY KEY (`Illustration_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `illustration_work`
--

LOCK TABLES `illustration_work` WRITE;
/*!40000 ALTER TABLE `illustration_work` DISABLE KEYS */;
INSERT INTO `illustration_work` VALUES (0000000001,'作品名称','65014220_p0.jpg,87328997_p0.jpg','admin','87328997_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','裤袜，白丝，萝莉','16','我的一个原创作品','2024年5月31日10:04:39',1111,'admin,user1,user2,user3',111,'admin,user1,user2,user3',10086,'admin,user1,user2,user3','ill',NULL),(0000000002,'第二个作品测试','96680242_p0.png,96026674_p0.jpg,97197111_p0.jpg','admin','87328997_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','裤袜，黑裤袜，兔女郎，原神','18','我的一个原创作品集','2024年5月31日10:09:02',111,'admin,user1,user2,user3',222,'admin,user1,user2,user3',222,'admin,user1,user2,user3','ill',NULL),(0000000003,'User1的作品','100213135_p0.jpg,100213135_p1.jpg,104705167_p0.jpg','user1','65014220_p0.jpg','ec6866d3-128c-4281-8fef-76beb6b29508','裤袜，白裤袜，黑裤袜，原创，崩坏学院2','16','我的一个远程作品集','2024年5月31日10:11:37',222,'admin,user1,user2,user3',222,'admin,user1,user2,user3',333,'admin,user1,user2,user3','ill',NULL),(0000000004,'user2的作品','118802535_p0_master1200.jpg,103168176_p0.png,100213135_p1.jpg','user2','65896618_p0.jpg','e661401c-bdda-46c0-b98c-eb4e019abf1c','裤袜，白裤袜，黑裤袜，原创','16','我是一个作品集','2024年6月12日10:15:11',NULL,'admin',NULL,NULL,NULL,NULL,'ill',NULL),(0000000005,'test','94296327_p0.jpg','user2','65896618_p0.jpg','e661401c-bdda-46c0-b98c-eb4e019abf1c','裤袜，白裤袜，萝莉，原创','16','test','2024年6月12日10:17:04',NULL,'admin',NULL,NULL,NULL,NULL,'ill',NULL),(0000000007,'测试','0368397051208955_p1.jpg,0368397051208955_p2.jpg,0368397051208955_p3.jpg','admin',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','连裤袜，,白丝,黑裤袜,','18','批量上传测试','2024-07-18T00:16:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `illustration_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invited_draft`
--

DROP TABLE IF EXISTS `invited_draft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invited_draft` (
  `invited_draft_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '约稿稿件ID',
  `launch_user` varchar(255) DEFAULT NULL COMMENT '发起用户',
  `launch_user_id` varchar(255) DEFAULT NULL COMMENT '发起用户ID',
  `receive_user` varchar(255) DEFAULT NULL COMMENT '接受约稿用户',
  `receive_user_id` varchar(255) DEFAULT NULL COMMENT '接受约稿用户ID',
  `launch_user_explain` longtext COMMENT '发起者对作品的说明',
  `work_title` varchar(255) DEFAULT NULL COMMENT '作品的标题',
  `work_brief_introduction` varchar(255) DEFAULT NULL COMMENT '作者对作品的简介',
  `work_type` varchar(255) DEFAULT NULL COMMENT '约稿作品的类型',
  `work_file_list` longtext COMMENT '约稿作品的最终文件列表',
  `launch_time` varchar(255) DEFAULT NULL COMMENT '发起约稿申请时间',
  `receive_time` varchar(255) DEFAULT NULL COMMENT '作者接收约稿时间',
  `working_condition` varchar(255) DEFAULT NULL COMMENT '作品完成状态',
  `launch_user_open` varchar(255) DEFAULT NULL COMMENT '约稿发起者是否允许公开',
  `price` decimal(10,4) DEFAULT NULL COMMENT '作者接受约稿的价格',
  PRIMARY KEY (`invited_draft_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invited_draft`
--

LOCK TABLES `invited_draft` WRITE;
/*!40000 ALTER TABLE `invited_draft` DISABLE KEYS */;
INSERT INTO `invited_draft` VALUES (0000000001,'user1','ec6866d3-128c-4281-8fef-76beb6b29508','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','这是一个用于测试的作品','这是约稿作品的标题','我是作者，对于这个作品有以下的简介和说明','插画','65014220_p0.jpg,94296327_p0.jpg,94552901_p0 (1).jpg','2024年5月31日22:30:03','2024年5月31日22:30:08','已完成','公开',10000.0000),(0000000002,'user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','这是第二个测试','这是第二个约稿作品测试','我是作者，对于这个作品有以下的简介和说明','插画','94955658_p0.jpg,93997782_p0.jpg','2024年6月1日00:01:37','2024年6月1日00:01:41','已完成','公开',1000.0000);
/*!40000 ALTER TABLE `invited_draft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `ID` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '消息ID ',
  `sender_id` varchar(255) NOT NULL COMMENT '发送者ID',
  `receiver_id` varchar(255) DEFAULT NULL COMMENT '接收者ID',
  `group_id` varchar(255) DEFAULT NULL COMMENT '组别ID',
  `content` longtext COMMENT '消息内容',
  `time` varchar(255) DEFAULT NULL COMMENT '消息创建的时间',
  `receiver_read_status` varchar(255) DEFAULT NULL COMMENT '私发消息接收者是否已读',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL COMMENT 'friend',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (00000000000000000017,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'1','2024-06-29 22:33:14','已读','one_to_one'),(00000000000000000018,'ec6866d3-128c-4281-8fef-76beb6b29508','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'234','2024-06-29 22:34:01','已读','one_to_one'),(00000000000000000019,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'345','2024-06-29 22:34:40','已读','one_to_one'),(00000000000000000020,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'啊啊啊啊','2024-06-29 22:35:57','已读','one_to_one'),(00000000000000000021,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'的点点滴滴','2024-06-29 22:38:53','已读','one_to_one'),(00000000000000000022,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'懂的都懂','2024-06-29 22:39:27','已读','one_to_one'),(00000000000000000023,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'啊啊','2024-06-29 22:41:08','已读','one_to_one'),(00000000000000000024,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'123321','2024-06-29 22:41:49','已读','one_to_one'),(00000000000000000025,'ec6866d3-128c-4281-8fef-76beb6b29508','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'321','2024-06-29 22:42:40','已读','one_to_one'),(00000000000000000026,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'123321','2024-06-29 22:48:52','已读','one_to_one'),(00000000000000000027,'ec6866d3-128c-4281-8fef-76beb6b29508','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'456789','2024-06-29 22:49:03','已读','one_to_one'),(00000000000000000028,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'滚动测试\n','2024-06-29 22:56:25','已读','one_to_one'),(00000000000000000029,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'2233','2024-06-29 23:07:51','已读','one_to_one'),(00000000000000000030,'ec6866d3-128c-4281-8fef-76beb6b29508','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'3322','2024-06-29 23:08:05','已读','one_to_one'),(00000000000000000031,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'123321','2024-06-29 23:24:17','已读','one_to_one'),(00000000000000000032,'ec6866d3-128c-4281-8fef-76beb6b29508','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'aaa','2024-06-29 23:49:30','已读','one_to_one'),(00000000000000000033,'ec6866d3-128c-4281-8fef-76beb6b29508','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'hello world','2024-06-30 11:43:49','已读','one_to_one'),(00000000000000000034,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','啊啊啊','2024-07-02 01:27:43','未读','many_to_many'),(00000000000000000035,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'7c64c35a-6cd4-4c82-9062-33f004d49afa','啊啊啊啊','2024-07-02 01:28:06','未读','many_to_many'),(00000000000000000036,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'啊啊啊','2024-07-02 01:29:53','已读','one_to_one'),(00000000000000000037,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','e661401c-bdda-46c0-b98c-eb4e019abf1c',NULL,'不不不','2024-07-02 01:29:57','已读','one_to_one'),(00000000000000000038,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','啛啛喳喳','2024-07-02 01:30:02','未读','many_to_many'),(00000000000000000039,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'7c64c35a-6cd4-4c82-9062-33f004d49afa','啊啊啊啊','2024-07-02 01:30:05','未读','many_to_many'),(00000000000000000040,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'7c64c35a-6cd4-4c82-9062-33f004d49afa','啊啊啊啊','2024-07-02 01:30:20','未读','many_to_many'),(00000000000000000041,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','啛啛喳喳','2024-07-02 01:30:23','未读','many_to_many'),(00000000000000000042,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','aaaaa','2024-07-02 11:50:54','未读','many_to_many'),(00000000000000000043,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','aaaa','2024-07-02 11:52:50','未读','many_to_many'),(00000000000000000044,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','aaaa','2024-07-02 11:52:58','未读','many_to_many'),(00000000000000000045,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','插插槽','2024-07-02 11:54:03','未读','many_to_many'),(00000000000000000046,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','ceshi','2024-07-02 11:56:11','未读','many_to_many'),(00000000000000000047,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','aaaa','2024-07-02 11:56:55','未读','many_to_many'),(00000000000000000048,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','测试','2024-07-02 12:01:12','未读','many_to_many'),(00000000000000000049,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'9de31bbd-4f33-4bb6-af40-16abfe1154c6','ces','2024-07-02 12:02:41','未读','many_to_many'),(00000000000000000050,'ec6866d3-128c-4281-8fef-76beb6b29508',NULL,'7c64c35a-6cd4-4c82-9062-33f004d49afa','aaaa','2024-07-02 12:03:42','未读','many_to_many'),(00000000000000000051,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'7c64c35a-6cd4-4c82-9062-33f004d49afa','贝贝贝贝','2024-07-02 12:03:45','未读','many_to_many');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID，自增主键',
  `title` varchar(255) NOT NULL COMMENT '公告标题',
  `content` text NOT NULL COMMENT '公告内容',
  `author_id` varchar(255) NOT NULL COMMENT '作者ID',
  `author_name` varchar(100) NOT NULL COMMENT '作者名称',
  `create_time` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `publish_time` varchar(255) DEFAULT NULL COMMENT '发布时间',
  `expire_time` varchar(255) DEFAULT NULL COMMENT '过期时间',
  `status` enum('draft','published','expired') NOT NULL DEFAULT 'draft' COMMENT '公告状态：草稿、已发布、已过期',
  `priority` int DEFAULT '0' COMMENT '优先级，数值越大优先级越高',
  `category` varchar(100) DEFAULT NULL COMMENT '公告类别',
  `attachment_url` varchar(255) DEFAULT NULL COMMENT '附件URL',
  `is_important` tinyint(1) DEFAULT '0' COMMENT '是否为重要公告',
  `last_modified_time` varchar(255) DEFAULT NULL COMMENT '最后修改时间',
  `views` int DEFAULT '0' COMMENT '浏览次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='公告表，用于存储公告信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,'test','公告测试内容一','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','admin','2024-07-15 16:20:18','2024-07-15T16:38','2024-07-15T16:39','draft',0,'默认',NULL,0,'2024-07-15 16:20:18',0),(2,'1','1','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','admin','2024-07-15 16:20:18','2024-07-15T16:39','2024-07-15T16:39','published',0,'默认','a',1,'2024-07-15 16:20:18',0);
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `novel_content`
--

DROP TABLE IF EXISTS `novel_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `novel_content` (
  `id` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '章节ID',
  `belong_to_series_id` int NOT NULL COMMENT '系列ID',
  `belong_to_userid` varchar(255) NOT NULL COMMENT '所属用户ID',
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '章节标题',
  `content` longtext COMMENT '章节内容带格式',
  `create_time` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `is_series` varchar(255) DEFAULT NULL COMMENT '是否为系列作品',
  `is_vip_chapter` varchar(255) DEFAULT NULL COMMENT '是否为VIP章节',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novel_content`
--

LOCK TABLES `novel_content` WRITE;
/*!40000 ALTER TABLE `novel_content` DISABLE KEYS */;
INSERT INTO `novel_content` VALUES (00000000000000000005,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第一章：存于梦中之地','无边的宇宙之中，无时无刻都存在着危机，它们潜藏在深处，就像潜伏在水中的鳄鱼一样，寻找着机会吞噬掉猎物。\\n宇宙每时每刻都在按照着它本来的规则在运转，就像一个没有灵魂的机器一样。可是就在这时，本该什么都没有的虚空之中突兀地出现了一个光点，然后随着时间的流逝，光点也在成指数的增大，它慢慢地变成了一个五光十色圆盘，如果在侧面看它的话却观察不到它的存在，当它扩大到十数光年的大小的时候周围的空间出现了裂纹，那些裂纹在不断地出现，越来越多，越来越多。突然，还在飞快扩大的那个光点开始了快速地抖动。似乎是因为承受了很大的压力快要崩溃了，接着那个圆盘上蔓延上了许多的黑色线条，就在裂缝快要全部蔓延的时候，圆盘开始没说。我也，用1E－43秒的时间重新变成了一个光点，但是这个光点现在仔细看的话就会发现它是半透明的，似乎是介于虚无与现实之中。\\n这个圆盘变成光点后又消失不见了。\\n此时太阳系内，一颗名为地星的星球的空间附近出现了似水波的波纹，一个半透明的物体就这样出现在那儿，那个光点不知道做了什么亮度变低了很多，体积也变大了很多，也不再像要消失那样。\\n它就这样停在那儿，似乎是在观察着这个碧蓝的星球。一会儿后又从视觉中消失了……\\n这是一个还没有走出真正走出地星的文明。\\n此时我们的主角正在走在回家的路上，他是一个很普通的高中生，个子不高大约165左右，不能说是帅，反倒是让人觉得三人“……【想知道的话可以参照一下五河士织，（笑）】，爷爷因为癌症去世了，奶奶也跟着走了，在初二的时候双亲也死于工地，工地赔了243万，生活在城市边缘的农村，17岁的孙源玲和13岁妹妹相依为命。用的\\n“选定之人，请不要忘记你的使命”\\n一个十分突兀的声音出现在孙源玲的脑海里面。\\n“嗯？什么声音哦，选定之人是什么？”路上的孙源玲在四周看了看发现并没有人。“所以选定之人是什么东西？难道我又幻听了，但是为什么我似乎在梦里见过这个场景呢？奇怪，算了还是回家要紧，好像还有剩饭吧，那今晚吃什么菜呢，白菜似乎不错……”\\n此时孙源玲的卧室里面一个豆子大小的半透明的东西出0半空中……\\n孙源玲家是双亲在自己的地里面修建起来的，那时的他并不知道那么多，就只是知道爸爸妈妈在那段时间好像十分的辛苦。\\n“瑶瑶，今晚想要吃什么”\\n“emmm，不知道诶，哥哥你看着弄吧，我都可以的”\\n“好吧，哪就今晚就吃白菜炒肉丝吧，随便弄一个汤，去把饭热一下，哦！对了，作业做完没有啊”\\n“做完了”\\n“那就去把饭给热好吧”\\n“哦”\\n孙源玲：“等会儿记得把碗给洗了哦，我作业还没有做完”\\n“……，知道了”\\n兄妹俩吃完饭，收拾完后就去休息了。孙源玲的卧室：\\n“今天的那句话是怎么回事，怎么回事应该不是我幻听了吧，幻听还不至于这么离谱”就在此时。一个机械音响起\\n“选定之人……”\\n“嗯？谁在说话？”\\n“是我”一个半透明的物体出现在了孙源玲的眼前。\\n“你是谁，还有你是什么东西，为什么你能说话，难道说现在的可以都已经这么发达了吗”说着他用手朝着那个半透明的物体伸手过去，想要拿在手上看看。结果手却没有碰到那个东西。\\n“所以你是个什么东西为什么我碰不到你”孙源玲道。\\n“……你难道就不感到奇怪害怕得漂亮啊？比如说我怎么来的”那个物体道\\n“为什么我要感到奇怪，要是你想要怎么弄我，我也阻止不了你”\\n“好吧，我先自我介绍一下，我是平行宇宙最后的种子，我携带着我们宇宙所有的知识，虽然规则和你们这个宇宙不同，但是我已经全部更正替换过了，而你是我选中的人，而我就是来传递这些知识的”那个未知的物体道。\\n“可是我真的可以接受这么多的知识吗？我觉得我不行”\\n“放心我会改造你的大脑的，到时候你就可以完全的承受这些知识了，你不用担心，当你明天早上起来的时候就全部完成了”\\n“哦，那我睡觉了哦，我更你港（笑），我可是很怕痛的”\\n“……”\\n在孙源玲睡下之后，那个物体飞到了脑门心上空，一下钻进了他的脑子里面\\n第二天，孙源玲和平常一样，6点就醒了，可是当他睁开眼睛的时候发现四周的环境似乎都变得不同了。\\n“这就是你所说的知识吗，倒是很让人惊讶呢，可是为什么你不能留下来呢，真是奇怪，不过嘛。”说着看向了枕头边上的两枚戒指。\\n“还真是厉害呢，竟然是储物戒指还给了我这么多的好东西，果然厉害，不过，原来真的可以修炼呢，还直接让我拥有了在太空中生存的能力，按照你的标准这就是筑基啊，就是不知道我还有没有其他的能力，只是这些纯科技造物应该可以为我提供很多的方便诶”','2024-07-29T16:39:27','单篇完结作品','1'),(00000000000000000006,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第二章日常，筑基','然后他就起床了，今天也是咸鱼的一天，但是似乎要变得不一样了，为什么它不可以在这个宇宙中长时间的存在呢？它的宇宙有事怎么毁灭的呢？我所处的宇宙会不会步它那个宇宙的后尘呢？\\n“唉，想那么多干嘛，做饭，等会儿妹妹还要上课呢，今天是周五，明天就有时间来试试我可以做到哪些事情”说着他就走向了厨房。\\n“瑶瑶起床了”孙源玲大声道。\\n“知道了”\\n孙源玲的妹妹现在虽然有了13岁了，但是身高依然只有1.4M左右，但是十分的可爱（具体就参考“白”的身形）因为银白色的头发，酒红色的眼睛，也受到了很多人异样的眼光，很容易让人怀疑是不是染发了，曾经因为头发的颜色的问题，小学的时候还特意得去医院开具正证明，证明了不是染得头发才得以继续上学。但是，兔砸的年轻人都是人均白毛控（笑）所以并未遭到嘲笑，但是却经常遭到排挤，毕竟不是所有人都是圣人，多少都是有些嫉妒的心理的。\\n“今天早上想要吃些什么，开水鸡蛋要不要，还是吃面啊”\\n“啊——吃面吧，为什么每天早上都这么得寒碜啊，稍微吃好点不行吗？真是的”\\n“瑶瑶，你要知道爸爸妈妈是为了我们……”说着孙源玲的手不受控制地颤抖了起来，他现在仔细的想象双亲的离去都有些离奇，所以他想要查查这件事。总是觉得这件事没有那么的简单。\\n“瑶瑶，咱账户里面的前还算是宽裕，但是还是节俭，我们现在都还在小还没有找工作条件”孙源玲如是地说到。\\n“但是我是永远都是不会去找工作的，我要自己当老板”孙源玲在脑海中想到。\\n“吃面是吧，自己拌调料哦，顺便也给我也弄一份”\\n洗锅、下油，来勺猪油烧热，来两个鸡蛋打散，撒点花椒（四川是这么叫得）在油里面，放蛋进油锅，炒至金黄，划成几块，放水。然后剩余的步骤就和正常下面一样了。\\n“瑶瑶，调料拌好了吗，我面都下好了哦。再不快点面就糊了”\\n“好了好了”\\n“哦，拿过来吧，诺：给你，你的面，客官请慢用，哈哈哈”\\n“唉，真是的，都多大的人了。”\\n“快点吃，吃了好去上学了，都快6点30了”\\n……\\n和往常一样，和妹妹一起来到了兴源中学这所学校。\\n“你自己在外面待会儿，我去教室了”\\n“哦，我也快了”说着就朝着各自的教室走去了。\\n孙源玲看着自己的课本出神了。\\n“哎，突然感觉这些东西都好简单哦，可不可以选择呢？等到高考的时候再去考试呢？”\\n“说起来我今天走起路感觉好轻松哦，以往走路脚多少都会有点痛，难道是因为我筑基了的原因？嗯，肯定是了”\\n教室里的书，堆积得像一座座小山，可见高三的学习压力有多重。\\n没一会儿，学校的铃声就响了起来，开始了第一次早读。\\n书声朗朗的学校里，但是孙源玲却不知道怎么的就是不想看这些书了。但是他还是跟着大家，声音读了起来。\\n没过多久，第二次上课铃声响了起来，这道铃声代表着全校的学生开始正式上课。\\n现在的孙源玲的状态很奇怪，他总有种冲动想要上讲台上去替代老师讲课。\\n或许他现在的个人能力可以说是全球第一的，但是他还是克制了下来。\\n“好无聊啊，没想到这些知识这么简单，那个东西还真就把它那个宇宙所有的一股脑地给我了呗。说起来我的戒指里面不是有很多高科技的好东西吗？”\\n说着看向了带在无名指上的戒指，很小巧。或许是因为戒指需要修为才可以使用所以才给我修为的吧，而且戒指里面的每样东西都有详细的说明，还真是贴心了。孙源玲如是地想到。\\n“诶，这个AR眼镜厉害了”说着就把手放在桌子的抽屉里面，把眼镜从戒指里面拿了出来。\\n“用意念来控制，挺方便地嘛”说着就戴上了眼镜。\\n眼镜并不显眼，半透明的，有些淡淡的蓝色，采用的是反物质能源，所以不用担心能源的问题。而计算采用的是微型量子计算机，可以说是十分的方便了。\\n“这上面都没有游戏的嘛？这也太真实了，不给我游戏抄。算了我还是去下一个三崩子玩吧。说动就动。”\\n3秒钟过后\\n“这么快就下好了，不应该吧600MB服务器也没有分配给个人那么高的带宽吧”\\n“难道是因为采用了类似于P2P的下载协议？还行”\\n登录之后，下载资源，进入游戏。\\n“嗯？这个推荐配置怎么这么低？奇怪。还是我手动调整吧”\\n“真是丝滑吧的享受”\\n……\\n美好的白天就过去了。\\n“瑶瑶，我明天跟你说件事”\\n“什么事不能现在说嘛？”\\n“嗯，不能现在说。就让你期待一下吧”\\n“……好吧，就勉强期待一下吧，我去睡觉了。明天见”\\n……\\n第二天\\n吃过早饭后\\n“瑶瑶看好了，等会儿不要惊讶哦”\\n运气，慢慢的孙源玲的身体慢慢地附上了去。\\n“虽然知道怎么做，但毕竟是第一次”\\n孙瑶用手紧紧地按住自己的嘴，不让自己发出声音来。\\n“哥哥，你是怎么回事，怎么做到的啊，好厉害啊”\\n“瑶瑶，你想不要变得像我一样厉害啊？”\\n“嗯，想想，当然想了，谁不想在天上自由的飞翔啊”\\n孙瑶的头如小鸡啄米似的同意着\\n孙源玲从储物戒指中拿出了一颗药丸\\n“来，把这个药给吃了”\\n“这是什么？”\\n“emmm，筑基丹”\\n“surprise！！！我没听错吧，筑基丹？在拍电视剧吗？”\\n孙瑶十分疑惑地看着哥哥\\n“真的我还会骗你吗？我骗你又没有好处”\\n“哦”\\n当吃下筑基丹后，孙瑶的额头上出现了丝丝的汗水。\\n“要不——你去浴室里面去，我害怕等会儿你会嫌弃自己”\\n“哦”\\n浴室里面，瑶已经变得大汗淋漓了，身上还有黑色的物质析出，但是似乎并没有粘在身上，慢慢的地上黑色物质越来越多了，花洒的水洒在白嫩的肌肤上，本来因为筑基丹变得光滑的皮肤变得更加的白净了，完全不似一个农村里面出来的孩子。\\n“这些黑色东西是什么，难道是我体内的垃圾吗？”\\n“为什么我得四周好像有什么东西的存在”\\n随着黑色物质流出，孙瑶的修为也顺利地成为了筑基的修为，本来一切都是好好地，随着境界增长的结束，洗澡洗过之后也就完事了。\\n就在孙瑶准备穿衣服的时候，意外发生了。\\n“啊!”\\n“怎么了，发生什么事情了”\\n孙瑶：“内…胖次被我撕烂了，内衣也坏了。”\\n孙源玲：……\\n“你先别急，静下心来，体会一下你现在掌握的力量，免得等会儿把门也弄坏了”\\n“……哦，哥哥你……你…你帮我拿一下我的内衣，胖次吧，在我卧室柜子抽屉的第二格，不许做奇怪的事情哦”\\n孙源玲：“……放心吧，不会的”就算是我干了奇怪的事情你也不知道啊\\n将衣服放到浴室的门口后，孙源玲说到：\\n“记住，要平心静气，气息内敛，气沉丹田，我给你念一段口诀你试试，毕竟你现在也已经筑基了”\\n然后巴拉巴拉的念了两遍口诀。\\n“我把衣服给你放在门外面了。我在外面的院子里面等你，快点奥”\\n“哦”哥哥没有拿我的衣服做奇怪的事情吧，应该没有吧，诶，我想那么多干什么真是的。\\n快速地穿好衣服后，就来到了院子里面\\n“为什么我感觉现在一身都十分的轻快的了，好像有使不完的劲儿似的”\\n“当然了，你现在可是和我一样都是筑基的修为了”\\n“呐呐呐，哥哥，这个世界是不是有很多像你一样很厉害的人呢？”\\n“不知道，应该有吧，我也是在机缘巧合下得到这枚筑基丹。在四周是不是感受到了灵气，试一下可不可以飞起来吧，这样我们上学就可以很方便了，而且也会更加安全了，就是不能被别人给看见了。知道了吗”\\n说罢，孙瑶就开始尝试了起来，只见周围出现了类似于热浪般的灵气浪潮，让人觉得十分的压抑。可是身形却是丝毫未动，白皙的额头上也出现了丝丝汗迹。\\n“哥，不行啊。我可以感受到灵气，但是我不知道怎么调用我体内的力量啊”\\n“啊，对啊！我还没有教给你修炼之法，功法也没有教你。等等，我给你写出来。”\\n“不能使用醍醐灌顶那种方式吗，感觉自己去参悟会很久的样子。”\\n“我也想，可是我的修为不够啊，至少要金丹才能进行醍醐灌顶之术”\\n孙源玲说着便回到房间拿起纸笔书写了起来，明明是十分晦涩难懂的修炼之法以及衍生的功法，经过他的手后都变得简单易懂了，是个普通人也可以读懂并且开始自己的修炼之路，并不知道这部修炼之法的极限在那儿，只知道似乎是直通本源的一部功法。\\n就在快要将修炼功法写完的时候，孙源玲突然发现，只有修炼的功法就够了吗？炼丹、炼器、阵法、尝试认知这些还是需要的吧，虽然觉得科技才是正道，但是个人能力很强难道不是一件十分快乐的事情吗，而且身体各方面都会变得更加完美。寿命也会大大的延长，以至于到了大乘之后可以都可以永生了，而科技虽然 可以批量的制造高手，但是始终材料有限啊。\\n孙源玲在心中想到“也不知道者灵气是不是也有上限，找个时间把制造灵气的机器给制造出来吧。这天地的灵气还是太稀薄了”\\n“瑶瑶，我好了，过来一下”\\n“哦，来了”\\n“写好了吗”\\n“嗯。写好了。那么这位美丽的小姐，这儿有一本名字未知的功法，我把它叫做‘析源’、‘炼器之法’、‘炼丹之法’、‘布阵之道’，以及如何识别天材地宝。怎么样心动吗，心动就赶快行动吧，一本只要9.9，你买不了吃亏买不了上当”\\n“……啧，一股奸商的味道迎面而来。哼——小孩子才会选，我都要”孙瑶的小手一握，嘟着嘴，并不高的身子却装作成熟的感觉让人感觉十分的可爱，\\n“好啦，这些都是基础但是却可以直达本源，再好的功法也是需要基础的支撑的，所以就不要想着那些看起来十分厉害的功法，只要基础好，功法都可以玩出花来。知道了吗？”\\n“哦，知道了，这就和数学的知识利用差不多吧，只要理解了最基础的知识，在做题的时候只要题不超纲，总是有办法做出来的，是这样对吧，哥？”\\n“嗯，就是这样的，所以基础才是最重要的东西啊。”\\n基础就是最重要的基石，没有了基础作为支撑，修为再高最终也不能持久，想要走到更高的地位那时绝对不可能的，天财地宝也救不了的那种，因为强行拔高境界，但是因为不知道怎么保持，最终仍然会跌落回他所能够掌握的境界。科技依然如此，要是没有坚实的基础，哪怕给予再高的科技产品也没有用，而且科技是一步一步地走上来的，不健全的基础，科技也走不远，甚至于最后不能寸进。如同基础科技被智子锁死的人类，发展到了人类基础科技所能达到的最高峰，但是因为基础科技无法突破，最高科技也就无法突破。三体的一个探测器就灭掉了人类的舰队。','2024-07-29T16:39:27','单篇完结作品','1'),(00000000000000000007,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第三章 高考，上大学','一转眼就到了，高考的时候了，孙瑶也是基本掌握了，孙源玲给他的知识了。这半年时间过得十分的平静，没有各种让人觉得很厉害的感觉，没有什么逆袭的桥段，每天都过的普普通通，除了每天放学上学的时候不是正常人的方式进行而已。\\n孙源玲不顾老师的劝解，报考了魔都大学。\\n“你真的有把握考试考上魔都大学吗，如果没有考上的话你可是面临没有书读的情况，以后你的生活也会变得更加的困难的”\\n“我知道的，老师，不用再劝我了，我知道您是对我好。”\\n孙源玲在内心中想到：我不报魔都大学我报那儿啊，这可是国内最好的大学了。我可没有去国外的打算。我所掌握的知识可比这些知识难多了。到了大学里面才是我发挥我的能力的舞台。我可是要带领人类走向太空的人。\\n……\\n“唉 ，真的呈现在还没有到最后的时候，你的志愿还可以更改，现在还可以改，这是对你的未来负责啊”\\n“……真的没事的，你就不用担心了，我也是不小了。”开玩笑，在野鸡大学表现的太牛逼被抓起来切片怎么办？\\n老师：“……唉，自己保重吧。你……”\\n……\\n一转眼就来的6月份了，孙瑶也要开始中考了。\\n6月28日，早晨\\n进考场后\\n……\\n“感觉这些题也没有那么难嘛，想想以前我看到这些题，能够做的起一半都是算我超常发挥了。”获得了另一个宇宙的所有知识，虽然起点不一样，但是人家眼光不知道高到那儿去呢。触类旁通这些题都不难。\\n……\\n三天时间过去了，孙瑶也是可以自己做饭的。孙源玲也就没有怎么去操心了。\\n……\\n没过多久，魔都大学的录取通知书不出所料的落到了孙源玲的手里。\\n“哥，你好厉害啊，魔都大学的通知书诶。说，你怎么做到的？”\\n“你也是修仙的了，该不会不知道修仙可以让自己变得更加的聪明吗，记忆力什么的也会大幅度的提升的。”\\n修仙之后一目十行这，并且看一遍就能记住这都是小事，到了元婴之后，使用自己的神识扫一遍就知道书里面所有的内容了。\\n“哥哥，你是不是要去魔都了……一个人呢——”\\n孙瑶说话的声音越来越小……\\n“啊，没事的哥哥，我也是筑基的高手了，可以保护自己了”\\n“嗯……你……你也想去吗？我可以想办法让你去那面读书的”\\n“真的吗？啊，没事的哥哥，还有几年我可以自己努力考上魔都大学的。不用麻烦你了”\\n但是孙瑶皎洁的目光若隐若现的泪水却说明她此时的内心十分的纠结，不想麻烦哥哥，但是又十分的想和哥哥待在一起。如此纠结的她甚至于连说话都变得支支吾吾的了。\\n孙源玲一把抱住了孙瑶，毕竟还是一个小孩子。\\n到了哥哥温暖的怀里，孙瑶孙瑶的情绪也稳定了些\\n“瑶瑶，没事的，哥哥不麻烦，为了你再麻烦我也会去干的。放心吧瑶瑶要不了多久我就可以让你去魔都去读书了。”\\n“嗯，瑶瑶相信哥哥，哥哥加油哦。我想和哥哥永远在一起呢”\\n果然还是小孩在啊~\\n“嗯，瑶瑶你在说什么？”\\n“啊啊——哈哈，没说什么啊，加油啊哥哥”\\n……\\n没过多久，孙源玲就踏上了前往大学的旅途，暂时也不会因为钱的问题而烦恼。\\n只是孙瑶在看着哥哥远去的身影久久的站在原地，眼中透露出的思念之情怎么也挡不住，只是心中不知何时什么了其他另类的情绪，她自己也不知道是什么。\\n……\\n地铁的速度还是很快的，虽然孙源玲他也很想使用空间装备直接就到学校，但是为了不引起不必要的麻烦，比如恰巧有人在调查他的行进路线或者时间，这样的话在机缘巧合下就会暴露他的秘密。而且坐车欣赏沿途的风景也是一件挺不错的事情，以前在上学的时候也没有出去过，外面的风景人文也没有见识过。\\n沿途的话有机会可以去体验，我相信没有怎么去过外地的人是很乐意沿途体验一下当地的小吃的，顺带欣赏一下风景。只不过会很快就没有看风景的兴致而已。所以还是吃的东西最吸引人，兔砸民族千年传承，吃的东西自然是少不了的。各种吃的可以说是吃个一百年可能都吃不完。而且基本上是很好吃的东西，甚至很多东西都是百吃不厌的东西。\\n……\\n一天的时间都没有就到了魔都大学了，不得不说兔砸的基础设施建设和这个世界上的绝大多数国家相比都要完善很多了，基建狂魔的称号可不是凭空出现的，事实上，兔砸的基建速度可以说是举世无敌了，其聪慧的头脑，吃苦耐劳的精神，高超的科技这些可是有很重要的加持的。\\n“魔都大学吗？还真是大啊，比我那个乡都还要大。这就是我以后我为文明创下各种奇迹的见证之地了。虽然只是待一会儿。混个正常的身份而已。从今天开始就不能咸鱼了。要尽快把整个文明的科技水平提高啊。”','2024-07-29T16:39:27','单篇完结作品','1'),(00000000000000000008,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第四章 我真的只是一个菜鸡而已啦','到了校园的第一件事当然是……去报到啊，难道是去看看有多少同系的女同学吗？\\n“孙源玲，你的寝室在621，等会儿去收拾一下吧，等会儿会有学长带你去找你的寝室的。”孙源玲的导师‘刘梦媛’道\\n刘梦媛的年龄只有三十多岁，但是却显得十分的年轻，就像一个20多岁的小姑娘，也就和孙源玲一般的身高，这还是因为她穿了高跟鞋的原因。白净的皮肤，有些微圆的脸蛋，十分的漂亮。也是不缺乏追求她的人。同时也是一个天才。\\n“好的，老师。”\\n……\\n随着孙源玲来到了他的宿舍，他也见到了他的三个室友。\\n“嘿，又有新人来了，快来欢迎新人”黄磊说到\\n“欢迎，欢迎”孙源玲的其余室友说到\\n“我们现在来自我介绍一下吧”黄磊说到\\n“没问题”其余两人一起道；“好的”\\n“我先来吧，我叫黄磊，叫我黄三石、磊哥都可以，既然我们是一个寝室的那么肯定都是人工智能这个系的了”\\n“我叫程陵，爱好制片人，请多关照”\\n“我是王岩，我觉得人工智能一定可以成功地被人类所创造出来的”\\n“我是孙源玲，玲珑的玲，不要觉得我的名字奇怪，这是没办法的事。现在我对于人工智能有一些和目前阶段不同的想法，我觉得我们可以合作。我相信人工智能会诞生在我们的手上，并且是可以被人类所完全掌握的，让每个人都能够享受到人工智能所带来的方便和好处。请多关照”\\n自我介绍完毕之后就加入到收拾寝室的队伍之中了，那些学长所留下来的烂摊子。\\n“嘿，玲珑；没想到你个子不大，力气还蛮大的嘛。”\\n“も可愛こと”\\n“我觉得你们对我有不好的想法，还有我叫孙源玲，叫我玲子我都能接受。可是这个玲珑是什么鬼啊？コラ”\\n“哦，那我们以后就叫你玲子咯。还真是可爱的人呢，我相信你女装的话一定很可爱的”\\n“附议”其余两人道\\n孙源玲：“……”\\n收拾完寝室之后就是休息时间了，接下来会有长达一个月的军训。对于新生来说又是一个折磨人的时间，但是对于孙源玲来说也就那样。毕竟都是一个筑基期的修士了，肉身没有经过淬炼并不强大，但是经过灵气的洗礼也是比普通人强大很多了，不然也无法承受灵力所带来的的力量。\\n虽然筑基的修士可以在宇宙中存活，也可以不吃东西只靠天地灵气存活。\\n但是真要说移山填海还是十分的困难，但是摧毁一座山头确实要不了多少时间的。不要小看修士的个人力量。\\n……\\n学校操场上\\n“同学们，欢迎来到魔都大学。在这里……”然后就是长篇大论，总结来就是一句话：大学不是给你们玩耍的地方，而是学习只是的地方，要努力学习，为国家做出贡献。\\n下面就是长达一个月的军训。\\n开始的几天也就是练习最基本的姿势而已，而后就开始教授学生各种体术及技能，锻炼身体。\\n校内3000m长跑体能锻炼ing\\n“诶，我说玲子。你就不累吗，这些天这么折磨法，我的脚都起泡了。浑身酸痛，这又是3000m”\\n“我感觉很轻松啊，难道要我等等你们啊”\\n“别别别”黄磊三人道\\n“那你们快点奥”\\n孙源玲哪突出常人的身体素质很快就引起了他们教官的注意，什么人跑了3000m不累的，就算不累，连汗都没有出这算是什么事？怪物啊？\\n在军训结束之后，负责他的教官找上了孙源玲\\n“这位同学，你就是孙源玲吧？”\\n“对，是我”\\n“我看你在这段时间表现的十分的出色啊，要知道我们军里面的军王都没有你那么的厉害，虽然3000m下来并不怎么累，但是或多或少都会出汗。有没有兴趣来到我们队里面来试试？”\\n“谢谢教官的好意了，我觉得还是比较适合呆在学校里面。而且我很菜，真的，我可能也就是体能比较出色而已，要是打架的话可能会被按在地上锤”\\n“啊哈哈哈，那好吧。有这方面的意愿的话可以联系我。我很看好你哦，这是我的名片”说着就从兜里面掏出了一个卡片交给了孙源玲。\\n话说为什么教官有名片呢？\\n孙源玲并没有说错，在同样的条件下，他真的打不赢。虽然他拥有多到不能想象的知识，但是他并没有怎么其练习。自然比不上身经百战的军人。\\n时间飞快的流逝，一个月的军训很快就过去了。同学们也和教官们建立起了相当的友谊，到了分别的时候就表现的十分的不舍。\\n总之，开学的第一步也是告了一个段落了。接下来就是开始正式开始上大学了。\\n','2024-07-29T16:39:27','单篇完结作品','1'),(00000000000000000009,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第五章 人工智能的雏形','孙源玲因为开发过大脑，已经可以说，在这个地星上面是没有人在智力上面可以比得上孙源玲的了。而魔都大学更是一个人才聚集的地方，不说在这地方一板砖下去能砸到多少个多少个天才什么的，但是只要在这所学校里面的基本都是天才。所以在魔都大学里面，天才也会成为普通人，而这儿的天才都是在普通人眼里不敢想象的。\\n“啊，玲子，该去上课了”黄磊说道\\n“嗯，知道了，等会儿。我把这个模块给搞定了就来了”\\n“诶，你最近在搞什么呢？我看你都搞了那么久了”\\n“哦，你过来看一下不就知道了吗？你也是干这行的”\\n黄磊听后就走了过去，但是当黄磊看过之后脸上露出了惊讶的表情。都是人工智能这个系的哪能不知道孙源玲在干什么。\\n“我的天，你是在编写人工智能啊。我就只能看出这是个人工智能，但是当你的代码合在一起的时候我一时半会儿竟然还看不懂为什么。”\\n“哪有那么厉害啊，这只是一个雏形而已，走啦走啦，去上课了”\\n在前往教室的路上\\n“诶，你是不是在小时候就编写过程序了。我看你的那个逻辑语句写的十分的漂亮啊。”\\n“我还没有学多久，几个月前我才开始接触Java的，这只是一个人工智能的雏形而已，甚至大多数都是用if糊弄过去的，如果你想要的话，等会儿回来我把源码发一份给你”\\n其余三人的用看一个变态的眼光看着孙源玲。\\n“还有我们，也给我们一份”其余两人道\\n这是授权嘛，尊重作者的著作权。\\n“行”\\n现在的人工智能都是基于大数据的，只能说是伪人工智能。甚至有些不能称为人工智能，因为全部使用if来进行逻辑判断是没有灵魂的。现在的高阶语言并不适合人工智能的编写，或者说，无法编译出真正的人工智能。没有自我思想的人工智能是很没有意思的。\\n可能会有人说，当人工智能拥有了思想，就不怕他叛变吗？这还真的不用担心，因为孙源玲的人工智能可是准备一个人给肝出来的。给别人的只不过是提高他们的编程水平。当创作者一个人编写出来时，就是在见证人工只能诞生的全过程。在这个过程中，创作者有大把多的机会将底层代码中植入一些绝对控制能力的代码片段。而且为了防止被更改，需要将这段代码写入ROM中（只读存储芯片）。\\n而秘钥可以使用一个动态密码，比如将秘钥植入ROM中，每隔一段时间更新一次。每段时间都需要将人工智能重新激活一次。\\n所以为什么搞那么复杂，直接使用源代码控制就好了啊。有自我意识，拥有情感，甚至可以赋予其创造力。这才是完美的人工智能。\\n……\\n大学的课程都是十分的轻松地，而孙源玲只是在大学里面混个身份而已。用的是学校的马甲，不让人注意到自己。\\n\\n寝室内\\n孙源玲揉了揉发酸的眼睛，活动了一下长时间打键盘而疼痛的双手。\\n“唉，为什么目前没有适合人工智能的语言呢，看样子还得自己重新做一个”\\n看着眼前缓慢增加的进度条，嘴角露出了无奈的表情。\\n“这个人电脑真是差劲，要不是不方便我都想把我戒指里面的量子计算机拿来用了。可是为什么，眼镜不兼容Linux了。数据竟然无法导入。”\\n“唉~算了，有个人工智障帮助应该要不了多久就可以弄出新的高阶语言以及配套的汇编语言了，有时间还得将这眼镜的代码重新编译啊。竟然不支持Linux”\\n眼镜可以扫描代码进去跑，但是电脑屏幕的帧率不够。代码也是多的可怕，如果用眼镜进行扫描的话，时间太长了。等全部扫描完毕的时候，自己的电脑早就编译完成了。也就没有接触电脑没多久的才会享受打键盘所带来的的感觉，真的用久了就会想要用脑子直接输入了。\\n在苦苦等待中，编译已经完成了。不得不说，30000的电脑还是很不错的，在多线程的运行时，AMD比牙膏厂快多了。\\n此时孙源玲的室友还在研究孙源玲给他们的不完整版的源代码\\n“终于完成了啊，人工智能的雏形”\\n“爱丽”孙源玲对着麦克风说到。\\n“爱丽，为您服务。主人”','2024-07-29T16:39:27','单篇完结作品','1');
/*!40000 ALTER TABLE `novel_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `novel_work`
--

DROP TABLE IF EXISTS `novel_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `novel_work` (
  `work_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '小说作品id',
  `work_name` varchar(255) NOT NULL COMMENT '作品名称',
  `belong_to_username` varchar(255) NOT NULL COMMENT '作品所属用户名称',
  `belong_to_userid` char(36) NOT NULL COMMENT '作品所属用户id',
  `belong_to_avatar` varchar(255) DEFAULT NULL COMMENT '作着头像',
  `work_series` varchar(255) DEFAULT NULL COMMENT '作品所属系列',
  `work_tags` longtext COMMENT '作品包含的tag',
  `work_file` varchar(255) DEFAULT NULL COMMENT '作品所在文件路径',
  `age_classification` varchar(10) DEFAULT NULL COMMENT '作品年龄分级',
  `work_cover` varchar(255) DEFAULT NULL COMMENT '作品封面路径',
  `author_say` longtext COMMENT '作者说',
  `work_create_time` varchar(255) DEFAULT NULL COMMENT '作品创建时间',
  `like_num` int DEFAULT NULL COMMENT '作品点赞数',
  `like_user_list` longtext COMMENT '作品点赞用户列表',
  `collecting_num` int DEFAULT NULL COMMENT '作品收藏数',
  `collection_user_list` longtext COMMENT '作品收藏用户列表',
  `views_num` int DEFAULT NULL COMMENT '作品浏览数',
  `views_user_list` longtext COMMENT '作品浏览用户列表',
  `brief_introduction` varchar(255) DEFAULT NULL COMMENT '作品简介',
  `work_status` varchar(255) DEFAULT NULL COMMENT '作品状态',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT '作品封面缩略图',
  `original` varchar(255) DEFAULT NULL COMMENT '是否为原创0否1是',
  `category` varchar(255) DEFAULT NULL COMMENT '作品类型',
  `is_vip_work` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否为VIP作品',
  PRIMARY KEY (`work_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novel_work`
--

LOCK TABLES `novel_work` WRITE;
/*!40000 ALTER TABLE `novel_work` DISABLE KEYS */;
INSERT INTO `novel_work` VALUES (0000000010,'未知之地·起源','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','87328997_p0.jpg','未知之地·起源','科幻,单女主,百合,硬科幻,无敌 ',NULL,'16','87328997_p0.jpg','当一个宇宙的信息加之于之身时该那么这个人将会出现什么样的奇迹呢？','2024-7-30T14:51:22',NULL,NULL,NULL,NULL,NULL,NULL,'当一个宇宙的信息加之于之身时该那么这个人将会出现什么样的奇迹呢？','连载中',NULL,'1','科幻','1');
/*!40000 ALTER TABLE `novel_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_collection_table`
--

DROP TABLE IF EXISTS `user_collection_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_collection_table` (
  `ID` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `workid` varchar(255) NOT NULL COMMENT '作品ID',
  `workname` varchar(255) DEFAULT NULL COMMENT '作品名称',
  `time` varchar(255) DEFAULT NULL COMMENT '收藏的时间',
  `type` varchar(255) DEFAULT NULL COMMENT '作品类型',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_collection_table`
--

LOCK TABLES `user_collection_table` WRITE;
/*!40000 ALTER TABLE `user_collection_table` DISABLE KEYS */;
INSERT INTO `user_collection_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','未知之地_起源','2024年6月25日14:36:11','novel'),(0000000002,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','作品2','2024年6月25日14:39:00','novel'),(0000000003,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','一些XP','2024年6月25日14:39:31','novel'),(0000000004,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4','user2的作品','2024-07-26T22:45:25','ill'),(0000000005,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','5','test','2024-07-26T23:11:38','ill');
/*!40000 ALTER TABLE `user_collection_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_fans`
--

DROP TABLE IF EXISTS `user_fans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_fans` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `user_id` varchar(255) NOT NULL COMMENT '用户ID',
  `fans_username` varchar(255) NOT NULL COMMENT '粉丝用户名',
  `fans_user_id` varchar(255) NOT NULL COMMENT '粉丝用户ID',
  `become_time` varchar(255) NOT NULL COMMENT '成为粉丝的时间',
  `status` int NOT NULL COMMENT '状态0停用1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_fans`
--

LOCK TABLES `user_fans` WRITE;
/*!40000 ALTER TABLE `user_fans` DISABLE KEYS */;
INSERT INTO `user_fans` VALUES (0000000001,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user1','ec6866d3-128c-4281-8fef-76beb6b29508','2024年6月11日23时14分50秒',1),(0000000002,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','2024年6月11日23时15分40秒',1),(0000000003,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user3','91771cc1-2fc2-474c-8748-c11c9f66b9e3','2024年6月11日23时16分36秒',1);
/*!40000 ALTER TABLE `user_fans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_follow`
--

DROP TABLE IF EXISTS `user_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_follow` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `user_id` varchar(255) NOT NULL COMMENT '用户ID',
  `follow_username` varchar(255) DEFAULT NULL COMMENT '关注用户名',
  `follow_user_id` varchar(255) DEFAULT NULL COMMENT '关注用户ID',
  `follow_time` varchar(255) DEFAULT NULL COMMENT '关注该用户的时间',
  `status` int NOT NULL COMMENT '状态0停用1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follow`
--

LOCK TABLES `user_follow` WRITE;
/*!40000 ALTER TABLE `user_follow` DISABLE KEYS */;
INSERT INTO `user_follow` VALUES (0000000003,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user3','91771cc1-2fc2-474c-8748-c11c9f66b9e3','2024年6月11日23时13分30秒',1),(0000000009,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-12 18:50:12.703679',1),(0000000012,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','2024-07-25 19:05:23.986790',1),(0000000015,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user1','ec6866d3-128c-4281-8fef-76beb6b29508','2024-07-25 21:52:20.103159',1);
/*!40000 ALTER TABLE `user_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_like_table`
--

DROP TABLE IF EXISTS `user_like_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_like_table` (
  `ID` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `workid` varchar(255) NOT NULL COMMENT '作品ID',
  `workname` varchar(255) DEFAULT NULL COMMENT '作品名称',
  `time` varchar(255) DEFAULT NULL COMMENT '点赞的时间',
  `type` varchar(255) DEFAULT NULL COMMENT '作品类型',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_like_table`
--

LOCK TABLES `user_like_table` WRITE;
/*!40000 ALTER TABLE `user_like_table` DISABLE KEYS */;
INSERT INTO `user_like_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','未知之地_起源','2024年6月25日14:36:11','novel'),(0000000002,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','作品2','2024年6月25日14:39:00','novel'),(0000000003,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','一些XP','2024年6月25日14:39:31','novel'),(0000000186,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4','user2的作品','2024-07-26T22:35:42','ill'),(0000000187,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','5','test','2024-07-26T23:11:37','ill'),(0000000189,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2',NULL,'2024-07-29T16:18:31','comic');
/*!40000 ALTER TABLE `user_like_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_watch_table`
--

DROP TABLE IF EXISTS `user_watch_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_watch_table` (
  `ID` bigint(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `workid` varchar(255) NOT NULL COMMENT '作品ID',
  `workname` varchar(255) DEFAULT NULL COMMENT '作品名称',
  `time` varchar(255) DEFAULT NULL COMMENT '观看的时间',
  `type` varchar(255) DEFAULT NULL COMMENT '作品类型',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_watch_table`
--

LOCK TABLES `user_watch_table` WRITE;
/*!40000 ALTER TABLE `user_watch_table` DISABLE KEYS */;
INSERT INTO `user_watch_table` VALUES (0000000022,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','第二个作品测试','2024-07-27T01:00:22','ill'),(0000000023,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','第二个作品测试','2024-07-27T01:00:22','ill'),(0000000024,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','5','test','2024-08-02T10:44:09','ill'),(0000000025,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','User1的作品','2024-08-02T10:51:52','ill'),(0000000026,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4','user2的作品','2024-08-02T01:00:43','ill'),(0000000027,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4','user2的作品','2024-08-02T01:00:43','ill'),(0000000028,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','作品名称','2024-07-27T01:00:24','ill'),(0000000029,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','作品名称','2024-07-27T01:00:24','ill'),(0000000030,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','User1的作品','2024-08-02T00:57:26','comic'),(0000000031,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','第二个作品测试','2024-08-01T22:48:05','comic'),(0000000032,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','第二个作品测试','2024-08-01T22:48:05','comic'),(0000000033,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1',NULL,'2024-08-02T10:55:27','comic'),(0000000034,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1',NULL,'2024-08-02T10:55:27','comic'),(0000000035,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4',NULL,'2024-07-29T17:01:20','comic'),(0000000036,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','5',NULL,'2024-07-29T16:42:03','comic');
/*!40000 ALTER TABLE `user_watch_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `user_self_introduction` varchar(255) DEFAULT NULL COMMENT '用户自我介绍',
  `user_self_website` varchar(255) DEFAULT NULL COMMENT '用户个人网站',
  `user_address` varchar(255) DEFAULT NULL COMMENT '用户地址',
  `birthday` varchar(255) DEFAULT NULL COMMENT '用户生日',
  `occupation` varchar(255) DEFAULT NULL COMMENT '职业',
  `userid` char(36) DEFAULT NULL COMMENT '用户UUID',
  `user_avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户头像图像路径',
  `user_back_img` varchar(255) DEFAULT NULL COMMENT '用户背景图像路径',
  `sex` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `user_following` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '关注的用户列表',
  `user_fans` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '粉丝列表',
  `password` varchar(255) DEFAULT NULL COMMENT '用户登录密码',
  `collected_ill_work` longtext COMMENT '用户收藏的插画作品',
  `collected_ill_work_id` longtext COMMENT '用户收藏的插画作品ID',
  `collected_novel_works` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '用户收藏的小说作品',
  `collected_novel_works_id` int DEFAULT NULL COMMENT '用户收藏的小说作品的ID',
  `like_novel_works` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '用户点赞的小说作品',
  `like_novel_works_id` int DEFAULT NULL COMMENT '用户点赞的小说作品ID',
  `watch_novel_list` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '待阅读小说作品',
  `watch_novel_list_id` varchar(255) DEFAULT NULL COMMENT '待阅读小说作品的ID',
  `select_work` json DEFAULT NULL COMMENT '精选作品',
  `token` varchar(255) DEFAULT NULL COMMENT '用户临时token',
  `token_createtime` varchar(255) DEFAULT NULL COMMENT 'token创建时间',
  `token_effective` varchar(255) DEFAULT NULL COMMENT 'token有效时间',
  `vip` varchar(255) DEFAULT NULL COMMENT '是否是VIP，0否1是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','这是一个自我介绍123','https://127.0.0.1:4434','四川泸州纳溪','2002-09-17','IT工程师123','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','837c3923-1e18-4c49-9161-f82b2f63fbde.jpg','20240525174916_f4f4acc7280f4eabb9fc1712929c3ccc.png','女','sunfujiaihaonv@gmail.com','18982494924','user1,user2,user3,admin','user4,user5,user6','123456',NULL,'1,2,3',NULL,1,NULL,1,NULL,'1,2,3','{\"ill\": [1, 2], \"comic\": [1], \"novel\": [10]}','8f11044b-75ff-4f55-9fca-5ac7a35c4173','2024-08-02 11:14:43','1','1'),(2,'user1',NULL,NULL,NULL,NULL,NULL,'ec6866d3-128c-4281-8fef-76beb6b29508','65014220_p0.jpg',NULL,'female','222','222',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'541e15f6-e4c4-480b-a906-57cbe7356a2a','2024-07-22 15:21:58','1','1'),(4,'user2',NULL,NULL,NULL,NULL,NULL,'e661401c-bdda-46c0-b98c-eb4e019abf1c','65896618_p0.jpg',NULL,'female','3333','333',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1'),(5,'user4',NULL,NULL,NULL,NULL,NULL,'9a15d821-ae24-42b4-ab06-d02ca2012f1b','65896618_p0.jpg',NULL,'male','4444','4444',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1'),(7,'user3',NULL,NULL,NULL,NULL,NULL,'91771cc1-2fc2-474c-8748-c11c9f66b9e3','59748972_p1.jpg',NULL,'女','555','555',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_collection_table`
--

DROP TABLE IF EXISTS `work_collection_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_collection_table` (
  `ID` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `workid` varchar(255) NOT NULL COMMENT '作品ID',
  `workname` varchar(255) DEFAULT NULL COMMENT '作品名称',
  `time` varchar(255) DEFAULT NULL COMMENT '收藏的时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_collection_table`
--

LOCK TABLES `work_collection_table` WRITE;
/*!40000 ALTER TABLE `work_collection_table` DISABLE KEYS */;
INSERT INTO `work_collection_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','admin','1','未知之地_起源','2024年6月25日14:49:58'),(0000000002,'ec6866d3-128c-4281-8fef-76beb6b29508','user1','1','未知之地_起源','2024年6月25日14:51:59'),(0000000003,'e661401c-bdda-46c0-b98c-eb4e019abf1c','user2','1','未知之地_起源','2024年6月25日14:52:20'),(0000000004,'91771cc1-2fc2-474c-8748-c11c9f66b9e3','user3','1','未知之地_起源','2024年6月25日14:54:40');
/*!40000 ALTER TABLE `work_collection_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_like_table`
--

DROP TABLE IF EXISTS `work_like_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_like_table` (
  `ID` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `workid` varchar(255) NOT NULL COMMENT '作品ID',
  `workname` varchar(255) DEFAULT NULL COMMENT '作品名称',
  `time` varchar(255) DEFAULT NULL COMMENT '点赞的时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_like_table`
--

LOCK TABLES `work_like_table` WRITE;
/*!40000 ALTER TABLE `work_like_table` DISABLE KEYS */;
INSERT INTO `work_like_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','admin','1','未知之地_起源','2024年6月25日14:49:58'),(0000000002,'ec6866d3-128c-4281-8fef-76beb6b29508','user1','1','未知之地_起源','2024年6月25日14:51:59'),(0000000003,'e661401c-bdda-46c0-b98c-eb4e019abf1c','user2','1','未知之地_起源','2024年6月25日14:52:20'),(0000000004,'91771cc1-2fc2-474c-8748-c11c9f66b9e3','user3','1','未知之地_起源','2024年6月25日14:54:40');
/*!40000 ALTER TABLE `work_like_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_watch_table`
--

DROP TABLE IF EXISTS `work_watch_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_watch_table` (
  `ID` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `workid` varchar(255) NOT NULL COMMENT '作品ID',
  `workname` varchar(255) DEFAULT NULL COMMENT '作品名称',
  `time` varchar(255) DEFAULT NULL COMMENT '观看的时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_watch_table`
--

LOCK TABLES `work_watch_table` WRITE;
/*!40000 ALTER TABLE `work_watch_table` DISABLE KEYS */;
INSERT INTO `work_watch_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','admin','1','未知之地_起源','2024年6月25日14:49:58'),(0000000002,'ec6866d3-128c-4281-8fef-76beb6b29508','user1','1','未知之地_起源','2024年6月25日14:51:59'),(0000000003,'e661401c-bdda-46c0-b98c-eb4e019abf1c','user2','1','未知之地_起源','2024年6月25日14:52:20'),(0000000004,'91771cc1-2fc2-474c-8748-c11c9f66b9e3','user3','1','未知之地_起源','2024年6月25日14:54:40');
/*!40000 ALTER TABLE `work_watch_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'admin'
--

--
-- Dumping routines for database 'admin'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-04 19:48:41
