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
ef18a94f-0601-11ef-b34a-00155de60230:1-3370';

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add placeholder model',7,'add_placeholdermodel'),(26,'Can change placeholder model',7,'change_placeholdermodel'),(27,'Can delete placeholder model',7,'delete_placeholdermodel'),(28,'Can view placeholder model',7,'view_placeholdermodel');
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
  `work_approved` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT '2' COMMENT '作品审核状态，0未通过，1通过，2未审核',
  `approved_userid` varchar(255) DEFAULT NULL COMMENT '审核人',
  `approved_time` varchar(255) DEFAULT NULL COMMENT '审核时间',
  `approved_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comic`
--

LOCK TABLES `comic` WRITE;
/*!40000 ALTER TABLE `comic` DISABLE KEYS */;
INSERT INTO `comic` VALUES (0000000001,'作品测测1','96950958_p0.png,117214493_p0_master1200.jpg','user1','ec6866d3-128c-4281-8fef-76beb6b29508','65014220_p0.jpg','tag1,tag2,tag3','16','this is a comic introduction','2024年6月27日18:39:06',NULL,'1',NULL,NULL,NULL),(0000000002,'作品测试2','20240525175111_0c1ff93008904940bc4cdc681bde78b5.jpg,20240525174916_f4f4acc7280f4eabb9fc1712929c3ccc.png','user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','65896618_p0.jpg','tag2,tag3,tag1','18','this is a test2 to comic introduction','2024年6月27日18:40:33',NULL,'1',NULL,NULL,NULL),(0000000003,'作品测试3','96680242_p0.png','user3','91771cc1-2fc2-474c-8748-c11c9f66b9e3','59748972_p1.jpg','tag1，标签2','18','这是一个作品的测试简介，','2024年6月27日18:42:17',NULL,'1',NULL,NULL,NULL),(0000000004,'漫画上传测试','2433195936509560_p1.jpg,2433195936509560_p2.jpg,2433195936509560_p3.png','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'萝莉,白裤袜','16','漫画作品上传测试','2024-07-18T13:38:21',NULL,'1',NULL,NULL,NULL),(0000000005,'漫画上传测试','6707269151560007_p1.jpg,6707269151560007_p2.jpg,6707269151560007_p3.jpg','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'裤袜,白裤袜,拆分','16','这是一个测试内容','2024-07-29T17:02:42',NULL,'1',NULL,NULL,NULL),(0000000006,'显示测试','0870348002627659_p1.jpg,0870348002627659_p2.jpg','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'萝莉,裤袜','16','css颜色测试','2024-08-07T17:01:45',NULL,'1',NULL,NULL,NULL),(0000000007,'jwt认证上传测试','2708551719690855_p1.jpg,2708551719690855_p2.png,2708551719690855_p3.png,2708551719690855_p4.png,2708551719690855_p5.png','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'测试','16','jwt认证上传测试','2024-08-21T16:54:20',NULL,'2',NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (46,1,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123','2024-07-28T21:56:01',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(47,1,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','321','2024-07-28T21:56:06',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(48,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123','2024-07-28T21:56:58',NULL,NULL,NULL,47,47),(49,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123','2024-07-28T21:57:45',NULL,NULL,NULL,46,46),(50,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1234','2024-07-28T21:58:31',NULL,NULL,NULL,46,49),(53,1,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123321','2024-07-28T22:02:18',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(55,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','0','2024-07-28T22:05:40',NULL,NULL,NULL,53,53),(56,1,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123','2024-07-28T22:05:56',NULL,NULL,NULL,47,48),(57,5,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123321','2024-07-29T00:02:25',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(58,4,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1233211234567','2024-07-29T00:09:47',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(59,4,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','测试评论','2024-07-29T00:22:43',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(60,4,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','回复测试评论','2024-07-29T00:22:52',NULL,NULL,NULL,58,58),(61,3,'comic','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','小说评论测试','2024-07-29T16:01:14',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(62,2,'comic','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','评论发送测试','2024-07-29T16:17:49',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(63,10,'novel','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','这是第一条小说评论，这小说写的还不错','2024-08-01T22:58:14',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(64,5,'ill','1',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','jwt替换认证测试','2024-08-21T00:50:37',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,0,0),(65,5,'ill','0',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','jwt回复评论测试','2024-08-21T00:53:51',NULL,NULL,NULL,64,64);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_like`
--

LOCK TABLES `comment_like` WRITE;
/*!40000 ALTER TABLE `comment_like` DISABLE KEYS */;
INSERT INTO `comment_like` VALUES (2,53,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-28T23:37:56','ill',1),(3,55,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-28T23:43:44','ill',1),(4,56,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-28T23:43:57','ill',1),(5,58,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-29T00:22:55','ill',4),(6,59,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-07-29T08:17:02','ill',4),(7,63,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-08-01T23:05:18','novel',10),(8,57,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-08-21T00:48:09','ill',5),(9,64,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-08-21T00:53:31','ill',5);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'GetUserInfo','placeholdermodel'),(6,'sessions','session');
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
INSERT INTO `django_session` VALUES ('06fbrurzs7xxslywv87kthidqai5oiu2','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seVDh:dXV-PzdRVz2161Y1TZNkTD2eoUMqrkHqzpWovVTXji4','2024-08-15 08:48:29.210280'),('07zf3adz5issobujeqdxe2gvjrh8erlw','.eJwNxkEOgzAMBMC_7JlIgFKlzmciB7stApGqdk6Iv9M5zQnu_ik_tW87TIuwM_IJc_ZuyLC-LGqGAauVvb3XA3ka4G3T_zDXmZ5JXiEypRCrUOAoHGRMSlTTGOsD13UDPzEhOQ:1seD6g:jduGODkGwQF7xe9wIWC78VCeT9a0ckNbwU0nHDoHpNI','2024-08-28 12:28:02.875565'),('0e9y7d8r1ebxffunnprggelozr1amr4w','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCl2:wFnroklHD4OumkFZwcyaCgTFQ3j12qJ3O8zRuZ3HOH0','2024-08-17 07:17:48.301525'),('0eo0jcl9nheuhpaexou6c3o6au6o10nx','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBxl:ih9JFgeL8CYV_vF0ZIpAZQq3EUAb4swVJSRyKYtz29Y','2024-08-17 06:26:53.105249'),('0gqi2kimhbiz6vn2px8l947yvpt1sgbt','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCbR:vvitZ6BJ4my3aYIqTSw1z5CchKx3PCLI52qDNHX6WNY','2024-08-17 07:07:53.108445'),('0gv0hpyvu74rw7ijlntuxegngiin9xx1','.eJwNxsEORTAQBdB_uWtNkFL6M81gBiH68ma6Ev_OWZ0bVGxLf9ZfvpTTQkaIN9TIiiJCyzyzKirsms687hdiU8Hywd8wSRfabhmdcAjOeyI3TDU5P_qGe2mlFsLzvEEKIWE:1sezab:ynfVK9p1cr0eXg7gsFSnYbvt6VyYzSwOK1HFQTI0t6Y','2024-08-16 17:14:09.213423'),('0jiiyf22o16ugu5uax6p84hrwmnaxebz','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezhL:_F6D5CVI0PZX_iZqW7husH1UfC6XYZqEirr2c_kgTEc','2024-08-16 17:21:07.842345'),('0kjukuqstjcn3qz0ey22h7gjucd5pg41','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBn7:UddbkM5XMvXO4V_dpDClH1Jh1GLXRVdYwMPxtewUoA4','2024-08-17 06:15:53.111776'),('0kngxri2n0orfgkixx277jm629d94fz4','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezxe:xs5Jk1yE-Otf9-gLEok5Cs0WY0QENJ96tNLi45Nd0ps','2024-08-16 17:37:58.269060'),('0lh49swsfgpgg2te4kjycwtun973pj3q','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDQC:363b8R7hpjU9lXIuz01EPDF8W6d1YtUoEeH1mmXcCJc','2024-08-28 12:48:12.648211'),('0oki7nmygw4scobd3s3qes1ojwwdeep8','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDWZ:ZFBx3yXRkQF41ygEp1dYHgd5Je7v5hls28DdyDEWuEI','2024-08-17 08:06:55.435000'),('0xfcy1tn8vpr5n96wcrneqo6emnxnfsp','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC7R:nz7xP5G1g7WNMJ0kYO_pVe_RtRueSgyUHfpbdRE2lGQ','2024-08-17 06:36:53.251486'),('199xmi292bak8yewr7qdg9lo54rnogq5','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD49:taw5BjFyDtYv3HakZyEWnKECdmoV09vQuyA07mRQC5U','2024-08-17 07:37:33.254319'),('1f81ykwc0j1meju07ykmcwknilcu43wh','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCqX:_JMR4RIkzKU_KWauxxd3ImAZCL8AFrVimGWoxLVFoPE','2024-08-17 07:23:29.597981'),('1g4jfhtin2172mn4jcvg5uc0tnn7b2oa','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezxi:Gnwf9Ni7fToMMlJ67VQDBW16Ud41zEDefUXRA-wJaUw','2024-08-16 17:38:02.965092'),('1lxm3pk4shulopjwhtfax9gmubbkizbe','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD65:SDIHpZAK-c4K70WLjCscDHSk9y_uP0QhqTqvPAGl83E','2024-08-17 07:39:33.250222'),('1q6xt1keko46l0m9xg3atha3wwkz1rdg','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD3B:szaSjZiN8l9hGpQvDDZO8V4eAhA2tg644MstZ0z8Kis','2024-08-17 07:36:33.242196'),('1xfrkl5hhff04fwoxylfh3zg3c5cxn6e','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDDp:1SInpB2yeczpBw5ykp7DdZAVzZC76os_VUeIHdeYlNA','2024-08-17 07:47:33.423021'),('24nkbyopnlnpwzp0grsw2wtogikjgeh9','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCRl:10bSUF6h7yZGTym34yplkkuwcGsgqh7GTRtqVgQJTa4','2024-08-17 06:57:53.091917'),('2kkxewc2383zgn4rve8x7cpp38gwhivl','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCPp:P2mRdJG1T-Us8sxIuC2pxWLQ4voaGS3gQ8ioIJ_mS2I','2024-08-17 06:55:53.110902'),('2kxj8p47lqe8af3bynhhtpdd2e6i6m70','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDN0:R6f-kInldPclcLiyCPSmKnre7mYg0tUBrCiDyLYMeFk','2024-08-17 07:57:02.419265'),('2l9r2jzur26oq8ksw4ykc3spj678ba3d','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCNt:dt4Diod-r8AwAHd0VwPkXwQ3xMMB86lm6GECpWlL0sg','2024-08-17 06:53:53.125569'),('2mf6hw6owafn7pgtzb7nktl21j436hos','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTEx:G35OHhavAbNGP1dWSFkNncFPRTpI5UrgSQp7CzY0kcQ','2024-08-15 06:41:39.259313'),('2nkdc0tmq8ve5sg31vbvu2rznlita8mw','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTEt:9ktCQTByloHAysddAEnWkI3JcWIWOfWXM5CWmvFGaiU','2024-08-15 06:41:35.741877'),('2v2gm07em4h30j5g78261v2ixovntu4i','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezlB:pBAknXNdqbtwoue3KF5dQDtoIZPKgHlu8FLvxkRLMDU','2024-08-16 17:25:05.577484'),('3eazxrzmkb6v3cyg40tl4hikm7415nqc','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBg2:mxog8-HtKJIuKk7qufPLXsOlXDAf9CVhX2K0rfhLUtI','2024-08-17 06:08:34.448914'),('3ppygbhxe2k7586a5v4784gisijgcj71','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCj6:JV95wCYkyZjsqXh19kHmxsv84jUpdIHkdUiwtK5SRis','2024-08-17 07:15:48.292036'),('451lk2p5z67qdekw3u9zn8ae7h2yabqx','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTEW:EHR9ls8vCswvlTEAtD7vVXft4Vf3X-Z_odRAnkrmhSQ','2024-08-15 06:41:12.025427'),('47t3pi6be5tq324s1tjrcol49rp7wyov','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDTF:q9UIHvCFRS_ZkTNQCsWavsACYwneSSYKrKN3sJIkQ_c','2024-08-28 12:51:21.233007'),('48nsfanvffe728n19xopltoakxtwvwkd','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD2D:xpySGocdi5ua5CNV4wJECPjzYySebTPDgLX3Hj7AWzI','2024-08-17 07:35:33.246540'),('4a7s2xokhu14pxr2u5uovr382lx67c7e','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seV6M:KfMHMqcb2yO1C47QZW05g9INfKzvnLxpE11rEDUXKqo','2024-08-15 08:40:54.626978'),('4ha6a9tfc16qameye2f6zf7vu9hmk7ft','.eJwNxkEOgyAQBdC7_LUkpQoClyGDTFtjI8YZVsa7t2_1LlDXTz5ZjrYL50pKSBdESbsgQfqysAgGrJK_7b3uSHaAto3_g58K2ehexkU7mik8nib6WI0bq-dSyxwC4b5_LJ0grg:1seDJo:lgsP_KPc4Go8zmiIDqiFEpjetlAwBsFIiX6sXDuprAw','2024-08-28 12:41:36.423397'),('4wkjcfo8ojxp0g5n1yuw1g9cgzajd3rd','.eJwNxkEOgyAQBdC7_LUkHUQ74TIEcLSmjTSdYWW8u32rdyJ3e6Wf6LcdKmnJlhFPqGXrigjttYoqBuyaPm3bD0QaYO0t_8EvM3HwkxsfvLpAPLlCXhyXufKTxhAK47puIxEgDg:1seD7l:M2MAqzhkVWAHenyJ03RDFh7RbXMics2fnKcrjuEY2_E','2024-08-28 12:29:09.488600'),('4xlcnbt5s0mohaepirap6pwfoznkhpp3','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCrV:mazb19X6bNIU-mJGmNv6HPzZN6MxByrYdWeeQvl8YNA','2024-08-17 07:24:29.765379'),('5cqz4veoza6gcub1g8e6hw4o8bctdfcc','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCmy:TdGTBKVJ_zAp739z-agQyRifKHs_0Pdmqd9-eZHc5zY','2024-08-17 07:19:48.296348'),('5kvsr9gv4lgx6apephx9u44cyhr4pgbv','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCcP:Rwgkw8EgREc10zAcm9LQf1RQSA-vaG_rwx81_WL2jho','2024-08-17 07:08:53.107720'),('5slq0y96w55yunkeh3duknj70vo0yb3b','.eJwNxjEOwjAMBdC7_LkZIoxa5zKRkzhQgRqEnanq3eFN74RMf-av2mccprmJC9IJc_FpSLBZq5phwW75PR77gRQX-Hjpf7hRYe6lh7quMRBTC3zfJEjl0nWjRrHjun5AwSF1:1set0T:DDVGUKdK5iufIm5Nyne--XXLg3DM0eVyLor6LCZktKc','2024-08-16 10:12:25.228862'),('647s5d0gj6p8hihgmv9cwi0hcq70a4d7','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC4X:Yh7BIk7DTuZqo7MQfr8AWMB8cUp7dxsbtMC60uSPIFQ','2024-08-17 06:33:53.114560'),('66b3537diqsj6z05w8blcium3kl3ybtq','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDL4:HF2MCjYO4GriChDPGpqt19z_A47YyO17g_wdIjdCGMo','2024-08-17 07:55:02.416089'),('6d8vr75cwyhmqogtlcycan1p1jzicq0k','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCzJ:Q9CbFv1zSzJA8Xql9wkotDKaxd-98SUTrOpPTq25Bac','2024-08-17 07:32:33.250009'),('6fgs1v94xyv0y8n0gxdz4wejzz07eyvg','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seVFP:GogLAst-NrvpXUIwmq1QCiUq0A-Etg3-U1MI9n-Qyp8','2024-08-15 08:50:15.407437'),('6yzdgdzi8ch0u858k79gvajxwugknkng','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCnw:3KJFRuv8WgBeb9HBVzZlCSK9UyQ0XAfMvOeTsdQR6DI','2024-08-17 07:20:48.294770'),('7592f657v3pon22gioey55awnit5sfvl','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDCr:zwkdMZFEmvPdcGQR81xG0E0eya7-wgLUV82z54RgwRw','2024-08-17 07:46:33.441101'),('7cviilwpbxo26xd1sqi6icurqgjocnrp','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCsT:yFD1-D99BqlkCoAAaXdb6V879MIGZqvXhdJs_dCpCs0','2024-08-17 07:25:29.797112'),('7jjh122og8vg8valtz45i2zii3owdy1e','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC2b:3KbSSY6kU2J9phERnQwpdTzxjoM1w-Uey_plnAeHtqY','2024-08-17 06:31:53.108071'),('7u6h3gp7trjde963lpi03tk06bl6b8v5','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDZT:AK14Lm6n-DcGfwn9QquGz0tFBSyj5_frt6pPIIrE6tc','2024-08-17 08:09:55.428473'),('7uk3uske3fv8zjdtso8s7kcv5ckxl47f','.eJwNxk0OgyAQBtC7fGtJFPyhXIaMMLSmjRhnWBnvXt_qXaCmn3iyHHUXjpmUEC6IkjZBgLSUWAQdNom_-t52hKGD1i8_g3NutTwms_CrmJGyNWspxfh56nnI3nq74L7_QmshNA:1seD8a:IW7gdFqJRqObFhsjBpo4aOVrNoufXf8sAeZgZMJ2XdY','2024-08-28 12:30:00.267944'),('81dvalnu9ioit0kld7s8uaodcgz6pokg','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD1F:lhVi5pKBimOY2sSRERPrl4f0F4i8KeQPCsTa-OE708o','2024-08-17 07:34:33.243333'),('81imii5luci2e25wc4aw5o6uxmom2nx3','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDcT:0kJZBTWYpiGkV2Q5Uu6NmXMgRCS2JrAJXS7e1lJ1Nnk','2024-08-14 14:00:53.740165'),('835deqcfty2bc9l55u3b7z19qplxr7dl','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCKz:TAlpAmG7JwCPOLfRfqboG2w2JRfneAItOOr-XJqaKdQ','2024-08-17 06:50:53.105887'),('83lm6q0h89qxkfelihkv4hmsqycnmnne','.eJwNxsEORTAQBdB_uWtNkFL6M81gBiH68ma6Ev_OWZ0bVGxLf9ZfvpTTQkaIN9TIiiJCyzyzKirsms687hdiU8Hywd8wSRfabhmdcAjOeyI3TDU5P_qGe2mlFsLzvEEKIWE:1sezab:ynfVK9p1cr0eXg7gsFSnYbvt6VyYzSwOK1HFQTI0t6Y','2024-08-16 17:14:09.210273'),('8a4pzc639s04l4qrrmgl20e5q25llwr7','.eJwNxkEOgyAQBdC7_LUkUhUDlyEDDK1pI40zrIx317d6J6jrJx4s_7YLx0JKCCdESbsgQHrOLIIBm8Rfe287gh2g7cvPQLVOvmRnShrZzHn0hhabzGut3lm3JkozrusGTWEhiA:1sf09I:PDgWs5RQhS74BCHySc6wgiu4t4imbjRyEo-KS6y7C6M','2024-08-16 17:50:00.381185'),('8noj4rf4rk11kham8pfs852zv8hqgpsk','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezxi:Gnwf9Ni7fToMMlJ67VQDBW16Ud41zEDefUXRA-wJaUw','2024-08-16 17:38:02.966097'),('8o3dcab6yaffi24bvhvbsfme8kxuzb3q','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seVFP:GogLAst-NrvpXUIwmq1QCiUq0A-Etg3-U1MI9n-Qyp8','2024-08-15 08:50:15.403717'),('8ro8mk06qiy8q96ac1hcc1k1g6h5m6hg','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTKf:uPQ0X2FB7-Q6UqNnoxRPPftOQORZ_y2Ok6Ru-bbVY3w','2024-08-15 06:47:33.261024'),('8t1l7is5hpe70eymo0yhktpv4wyzweiz','.eJwNxkEOgyAQBdC7_LUsABHkMmSUaWs00nSGlfHu9q3eBer6KT-WbzuFSyUl5AuipF2QIX1dWQQDNilHe28nsh2gbef_MCWbXCQyYQ5sxlf0Zp5iMq6G6sgvo7Me9_0AKjIgRg:1seD7l:fGs1xjhjBuOQmmUkLik4u80Tdl9BeMVzXqjNI4v0lYw','2024-08-28 12:29:09.500627'),('90c2e7hz53sjtrx4ofmdavpzplxmbdg0','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBq1:JWhUjF2lPq5xfH7JeWO6n-BQPuYK1VKEz89WALwb6-k','2024-08-17 06:18:53.109936'),('91vutx3vl6ol3qyzq0nznnx2zusvs0zv','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDSh:BPb_VjcAtGv9Nt6KeIFo_j2tXar2Gs808pYvwQnW7cc','2024-08-17 08:02:55.430802'),('98g9scjb5l2iwyhd6rbozsc5pfh84cif','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBjD:LmGJbJOnmhgb1K3zjtfQ5YKkLt8QWjQFniR4gxRxZt4','2024-08-17 06:11:51.710383'),('99s5q2ba8lflv5i34zerqsvzerx40yeq','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezlB:pBAknXNdqbtwoue3KF5dQDtoIZPKgHlu8FLvxkRLMDU','2024-08-16 17:25:05.571956'),('9l5j7jjkcr11sa03sm4d2knfvwh36om4','.eJwNxkEOgyAQBdC7_LUkKkwRLkOmQKvRSNMZVsa7t2_1LnDXNX2rfNopNRVWRrwgytoFEdJzriIYsEk62ns7EacB2vb6H8g6S3ksxnvrjVvKZJhmb-zzFR5hoUCjw33_ACR6H-4:1seDNh:r26-hrDBLorU7IZNmM-DTUsh4eodxI1i-O_PfNrvQWQ','2024-08-28 12:45:37.595949'),('9vm68kug170ds4cyq3fc1izoopdstrpx','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1seziv:14lcnxZcMj2UzTfSkoJuFAGvxBXkRFR_GqEdA29FgdU','2024-08-16 17:22:45.566519'),('9w1itu63p7ps1fbj4kqd24f51mjtqq3f','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTLF:zhZ5bm9nQaV-xyC65qFYHB6Fs9EkmLtAW9_ts7F0qfc','2024-08-15 06:48:09.093118'),('9zf45pejtzl5cqt2qe67lhsfmahh4d57','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seWao:Xbb9CPpKOF3gTbGuekQ8myKl-m-X-9YGmeHKC2RQ8m0','2024-08-15 10:16:26.135920'),('9zqlvoaeuw0wvamt5t4hsi4gmkvcwilg','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seWLL:P2-gwawBtjEVUljmGqIJIZ7lR8g3BR3zPx9xajBB1FE','2024-08-15 10:00:27.502798'),('9zx3suxso1wyco6ak0aslj0383q4xsyg','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDOp:4_z40lVTRcY2qdj26dXHqYSGJhXeJHGzUEZD2twz_dw','2024-08-17 07:58:55.429593'),('a7p2jynsas69uw3mgvf0wta3oy2xrr7r','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDaR:qrq9DXK_fkL4e96cgOBiuiwNoO_SAgcaXpzr74t6Ou0','2024-08-17 08:10:55.418156'),('abwtazwubiefvg8loykcawxb17eh50y0','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seV7G:RheGaEAysbP-deWjs1FqKmku9h_9vzduXLwI7BsgvRA','2024-08-15 08:41:50.119879'),('ahv34phrf578pvo1vbstarx5ixj7xolm','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTTQ:9L4rG9Xa5gok-IntNlmKTUerxIfg1f_L1UdFdiPoz7c','2024-08-15 06:56:36.514312'),('arbnc1k8qkr9g3ymqyzgu4nkihp98yjr','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCsX:Qd_-lD0klxe1AZ11iZOpB-xhOMOaYkv1h2BfF2PNfFg','2024-08-17 07:25:33.075753'),('b1q9nllng3b3bvyl8km04tsw3mlij5o3','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBvp:zNGnt3schKs2ExHyIxsekA_Pj3VQJ2sIPuyf8p-XLhM','2024-08-17 06:24:53.114770'),('b2en4t7645tf5bmdyh5dvbd9n799vm7l','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seXN6:2hoh_hVxf9zStjCq0LaCsJPivB6fiLJeBQ7P5VUpB3A','2024-08-15 11:06:20.862840'),('b33xsvk2ufja2hxcap41pq0qgp9e6c5t','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCm0:fuzBRsf9j1szetPnJqgqBsuvT1n7HsBITBp0Zd92Uas','2024-08-17 07:18:48.300582'),('b50qu1yqim7s85tejngha21asnn6irsa','.eJwNxk0OwiAQBtC7fOuSMPZH4TIEhrE2mmKcYdX07vWt3oHc7ZV-ot-2q6SaLSMeUMvWFRHamUUVAzZNn7ZuOyINsPaW_zAVH7xfRlf49nBTKOwC8dORjHOVWeheCed5ATNKIPM:1seDNh:iKJd-Dg9GyAsISfluM5mT02vquFAyCA3grLcFPucKnY','2024-08-28 12:45:37.600567'),('b8unrl99io9a70sfeauf0o6ddsquojwe','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1seziv:14lcnxZcMj2UzTfSkoJuFAGvxBXkRFR_GqEdA29FgdU','2024-08-16 17:22:45.575502'),('be9b3w0tus79us3l1q3orsqwhpoo7jdi','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBl8:fCJ6PnCSGn-3HLSdi4ot3W4aK6GpeBsYOFmESBl9d4k','2024-08-17 06:13:50.116394'),('bfblfppu5v3dvmwbjtyyi5gj5zl5zstk','.eJwNxkEKwyAQBdC7_HUEbaoGLyOjDq20xNIZVyF3T97qHaCp7_xn-Y1dODdSQjogSjoFCTJrZREs6JK_49V3JLdAx4fvYQ3kgyNvIrdgnqFuhqK1ZvPNNnqshV3BeV4zOyDt:1set1h:6zA0MAEKZ4PyG2noYK-1g-Xy0kTpMYq5If3VYmQ9B_A','2024-08-16 10:13:41.888409'),('bmxdavc6f4d8n08xbjiiqrlstcyv2okx','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCou:yarz3x62RGbNFu4yBFOW9AkaHVxYLFyWfde598V_wIw','2024-08-17 07:21:48.300876'),('bu80yrlv7guy4tn2z5t82sl6n9bwgavo','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDG7:0zTNXf_UVlAYWoh6PLPlkG0yjaSVrsNxOM0e8791oR4','2024-08-17 07:49:55.428480'),('bud0vifimbtqllkwy07fmm4brtkyotgz','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDQG:BLmZM9iOf2sTaQ6_f1R_BGEmw6wP-uzjpTCpcmuBrpQ','2024-08-28 12:48:16.894703'),('bzr5dub4e2lgqpxszolw6xhpmzbwkimf','.eJwNxjEOgzAMBdC7_JkMJUmBXCYyxrQIRBB2JsTd4U3vAlX751P0KLtKnsgI6YIaWVUkaGUWVTRYNG_lt-xInwZWVnmHbmIOfib3HYVdIA6uF4lOhjh77qPvWo_7fgBSFiGW:1seDKr:nBAHyfwpzJrVJqYt_l7veF9u_4LezlgSkxmtuXrO2Fw','2024-08-28 12:42:41.329412'),('c4mepqoc7ovu4c3kv4synvih6cxmuy2s','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDQG:BLmZM9iOf2sTaQ6_f1R_BGEmw6wP-uzjpTCpcmuBrpQ','2024-08-28 12:48:16.890115'),('c7v0k3byhu9crvp59hh8wxfh8j4kdvtz','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBlA:_OmkF_pIy4ayHpMLLaDROV9oDtP1W4qKkAOtr5hGrF0','2024-08-17 06:13:52.948868'),('c8rpfaxe1s5g9w2tu6z3q1goe72pddzy','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDTF:q9UIHvCFRS_ZkTNQCsWavsACYwneSSYKrKN3sJIkQ_c','2024-08-28 12:51:21.228029'),('cgwi1hppskr2qdcsjeemzo894vz0elu6','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDYV:CpAcIZYK6U3aK4icYuQST2dkH5VHQP22l3fiViUkK0s','2024-08-17 08:08:55.435548'),('cjqhfiersn2530ysapmqhrbzrq9vkbgq','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC6T:F_X3FPEG5dVyivJIfn6MEYrznQB1wq0rN9_0M1A03L4','2024-08-17 06:35:53.109347'),('cp6hgt8nrc3s460ey823btr5j4xcnj1l','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seV64:KxVpxAcDQhER8SBd_wtT1sRXcg66oIIpO7qJBAUp0cE','2024-08-15 08:40:36.678783'),('cs5x4ik54829ugha1u9iy9a6r983gzis','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seV66:uCowdh9xDTeXwjNFp0iJdpTg68AP8CkmZ0J96qf_zfw','2024-08-15 08:40:38.404391'),('cuu8ue7zon4n1t17v9m7okwah8bt5l9a','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezxu:vimneN6wdpTMQnb1mImXtTgO1LBKWWNZLKePWLvkvbQ','2024-08-16 17:38:14.977260'),('cyeu14jjmrg3v0xdf6aubu7tq6kxbikg','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seVDh:dXV-PzdRVz2161Y1TZNkTD2eoUMqrkHqzpWovVTXji4','2024-08-15 08:48:29.215336'),('cyyq6beu1ei5in1myd6aeaxopfqhtxid','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBh1:3IxOSy6ArCi6RY1SNaIFSxVWi_bmn5lTQl_y8ZRqiz0','2024-08-17 06:09:35.408208'),('czstmyidug75jxa587oy3gotb4e3cftk','.eJwNxk0KgCAQBtC7fOuEAknzMjLq9EOR0Yyr6O71Vu8BNV3jzXLVUzgWUkJ4IEraBAHScmYRdNgkHnXZToShg9ad_8GWsfepjGZ2no3NORnPlP75uVjH00QJ7_sBSy0h_w:1sf09f:icfjSie0k74swjUDwsthORjQ8REMaPsv1wGXwL_3f5g','2024-08-16 17:50:23.855520'),('d1ram7syfhh1tcpk4o07l78l3qq0gcyw','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezwa:Y2JOekiEY9Q-9QJSZrF8bH5iRvW144fR9bDI_w707bc','2024-08-16 17:36:52.028676'),('d9uu48in5rc4a8lv73w0k8q2mfhkjjw0','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezpP:1RKj5M7VLjHnv7fVeRH5z1NoyARu5kXo39XpqXInK-8','2024-08-16 17:29:27.970982'),('da6odre3dntif444uc1n6rui0o75fvtz','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCgi:PvoO0yHAHTxQ3DC-p5IFm4HKz5V7GloyrIaugOMIHEc','2024-08-17 07:13:20.343328'),('dh1ciszpdr8ea2ksncjtimnbboq8saf1','.eJwNxkkOhCAQBdC7_LUk0JRGuAxhcogdMVaxMt69-63eg9hlC3flq51cQ4kS4R-wROkMD-45V2YM2Dl827qf8GaAtKP-h8nMJY1LUcuHSJEes3LOkpoKaW2dyckmvO8PM6Eglw:1seD6e:AeXobz52wHWwN3Lbz5Q4z_4oh8LRUOMiLzXXZWiOg20','2024-08-28 12:28:00.558305'),('dmmqjap6bap5vh1whyj2sbf6msmo752h','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfByj:JyrffPAoHhTs7s1D3ixgK0qtdnsdiK78-ngR0vRw__A','2024-08-17 06:27:53.113799'),('dmxl5l4a77gmo91o40mqlzhhr5tlxrm8','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCFB:ajcvrFOye1EQArhsELGAi2AMXzSllkEsLVf0aECNz7w','2024-08-17 06:44:53.104646'),('dxdmyib8tovgzlusgb5eftlevlb1tgdr','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezui:xOI8GbXOQfRsCFD_3AM3CaAwTBwKh6yWZ1WceXDkbiw','2024-08-16 17:34:56.597677'),('dy8gy7kewrpjzt32ekiw4iese5ocz010','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCXZ:sz-or6K1Pol_kkZ2SoQTypAkf4LqmWDzVRvMM3Wuxt4','2024-08-17 07:03:53.119961'),('dyz4lfcq063hi2wpv8xqucc15f8ewkf3','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezhL:_F6D5CVI0PZX_iZqW7husH1UfC6XYZqEirr2c_kgTEc','2024-08-16 17:21:07.847119'),('e5vvht5grtod576fe6gx08craecwmokk','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDI3:KjQMP8TlAFYg2u14JBu3lhvGR2Z6XqQPe8Dyz-lAYh4','2024-08-17 07:51:55.419841'),('e65sydp3oyp9bnmtwrag2jycw8460j90','.eJwNxkEOhCAMBdC7_LUkCkQmXIbUWh0zEzG2rIx317d6F6jZt5yiR91VykxGyBfUyJoiQxuzqKLDpuVf121HHjpY_ck7sPjAYfaOYvIuMkX3GQfv-pCWNxLSNOG-Hze-IL8:1seD6r:UuSdk22kgzQikMyUWPpXHa9Zl3FqVuxRNYheZs6yzds','2024-08-28 12:28:13.532762'),('e6jhhxqbi66rm590zrslcx7yl0mjp32p','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD73:pWQcjXhmXQwNQx1i-pWsDL-cH7RudBvqHc-od8cgw2c','2024-08-17 07:40:33.259672'),('e8c41vmf3embidwn27ly69vewh0edsq2','.eJwNxkEOgyAQBdC7_LUkUhUDlyEDDK1pI40zrIx317d6J6jrJx4s_7YLx0JKCCdESbsgQHrOLIIBm8Rfe287gh2g7cvPQLVOvmRnShrZzHn0hhabzGut3lm3JkozrusGTWEhiA:1sf09L:2EhDkdvaayFp8YiZ5a6OuRypcB2OgdtopzoLMvS0-w4','2024-08-16 17:50:03.102321'),('efb1f587018jy872tdw6kuwexjlq1ok5','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDQl:Fe0lQwMbyTZS_lWjwURrg7aG9FRTAvBhDOFCi8ddyFM','2024-08-17 08:00:55.412449'),('ehzlrb2rk7c1sy2cz0higuyunsldfab3','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCJ3:ncndUx_OZLf-GzPX-mpW7nRT36YRjyfIugTj1OKt4YQ','2024-08-17 06:48:53.107296'),('ens7fplreuz1yjlm6cbum9iu48nbe14t','.eJwNxk0KgCAQBtC7fOuEAknzMjLq9EOR0Yyr6O71Vu8BNV3jzXLVUzgWUkJ4IEraBAHScmYRdNgkHnXZToShg9ad_8GWsfepjGZ2no3NORnPlP75uVjH00QJ7_sBSy0h_w:1sf09i:JE2cSpxlmd2EN7ba4GGmzUwQIaigOYKDP8QYahNW5Tw','2024-08-16 17:50:26.016705'),('es83kj16urhw4h2wckxks6k9l92p1tgk','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD57:Y6YFcQg7UoNLb-5ffVelh4y9b-7_zPqKXISrKcApjQc','2024-08-17 07:38:33.265011'),('esdjtv91fdai2rams16p7xbt3fjt9yvg','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCQn:n8hfCd-hIi4xBbwu0T5KQhHHSyQsZMryKzCC4roEI2E','2024-08-17 06:56:53.114178'),('f5zq0o4a4qj9uknx7yblcula0nsavx5q','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCI5:69paYyu-Mgr3aoxijF24ERMncWJgEiY9jFe_X3ek8Rc','2024-08-17 06:47:53.106650'),('fjmui3div5iooem513fre1kocdomrhwn','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDPn:juXC0wEBz4yLO-NiAlsrcQnBDdWLsWJQ3P9VawVx6-Q','2024-08-17 07:59:55.441970'),('fkttgkq6yayhl7o9t4iy4vnonrrjg2tv','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1seznl:z-_lXcWEj2UlIabsPH-R1u5A5mtXiIr5KLAIY6SrnZU','2024-08-16 17:27:45.733125'),('fnqhx816q7ksclbc6vvp1nkyyrbes420','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTBF:hyWH6f18uKCN17WHbC2A8TAUKf3B5NdRuWGzqE6KC2g','2024-08-15 06:37:49.944811'),('fnvz8mzfryj7prixtgj1jboeieze6925','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezwa:Y2JOekiEY9Q-9QJSZrF8bH5iRvW144fR9bDI_w707bc','2024-08-16 17:36:52.023888'),('fpsdcv9n5ek158o8gq0vn2cdydtx8q7u','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCWb:4BxMrvAZEWDsqwHK3xUgT0p39D9eorSzQBQE21b_KnE','2024-08-17 07:02:53.109857'),('fu93qlkpgurpijqivneugwmp621fsxtv','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDH5:rAGQuQllgDQqUngnmbVSMaMzIA-vGlQJVDt9EdqDrfE','2024-08-17 07:50:55.414014'),('fxodrq3xbyf83uwgbckotsmrc6hja1td','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seWQH:ggQdWY5XpvYghO0vrwbRgdCMVwDH8bZVq7YFxgyDzHM','2024-08-15 10:05:33.944113'),('ghlznv5x1y6ucxqyu8683e4v2rhld9nt','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seVBA:KxgbD_P64w7mQdlEL7Tfy7xCiiEDl0Mpi4JRrMVmUuo','2024-08-15 08:45:52.981750'),('gi5woenrg6w96mavqv4gbq3r10c61p63','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCtV:w39poaJGwLgjnfUdSJJLGpS1g1M-6dOKPwWht52mbGY','2024-08-17 07:26:33.265920'),('goc7qthuvhaxgnuxln8jkeyz1tu9gxg8','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seVBA:KxgbD_P64w7mQdlEL7Tfy7xCiiEDl0Mpi4JRrMVmUuo','2024-08-15 08:45:52.981750'),('gpakl3r5gu2pcujflop5th2i8rpyg9w6','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDYt:wDVOpBHneh7BWP4ChQ4qNA3Wk2Zl760QLfEmIASwq6Y','2024-08-14 13:57:11.849095'),('h0i8axcfihqgsi4xzg6f51lty5tdt6pm','.eJwNxkkOgzAMBdC7_DWRihLIcJnIpGZQK4Kws0LcHd7qXaCmaz5ZjroL5y8pIV0QJW2CBGmlsAg6bJL_ddl2pL6D1h-_w0BhDmWOJvZuMC5M1kz88ca7SMX6cXTW474fNwAghQ:1sfAad:uKFUVgsiM88eseEKht1V5q54DynTs6pRBe22ok9xfdo','2024-08-17 04:58:55.100393'),('h2gjnc1hvpfz97x0rtkwrj8el3dl3owt','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCAL:Q8v5F6yxhGJJNjwmG-mECw7f-PHrPahRbrBnw5oLnng','2024-08-17 06:39:53.117401'),('h51fx2owcoslu7g0tdgu55nbjkerani5','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCMv:t0MK5XBCYmw-QPX66VwjGbl-IuO9j2x3PwIYU4m8q38','2024-08-17 06:52:53.114874'),('h5u6egnxqs2s49ut5ux6ciso36wbrjje','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezkS:nJgzqeVy5H5cbEPsYwEz2tbLqdMqikhILoSEhtnajpc','2024-08-16 17:24:20.022666'),('hacdy93j424gi2wsw4kxkg8s3qae6758','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTCP:6qt8fWfUxIW9Pz943GW3Wbv3RkuxDccdndV9kHjs22A','2024-08-15 06:39:01.126207'),('hbb7w40c40mkk8tixpzzeleaz70enags','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezpP:1RKj5M7VLjHnv7fVeRH5z1NoyARu5kXo39XpqXInK-8','2024-08-16 17:29:27.973584'),('hdjxgs5rqeqilhjdueas17tzcg16zyh2','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDRj:7kZ1UH608YJGmHgWXGnprcM81cxm3--p0FrWUw-wDlg','2024-08-17 08:01:55.427667'),('hdzcfhewdmwbat4kq7jpaagss1quiiph','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC3Z:J0L4UUHwdMMB4J2q6QEiq7pqJ0YQA0kpZQoTfcPWeYM','2024-08-17 06:32:53.097074'),('hjs3l3gp5cvv1sekqhsbnpgx6ux2ihiy','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTpo:CKhQWPsPdXgAIvaz5QOXQEXTPUkzCbOURCVI49Fk7Z4','2024-08-15 07:19:44.999739'),('hsxmxoatrcyhox9zbdszgoa6wx4j6ktf','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCqi:MCF4u5FPGTlJRx6S_8pl7cd0klG54hnG1YfovZb46N0','2024-08-17 07:23:40.642400'),('hwl1kmkkjm7kjhybecx0t24sirehn8fw','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTTQ:9L4rG9Xa5gok-IntNlmKTUerxIfg1f_L1UdFdiPoz7c','2024-08-15 06:56:36.517827'),('hwxcwzapmr48klm1f17oac30s8lqqety','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCyL:6ZP6EFawP_Q-2SwYlaLxMk6lUtze1NGbvVGqaco9KP8','2024-08-17 07:31:33.263392'),('hy62viuhp5i3k70vc0u9o20bv5q7uxaj','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDUd:oEP0sTOyBJ6QTCjPO604quG-sRI_ywKSHW-6eI_VkDA','2024-08-17 08:04:55.431248'),('hyeqgpawgef3ot9qigw0uw1y87jekqyq','.eJwNxsEORTAQBdB_uWtNkFL6M81gBiH68ma6Ev_OWZ0bVGxLf9ZfvpTTQkaIN9TIiiJCyzyzKirsms687hdiU8Hywd8wSRfabhmdcAjOeyI3TDU5P_qGe2mlFsLzvEEKIWE:1sez4W:dWnc9YyKuq-P3kU5Ol3_6Y42BfzGwLjaJaUKDWV34xc','2024-08-16 16:41:00.969639'),('i7i9tabbxteue5750ye49fc127u6hql0','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDCx:eOlkl680Vf7bkQHNczWymASw8wmbkk1RQ_wFLFGhqKw','2024-08-17 07:46:39.050715'),('i8y9dkdxhd12u5jjd8vqvfsrodj0mhgf','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seWPR:OIJXONue1efYcUzY2-2w0PMQiW63HJTmzzvWfVF3xxs','2024-08-15 10:04:41.904203'),('ie8m709ouremh7ymqtsg0art0ulcf87h','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDM2:YSji9StVVAB387winHqFbLfZRDeHheY2-fkzYH88cTM','2024-08-17 07:56:02.427443'),('iw3ubdpyn6u34qm4pwt15tyn1yk2ath3','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCG9:-U9kg793z22Vwm4vkOoab5BG3IjcWeKrHi6UydqjsvA','2024-08-17 06:45:53.113218'),('iw4ggnj3nu2q127rq46w94vcx1qkup5p','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTmr:mTgaZS2NNzU47NzvHY0xUThoNbdi2UlsdUK085aHKOc','2024-08-15 07:16:41.886153'),('j53kvuh9y4nxlokhyvlja95wiekffb20','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDQF:431k7i1wM_1oCuXwJMMKwRTUySeGeAy5zNcnpBeQqAg','2024-08-28 12:48:15.110735'),('jfxt9xxdikdgarq0yrhfo8sm1rzs2374','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezxu:vimneN6wdpTMQnb1mImXtTgO1LBKWWNZLKePWLvkvbQ','2024-08-16 17:38:14.981777'),('jh27n44ah6ws044pk4nsizrskv8i81e1','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCrw:A4lh4t0M81Fkrd06Y6WX9y2KlT7znpckqjjNmfukJQ4','2024-08-17 07:24:56.820892'),('jiwt4z7ib7hadebx8jdswtfwe78hdxyp','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCZV:ikbcT7vXUZWXOJn1L6Oel78PKi0GnWs9CMPFP6UtrpI','2024-08-17 07:05:53.116223'),('jjk9myrbzay7mabyfvpwdid698nn2vf7','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCSj:IMyHdGJoxM_oVgfKJC1Zvy_d317rzKSSRqNC9H4jcng','2024-08-17 06:58:53.104570'),('jl9qkn0up9moln4pr7rwaszeku3rma3f','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDK6:EWGYjN1C3RTEkTlWu5lrF7Us2nZ-GcqXug6W_U2KT_M','2024-08-17 07:54:02.424593'),('jldx9p0jat7b07sxohdh0bbv9n4so8mf','.eJwNxjEOwjAMBdC7_LkZIoxa5zKRkzhQgRqEnanq3eFN74RMf-av2mccprmJC9IJc_FpSLBZq5phwW75PR77gRQX-Hjpf7hRYe6lh7quMRBTC3zfJEjl0nWjRrHjun5AwSF1:1set0W:jQmrxqRv_Y5zfJ-cH7n9k0kSBJLgt2LLkrVs2-Pf0Wc','2024-08-16 10:12:28.782779'),('jrtjr379gghtotp31f8mopoqh4ssiayg','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCTh:hNYyZXH565euR0PfvnoSuTpu4ytjUS0v9NPZ9vww2l0','2024-08-17 06:59:53.107367'),('jx51pg63y6gwnq4txcb40stkf2xi7avs','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCrA:oDnCU2l0AXPqQGEQSs2n_U7Ye7hI2Yrd8_7wb8lZhPY','2024-08-17 07:24:08.658362'),('kbevvzbznzfqvg6xxw63a0q9r6w8beic','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCCH:R7ZmjAhZYiy2Q3ERpbQYZVm91gfW8OI-0OHBy6l7ufo','2024-08-17 06:41:53.106087'),('keritactak8xiwlogaz25y0gejti6okr','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC0f:LJ2AZ-jicTwYhicBsyUcLZR88R0m6cX1518rjrIGkS8','2024-08-17 06:29:53.097815'),('kj7dlxeuu7n1jua0r8gm0nu6fcyny8cz','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD3W:P-GacF5bPt6S6znWTCDUt-j13x_eoo8HHDbzWZkwqrM','2024-08-17 07:36:54.355515'),('kjsqltj75msdc7lso2x6uj723kyo3v23','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDBt:15iJwt1un4_xZTPCtf_-OvrQjF7k4mc-kIrje4rIilY','2024-08-17 07:45:33.246306'),('ksbdmee1xjrs1w06nkpmdn1ij7mij0vi','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBqz:__2BW5Nhgb8MxLlDOoxiBIPgfidOl4xbAsWMUQSjE2c','2024-08-17 06:19:53.108290'),('kxbr1od0ur5rawi4edt81tvwbuvpuezl','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCDF:Ou1epSVKgNH21BI4-aFB8NnHdEHLX4bYvTHZ15wRjtg','2024-08-17 06:42:53.096800'),('ky9roe3ojiu8o0r3960pwmya8pgbnnpf','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDEn:rIo8l56MaHlx1imowJfEFd_S_4ValsHTwrXSzchnR_Q','2024-08-17 07:48:33.421097'),('l4rek81cq2zkzuf3qxl2ex8r9vki67pj','.eJwNxkEKwyAQBdC7_HUEbaoGLyOjDq20xNIZVyF3T97qHaCp7_xn-Y1dODdSQjogSjoFCTJrZREs6JK_49V3JLdAx4fvYQ3kgyNvIrdgnqFuhqK1ZvPNNnqshV3BeV4zOyDt:1set1h:6zA0MAEKZ4PyG2noYK-1g-Xy0kTpMYq5If3VYmQ9B_A','2024-08-16 10:13:41.885411'),('lalrgexsebr5s897cmipf8odo4mdbqff','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD9L:_McRhLoXHd-5TCjrosxTefi3UYs26AcX51Kgiy-cwTU','2024-08-17 07:42:55.428786'),('ld5nj15drydrmg6aqw7dbobisbetpw9i','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDIq:eFBLbkIGLhYlDlY6bf9B0iFnLVssBPNEYR2dHyIN65A','2024-08-17 07:52:44.196339'),('ldd68iz00nzoiojtkfcu5z8hto3upkn7','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezzL:dw1tSECUyx-B5_EILHNNqmlNHyLJgTJDEzS6a9xxo_Y','2024-08-16 17:39:43.614900'),('ll62b0l51phlu38eshk5g9lo1kcdj1wj','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCdN:8zpyiMeStyZ-Sj0e7SVXXssi0qXulL6kGLuk2FPrV0I','2024-08-17 07:09:53.130481'),('loyshd30gy002wud23fyzmukpcbmr1zn','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1seziv:14lcnxZcMj2UzTfSkoJuFAGvxBXkRFR_GqEdA29FgdU','2024-08-16 17:22:45.579294'),('m0vh3q4bnj5h6493wfaamhsqcz0z5k0w','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBo5:klUn9fwAqxoohEnRGsaoklELfYgULxvn7DItgVW_jII','2024-08-17 06:16:53.107581'),('m4epxcvbg6vigynic6b2cffkwo7299xl','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBkC:v9B-ssXfpwTxWIoaVzYbHOYikgzeVbWLPudAf9Uaztg','2024-08-17 06:12:52.424826'),('mkyxpqgg68ni7etv567aohacmx4lcipl','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC1d:6OYxQ-cwumhW9S36IJMne1-6h6KoegIbbmq3vtUVs4k','2024-08-17 06:30:53.112379'),('mo8fysib5xhr681xjepfhvzpegn0oqot','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCeL:nwWTUNIu_yrRK-pXc5tG159hdYJ6nqDkHoYkHcPLEmY','2024-08-17 07:10:53.104496'),('mpz8ju66iayrfls4yy2ct9qjw2odl7gc','.eJwNxkEOQDAQBdC7_LUmqGr0Ms20JghRMdOVuDtv9R5Q1TXeLFc5heNMSggPREmrIEBqziyCBpvEoyzbidA10LLzP0yO-97Z1tAwWjPYxCYlT8Z7dq7t0kQ2430_LssgwA:1seDEJ:trJSpOeEz5vgYJfzqxwlqL7JFaInKUlUlwsPZU9b0GM','2024-08-28 12:35:55.400528'),('mth30pcvj4z3fastr3n1jta92xwhlvje','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCgH:Qb1VfDK6ONEYzNqh-C_-vxsvC8IOIVlJM2A07Ia9GD0','2024-08-17 07:12:53.111179'),('mx4c10q79vld6lmhsycuqkk09pnrouni','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCYX:I_w5J2ASZfkVla_7c_UKxPrEU5ixv8TN7KfTQyZ6x6E','2024-08-17 07:04:53.132494'),('myrmbey376a79tcd3xigu4g1amgadqxu','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTEY:cBUnG2vaX2enSBJBQk5BczCcd6K6Oy1xNaxNaZF8QEo','2024-08-15 06:41:14.782234'),('n0hgxik8v4ibri4e28v6rddmp0acphxs','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBur:bDJQluQBqFnhVbvnOPk9seXydfT6vNf8Vnn_Ib7Dy64','2024-08-17 06:23:53.111229'),('n0nahmfv68u4kdxcpv3qp2q4s185q97q','.eJwNxkEOgyAQBdC7_LUkEoVULkOYYbCmjTSdYWW8e_tW70IZ9sxf0U8_VXItVpAuqBUbigQdzKKKCYfmd9-PE8lPsP6S_0CR4oPJO1nn4Fby7Kht3i2xhlbbEjYm3PcPQ5ohiQ:1seDEe:3Of1jpHj0W9cOcdf5xu-MANA6B9he5lGK4PtHFtbK4s','2024-08-28 12:36:16.949298'),('n3av314mi90z2fux0mi53u1fik136ujb','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDcT:0kJZBTWYpiGkV2Q5Uu6NmXMgRCS2JrAJXS7e1lJ1Nnk','2024-08-14 14:00:53.735161'),('nj6r0o9czy2amds89epep6aqlk2t6q09','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCBJ:U2ke8J-c2XzcTTFB-gYuWNEFg3A8hS2SAW0i2kiEX8w','2024-08-17 06:40:53.103184'),('nte9s10spsx5dv7o47porfva61eys3u1','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCLx:RBEsVS1YJ991iAsovBha4evzNAHX6KL0YEstBmdD4J4','2024-08-17 06:51:53.108587'),('nu8fu78gy73pzn6gk2yzmknb5fjynvfo','.eJwNxkEOhCAMBdC7_LUkqDgglyEN1BkzRowtK-Pd9a3eBWr6SyfLUXfhVEgJ8YIoaRNESMuZRdBhlbTV77oj9h20_vkdpjIP_lO8IR-ccdb2hpiL8TRm60IOCy247wc0-iEv:1seDJp:zDQjgUW8FnDIpu16SbnZMjuP8wGh4-YNEZeagKJuics','2024-08-28 12:41:37.788158'),('o3ulc47co2xqhz3asq0f8xqgh35d4fmt','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1seziE:dY04bOSRkpeQWNrMbhd8DnkWJLM342h_9OgOtdT22ik','2024-08-16 17:22:02.795575'),('o7xrffz63zahtnghbph4skcsx26l463k','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1seziE:dY04bOSRkpeQWNrMbhd8DnkWJLM342h_9OgOtdT22ik','2024-08-16 17:22:02.787460'),('oe8znee349uh4l9sgaby698rdef30kc7','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezhE:0PBJRUdll4nDFXuF4uJ2ErmrZNlm_OfHqKJDXwV3G28','2024-08-16 17:21:00.732874'),('of5ecu92yv533rwb7axzutlrt412fhs7','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seVF4:bohl2JiN39NLdURcLpeFn5hznybx2599yMlsFHw7x6g','2024-08-15 08:49:54.673581'),('oh5mtj86lblw7m5lv7h78ouf0qt7wlso','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBzh:B9ASCzNGCZo475YXu_G3TsrzEb0J0GBcEthsK5wUlLU','2024-08-17 06:28:53.121672'),('ojfwhsn8ycy2bmnh2fuv1bxo3qq6xncn','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDAv:mCItpxcodP3J6lz2AeobgIRzMdPAlPHovGYxXRER4ps','2024-08-17 07:44:33.250140'),('om90l6eon5c2ukwvs02cic8tzn98kq1v','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCVd:OWubcFbwyQ0uonTW8EI2WUe7L6EPRqASh1Wtmj3fU_4','2024-08-17 07:01:53.120870'),('omuz6lnwlp3is3l7z5nyqzttip5kf46s','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTCP:6qt8fWfUxIW9Pz943GW3Wbv3RkuxDccdndV9kHjs22A','2024-08-15 06:39:01.128713'),('on4blevdjlrrv5o3by6pejjywdcbokcy','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC5V:G7UIXtoWr1FhRVi1SJGhSLZiutlsLe7LvifGbMw8R5k','2024-08-17 06:34:53.106487'),('opa916gmvap31o1xfxv2kmxyxoixhozc','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezui:xOI8GbXOQfRsCFD_3AM3CaAwTBwKh6yWZ1WceXDkbiw','2024-08-16 17:34:56.601205'),('p4pqliq8qhpepmrmbjb1es1fhvvnxewe','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCxN:CEXVjxNS-3xQFPusEEtuwVyaM37LRg6q1jJFI6lMC1Q','2024-08-17 07:30:33.277122'),('p9z2fqqg1gf8lmr0o2bqilwrnha35994','.eJwNxkEOgjAQBdC7_DVNgKAOvUzzO06UaKhxpivC3fWt3gH2eJav-aftbuXOIPIBD0Z3ZHhXNXcM2Ly822PbkacB0V72H2qdb5UT05Uz0yKmiaNoupipjCKyLivO8wdKyyFd:1seDL4:Kcfm5ER4fAdqqLAvRExGcUToW2VQLpAz899cyAfNYGU','2024-08-28 12:42:54.289460'),('paig3bq7ywvbu4x55zpxgbx7vrtaawz0','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBwn:6GFamnlxyTZDT6YK-0fqs4lCS7hQEtsUiD6hUFXu8vE','2024-08-17 06:25:53.117797'),('pbd9u89cuqg8ys7yzsdg08s0d5s32exn','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBfW:OywL6g58ZVbHrCxjaAB4913MaeSZYw0ZgHd0V9yxl0U','2024-08-17 06:08:02.238736'),('pc40to84eml3vs6oq6awx8jshpnp3cbp','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBl9:enVv10YHAuQQU9L6E8ilZwaPudP6U1swiLCjGB9jR3s','2024-08-17 06:13:51.763784'),('pefjhmiihwb1dqzi7zait65jdf8bxm48','.eJwNxkEOgyAQBdC7_LUkgqZWLkMGmWmNRprOsDLeXd_qnaBm3_Rn_dVDORUyQjyhRtYUEdqWhVXRYdW01896IPoOVjd-hl5Epuyz4-E9uDFwcTMJOR-yFwmlf00zrusGSwMhiA:1seDAV:lT4jktoH28cP-hVbLdyRCB9mCXOxMc4HhQ9-VlXCbeQ','2024-08-28 12:31:59.557402'),('pf47didnqo6o5hnl7p17qbkpabyqhe30','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezwV:AitosDsXCd8EP7VYJtv_QRMIA8Q_4E5ScD0u4dkjjrU','2024-08-16 17:36:47.234321'),('pltw5o7re8lms5j06rz4is8sfb8qq787','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seWQH:ggQdWY5XpvYghO0vrwbRgdCMVwDH8bZVq7YFxgyDzHM','2024-08-15 10:05:33.943604'),('prebg9sqjcx9h94l9hv2z5tagda31vxo','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCOr:Aj70Ggj6AGAXChyUE4DFpfupcb5QLymhZiLy3OSU5p0','2024-08-17 06:54:53.102624'),('qgjbxol3dritbobjmie5j7yvn30ztcpb','.eJwNxkEOgyAQBdC7_LUkBaUolyEDHVpjI8YZVsa7t2_1LlDXTzpZjrYLpxcpIV4QJe2CCOmlsAgGrJK-7b3uiHaAto3_w9NP7HwIhhY7m6mOD5PHXA2FulTnbS6Ocd8_MOghAA:1seDEJ:H61DRkznXscDC31CF_UnnYn-m7tf9G5UtvFspG2M25c','2024-08-28 12:35:55.419811'),('qmdwc17xit9wf9y77vs45xwjm7poqx3b','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDJ8:h-GILK9DzL8qwOpir5ZRtAKkrBVZEu8vhiOmXYQuaxU','2024-08-17 07:53:02.091064'),('qmlng330po2o1tf17ohgcflawypj4m44','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDct:ks8aE1P9gog9qJpE2QDcI1-kvBE7VOY9eWD-CPMHGQE','2024-08-14 14:01:19.390735'),('qquj3vdrygb06tc45b21uxh4th4chu84','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBm9:rUVRh8wEYJHedYuq1dXLiNSqJSHR0QMgDWnkWYGRP08','2024-08-17 06:14:53.113998'),('rddg9cu00gxxt2e1ri7085z0gzn0cdfp','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCED:rDRyntzfNg5JcaYnb_1huE01TLadCWq0HQl2WuOldfw','2024-08-17 06:43:53.111956'),('rgmqt6bat5kyhujsxr7orh9oprok0spi','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCaT:VXlgqzhaW9rhPoYsLr8lbSTNwu3k21lf-dGxjmkXyLo','2024-08-17 07:06:53.113081'),('rjdz87623xv2k2vaj196xur12yg40psb','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDJ8:h-GILK9DzL8qwOpir5ZRtAKkrBVZEu8vhiOmXYQuaxU','2024-08-17 07:53:02.085546'),('rq112uihjlrjunu2ru6mpbd6mm6ts5il','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBlA:_OmkF_pIy4ayHpMLLaDROV9oDtP1W4qKkAOtr5hGrF0','2024-08-17 06:13:52.944862'),('rqcnp17uvaae2f8n37ham4mp78s0uea2','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCi8:o4x1mXf42LvGpoD0PU8ILQgL9z-xXG_U0uvL71n5tVY','2024-08-17 07:14:48.299482'),('rr1a7ah9opveq39cbpumt74xln8gihse','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezwV:AitosDsXCd8EP7VYJtv_QRMIA8Q_4E5ScD0u4dkjjrU','2024-08-16 17:36:47.238329'),('rta7arazi8yrv49wcd6wlpq53hwuv3bj','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezpS:Y8g_0fFAsmd7w11hjzWCVU8cQqog8p5nMIZttwgVIzg','2024-08-16 17:29:30.694196'),('rxzxcoqu7bxlzrlfmd8al8wof00ohl9p','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezkR:B4u8T9HFg54oZLRcHW2AhooxNSw8aCeshHLbUZhsPdY','2024-08-16 17:24:19.997388'),('sbpu5qowlvtlmuix7wkpkelkaqc27omg','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCfJ:Bv0SXghH8D70hleXZg_hljxcNMM7qIvNmbZIvmuSff0','2024-08-17 07:11:53.111490'),('sh6ohto2thjw50l543f2ig2j2s2tay4x','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezpU:HiE2IIU-a_u2uqjZlNVqhbvIEEc45Dcr6V_FsIqXF00','2024-08-16 17:29:32.889931'),('sjfrbkkbgefccp9bfpf6xp05pagmh7ln','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCuT:1EuzBAbxdw4loqAYklv68SPt92ELZGt9XWylTfV69bY','2024-08-17 07:27:33.264898'),('sjy3rarhm3qrp99kz2vp943ucg2bxqej','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTLF:zhZ5bm9nQaV-xyC65qFYHB6Fs9EkmLtAW9_ts7F0qfc','2024-08-15 06:48:09.092595'),('skp8tl2qezydvbmfarsexf0jq6qo24l5','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDAJ:eIim8B4qzkk81r4QZXrQO9GtuS8LfnA7uiLqBSnC1YY','2024-08-17 07:43:55.434170'),('st7d6q5ivtsukw37qp3wzdvvz0e1bq3b','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCwP:uTt8Ol5T9pgPe0EzsM9VhkyGBiWRgoRt2nkxw83pfnE','2024-08-17 07:29:33.268721'),('t3vi3n7s01flyuli5wc1apdgst7u8ipp','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seXN6:2hoh_hVxf9zStjCq0LaCsJPivB6fiLJeBQ7P5VUpB3A','2024-08-15 11:06:20.857277'),('t3xeed0scedzkf87baliia51sqg7a9fh','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seWao:Xbb9CPpKOF3gTbGuekQ8myKl-m-X-9YGmeHKC2RQ8m0','2024-08-15 10:16:26.160031'),('tlzvz3o0djlufzvcbvhs18yzqikzo514','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCUf:rULTqG2InjuP4DSygvU45qJR4pd4Bw_WC2_ujdm7GqA','2024-08-17 07:00:53.113579'),('ttfqf1tj0ymm3hdko8bkowanucjylxqk','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCps:RL3ZQqbGuR3z-HYd1bUQzjSTQjXKc9UvfXfqzuikmuQ','2024-08-17 07:22:48.295342'),('tvmgytkjxkbrc158tjq6krnhzg55m2mq','.eJwNxkEKwyAQBdC7_HUEbaoGLyOjDq20xNIZVyF3T97qHaCp7_xn-Y1dODdSQjogSjoFCTJrZREs6JK_49V3JLdAx4fvYQ3kgyNvIrdgnqFuhqK1ZvPNNnqshV3BeV4zOyDt:1set1e:AXqWN7YPdFqe0C3sUtPlMNh-XDfz72qSuItONHRSDLM','2024-08-16 10:13:38.523098'),('twk4itx1yhsx4whe8zvr5ow5ofoc12ko','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1seznl:z-_lXcWEj2UlIabsPH-R1u5A5mtXiIr5KLAIY6SrnZU','2024-08-16 17:27:45.729115'),('tyzkgorhn9d9bycfhuattyk6bzvesgz2','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCvR:O5N_M_EuFsNK1X551Qdf3cY-htyjBAFvi_vrrcoqtbA','2024-08-17 07:28:33.261602'),('tz2o1qqnrjt6i54qx42zucxqrula3jox','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDVb:cerAtYcS917KAqZMiRWY_Otgck3gn4n3iwFnbJy4MMM','2024-08-17 08:05:55.442240'),('u0i4e34o11ao7tenyybsqu2u8wb3k83q','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCH7:CIEpu7kzDlhCSHgdw0_o6oSW-IOa9_Q_iyjmSUnODu8','2024-08-17 06:46:53.111578'),('ugtsd0n48gb6h7rji63gdei7npnhg0f7','.eJwNxkEOgyAQBdC7_LUknTpG4DJkItAajTTOsDLe3b7VuyDdvuks-muHlpTFBPGCmlhXRGhflqKKAaumvX3WA5EGWNvKf2DPdabX202BvWMRciHX0U0yZyYOwVfCfT8ngyBL:1seDAT:kc982Xzgs5j2Qf2yGiwRuwEwclcxhZaU7dN7VKwsGYM','2024-08-28 12:31:57.420885'),('uhnb59v22gvvl8in44f6wsip11l1cl3w','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezkS:nJgzqeVy5H5cbEPsYwEz2tbLqdMqikhILoSEhtnajpc','2024-08-16 17:24:20.023186'),('ui9odod9dlj7xm12xan1cnp0d14srd1r','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC9N:Pdc3P_MXj0yQcecSrFfI5HMcwCYsR6xcpurcGSbuniU','2024-08-17 06:38:53.101397'),('uleya19zoc41cniu8jlru4fievc4htft','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDXX:I7exOAu97cZ30Y5nMWKs_bm4aqO6q3OBypx_bBITQmA','2024-08-17 08:07:55.431302'),('uqp5vv2qycs4y6e1b0unxv1x5n9cuwe5','.eJwNxkEOhCAMBdC7_LUkMJYYuQwpCGo0YqZlZbz7zFu9B9x1i98id7ukxIWVER6IsnZBgPSciwgG7BLPtu4Xghug7Sj_wbrR5ey8sZ4XQ4nIJF_ZTLP1dR6p0ifhfX8xjiC5:1seDL4:ZXSW8P-MrU4_dNOQreCG5_fwo-lGWW7q37Qks6PpXEs','2024-08-28 12:42:54.300986'),('uyudtb9u8xt2929ois65rzeheye7qdpj','.eJwNxksOgzAMBcC7vDWRSGN-uUxkXIuiVqSqnRXi7nRWc4Kbv8pP7VsP0_JkZ-QT5uzNkGFNRM3QYbfyqdt-IMcOXt_6H5LwSusyhGEc-0A0zWFhoiATCydNMc4PXNcNNA4glg:1seD6g:K8BmzkpnhBDJHqSTDFkAIIVrsUbBZNWNHpnILB2hXOw','2024-08-28 12:28:02.862521'),('v46ihwkdeqgfgwqdpo4xwd3xhz25irbd','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBrx:UgBDE6XMUp4od9Jny9mup8pBQCHW90j7-2Bup90csZk','2024-08-17 06:20:53.104077'),('v4lrjdgmm8hzi8hlmy9ux4fh3xgr7o16','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBtt:QwTV9zeRN0l1cqda7SszoBDk8WqOv1oJtUIb10n7bP4','2024-08-17 06:22:53.118845'),('v506our6lu8lz2w70witqhs7qdclf78o','.eJwNxsEORTAQBdB_uWtNkFL6M81gBiH68ma6Ev_OWZ0bVGxLf9ZfvpTTQkaIN9TIiiJCyzyzKirsms687hdiU8Hywd8wSRfabhmdcAjOeyI3TDU5P_qGe2mlFsLzvEEKIWE:1sez4Y:ds_4OaZat8_SalrSBArKvNja94bsVjCvS9wa8B4ICM8','2024-08-16 16:41:02.134320'),('v6kxwc8kuqktmd5gqocrhmanej9ri4jc','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCk4:PfNnBE1S27aBeWvVn5OYS6hFSYX_byqTtvjk-SsXK0k','2024-08-17 07:16:48.298419'),('vakp0ydwo9cxmm5kjhu0oreg9hovigva','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDIq:eFBLbkIGLhYlDlY6bf9B0iFnLVssBPNEYR2dHyIN65A','2024-08-17 07:52:44.200346'),('vat16fiss5p983b9ecplyuho60uwgt5e','.eJwNxk0OgyAQBtC7fGtI0DpKuAwZftqaNmI6w4p4d_tWb4C7vuOvytkOqbGwMsKAKGsXBEjPuYrAYJf4ba_9QJgMtH3qf6CNHvOasmXnk10SkWX22TreqPjyLG6dcF03OF4hIA:1seDEg:lYkj0NLPAd1ILUgbMP6Z9NxEFD4BPHtQ-XekhUJF2ZU','2024-08-28 12:36:18.455807'),('vcmn3qc7f42xbozz4v5z4u2etjwosclu','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDBu:r7K7ZQKPC1aIVMueV99i4Rn_VdD0CdVO-686wiHtKmo','2024-08-17 07:45:34.855613'),('vgutsl0j7pdnx23u8k6pwgm4oijf662o','.eJwNxkEOhCAMBdC7_LUkEnAELkNI6cwYjRhbVsa761u9C6XrP58sR9uFcy1akC6IFu2CBOlELIIBi-St_ZYdyQ7QtvI72JnnQCEYRy4az9NoYnXfd3Hk6u2H_IT7fgAyRyCw:1seWLJ:RA8TZzXrB9wkicIAh9Zr4YKHoq9I94AOQyxOIuy70kc','2024-08-15 10:00:25.732069'),('voj08ybchis9a0cdrpebm4hzbn27q1g6','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezxe:xs5Jk1yE-Otf9-gLEok5Cs0WY0QENJ96tNLi45Nd0ps','2024-08-16 17:37:58.265052'),('vz7s37sogge98bkll0uyv7w8ymb8qokf','.eJwNxkkOgzAMBdC7_DWRihLIcJnIpGZQK4Kws0LcHd7qXaCmaz5ZjroL5y8pIV0QJW2CBGmlsAg6bJL_ddl2pL6D1h-_w0BhDmWOJvZuMC5M1kz88ca7SMX6cXTW474fNwAghQ:1sfAae:4hCMHb07UjOcUgMEiaBmSgW0iGDymEHqlGtem1uw6cM','2024-08-17 04:58:56.625680'),('vzalxg1a5ejc5byvd3z52hnyug1l103b','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfC8P:k-OK6s86O-ZHDvEslUL2uh5Uic1n-cPZ69WEDsGDMus','2024-08-17 06:37:53.116916'),('wiu18v1kjn15z2u9f0dyqvt0ng0pazm1','.eJwNxkEOgyAQBdC7_LUkRVCBy5ABJ62pEeMMK-Pd27d6N6jrJ18sZzuE80pKSDdESbsgQXqtLIIBm-S9vbcDyQ7Q9uX_UL19Tc7PJkyFjbccDC0xmLFEt9hYHM0rnucHKhMgcw:1seTEW:EHR9ls8vCswvlTEAtD7vVXft4Vf3X-Z_odRAnkrmhSQ','2024-08-15 06:41:12.024899'),('wmftnx9zv3c92eeakee7v7m98optvvrh','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfChA:dcI0JaiA0DksjIAvYZCIYsRfkfSxGSLkxVkoWur4kWA','2024-08-17 07:13:48.102855'),('wrub6u23b3zpmrnr8eqf1szszxzkokd4','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBsv:dpTFnIGA52oSjmMWElqM3fVVRqnjFSqg0iSNtk49dJs','2024-08-17 06:21:53.126678'),('wvipdfv7bry320zlpctun2f6hmf7qo5f','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seV6M:KfMHMqcb2yO1C47QZW05g9INfKzvnLxpE11rEDUXKqo','2024-08-15 08:40:54.623978'),('x1jmtmkahy96w0qe1jocrsky6ma9iz6m','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCqX:_JMR4RIkzKU_KWauxxd3ImAZCL8AFrVimGWoxLVFoPE','2024-08-17 07:23:29.602503'),('x61d5e44onli2hlfspt4zn2ug2vqi2sh','.eJwNxkEOgyAQBdC7_LUkWEdELkOmCNbUSOMMK-Pd61u9C9z0E88sv3pIjgsrI1wQZW2CAGkpZRF02CTudd0OhL6D1m9-hp7mZCfvjHd2MvTmYngYi_GUyI6LJ-YX7vsPK8MgnA:1sezhH:mCY0frnc0dPvKjroTGFy0kciowLs9xAlr6DonKP-unk','2024-08-16 17:21:03.692293'),('xal1dvyc4n11emd2njskwjfblfggc47l','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfChA:dcI0JaiA0DksjIAvYZCIYsRfkfSxGSLkxVkoWur4kWA','2024-08-17 07:13:48.106373'),('xewlhz2kkiet4tahisch64whin0ssu7y','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfBp3:Q4JGNv0FEC_cRF_E9m8btRCOGewtAQw6ewp_GFir27Y','2024-08-17 06:17:53.095892'),('xjukgqbigr1pzenm55d8ihmtxypr3h84','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDct:ks8aE1P9gog9qJpE2QDcI1-kvBE7VOY9eWD-CPMHGQE','2024-08-14 14:01:19.385724'),('xuntent05mbvx9ljpu0pe839wump226d','.eJwNxkEOhCAMBdC7_LUkKgiByxCsHTUzEWPLynh3563ejdJ0yxfLWQ_hvBQtSDdEizZBgjQiFkGHXfKvrvuBNHTQ-uX_EH0_LNGTmcLHGWfHyUQ7sqFIPXOYrQ8Oz_MCK3YgfA:1sezzL:dw1tSECUyx-B5_EILHNNqmlNHyLJgTJDEzS6a9xxo_Y','2024-08-16 17:39:43.612902'),('xyfhwbu9awqa5bdxmnuwo41tdyfi68ba','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD0H:GAL9N5i6j6EjorgrUYfWbABG742Vnl80eZxdChXJn3I','2024-08-17 07:33:33.254558'),('y0lzz4n354r0xcj045mv97azoiq9dfnm','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCK1:W31pm68UoeDiQAvUKBIE_9WqyQ-ADcI6uZs01vVlCAo','2024-08-17 06:49:53.111774'),('y17g9ut1u5y6k2s112g3ytcpahzjkqx1','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfD81:qe9k4oIkLh-04ykoFl0TiZ7hshCw3eWcH7DML_2cuLc','2024-08-17 07:41:33.454479'),('z86lcqvv3hkkdkop459vvo87rw2wkjun','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seVF4:bohl2JiN39NLdURcLpeFn5hznybx2599yMlsFHw7x6g','2024-08-15 08:49:54.674123'),('zaa4lscqp85nkv2ldqyjunkofs091o33','.eJwNxjEOgzAMBdC7_JkMhZRALhMZxwHUiiDsTIi7t296N6jZli7Rsx4qKZMR4g01sqaI0MYsquiwa_rWdT8QXx2sfuQ_jGHx78zsJBdynmVxc54GN_peplJCz0HwPD9SViH-:1seV7G:RheGaEAysbP-deWjs1FqKmku9h_9vzduXLwI7BsgvRA','2024-08-15 08:41:50.116881'),('zfmhncz8dpyz1x16eftax5q80424np86','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfDTf:AM6ygnjHSaRhqNiepZF2bL9FOMAIDB7f_-2eEHSAE_0','2024-08-17 08:03:55.430935'),('zglatmzm39umwaufdjjps1ycpypm8wmy','.eJwNxkEOhCAMBdC7_LUkYh01XIYUaNRoZDItK-Pdnbd6N7jZFn-i33qpxMLGCDfU2JoiQFvOoooOu8azrvuF4DtYPeQ_cPbUz0VcGj25MdHH8SLZlZ4HStMwsxCe5wU_syE-:1seD6r:ro3v_M6o15KB8rSkm0BmLDaWu9YxKJePYYHo_IOquZk','2024-08-28 12:28:13.518661'),('zioklhsy8s2ogf8md9je4ljwr200h9nd','.eJwNx0EOgyAQRuG7_GtJqFIQLkMmOFrTRowzrIx3L3mb792gpp98sZz1EM4LKSHdECVtggRppbAIBuySf3XbD6TXAK1f7oKNvI4c38YvzhnHPph5Kn1Db4pExVo8zx8x6iB-:1seDAV:U1bpKp9AsV0skitrDVylevLG95mQmKI_2-OoLDY2Upk','2024-08-28 12:31:59.546872'),('zm982f4j1gpmggtgah8xcp29rdipofks','.eJwNxksOhCAQBcC7vLUkogwolyEt034yEzF2szLeXWtVF6jqmk6Wo-zC6UtKiBdESasgQmrOLIIGm6R_WbYd0TbQ8uN34KEduJtm4723xrmpNSP50dhPmLMNrqPQ474fMnIgcg:1sfCsX:Qd_-lD0klxe1AZ11iZOpB-xhOMOaYkv1h2BfF2PNfFg','2024-08-17 07:25:33.080266'),('zvmi0kow2ut7ut5ntf35f8du54usf1t0','.eJwNxkEOwiAQBdC7_HVJFGoYuAyh49A2mmKcYdX07vpW70QdtpWv6KcfKuVZrSKfUKs2FBk6mEUVE3Yt777uB_J9gvWX_Afi-bEsrblITG4mf3MphuQiJxYK3rdQcV0_Oxcg5Q:1seDYt:wDVOpBHneh7BWP4ChQ4qNA3Wk2Zl760QLfEmIASwq6Y','2024-08-14 13:57:11.844573');
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
  `Illustration_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '插画作品ID',
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
  `work_approved` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT '2' COMMENT '作品审核状态，0未通过，1通过，2待审核',
  `approved_userid` varchar(255) DEFAULT NULL COMMENT '审核人',
  `approved_time` varchar(255) DEFAULT NULL COMMENT '审核时间',
  `approved_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`Illustration_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `illustration_work`
--

LOCK TABLES `illustration_work` WRITE;
/*!40000 ALTER TABLE `illustration_work` DISABLE KEYS */;
INSERT INTO `illustration_work` VALUES (1,'作品名称','65014220_p0.jpg,87328997_p0.jpg','admin','87328997_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','裤袜，白丝，萝莉','16','我的一个原创作品','2024年5月31日10:04:39',1111,'admin,user1,user2,user3',111,'admin,user1,user2,user3',10086,'admin,user1,user2,user3','ill',NULL,'1',NULL,NULL,NULL),(2,'第二个作品测试','96680242_p0.png,96026674_p0.jpg,97197111_p0.jpg','admin','87328997_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','裤袜，黑裤袜，兔女郎，原神','18','我的一个原创作品集','2024年5月31日10:09:02',111,'admin,user1,user2,user3',222,'admin,user1,user2,user3',222,'admin,user1,user2,user3','ill',NULL,'1',NULL,NULL,NULL),(3,'User1的作品','100213135_p0.jpg,100213135_p1.jpg,104705167_p0.jpg','user1','65014220_p0.jpg','ec6866d3-128c-4281-8fef-76beb6b29508','裤袜，白裤袜，黑裤袜，原创，崩坏学院2','16','我的一个远程作品集','2024年5月31日10:11:37',222,'admin,user1,user2,user3',222,'admin,user1,user2,user3',333,'admin,user1,user2,user3','ill',NULL,'1',NULL,NULL,NULL),(4,'user2的作品','118802535_p0_master1200.jpg,103168176_p0.png,100213135_p1.jpg','user2','65896618_p0.jpg','e661401c-bdda-46c0-b98c-eb4e019abf1c','裤袜，白裤袜，黑裤袜，原创','16','我是一个作品集','2024年6月12日10:15:11',NULL,'admin',NULL,NULL,NULL,NULL,'ill',NULL,'1',NULL,NULL,NULL),(5,'test','94296327_p0.jpg','user2','65896618_p0.jpg','e661401c-bdda-46c0-b98c-eb4e019abf1c','裤袜，白裤袜，萝莉，原创','16','test','2024年6月12日10:17:04',NULL,'admin',NULL,NULL,NULL,NULL,'ill',NULL,'1',NULL,NULL,NULL),(7,'测试','0368397051208955_p1.jpg,0368397051208955_p2.jpg,0368397051208955_p3.jpg','admin',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','连裤袜，,白丝,黑裤袜,','18','批量上传测试','2024-07-18T00:16:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL),(8,'普通用户投稿测试','3808381322275798_p1.jpg','user1',NULL,'ec6866d3-128c-4281-8fef-76beb6b29508','吃撑,黑裤袜','16','普通用户投稿测试','2024-08-05T16:07:11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL),(9,'jwt认证测试','6637378489955012_p1.jpg','admin',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','测试','16','jwt认证测试','2024-08-21T16:51:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL,NULL),(10,'AI自动审稿测试','6128101040587943_p1.jpg,6128101040587943_p2.jpg','admin',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','测试','16','AI自动审稿测试','2024-08-29T19:20:12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL),(11,'AI自动审稿测试1','5316451698800188_p1.jpg,5316451698800188_p2.jpg,5316451698800188_p3.jpg','admin',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','测试','16','AI自动审稿测试1','2024-08-29T19:23:24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL),(12,'AI自动审稿测试2','4889395955362738_p1.jpg,4889395955362738_p2.jpg,4889395955362738_p3.jpg,4889395955362738_p4.jpg','admin',NULL,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','测试','18','AI自动审稿测试2','2024-08-29T19:30:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL);
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
  `is_vip_chapter` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT '0' COMMENT '是否为VIP章节',
  `chapter_approved` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT '2' COMMENT '章节审核状态，0不通过，1通过，1待审核',
  `approved_userid` varchar(255) DEFAULT NULL COMMENT '审核用户',
  `approved_time` varchar(255) DEFAULT NULL COMMENT '审核时间',
  `approved_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novel_content`
--

LOCK TABLES `novel_content` WRITE;
/*!40000 ALTER TABLE `novel_content` DISABLE KEYS */;
INSERT INTO `novel_content` VALUES (00000000000000000005,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第一章：存于梦中之地','无边的宇宙之中，无时无刻都存在着危机，它们潜藏在深处，就像潜伏在水中的鳄鱼一样，寻找着机会吞噬掉猎物。\\n宇宙每时每刻都在按照着它本来的规则在运转，就像一个没有灵魂的机器一样。可是就在这时，本该什么都没有的虚空之中突兀地出现了一个光点，然后随着时间的流逝，光点也在成指数的增大，它慢慢地变成了一个五光十色圆盘，如果在侧面看它的话却观察不到它的存在，当它扩大到十数光年的大小的时候周围的空间出现了裂纹，那些裂纹在不断地出现，越来越多，越来越多。突然，还在飞快扩大的那个光点开始了快速地抖动。似乎是因为承受了很大的压力快要崩溃了，接着那个圆盘上蔓延上了许多的黑色线条，就在裂缝快要全部蔓延的时候，圆盘开始没说。我也，用1E－43秒的时间重新变成了一个光点，但是这个光点现在仔细看的话就会发现它是半透明的，似乎是介于虚无与现实之中。\\n这个圆盘变成光点后又消失不见了。\\n此时太阳系内，一颗名为地星的星球的空间附近出现了似水波的波纹，一个半透明的物体就这样出现在那儿，那个光点不知道做了什么亮度变低了很多，体积也变大了很多，也不再像要消失那样。\\n它就这样停在那儿，似乎是在观察着这个碧蓝的星球。一会儿后又从视觉中消失了……\\n这是一个还没有走出真正走出地星的文明。\\n此时我们的主角正在走在回家的路上，他是一个很普通的高中生，个子不高大约165左右，不能说是帅，反倒是让人觉得三人“……【想知道的话可以参照一下五河士织，（笑）】，爷爷因为癌症去世了，奶奶也跟着走了，在初二的时候双亲也死于工地，工地赔了243万，生活在城市边缘的农村，17岁的孙源玲和13岁妹妹相依为命。用的\\n“选定之人，请不要忘记你的使命”\\n一个十分突兀的声音出现在孙源玲的脑海里面。\\n“嗯？什么声音哦，选定之人是什么？”路上的孙源玲在四周看了看发现并没有人。“所以选定之人是什么东西？难道我又幻听了，但是为什么我似乎在梦里见过这个场景呢？奇怪，算了还是回家要紧，好像还有剩饭吧，那今晚吃什么菜呢，白菜似乎不错……”\\n此时孙源玲的卧室里面一个豆子大小的半透明的东西出0半空中……\\n孙源玲家是双亲在自己的地里面修建起来的，那时的他并不知道那么多，就只是知道爸爸妈妈在那段时间好像十分的辛苦。\\n“瑶瑶，今晚想要吃什么”\\n“emmm，不知道诶，哥哥你看着弄吧，我都可以的”\\n“好吧，哪就今晚就吃白菜炒肉丝吧，随便弄一个汤，去把饭热一下，哦！对了，作业做完没有啊”\\n“做完了”\\n“那就去把饭给热好吧”\\n“哦”\\n孙源玲：“等会儿记得把碗给洗了哦，我作业还没有做完”\\n“……，知道了”\\n兄妹俩吃完饭，收拾完后就去休息了。孙源玲的卧室：\\n“今天的那句话是怎么回事，怎么回事应该不是我幻听了吧，幻听还不至于这么离谱”就在此时。一个机械音响起\\n“选定之人……”\\n“嗯？谁在说话？”\\n“是我”一个半透明的物体出现在了孙源玲的眼前。\\n“你是谁，还有你是什么东西，为什么你能说话，难道说现在的可以都已经这么发达了吗”说着他用手朝着那个半透明的物体伸手过去，想要拿在手上看看。结果手却没有碰到那个东西。\\n“所以你是个什么东西为什么我碰不到你”孙源玲道。\\n“……你难道就不感到奇怪害怕得漂亮啊？比如说我怎么来的”那个物体道\\n“为什么我要感到奇怪，要是你想要怎么弄我，我也阻止不了你”\\n“好吧，我先自我介绍一下，我是平行宇宙最后的种子，我携带着我们宇宙所有的知识，虽然规则和你们这个宇宙不同，但是我已经全部更正替换过了，而你是我选中的人，而我就是来传递这些知识的”那个未知的物体道。\\n“可是我真的可以接受这么多的知识吗？我觉得我不行”\\n“放心我会改造你的大脑的，到时候你就可以完全的承受这些知识了，你不用担心，当你明天早上起来的时候就全部完成了”\\n“哦，那我睡觉了哦，我更你港（笑），我可是很怕痛的”\\n“……”\\n在孙源玲睡下之后，那个物体飞到了脑门心上空，一下钻进了他的脑子里面\\n第二天，孙源玲和平常一样，6点就醒了，可是当他睁开眼睛的时候发现四周的环境似乎都变得不同了。\\n“这就是你所说的知识吗，倒是很让人惊讶呢，可是为什么你不能留下来呢，真是奇怪，不过嘛。”说着看向了枕头边上的两枚戒指。\\n“还真是厉害呢，竟然是储物戒指还给了我这么多的好东西，果然厉害，不过，原来真的可以修炼呢，还直接让我拥有了在太空中生存的能力，按照你的标准这就是筑基啊，就是不知道我还有没有其他的能力，只是这些纯科技造物应该可以为我提供很多的方便诶”','2024-07-29T16:39:27','单篇完结作品','1','1',NULL,NULL,NULL),(00000000000000000006,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第二章日常，筑基','然后他就起床了，今天也是咸鱼的一天，但是似乎要变得不一样了，为什么它不可以在这个宇宙中长时间的存在呢？它的宇宙有事怎么毁灭的呢？我所处的宇宙会不会步它那个宇宙的后尘呢？\\n“唉，想那么多干嘛，做饭，等会儿妹妹还要上课呢，今天是周五，明天就有时间来试试我可以做到哪些事情”说着他就走向了厨房。\\n“瑶瑶起床了”孙源玲大声道。\\n“知道了”\\n孙源玲的妹妹现在虽然有了13岁了，但是身高依然只有1.4M左右，但是十分的可爱（具体就参考“白”的身形）因为银白色的头发，酒红色的眼睛，也受到了很多人异样的眼光，很容易让人怀疑是不是染发了，曾经因为头发的颜色的问题，小学的时候还特意得去医院开具正证明，证明了不是染得头发才得以继续上学。但是，兔砸的年轻人都是人均白毛控（笑）所以并未遭到嘲笑，但是却经常遭到排挤，毕竟不是所有人都是圣人，多少都是有些嫉妒的心理的。\\n“今天早上想要吃些什么，开水鸡蛋要不要，还是吃面啊”\\n“啊——吃面吧，为什么每天早上都这么得寒碜啊，稍微吃好点不行吗？真是的”\\n“瑶瑶，你要知道爸爸妈妈是为了我们……”说着孙源玲的手不受控制地颤抖了起来，他现在仔细的想象双亲的离去都有些离奇，所以他想要查查这件事。总是觉得这件事没有那么的简单。\\n“瑶瑶，咱账户里面的前还算是宽裕，但是还是节俭，我们现在都还在小还没有找工作条件”孙源玲如是地说到。\\n“但是我是永远都是不会去找工作的，我要自己当老板”孙源玲在脑海中想到。\\n“吃面是吧，自己拌调料哦，顺便也给我也弄一份”\\n洗锅、下油，来勺猪油烧热，来两个鸡蛋打散，撒点花椒（四川是这么叫得）在油里面，放蛋进油锅，炒至金黄，划成几块，放水。然后剩余的步骤就和正常下面一样了。\\n“瑶瑶，调料拌好了吗，我面都下好了哦。再不快点面就糊了”\\n“好了好了”\\n“哦，拿过来吧，诺：给你，你的面，客官请慢用，哈哈哈”\\n“唉，真是的，都多大的人了。”\\n“快点吃，吃了好去上学了，都快6点30了”\\n……\\n和往常一样，和妹妹一起来到了兴源中学这所学校。\\n“你自己在外面待会儿，我去教室了”\\n“哦，我也快了”说着就朝着各自的教室走去了。\\n孙源玲看着自己的课本出神了。\\n“哎，突然感觉这些东西都好简单哦，可不可以选择呢？等到高考的时候再去考试呢？”\\n“说起来我今天走起路感觉好轻松哦，以往走路脚多少都会有点痛，难道是因为我筑基了的原因？嗯，肯定是了”\\n教室里的书，堆积得像一座座小山，可见高三的学习压力有多重。\\n没一会儿，学校的铃声就响了起来，开始了第一次早读。\\n书声朗朗的学校里，但是孙源玲却不知道怎么的就是不想看这些书了。但是他还是跟着大家，声音读了起来。\\n没过多久，第二次上课铃声响了起来，这道铃声代表着全校的学生开始正式上课。\\n现在的孙源玲的状态很奇怪，他总有种冲动想要上讲台上去替代老师讲课。\\n或许他现在的个人能力可以说是全球第一的，但是他还是克制了下来。\\n“好无聊啊，没想到这些知识这么简单，那个东西还真就把它那个宇宙所有的一股脑地给我了呗。说起来我的戒指里面不是有很多高科技的好东西吗？”\\n说着看向了带在无名指上的戒指，很小巧。或许是因为戒指需要修为才可以使用所以才给我修为的吧，而且戒指里面的每样东西都有详细的说明，还真是贴心了。孙源玲如是地想到。\\n“诶，这个AR眼镜厉害了”说着就把手放在桌子的抽屉里面，把眼镜从戒指里面拿了出来。\\n“用意念来控制，挺方便地嘛”说着就戴上了眼镜。\\n眼镜并不显眼，半透明的，有些淡淡的蓝色，采用的是反物质能源，所以不用担心能源的问题。而计算采用的是微型量子计算机，可以说是十分的方便了。\\n“这上面都没有游戏的嘛？这也太真实了，不给我游戏抄。算了我还是去下一个三崩子玩吧。说动就动。”\\n3秒钟过后\\n“这么快就下好了，不应该吧600MB服务器也没有分配给个人那么高的带宽吧”\\n“难道是因为采用了类似于P2P的下载协议？还行”\\n登录之后，下载资源，进入游戏。\\n“嗯？这个推荐配置怎么这么低？奇怪。还是我手动调整吧”\\n“真是丝滑吧的享受”\\n……\\n美好的白天就过去了。\\n“瑶瑶，我明天跟你说件事”\\n“什么事不能现在说嘛？”\\n“嗯，不能现在说。就让你期待一下吧”\\n“……好吧，就勉强期待一下吧，我去睡觉了。明天见”\\n……\\n第二天\\n吃过早饭后\\n“瑶瑶看好了，等会儿不要惊讶哦”\\n运气，慢慢的孙源玲的身体慢慢地附上了去。\\n“虽然知道怎么做，但毕竟是第一次”\\n孙瑶用手紧紧地按住自己的嘴，不让自己发出声音来。\\n“哥哥，你是怎么回事，怎么做到的啊，好厉害啊”\\n“瑶瑶，你想不要变得像我一样厉害啊？”\\n“嗯，想想，当然想了，谁不想在天上自由的飞翔啊”\\n孙瑶的头如小鸡啄米似的同意着\\n孙源玲从储物戒指中拿出了一颗药丸\\n“来，把这个药给吃了”\\n“这是什么？”\\n“emmm，筑基丹”\\n“surprise！！！我没听错吧，筑基丹？在拍电视剧吗？”\\n孙瑶十分疑惑地看着哥哥\\n“真的我还会骗你吗？我骗你又没有好处”\\n“哦”\\n当吃下筑基丹后，孙瑶的额头上出现了丝丝的汗水。\\n“要不——你去浴室里面去，我害怕等会儿你会嫌弃自己”\\n“哦”\\n浴室里面，瑶已经变得大汗淋漓了，身上还有黑色的物质析出，但是似乎并没有粘在身上，慢慢的地上黑色物质越来越多了，花洒的水洒在白嫩的肌肤上，本来因为筑基丹变得光滑的皮肤变得更加的白净了，完全不似一个农村里面出来的孩子。\\n“这些黑色东西是什么，难道是我体内的垃圾吗？”\\n“为什么我得四周好像有什么东西的存在”\\n随着黑色物质流出，孙瑶的修为也顺利地成为了筑基的修为，本来一切都是好好地，随着境界增长的结束，洗澡洗过之后也就完事了。\\n就在孙瑶准备穿衣服的时候，意外发生了。\\n“啊!”\\n“怎么了，发生什么事情了”\\n孙瑶：“内…胖次被我撕烂了，内衣也坏了。”\\n孙源玲：……\\n“你先别急，静下心来，体会一下你现在掌握的力量，免得等会儿把门也弄坏了”\\n“……哦，哥哥你……你…你帮我拿一下我的内衣，胖次吧，在我卧室柜子抽屉的第二格，不许做奇怪的事情哦”\\n孙源玲：“……放心吧，不会的”就算是我干了奇怪的事情你也不知道啊\\n将衣服放到浴室的门口后，孙源玲说到：\\n“记住，要平心静气，气息内敛，气沉丹田，我给你念一段口诀你试试，毕竟你现在也已经筑基了”\\n然后巴拉巴拉的念了两遍口诀。\\n“我把衣服给你放在门外面了。我在外面的院子里面等你，快点奥”\\n“哦”哥哥没有拿我的衣服做奇怪的事情吧，应该没有吧，诶，我想那么多干什么真是的。\\n快速地穿好衣服后，就来到了院子里面\\n“为什么我感觉现在一身都十分的轻快的了，好像有使不完的劲儿似的”\\n“当然了，你现在可是和我一样都是筑基的修为了”\\n“呐呐呐，哥哥，这个世界是不是有很多像你一样很厉害的人呢？”\\n“不知道，应该有吧，我也是在机缘巧合下得到这枚筑基丹。在四周是不是感受到了灵气，试一下可不可以飞起来吧，这样我们上学就可以很方便了，而且也会更加安全了，就是不能被别人给看见了。知道了吗”\\n说罢，孙瑶就开始尝试了起来，只见周围出现了类似于热浪般的灵气浪潮，让人觉得十分的压抑。可是身形却是丝毫未动，白皙的额头上也出现了丝丝汗迹。\\n“哥，不行啊。我可以感受到灵气，但是我不知道怎么调用我体内的力量啊”\\n“啊，对啊！我还没有教给你修炼之法，功法也没有教你。等等，我给你写出来。”\\n“不能使用醍醐灌顶那种方式吗，感觉自己去参悟会很久的样子。”\\n“我也想，可是我的修为不够啊，至少要金丹才能进行醍醐灌顶之术”\\n孙源玲说着便回到房间拿起纸笔书写了起来，明明是十分晦涩难懂的修炼之法以及衍生的功法，经过他的手后都变得简单易懂了，是个普通人也可以读懂并且开始自己的修炼之路，并不知道这部修炼之法的极限在那儿，只知道似乎是直通本源的一部功法。\\n就在快要将修炼功法写完的时候，孙源玲突然发现，只有修炼的功法就够了吗？炼丹、炼器、阵法、尝试认知这些还是需要的吧，虽然觉得科技才是正道，但是个人能力很强难道不是一件十分快乐的事情吗，而且身体各方面都会变得更加完美。寿命也会大大的延长，以至于到了大乘之后可以都可以永生了，而科技虽然 可以批量的制造高手，但是始终材料有限啊。\\n孙源玲在心中想到“也不知道者灵气是不是也有上限，找个时间把制造灵气的机器给制造出来吧。这天地的灵气还是太稀薄了”\\n“瑶瑶，我好了，过来一下”\\n“哦，来了”\\n“写好了吗”\\n“嗯。写好了。那么这位美丽的小姐，这儿有一本名字未知的功法，我把它叫做‘析源’、‘炼器之法’、‘炼丹之法’、‘布阵之道’，以及如何识别天材地宝。怎么样心动吗，心动就赶快行动吧，一本只要9.9，你买不了吃亏买不了上当”\\n“……啧，一股奸商的味道迎面而来。哼——小孩子才会选，我都要”孙瑶的小手一握，嘟着嘴，并不高的身子却装作成熟的感觉让人感觉十分的可爱，\\n“好啦，这些都是基础但是却可以直达本源，再好的功法也是需要基础的支撑的，所以就不要想着那些看起来十分厉害的功法，只要基础好，功法都可以玩出花来。知道了吗？”\\n“哦，知道了，这就和数学的知识利用差不多吧，只要理解了最基础的知识，在做题的时候只要题不超纲，总是有办法做出来的，是这样对吧，哥？”\\n“嗯，就是这样的，所以基础才是最重要的东西啊。”\\n基础就是最重要的基石，没有了基础作为支撑，修为再高最终也不能持久，想要走到更高的地位那时绝对不可能的，天财地宝也救不了的那种，因为强行拔高境界，但是因为不知道怎么保持，最终仍然会跌落回他所能够掌握的境界。科技依然如此，要是没有坚实的基础，哪怕给予再高的科技产品也没有用，而且科技是一步一步地走上来的，不健全的基础，科技也走不远，甚至于最后不能寸进。如同基础科技被智子锁死的人类，发展到了人类基础科技所能达到的最高峰，但是因为基础科技无法突破，最高科技也就无法突破。三体的一个探测器就灭掉了人类的舰队。','2024-07-29T16:39:27','单篇完结作品','1','1',NULL,NULL,NULL),(00000000000000000007,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第三章 高考，上大学','一转眼就到了，高考的时候了，孙瑶也是基本掌握了，孙源玲给他的知识了。这半年时间过得十分的平静，没有各种让人觉得很厉害的感觉，没有什么逆袭的桥段，每天都过的普普通通，除了每天放学上学的时候不是正常人的方式进行而已。\\n孙源玲不顾老师的劝解，报考了魔都大学。\\n“你真的有把握考试考上魔都大学吗，如果没有考上的话你可是面临没有书读的情况，以后你的生活也会变得更加的困难的”\\n“我知道的，老师，不用再劝我了，我知道您是对我好。”\\n孙源玲在内心中想到：我不报魔都大学我报那儿啊，这可是国内最好的大学了。我可没有去国外的打算。我所掌握的知识可比这些知识难多了。到了大学里面才是我发挥我的能力的舞台。我可是要带领人类走向太空的人。\\n……\\n“唉 ，真的呈现在还没有到最后的时候，你的志愿还可以更改，现在还可以改，这是对你的未来负责啊”\\n“……真的没事的，你就不用担心了，我也是不小了。”开玩笑，在野鸡大学表现的太牛逼被抓起来切片怎么办？\\n老师：“……唉，自己保重吧。你……”\\n……\\n一转眼就来的6月份了，孙瑶也要开始中考了。\\n6月28日，早晨\\n进考场后\\n……\\n“感觉这些题也没有那么难嘛，想想以前我看到这些题，能够做的起一半都是算我超常发挥了。”获得了另一个宇宙的所有知识，虽然起点不一样，但是人家眼光不知道高到那儿去呢。触类旁通这些题都不难。\\n……\\n三天时间过去了，孙瑶也是可以自己做饭的。孙源玲也就没有怎么去操心了。\\n……\\n没过多久，魔都大学的录取通知书不出所料的落到了孙源玲的手里。\\n“哥，你好厉害啊，魔都大学的通知书诶。说，你怎么做到的？”\\n“你也是修仙的了，该不会不知道修仙可以让自己变得更加的聪明吗，记忆力什么的也会大幅度的提升的。”\\n修仙之后一目十行这，并且看一遍就能记住这都是小事，到了元婴之后，使用自己的神识扫一遍就知道书里面所有的内容了。\\n“哥哥，你是不是要去魔都了……一个人呢——”\\n孙瑶说话的声音越来越小……\\n“啊，没事的哥哥，我也是筑基的高手了，可以保护自己了”\\n“嗯……你……你也想去吗？我可以想办法让你去那面读书的”\\n“真的吗？啊，没事的哥哥，还有几年我可以自己努力考上魔都大学的。不用麻烦你了”\\n但是孙瑶皎洁的目光若隐若现的泪水却说明她此时的内心十分的纠结，不想麻烦哥哥，但是又十分的想和哥哥待在一起。如此纠结的她甚至于连说话都变得支支吾吾的了。\\n孙源玲一把抱住了孙瑶，毕竟还是一个小孩子。\\n到了哥哥温暖的怀里，孙瑶孙瑶的情绪也稳定了些\\n“瑶瑶，没事的，哥哥不麻烦，为了你再麻烦我也会去干的。放心吧瑶瑶要不了多久我就可以让你去魔都去读书了。”\\n“嗯，瑶瑶相信哥哥，哥哥加油哦。我想和哥哥永远在一起呢”\\n果然还是小孩在啊~\\n“嗯，瑶瑶你在说什么？”\\n“啊啊——哈哈，没说什么啊，加油啊哥哥”\\n……\\n没过多久，孙源玲就踏上了前往大学的旅途，暂时也不会因为钱的问题而烦恼。\\n只是孙瑶在看着哥哥远去的身影久久的站在原地，眼中透露出的思念之情怎么也挡不住，只是心中不知何时什么了其他另类的情绪，她自己也不知道是什么。\\n……\\n地铁的速度还是很快的，虽然孙源玲他也很想使用空间装备直接就到学校，但是为了不引起不必要的麻烦，比如恰巧有人在调查他的行进路线或者时间，这样的话在机缘巧合下就会暴露他的秘密。而且坐车欣赏沿途的风景也是一件挺不错的事情，以前在上学的时候也没有出去过，外面的风景人文也没有见识过。\\n沿途的话有机会可以去体验，我相信没有怎么去过外地的人是很乐意沿途体验一下当地的小吃的，顺带欣赏一下风景。只不过会很快就没有看风景的兴致而已。所以还是吃的东西最吸引人，兔砸民族千年传承，吃的东西自然是少不了的。各种吃的可以说是吃个一百年可能都吃不完。而且基本上是很好吃的东西，甚至很多东西都是百吃不厌的东西。\\n……\\n一天的时间都没有就到了魔都大学了，不得不说兔砸的基础设施建设和这个世界上的绝大多数国家相比都要完善很多了，基建狂魔的称号可不是凭空出现的，事实上，兔砸的基建速度可以说是举世无敌了，其聪慧的头脑，吃苦耐劳的精神，高超的科技这些可是有很重要的加持的。\\n“魔都大学吗？还真是大啊，比我那个乡都还要大。这就是我以后我为文明创下各种奇迹的见证之地了。虽然只是待一会儿。混个正常的身份而已。从今天开始就不能咸鱼了。要尽快把整个文明的科技水平提高啊。”','2024-07-29T16:39:27','单篇完结作品','1','1',NULL,NULL,NULL),(00000000000000000008,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第四章 我真的只是一个菜鸡而已啦','到了校园的第一件事当然是……去报到啊，难道是去看看有多少同系的女同学吗？\\n“孙源玲，你的寝室在621，等会儿去收拾一下吧，等会儿会有学长带你去找你的寝室的。”孙源玲的导师‘刘梦媛’道\\n刘梦媛的年龄只有三十多岁，但是却显得十分的年轻，就像一个20多岁的小姑娘，也就和孙源玲一般的身高，这还是因为她穿了高跟鞋的原因。白净的皮肤，有些微圆的脸蛋，十分的漂亮。也是不缺乏追求她的人。同时也是一个天才。\\n“好的，老师。”\\n……\\n随着孙源玲来到了他的宿舍，他也见到了他的三个室友。\\n“嘿，又有新人来了，快来欢迎新人”黄磊说到\\n“欢迎，欢迎”孙源玲的其余室友说到\\n“我们现在来自我介绍一下吧”黄磊说到\\n“没问题”其余两人一起道；“好的”\\n“我先来吧，我叫黄磊，叫我黄三石、磊哥都可以，既然我们是一个寝室的那么肯定都是人工智能这个系的了”\\n“我叫程陵，爱好制片人，请多关照”\\n“我是王岩，我觉得人工智能一定可以成功地被人类所创造出来的”\\n“我是孙源玲，玲珑的玲，不要觉得我的名字奇怪，这是没办法的事。现在我对于人工智能有一些和目前阶段不同的想法，我觉得我们可以合作。我相信人工智能会诞生在我们的手上，并且是可以被人类所完全掌握的，让每个人都能够享受到人工智能所带来的方便和好处。请多关照”\\n自我介绍完毕之后就加入到收拾寝室的队伍之中了，那些学长所留下来的烂摊子。\\n“嘿，玲珑；没想到你个子不大，力气还蛮大的嘛。”\\n“も可愛こと”\\n“我觉得你们对我有不好的想法，还有我叫孙源玲，叫我玲子我都能接受。可是这个玲珑是什么鬼啊？コラ”\\n“哦，那我们以后就叫你玲子咯。还真是可爱的人呢，我相信你女装的话一定很可爱的”\\n“附议”其余两人道\\n孙源玲：“……”\\n收拾完寝室之后就是休息时间了，接下来会有长达一个月的军训。对于新生来说又是一个折磨人的时间，但是对于孙源玲来说也就那样。毕竟都是一个筑基期的修士了，肉身没有经过淬炼并不强大，但是经过灵气的洗礼也是比普通人强大很多了，不然也无法承受灵力所带来的的力量。\\n虽然筑基的修士可以在宇宙中存活，也可以不吃东西只靠天地灵气存活。\\n但是真要说移山填海还是十分的困难，但是摧毁一座山头确实要不了多少时间的。不要小看修士的个人力量。\\n……\\n学校操场上\\n“同学们，欢迎来到魔都大学。在这里……”然后就是长篇大论，总结来就是一句话：大学不是给你们玩耍的地方，而是学习只是的地方，要努力学习，为国家做出贡献。\\n下面就是长达一个月的军训。\\n开始的几天也就是练习最基本的姿势而已，而后就开始教授学生各种体术及技能，锻炼身体。\\n校内3000m长跑体能锻炼ing\\n“诶，我说玲子。你就不累吗，这些天这么折磨法，我的脚都起泡了。浑身酸痛，这又是3000m”\\n“我感觉很轻松啊，难道要我等等你们啊”\\n“别别别”黄磊三人道\\n“那你们快点奥”\\n孙源玲哪突出常人的身体素质很快就引起了他们教官的注意，什么人跑了3000m不累的，就算不累，连汗都没有出这算是什么事？怪物啊？\\n在军训结束之后，负责他的教官找上了孙源玲\\n“这位同学，你就是孙源玲吧？”\\n“对，是我”\\n“我看你在这段时间表现的十分的出色啊，要知道我们军里面的军王都没有你那么的厉害，虽然3000m下来并不怎么累，但是或多或少都会出汗。有没有兴趣来到我们队里面来试试？”\\n“谢谢教官的好意了，我觉得还是比较适合呆在学校里面。而且我很菜，真的，我可能也就是体能比较出色而已，要是打架的话可能会被按在地上锤”\\n“啊哈哈哈，那好吧。有这方面的意愿的话可以联系我。我很看好你哦，这是我的名片”说着就从兜里面掏出了一个卡片交给了孙源玲。\\n话说为什么教官有名片呢？\\n孙源玲并没有说错，在同样的条件下，他真的打不赢。虽然他拥有多到不能想象的知识，但是他并没有怎么其练习。自然比不上身经百战的军人。\\n时间飞快的流逝，一个月的军训很快就过去了。同学们也和教官们建立起了相当的友谊，到了分别的时候就表现的十分的不舍。\\n总之，开学的第一步也是告了一个段落了。接下来就是开始正式开始上大学了。\\n','2024-07-29T16:39:27','单篇完结作品','1','1',NULL,NULL,NULL),(00000000000000000009,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第五章 人工智能的雏形','孙源玲因为开发过大脑，已经可以说，在这个地星上面是没有人在智力上面可以比得上孙源玲的了。而魔都大学更是一个人才聚集的地方，不说在这地方一板砖下去能砸到多少个多少个天才什么的，但是只要在这所学校里面的基本都是天才。所以在魔都大学里面，天才也会成为普通人，而这儿的天才都是在普通人眼里不敢想象的。\\n“啊，玲子，该去上课了”黄磊说道\\n“嗯，知道了，等会儿。我把这个模块给搞定了就来了”\\n“诶，你最近在搞什么呢？我看你都搞了那么久了”\\n“哦，你过来看一下不就知道了吗？你也是干这行的”\\n黄磊听后就走了过去，但是当黄磊看过之后脸上露出了惊讶的表情。都是人工智能这个系的哪能不知道孙源玲在干什么。\\n“我的天，你是在编写人工智能啊。我就只能看出这是个人工智能，但是当你的代码合在一起的时候我一时半会儿竟然还看不懂为什么。”\\n“哪有那么厉害啊，这只是一个雏形而已，走啦走啦，去上课了”\\n在前往教室的路上\\n“诶，你是不是在小时候就编写过程序了。我看你的那个逻辑语句写的十分的漂亮啊。”\\n“我还没有学多久，几个月前我才开始接触Java的，这只是一个人工智能的雏形而已，甚至大多数都是用if糊弄过去的，如果你想要的话，等会儿回来我把源码发一份给你”\\n其余三人的用看一个变态的眼光看着孙源玲。\\n“还有我们，也给我们一份”其余两人道\\n这是授权嘛，尊重作者的著作权。\\n“行”\\n现在的人工智能都是基于大数据的，只能说是伪人工智能。甚至有些不能称为人工智能，因为全部使用if来进行逻辑判断是没有灵魂的。现在的高阶语言并不适合人工智能的编写，或者说，无法编译出真正的人工智能。没有自我思想的人工智能是很没有意思的。\\n可能会有人说，当人工智能拥有了思想，就不怕他叛变吗？这还真的不用担心，因为孙源玲的人工智能可是准备一个人给肝出来的。给别人的只不过是提高他们的编程水平。当创作者一个人编写出来时，就是在见证人工只能诞生的全过程。在这个过程中，创作者有大把多的机会将底层代码中植入一些绝对控制能力的代码片段。而且为了防止被更改，需要将这段代码写入ROM中（只读存储芯片）。\\n而秘钥可以使用一个动态密码，比如将秘钥植入ROM中，每隔一段时间更新一次。每段时间都需要将人工智能重新激活一次。\\n所以为什么搞那么复杂，直接使用源代码控制就好了啊。有自我意识，拥有情感，甚至可以赋予其创造力。这才是完美的人工智能。\\n……\\n大学的课程都是十分的轻松地，而孙源玲只是在大学里面混个身份而已。用的是学校的马甲，不让人注意到自己。\\n\\n寝室内\\n孙源玲揉了揉发酸的眼睛，活动了一下长时间打键盘而疼痛的双手。\\n“唉，为什么目前没有适合人工智能的语言呢，看样子还得自己重新做一个”\\n看着眼前缓慢增加的进度条，嘴角露出了无奈的表情。\\n“这个人电脑真是差劲，要不是不方便我都想把我戒指里面的量子计算机拿来用了。可是为什么，眼镜不兼容Linux了。数据竟然无法导入。”\\n“唉~算了，有个人工智障帮助应该要不了多久就可以弄出新的高阶语言以及配套的汇编语言了，有时间还得将这眼镜的代码重新编译啊。竟然不支持Linux”\\n眼镜可以扫描代码进去跑，但是电脑屏幕的帧率不够。代码也是多的可怕，如果用眼镜进行扫描的话，时间太长了。等全部扫描完毕的时候，自己的电脑早就编译完成了。也就没有接触电脑没多久的才会享受打键盘所带来的的感觉，真的用久了就会想要用脑子直接输入了。\\n在苦苦等待中，编译已经完成了。不得不说，30000的电脑还是很不错的，在多线程的运行时，AMD比牙膏厂快多了。\\n此时孙源玲的室友还在研究孙源玲给他们的不完整版的源代码\\n“终于完成了啊，人工智能的雏形”\\n“爱丽”孙源玲对着麦克风说到。\\n“爱丽，为您服务。主人”','2024-07-29T16:39:27','单篇完结作品','1','1',NULL,NULL,NULL),(00000000000000000010,11,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第一章测试','第一章内容测试','2024-08-11T00:32:45','单篇完结作品','0','1',NULL,NULL,NULL),(00000000000000000011,12,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','测试','123测试，jwt上传测试','2024-08-21T19:13:14','单篇完结作品','0','2',NULL,NULL,NULL),(00000000000000000012,10,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','第六章 初级人工智能，爱丽','这是第一个出现在地星上的真正意义上的人工智能，虽然是初级的人工智能。而且因为编码的原因所以没有自我思想。而因为是错误的方式诞生出来的人工智能。孙源玲并没有更多的设置他的更多细节。只是让其能够帮助自己完成重新编码就完事了。\\n“爱丽，介绍一下你自己”\\n一阵毫无感情的声音响起，一下就可以听出是人工智能发出的声音\\n“好的主人，我的名字是‘爱丽’，诞生于星历2019年9月17日，可以辅助您进行工作，提高工作的效率。\\n拥有一定的逻辑判断能力，和较强的行为理解能力。因为您并没有赋予我声源，所以是合成的声音。可以基于大数据进行学习。”\\n爱丽的自我介绍过程没有一点声音的起伏，每个字的发音间隔都是相同的。并且因为只是自己配的个人电脑，CPU温度很快就彪起来了。水冷加液金散热都压不住了，甚至因为温度的上升，CPU开始锁频，电脑的运行变得十分的卡顿。甚至是NVME固态也处于满占用的状态。128GB的DDR4内存占用超过80%。\\n就在这样让电表倒转的情况下，初代人工智能出世了。\\n孙源玲看着正在疯狂运转的电脑，知道它正在学习知识。初始学习的都是关于汇编语言的基础知识。甚至说，如果需要还要自己重新编写汇编语言（高级语言转换为汇编语言，然后在转换为二进制码）。\\n“看来现在的电脑还是太弱了啊，真想用量子超算来运载。不行我得控制住我自己，直接一步登天可就没有意思了。万一中途出现了什么意外，连另一个宇宙都没有发生过的以外事情，而自己却没有观察到，那就亏大了。\\n还是需要更好配置的服务器啊，个人电脑始终不行啊。”\\n“爱丽，停止学习。筛选一下，那些店铺的志强 E5 2678v3 比较好，就在用网上的资源作为参照资料进行筛选。”\\n一会儿过后，爱丽终于反应过来。\\n“好的主人，已停止所有的内容学习，开始筛选店铺。Tips：请及时扩展硬盘空间，以及内存容量，以满足运行需要。”\\n没有一会儿，店铺就已经筛选出来了。\\n“看来只是筛选，还是比较快的。不愧是出自我手的人工智能，比市面上的人工智能强多了。‘爱丽’价格从低到高排序。”\\n“好的，已完成，主人。”\\n“爱丽，继续筛选显卡，内存，机械硬盘和固态硬盘，不要NVME固态，固态要eMLC颗粒的，主板选择……”\\n在这个时候不选好些，以后会造成性能瓶颈的，服务器虽然是用机械才能更好地适用于服务器，但是固态性能十分的强劲啊。\\n当这一套下来以后，差不多要60多万，多数的钱都是花在硬盘和内存上面了，毕竟服务器用的内存是服务器专用的内存条，拥有地址纠错的功能，这项能力对于个人电脑的用处不大，但是对于要处理超大量数据的服务器确实十分的有用。\\nCPU可以买了4颗，自然就要从四路主板里面去选择。总之并不便宜，但是这些都是前期需要的东西。\\n“还要在外面单独租房啊，不然这服务器在宿舍里面可放不下。”\\n“爱丽，帮我申请一下静态IP地址，并且申请一个专用线路，1000MB就够了”\\n主要是钱实在不多啊，1000MB的专用线路也会要不少的钱。\\n……\\n很快，配件就全部选择完毕并且下单完毕，这不得不说兔砸的某宝是真的厉害。\\n“过几天这些东西就可以到货了，先去租房吧。过两天安装光纤的人就来了。”\\n……\\n校外一个房东处\\n“1000一个月怎么样，这个价格已经十分的便宜了。你要知道，这房子的面积可不小了”\\n“在便宜一点950，你这儿的位置并不怎么好，采光太差了。”\\n……\\n最终老板实在熬不过了\\n“行吧行吧，950一个月”\\n就这样，住房的问题也解决了，但是孙源玲并不打算住在这里面，这是放服务器的，服务器可是会吵死人的。孙源玲还是住在学校的宿舍。\\n“终于全部搞定了啊，等过几天网线装好了后，配件就差不多到了。到时候这个初级人工智能也就可以帮助我编写新的语言了。到时候选择中文为高阶语言吧，虽然中文并不适合编程，但是有我特质的汇编语言，我想事情很简单就可以解决的。\\n谁知道，像中文这样的语言会不会更加的适合人工智能呢？”','2024-08-24T15:22:17','单篇完结作品','0','2',NULL,NULL,NULL);
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
  `is_vip_work` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT '0' COMMENT '是否为VIP作品',
  `work_approved` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT '2' COMMENT '作品审核状态，0未通过，1通过，2待审核',
  `approved_userid` varchar(255) DEFAULT NULL COMMENT '审核人',
  `approved_time` varchar(255) DEFAULT NULL COMMENT '审核时间',
  `approved_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`work_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novel_work`
--

LOCK TABLES `novel_work` WRITE;
/*!40000 ALTER TABLE `novel_work` DISABLE KEYS */;
INSERT INTO `novel_work` VALUES (0000000010,'未知之地·起源','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','87328997_p0.jpg','未知之地·起源','科幻,单女主,百合,硬科幻,无敌 ',NULL,'16','87328997_p0.jpg','当一个宇宙的信息加之于之身时该那么这个人将会出现什么样的奇迹呢？','2024-7-30T14:51:22',NULL,NULL,NULL,NULL,NULL,NULL,'当一个宇宙的信息加之于之身时该那么这个人将会出现什么样的奇迹呢？','连载中',NULL,'1','科幻','1','1',NULL,NULL,NULL),(0000000011,'测试作品1','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'测试作品1','测试',NULL,'16','template_4_99c90aaf-786e-4d7e-99f1-6c516fa12d62_output.jpg',NULL,'2024-08-11T00:32:45',NULL,NULL,NULL,NULL,NULL,NULL,'这是一个用于测试的作品','连载中',NULL,'1','其他','0','1',NULL,NULL,NULL),(0000000012,'jwt上传测试','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'jwt测试','123,321',NULL,'16','template_1_6e65fd7e-82d1-425b-9d8f-c22cab02c7b3_output.jpg',NULL,'2024-08-21T19:10:14',NULL,NULL,NULL,NULL,NULL,NULL,'123','',NULL,'1','恋爱','0','2',NULL,NULL,NULL);
/*!40000 ALTER TABLE `novel_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_collection_table`
--

DROP TABLE IF EXISTS `user_collection_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_collection_table` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `workid` varchar(255) NOT NULL COMMENT '作品ID',
  `workname` varchar(255) DEFAULT NULL COMMENT '作品名称',
  `time` varchar(255) DEFAULT NULL COMMENT '收藏的时间',
  `type` varchar(255) DEFAULT NULL COMMENT '作品类型',
  `is_open` varchar(255) DEFAULT NULL COMMENT '是否公开',
  `is_collection` varchar(255) DEFAULT NULL COMMENT '是否收藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_collection_table`
--

LOCK TABLES `user_collection_table` WRITE;
/*!40000 ALTER TABLE `user_collection_table` DISABLE KEYS */;
INSERT INTO `user_collection_table` VALUES (0000000002,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','作品2','2024年6月25日14:39:00','novel','0','1'),(0000000003,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','一些XP','2024年6月25日14:39:31','novel','1','1'),(0000000004,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4','user2的作品','2024-07-26T22:45:25','ill','1','1'),(0000000007,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3',NULL,'2024-08-05T20:21:55','comic','1','1'),(0000000008,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2',NULL,'2024-08-05T20:22:03','comic','1','1'),(0000000022,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','5','test','2024-08-21T00:47:57','ill','1','1'),(0000000023,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','11','测试作品1','2024-08-21T16:38:48','novel','1','1');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follow`
--

LOCK TABLES `user_follow` WRITE;
/*!40000 ALTER TABLE `user_follow` DISABLE KEYS */;
INSERT INTO `user_follow` VALUES (0000000003,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user3','91771cc1-2fc2-474c-8748-c11c9f66b9e3','2024年6月11日23时13分30秒',1),(0000000012,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','2024-07-25 19:05:23.986790',1),(0000000015,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user1','ec6866d3-128c-4281-8fef-76beb6b29508','2024-07-25 21:52:20.103159',1),(0000000016,'user1','ec6866d3-128c-4281-8fef-76beb6b29508','user1','ec6866d3-128c-4281-8fef-76beb6b29508','2024-08-05 16:09:52.673866',1),(0000000022,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2024-08-21 18:33:17.841435',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_like_table`
--

LOCK TABLES `user_like_table` WRITE;
/*!40000 ALTER TABLE `user_like_table` DISABLE KEYS */;
INSERT INTO `user_like_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','未知之地_起源','2024年6月25日14:36:11','novel'),(0000000002,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','作品2','2024年6月25日14:39:00','novel'),(0000000003,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','一些XP','2024年6月25日14:39:31','novel'),(0000000186,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4','user2的作品','2024-07-26T22:35:42','ill'),(0000000189,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2',NULL,'2024-07-29T16:18:31','comic'),(0000000190,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3',NULL,'2024-08-05T20:21:54','comic'),(0000000215,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','User1的作品','2024-08-11T01:27:15','ill'),(0000000216,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','5','test','2024-08-21T00:47:56','ill'),(0000000217,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','10','未知之地·起源','2024-08-21T01:05:54','novel'),(0000000218,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','11','测试作品1','2024-08-21T16:38:49','novel');
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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_watch_table`
--

LOCK TABLES `user_watch_table` WRITE;
/*!40000 ALTER TABLE `user_watch_table` DISABLE KEYS */;
INSERT INTO `user_watch_table` VALUES (0000000022,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','第二个作品测试','2024-08-08T16:03:39','ill'),(0000000023,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','第二个作品测试','2024-08-08T16:03:39','ill'),(0000000024,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','5','test','2024-08-11T14:19:26','ill'),(0000000025,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','User1的作品','2024-08-11T19:01:57','ill'),(0000000026,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4','user2的作品','2024-08-11T12:57:06','ill'),(0000000027,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4','user2的作品','2024-08-11T12:57:06','ill'),(0000000028,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','作品名称','2024-08-11T01:04:50','ill'),(0000000029,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','作品名称','2024-08-11T01:04:50','ill'),(0000000030,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','User1的作品','2024-08-11T14:19:30','comic'),(0000000031,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','第二个作品测试','2024-08-11T19:01:39','comic'),(0000000032,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','第二个作品测试','2024-08-11T19:01:39','comic'),(0000000033,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1',NULL,'2024-08-11T14:00:56','comic'),(0000000034,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1',NULL,'2024-08-11T14:00:56','comic'),(0000000035,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','4',NULL,'2024-07-29T17:01:20','comic'),(0000000036,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','5',NULL,'2024-07-29T16:42:03','comic'),(0000000037,'ec6866d3-128c-4281-8fef-76beb6b29508','8','普通用户投稿测试','2024-08-05T16:09:50','ill'),(0000000038,'ec6866d3-128c-4281-8fef-76beb6b29508','8','普通用户投稿测试','2024-08-05T16:09:50','ill'),(0000000039,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','10','未知之地·起源','2024-08-11T19:01:27','novel'),(0000000040,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','10','未知之地·起源','2024-08-11T19:01:27','novel'),(0000000041,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','7','测试','2024-08-11T01:02:59','ill'),(0000000042,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','6',NULL,'2024-08-11T14:01:08','comic'),(0000000043,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','11','测试作品1','2024-08-11T15:20:58','novel'),(0000000044,'f','5','test','2024-08-30T15:37:32','ill'),(0000000045,'f','3',NULL,'2024-08-30T15:36:38','comic'),(0000000046,'f','3',NULL,'2024-08-30T15:36:38','comic'),(0000000047,'f','2',NULL,'2024-08-30T15:36:46','comic'),(0000000048,'f','6',NULL,'2024-08-21T17:07:56','comic'),(0000000049,'f','6',NULL,'2024-08-21T17:07:56','comic'),(0000000050,'f','10','未知之地·起源','2024-08-30T15:13:49','novel'),(0000000051,'f','11','测试作品1','2024-08-30T12:44:41','novel'),(0000000052,'f','9','jwt认证测试','2024-08-21T16:58:45','ill'),(0000000053,'f','9','jwt认证测试','2024-08-21T16:58:45','ill'),(0000000054,'f','4','user2的作品','2024-08-30T15:33:20','ill'),(0000000055,'f','7',NULL,'2024-08-30T15:36:52','comic'),(0000000056,'f','7',NULL,'2024-08-30T15:36:52','comic'),(0000000057,'f','2','第二个作品测试','2024-08-30T14:51:58','ill'),(0000000058,'f','2','第二个作品测试','2024-08-30T14:51:58','ill'),(0000000059,'f','12','AI自动审稿测试2','2024-08-30T14:33:20','ill'),(0000000060,'f','12','jwt上传测试','2024-08-30T12:34:28','novel'),(0000000061,'f','10','AI自动审稿测试','2024-08-30T16:24:43','ill'),(0000000062,'f','10','AI自动审稿测试','2024-08-30T16:24:43','ill'),(0000000063,'f','7','测试','2024-08-30T14:12:33','ill'),(0000000064,'f','7','测试','2024-08-30T14:12:33','ill'),(0000000065,'f','1','AI自动审稿测试2','2024-08-30T14:43:09','ill'),(0000000066,'f','3','User1的作品','2024-08-30T15:06:25','ill'),(0000000067,'f','3','User1的作品','2024-08-30T15:06:25','ill'),(0000000068,'f','8','普通用户投稿测试','2024-08-30T16:24:32','ill'),(0000000069,'f','8','普通用户投稿测试','2024-08-30T16:24:32','ill'),(0000000070,'f','1',NULL,'2024-08-30T15:36:49','comic'),(0000000071,'f','1',NULL,'2024-08-30T15:36:49','comic');
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
  `account_status` varchar(255) DEFAULT NULL COMMENT '账号状态，0封禁，1正常，2禁言',
  `account_permissions` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '账号权限，0普通，1管理员，2超级管理员，-1是临时用户',
  `token_expiry` varchar(255) DEFAULT NULL COMMENT 'token有效期',
  `user_register` varchar(255) DEFAULT NULL COMMENT '账号注册时间',
  `per` varchar(255) DEFAULT NULL COMMENT '账号权限，0普通，1管理员，2超级管理员',
  `last_login` varchar(255) DEFAULT NULL COMMENT '最后登录时间',
  `ip_address` varchar(255) DEFAULT NULL COMMENT '用户IP地址',
  `role` varchar(255) DEFAULT NULL COMMENT '用户身份',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','这是一个自我介绍123','https://127.0.0.1:4434','四川泸州纳溪','2002-09-17','IT工程师123','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','837c3923-1e18-4c49-9161-f82b2f63fbde.jpg','20240525174916_f4f4acc7280f4eabb9fc1712929c3ccc.png','女','sunfujiaihaonv@gmail.com','18982494924','user1,user2,user3,admin','user4,user5,user6','123456',NULL,'1,2,3',NULL,1,NULL,1,NULL,'1,2,3','{\"ill\": [2, 1], \"comic\": [1, 5], \"novel\": [10]}','cb64aa48-f68a-46cc-a846-5a8323a83ba4','2024-08-20 21:26:51','1','1','1','2','2024-08-17 16:10:55','2024-8-15 18:05:58','2',NULL,NULL,'super_admin'),(2,'user1',NULL,NULL,NULL,NULL,NULL,'ec6866d3-128c-4281-8fef-76beb6b29508','65014220_p0.jpg','20240525174916_f4f4acc7280f4eabb9fc1712929c3ccc.png','女','222','22222',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'bb942ac7-5b7c-4756-8827-75bef7e797a5','2024-08-17 14:42:16','1','1','1','1','2024-08-17 01:50:03','2024-8-15 18:06:03','1',NULL,NULL,'admin'),(4,'user2',NULL,'111',NULL,NULL,NULL,'e661401c-bdda-46c0-b98c-eb4e019abf1c','65896618_p0.jpg',NULL,'female','3333','333',NULL,NULL,'12345678',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1','0',NULL,'2024-8-15 18:06:06','0',NULL,NULL,NULL),(5,'user4',NULL,NULL,NULL,NULL,NULL,'9a15d821-ae24-42b4-ab06-d02ca2012f1b','65896618_p0.jpg',NULL,'male','4444','4444',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1','0',NULL,'2024-8-15 18:06:08','0',NULL,NULL,NULL),(7,'user3',NULL,NULL,NULL,NULL,NULL,'91771cc1-2fc2-474c-8748-c11c9f66b9e3','59748972_p1.jpg',NULL,'女','555','555',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','1','0',NULL,'2024-8-15 18:06:10','0',NULL,NULL,NULL),(8,'temp_faf65703',NULL,NULL,NULL,NULL,NULL,'faf65703-f935-4d74-be9f-29b90f006d71',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a783d60d-61ee-417d-8a9e-ec73894d944b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','2','-1',NULL,NULL,NULL,'2024-08-20 21:26:45','127.0.0.1',NULL),(9,'temp_5d05bb5d',NULL,NULL,NULL,NULL,NULL,'5d05bb5d-2cd1-4492-bef4-adb4c9fa488d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'e57de992-5005-4696-bb01-06678fae4f90',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','2','-1',NULL,NULL,NULL,'2024-08-23 14:49:03','127.0.0.1',NULL),(10,'temp_d80d833e',NULL,NULL,NULL,NULL,NULL,'d80d833e-519c-4ba0-ad84-e8af333b41cd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'39be10d5-a05c-4afd-9bc2-e08f84dfcc64',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','2','-1',NULL,NULL,NULL,'2024-08-24 17:03:08','127.0.0.1',NULL),(11,'temp_0d8572e4',NULL,NULL,NULL,NULL,NULL,'0d8572e4-3214-4041-8b5e-caa49d58433d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'5eef387a-81b8-4a7d-abc7-26bc3e64e523',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','2','-1',NULL,NULL,NULL,'2024-08-26 16:16:34','127.0.0.1',NULL),(12,'temp_1a5579b2',NULL,NULL,NULL,NULL,NULL,'1a5579b2-77dd-4893-aaa1-2ccbffe4cf5a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'5af9108b-af94-45c8-ae18-bc63e2cd19fd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','2','-1',NULL,NULL,NULL,'2024-08-27 21:16:22','127.0.0.1',NULL),(13,'temp_a1e0f8ca',NULL,NULL,NULL,NULL,NULL,'a1e0f8ca-f4e5-4ba9-8eff-3f947feaee8d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'f3dc8fc1-b474-4ef9-81e7-b5f67fcb8925',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','2','-1',NULL,NULL,NULL,'2024-08-30 09:30:58','127.0.0.1',NULL);
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

-- Dump completed on 2024-09-01 13:22:42
