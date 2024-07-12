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
ef18a94f-0601-11ef-b34a-00155de60230:1-437';

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comic`
--

LOCK TABLES `comic` WRITE;
/*!40000 ALTER TABLE `comic` DISABLE KEYS */;
INSERT INTO `comic` VALUES (0000000001,'作品测测1','96950958_p0.png,117214493_p0_master1200.jpg','user1','ec6866d3-128c-4281-8fef-76beb6b29508','65014220_p0.jpg','tag1,tag2,tag3','16','this is a comic introduction','2024年6月27日18:39:06',NULL),(0000000002,'作品测试2','20240525175111_0c1ff93008904940bc4cdc681bde78b5.jpg,20240525174916_f4f4acc7280f4eabb9fc1712929c3ccc.png','user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','65896618_p0.jpg','tag2,tag3,tag1','18','this is a test2 to comic introduction','2024年6月27日18:40:33',NULL),(0000000003,'作品测试3','96680242_p0.png','user3','91771cc1-2fc2-474c-8748-c11c9f66b9e3','59748972_p1.jpg','tag1，标签2','18','这是一个作品的测试简介，','2024年6月27日18:42:17',NULL);
/*!40000 ALTER TABLE `comic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `work_id` int NOT NULL COMMENT '评论区所属id',
  `is_root_comment` varchar(255) DEFAULT NULL COMMENT '是否为主评论',
  `send_username` varchar(255) NOT NULL COMMENT '发送者昵称',
  `send_userid` char(36) NOT NULL COMMENT '发送者id',
  `content` longtext COMMENT '详细评论内容',
  `date` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发送时间',
  `main_username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '被回复的评论者昵称',
  `main_userid` char(36) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '被回复的评论者id',
  `main_comment_index` varchar(255) DEFAULT NULL COMMENT '主评论索引',
  `main_comment_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '主评论id',
  `reply_comment_id` int(10) unsigned zerofill DEFAULT NULL COMMENT '回复的评论的id',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (0000000001,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','主回复评论一','2024年4月30日22:31:23','','','','',NULL),(0000000002,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','回复主评论一','2024年5月5日21:04:24','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'0000000001',0000000001),(0000000003,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','主评论回复二','2024年5月5日21:07:36',NULL,NULL,NULL,NULL,NULL),(0000000004,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','回复主评论二','2024年5月5日21:08:01','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'0000000003',0000000003),(0000000005,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','主评论三','2024年5月8日00:30:25',NULL,NULL,NULL,NULL,NULL),(0000000006,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','111','2024-05-08 01:09:09',NULL,NULL,NULL,NULL,NULL),(0000000007,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','222','2024-05-08 01:09:38',NULL,NULL,NULL,'6',0000000006),(0000000008,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','新增的回复1','2024-05-08 22:18:17',NULL,NULL,NULL,NULL,NULL),(0000000009,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','新增的回复12','2024-05-08 22:18:22',NULL,NULL,NULL,NULL,NULL),(0000000010,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','新增的回复123','2024-05-08 22:18:24',NULL,NULL,NULL,NULL,NULL),(0000000011,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1234','2024-05-08 22:19:08',NULL,NULL,NULL,'1',0000000001),(0000000012,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','新增子回复1','2024-05-08 22:19:20',NULL,NULL,NULL,'1',0000000001),(0000000013,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','新增子回复12','2024-05-08 22:19:31',NULL,NULL,NULL,'1',0000000002),(0000000014,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','123321','2024-05-12 14:56:50',NULL,NULL,NULL,'3',0000000003),(0000000015,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','111','2024-05-12 14:58:23',NULL,NULL,NULL,'8',0000000008),(0000000016,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','111','2024-05-12 15:04:10',NULL,NULL,NULL,'5',0000000005);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `illustration_work`
--

