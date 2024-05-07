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
ef18a94f-0601-11ef-b34a-00155de60230:1-56';

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (0000000001,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','主回复评论一','2024年4月30日22:31:23','','','','',NULL),(0000000002,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','回复主评论一','2024年5月5日21:04:24','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'0000000001',0000000001),(0000000003,1,'是','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','主评论回复二','2024年5月5日21:07:36',NULL,NULL,NULL,NULL,NULL),(0000000004,1,'否','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','回复主评论二','2024年5月5日21:08:01','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb',NULL,'0000000003',0000000003);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
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
  `work_create_time` datetime DEFAULT NULL COMMENT '作品创建时间',
  `like_num` int DEFAULT NULL COMMENT '作品点赞数',
  `collecting_num` int DEFAULT NULL COMMENT '作品收藏数',
  `views_num` int DEFAULT NULL COMMENT '作品浏览数',
  PRIMARY KEY (`work_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `novel_work`
--

LOCK TABLES `novel_work` WRITE;
/*!40000 ALTER TABLE `novel_work` DISABLE KEYS */;
INSERT INTO `novel_work` VALUES (0000000001,'未知之地_起源','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','科幻','科幻,超级科技,双女主','未知之地_起源','18','87328997_p0.jpg','没啥好说的','2024-05-02 13:55:05',10086,10010,10000),(0000000002,'作品2','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','种田','种田,二次元,单女主,性转','作品2','18','104705167_p0.jpg','这是第二个作品','2024-05-03 23:02:51',222222,333333,333333),(0000000003,'一些XP','admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','杂项','丝袜,裤袜,白裤袜,黑裤袜,萝莉,紧缚','杂项','18','87328997_p0.jpg','这是一个测试作品项目','2024-05-04 23:57:29',213131,1654,3135456);
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
  `userid` char(36) DEFAULT NULL COMMENT '用户UUID',
  `user_avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户头像图像路径',
  `user_back_img` varchar(255) DEFAULT NULL COMMENT '用户背景图像路径',
  `sex` enum('男','女','其他') DEFAULT NULL COMMENT '性别',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `user_following` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '关注的用户列表',
  `user_fans` longtext CHARACTER SET utf8mb3 COLLATE utf8_general_ci COMMENT '粉丝列表',
  `password` varchar(255) DEFAULT NULL COMMENT '用户登录密码',
  `collected_works` longtext COMMENT '用户收藏的作品',
  `like_works` longtext COMMENT '用户点赞的作品',
  `watch_list` longtext COMMENT '待阅读作品',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','f575b4d3-0683-11ef-adf4-00ffc6b98bdb','87328997_p0.jpg','97165605_p0.jpg','女','sunfujiaihaonv@gmail.com','18982494924','user1,user2,user3,admin','user4,user5,user6','123456',NULL,NULL,NULL);
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

-- Dump completed on 2024-05-07  8:41:11
