/*
SQLyog Ultimate v8.32 
MySQL - 5.5.33 : Database - students
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`students` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `students`;

/*Table structure for table `gam` */

DROP TABLE IF EXISTS `gam`;

CREATE TABLE `gam` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `gname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `gam` */

insert  into `gam`(`id`,`gname`) values (1,'舞蹈社'),(2,'书社');

/*Table structure for table `stu` */

DROP TABLE IF EXISTS `stu`;

CREATE TABLE `stu` (
  `sno` int(10) NOT NULL AUTO_INCREMENT,
  `sname` varchar(50) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `grade` varchar(40) DEFAULT NULL,
  `gid` int(10) DEFAULT NULL,
  `classes` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sno`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=utf8;

/*Data for the table `stu` */

insert  into `stu`(`sno`,`sname`,`sex`,`grade`,`gid`,`classes`) values (1001,'章子','男','八年级',1,'一班'),(1002,'张思','男','三年级',2,'二班'),(1003,'王五','男','四年级',1,'三班'),(1004,'吴昊','女','五年级',2,'四班'),(1005,'八戒','男','三年级',1,'一班'),(1006,'二西轰','男','八年级',2,'八班'),(1007,'师傅','女','三年级',2,'四班'),(1008,'大师兄','男','四年级',2,'六班');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `uid` int(20) NOT NULL AUTO_INCREMENT,
  `uname` varchar(50) DEFAULT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`uid`,`uname`,`pwd`) values (1,'admin','123456'),(2,'user','123456'),(3,'admins','123456'),(4,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
