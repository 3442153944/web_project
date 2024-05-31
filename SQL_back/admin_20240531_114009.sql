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

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '22280e92-05be-11ef-ba69-80fa5b5f0ae3:1-42';

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
-- Table structure for table `illustration_work`
--

DROP TABLE IF EXISTS `illustration_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `illustration_work` (
  `Illustration_id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '插画作品ID',
  `name` varchar(255) NOT NULL COMMENT '作品名称',
  `content_file_list` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '作品文件路径列表',
  `belong_to_user` varchar(255) DEFAULT NULL COMMENT '作品属于谁',
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
  PRIMARY KEY (`Illustration_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `illustration_work`
--

LOCK TABLES `illustration_work` WRITE;
/*!40000 ALTER TABLE `illustration_work` DISABLE KEYS */;
INSERT INTO `illustration_work` VALUES (0000000001,'作品名称','65014220_p0.jpg,87328997_p0.jpg','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','裤袜，白丝，萝莉','16','我的一个原创作品','2024年5月31日10:04:39',1111,'admin,user1,user2,user3',111,'admin,user1,user2,user3',10086,'admin,user1,user2,user3'),(0000000002,'第二个作品测试','96680242_p0.png,96026674_p0.jpg,97197111_p0.jpg','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','裤袜，黑裤袜，兔女郎，原神','18','我的一个原创作品集','2024年5月31日10:09:02',111,'admin,user1,user2,user3',222,'admin,user1,user2,user3',222,'admin,user1,user2,user3'),(0000000003,'User1的作品','100213135_p0.jpg,100213135_p1.jpg,104705167_p0.jpg','user1','ec6866d3-128c-4281-8fef-76beb6b29508','裤袜，白裤袜，黑裤袜，原创，崩坏学院2','16','我的一个远程作品集','2024年5月31日10:11:37',222,'admin,user1,user2,user3',222,'admin,user1,user2,user3',333,'admin,user1,user2,user3');
/*!40000 ALTER TABLE `illustration_work` ENABLE KEYS */;
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
  PRIMARY KEY (`work_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novel_work`
--

LOCK TABLES `novel_work` WRITE;
/*!40000 ALTER TABLE `novel_work` DISABLE KEYS */;
INSERT INTO `novel_work` VALUES (0000000001,'未知之地_起源','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','科幻','科幻,超级科技,双女主','未知之地_起源','18','87328997_p0.jpg','没啥好说的','2024-05-02 13:55:05',10086,NULL,10010,NULL,10000,NULL),(0000000002,'作品2','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','种田','种田,二次元,单女主,性转','作品2','18','104705167_p0.jpg','这是第二个作品','2024-05-03 23:02:51',222222,NULL,333333,NULL,333333,NULL),(0000000003,'一些XP','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','杂项','丝袜,裤袜,白裤袜,黑裤袜,萝莉,紧缚','杂项','18','87328997_p0.jpg','这是一个测试作品项目','2024-05-04 23:57:29',213131,NULL,1654,NULL,3135456,NULL);
/*!40000 ALTER TABLE `novel_work` ENABLE KEYS */;
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
  `collected_novel_works` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '用户收藏的小说作品',
  `collected_novel_works_id` int DEFAULT NULL COMMENT '用户收藏的小说作品的ID',
  `like_novel_works` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '用户点赞的小说作品',
  `like_novel_works_id` int DEFAULT NULL COMMENT '用户点赞的小说作品ID',
  `watch_novel_list` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '待阅读小说作品',
  `watch_novel_list_id` varchar(255) DEFAULT NULL COMMENT '待阅读小说作品的ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','这是一个自我介绍','https://127.0.0.1:4434','四川泸州','2002年9月17日','IT工程师123','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','87328997_p0.jpg','20240525180208_e94dd6fb14414ad49679b062b92ec1a3.jpg','女','sunfujiaihaonv@gmail.com','18982494924','user1,user2,user3,admin','user4,user5,user6','123456',NULL,NULL,NULL,NULL,NULL,NULL),(2,'user1',NULL,NULL,NULL,NULL,NULL,'ec6866d3-128c-4281-8fef-76beb6b29508','65014220_p0.jpg',NULL,'female','222','222',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL),(4,'user2',NULL,NULL,NULL,NULL,NULL,'e661401c-bdda-46c0-b98c-eb4e019abf1c','65896618_p0.jpg',NULL,'female','3333','333',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL),(5,'user4',NULL,NULL,NULL,NULL,NULL,'9a15d821-ae24-42b4-ab06-d02ca2012f1b','65896618_p0.jpg',NULL,'male','4444','4444',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL),(7,'user3',NULL,NULL,NULL,NULL,NULL,'91771cc1-2fc2-474c-8748-c11c9f66b9e3','59748972_p1.jpg',NULL,'女','555','555',NULL,NULL,'123456',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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

-- Dump completed on 2024-05-31 11:40:12