LOCK TABLES `illustration_work` WRITE;
/*!40000 ALTER TABLE `illustration_work` DISABLE KEYS */;
INSERT INTO `illustration_work` VALUES (0000000001,'作品名称','65014220_p0.jpg,87328997_p0.jpg','admin','87328997_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','裤袜，白丝，萝莉','16','我的一个原创作品','2024年5月31日10:04:39',1111,'admin,user1,user2,user3',111,'admin,user1,user2,user3',10086,'admin,user1,user2,user3','ill',NULL),(0000000002,'第二个作品测试','96680242_p0.png,96026674_p0.jpg,97197111_p0.jpg','admin','87328997_p0.jpg','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','裤袜，黑裤袜，兔女郎，原神','18','我的一个原创作品集','2024年5月31日10:09:02',111,'admin,user1,user2,user3',222,'admin,user1,user2,user3',222,'admin,user1,user2,user3','ill',NULL),(0000000003,'User1的作品','100213135_p0.jpg,100213135_p1.jpg,104705167_p0.jpg','user1','65014220_p0.jpg','ec6866d3-128c-4281-8fef-76beb6b29508','裤袜，白裤袜，黑裤袜，原创，崩坏学院2','16','我的一个远程作品集','2024年5月31日10:11:37',222,'admin,user1,user2,user3',222,'admin,user1,user2,user3',333,'admin,user1,user2,user3','ill',NULL),(0000000004,'user2的作品','118802535_p0_master1200.jpg,103168176_p0.png,100213135_p1.jpg','user2','65896618_p0.jpg','e661401c-bdda-46c0-b98c-eb4e019abf1c','裤袜，白裤袜，黑裤袜，原创','16','我是一个作品集','2024年6月12日10:15:11',NULL,'admin',NULL,NULL,NULL,NULL,'ill',NULL),(0000000005,'test','94296327_p0.jpg','user2','65896618_p0.jpg','e661401c-bdda-46c0-b98c-eb4e019abf1c','裤袜，白裤袜，萝莉，原创','16','test','2024年6月12日10:17:04',NULL,'admin',NULL,NULL,NULL,NULL,'ill',NULL);
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
  PRIMARY KEY (`work_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novel_work`
--

LOCK TABLES `novel_work` WRITE;
/*!40000 ALTER TABLE `novel_work` DISABLE KEYS */;
INSERT INTO `novel_work` VALUES (0000000001,'未知之地_起源','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','87328997_p0.jpg','科幻','科幻,超级科技,双女主','未知之地_起源','18','87328997_p0.jpg','没啥好说的','2024-05-02 13:55:05',10086,NULL,10010,NULL,10000,NULL,'这是一个作品简介','连载',NULL),(0000000002,'作品2','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','87328997_p0.jpg','种田','种田,二次元,单女主,性转','作品2','18','104705167_p0.jpg','这是第二个作品','2024-05-03 23:02:51',222222,NULL,333333,NULL,333333,NULL,NULL,'连载',NULL),(0000000003,'一些XP','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','87328997_p0.jpg','杂项','丝袜,裤袜,白裤袜,黑裤袜,萝莉,紧缚','杂项','18','87328997_p0.jpg','这是一个测试作品项目','2024-05-04 23:57:29',213131,NULL,1654,NULL,3135456,NULL,NULL,'连载',NULL),(0000000004,'作品1','user1','ec6866d3-128c-4281-8fef-76beb6b29508','65014220_p0.jpg','测试','科幻,超级科技,双女主','测试','16','87328997_p0.jpg','这是一个作品测试','2024年6月26日20:28:57',111,NULL,NULL,NULL,NULL,NULL,'这是一个作品简介，第一个测试作品的','连载',NULL),(0000000005,'作品测试','user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','65896618_p0.jpg','测试项','tag1,tag2,tag3','测试','18','96689047_p0.jpg','这是第二个作品的测试案例','2024年6月27日18:50:46',NULL,NULL,NULL,NULL,NULL,NULL,'这是一个作品简介，这是第二个测试案例的','完结',NULL),(0000000006,'作品测试2','user3','91771cc1-2fc2-474c-8748-c11c9f66b9e3','59748972_p1.jpg','测试项2','tag1,tag3,tag1','测试项2','16','96680242_p0.png','这是一个作品的测试案例，第三个测试案例','2024年6月27日18:52:46',NULL,NULL,NULL,NULL,NULL,NULL,'这是一个作品简介，是第三个作品测试例','连载',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_collection_table`
--

LOCK TABLES `user_collection_table` WRITE;
/*!40000 ALTER TABLE `user_collection_table` DISABLE KEYS */;
INSERT INTO `user_collection_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','未知之地_起源','2024年6月25日14:36:11','novel'),(0000000002,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','作品2','2024年6月25日14:39:00','novel'),(0000000003,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','一些XP','2024年6月25日14:39:31','novel');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follow`
--

LOCK TABLES `user_follow` WRITE;
/*!40000 ALTER TABLE `user_follow` DISABLE KEYS */;
INSERT INTO `user_follow` VALUES (0000000001,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user1','ec6866d3-128c-4281-8fef-76beb6b29508','2024年6月11日23时11分15秒',1),(0000000002,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user2','e661401c-bdda-46c0-b98c-eb4e019abf1c','2024年6月11日23时12分18秒',1),(0000000003,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','user3','91771cc1-2fc2-474c-8748-c11c9f66b9e3','2024年6月11日23时13分30秒',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_like_table`
--

LOCK TABLES `user_like_table` WRITE;
/*!40000 ALTER TABLE `user_like_table` DISABLE KEYS */;
INSERT INTO `user_like_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','未知之地_起源','2024年6月25日14:36:11','novel'),(0000000002,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','作品2','2024年6月25日14:39:00','novel'),(0000000003,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','一些XP','2024年6月25日14:39:31','novel');
/*!40000 ALTER TABLE `user_like_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_watch_table`
--

DROP TABLE IF EXISTS `user_watch_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_watch_table` (
  `ID` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userid` varchar(255) NOT NULL COMMENT '用户ID',
  `workid` varchar(255) NOT NULL COMMENT '作品ID',
  `workname` varchar(255) DEFAULT NULL COMMENT '作品名称',
  `time` varchar(255) DEFAULT NULL COMMENT '观看的时间',
  `type` varchar(255) DEFAULT NULL COMMENT '作品类型',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_watch_table`
--

LOCK TABLES `user_watch_table` WRITE;
/*!40000 ALTER TABLE `user_watch_table` DISABLE KEYS */;
INSERT INTO `user_watch_table` VALUES (0000000001,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','1','未知之地_起源','2024年6月25日14:36:11','novel'),(0000000002,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','2','作品2','2024年6月25日14:39:00','novel'),(0000000003,'f575b4d3-0683-11ef-adf4-00ffc6b98bdb','3','一些XP','2024年6月25日14:39:31','novel');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','这是一个自我介绍','https://127.0.0.1:4434','四川泸州','2002年9月17日','IT工程师123','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','87328997_p0.jpg','20240525180208_e94dd6fb14414ad49679b062b92ec1a3.jpg','女','sunfujiaihaonv@gmail.com','18982494924','user1,user2,user3,admin','user4,user5,user6','123456',NULL,'1,2,3',NULL,1,NULL,1,NULL,'1,2,3','{\"ill_id\": [\"1\", \"2\"], \"work_id\": [\"1\"]}'),(2,'user1',NULL,NULL,NULL,NULL,NULL,'ec6866d3-128c-4281-8fef-76beb6b29508','65014220_p0.jpg',NULL,'female','222','222',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'user2',NULL,NULL,NULL,NULL,NULL,'e661401c-bdda-46c0-b98c-eb4e019abf1c','65896618_p0.jpg',NULL,'female','3333','333',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'user4',NULL,NULL,NULL,NULL,NULL,'9a15d821-ae24-42b4-ab06-d02ca2012f1b','65896618_p0.jpg',NULL,'male','4444','4444',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'user3',NULL,NULL,NULL,NULL,NULL,'91771cc1-2fc2-474c-8748-c11c9f66b9e3','59748972_p1.jpg',NULL,'女','555','555',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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

-- Dump completed on 2024-07-12 12:08:22
