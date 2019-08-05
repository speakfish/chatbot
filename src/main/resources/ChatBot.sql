-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.7.23


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema chatbot
--

CREATE DATABASE IF NOT EXISTS chatbot;
USE chatbot;

--
-- Definition of table `chatbot_base_dict`
--

DROP TABLE IF EXISTS `chatbot_base_dict`;
CREATE TABLE `chatbot_base_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text,
  `type` int(11) DEFAULT '0' COMMENT '0:故事，1：笑话，2：名言警句',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `chatbot_base_dict`
--

/*!40000 ALTER TABLE `chatbot_base_dict` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatbot_base_dict` ENABLE KEYS */;


--
-- Definition of table `chatbot_question_answer`
--

DROP TABLE IF EXISTS `chatbot_question_answer`;
CREATE TABLE `chatbot_question_answer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question` varchar(1024) DEFAULT NULL,
  `answer` varchar(1024) DEFAULT NULL,
  `type` int(2) DEFAULT '0' COMMENT '0：幽默  1：高冷  2：直男 3：撒娇',
  `source` int(2) DEFAULT '0' COMMENT '0：人工 1：爬虫',
  `createDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `chatbot_question_answer`
--

/*!40000 ALTER TABLE `chatbot_question_answer` DISABLE KEYS */;
INSERT INTO `chatbot_question_answer` (`id`,`question`,`answer`,`type`,`source`,`createDate`) VALUES 
 (6,'吃晚饭了吗','没有啊',0,0,'2019-07-29 18:26:07');
/*!40000 ALTER TABLE `chatbot_question_answer` ENABLE KEYS */;


--
-- Definition of table `chatbot_user_info`
--

DROP TABLE IF EXISTS `chatbot_user_info`;
CREATE TABLE `chatbot_user_info` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `hobby` varchar(255) DEFAULT NULL COMMENT '兴趣爱好，以|分割',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `chatbot_user_info`
--

/*!40000 ALTER TABLE `chatbot_user_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatbot_user_info` ENABLE KEYS */;


--
-- Definition of table `rel_role_resource`
--

DROP TABLE IF EXISTS `rel_role_resource`;
CREATE TABLE `rel_role_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resourceId` varchar(255) DEFAULT NULL,
  `roleCode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rel_role_resource`
--

/*!40000 ALTER TABLE `rel_role_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `rel_role_resource` ENABLE KEYS */;


--
-- Definition of table `sys_dict_item`
--

DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_dict_item`
--

/*!40000 ALTER TABLE `sys_dict_item` DISABLE KEYS */;
INSERT INTO `sys_dict_item` (`id`,`code`,`name`,`status`,`value`) VALUES 
 (273,'ErrorRequestType','附件不存在',0,'0'),
 (274,'ErrorRequestType','签名异常',0,'1'),
 (275,'ErrorRequestType','A2解密错误',0,'2'),
 (276,'ErrorRequestType','D1解密错误',0,'3'),
 (277,'RequestReferType','正常',0,'0'),
 (278,'RequestReferType','已发布许可证',0,'1'),
 (279,'RequestReferType','重复申请',0,'2'),
 (280,'ServerId','001',0,'01'),
 (281,'ServerId','002',0,'02'),
 (282,'ServerId','003',0,'03'),
 (283,'ServerId','004',0,'04'),
 (284,'ServerId','005',0,'05'),
 (285,'SubmitComment','公司名称不全',0,'0'),
 (286,'SubmitComment','用户编号错误',0,'1'),
 (287,'SubmitComment','重复申请',0,'2'),
 (288,'SubmitComment','其他',0,'3'),
 (289,'ApproveComment','公司名称不全',0,'0'),
 (290,'ApproveComment','用户编号错误',0,'1'),
 (291,'ApproveComment','重复申请',0,'2'),
 (292,'ApproveComment','其他',0,'3'),
 (293,'answerType','幽默',0,'0'),
 (294,'answerType','高冷',0,'1'),
 (295,'answerType','直男',0,'2'),
 (296,'answerType','撒娇',0,'3');
/*!40000 ALTER TABLE `sys_dict_item` ENABLE KEYS */;


--
-- Definition of table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_dict_type`
--

/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` (`id`,`code`,`name`,`status`) VALUES 
 (69,'ErrorRequestType','异常请求类型',0),
 (70,'RequestReferType','请求参考类型',0),
 (71,'ServerId','分中心',0),
 (72,'SubmitComment','初审意见',0),
 (73,'ApproveComment','复审意见',0),
 (74,'answerType','聊天风格',0);
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;


--
-- Definition of table `sys_resource`
--

DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_resource`
--

/*!40000 ALTER TABLE `sys_resource` DISABLE KEYS */;
INSERT INTO `sys_resource` (`id`,`code`,`name`,`status`,`type`,`url`) VALUES 
 (39,'100','Welcome',0,NULL,'/page/welcome'),
 (40,'200','后台系统',0,NULL,NULL),
 (41,'200-001','问答录入',0,NULL,'/chatbot/questionAnswer/forward');
/*!40000 ALTER TABLE `sys_resource` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
