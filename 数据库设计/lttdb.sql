/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.6.10 : Database - lltdb
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lltdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `lltdb`;

/*Table structure for table `ic_category_config` */

DROP TABLE IF EXISTS `ic_category_config`;

CREATE TABLE `ic_category_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pid` bigint NOT NULL COMMENT 'parent_id',
  `bizid` bigint NOT NULL COMMENT '表示层级关系',
  `title` varchar(10) NOT NULL,
  `level` int NOT NULL,
  `sort` int  NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bizid` (`bizid`),
  CONSTRAINT `ic_category_config_ibfk_1` FOREIGN KEY (`bizid`) REFERENCES `ic_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ic_category_config` */

/*Table structure for table `ic_children_sku` */

DROP TABLE IF EXISTS `ic_children_sku`;

CREATE TABLE `ic_sku_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `price` bigint(20) NOT NULL COMMENT '价格。单位为分',
  `long_title` varchar(30) NOT NULL COMMENT '子sku长名称',
  `short_title` varchar(15) NOT NULL COMMENT '子sku短名称',
  `father_id` bigint(20) NOT NULL COMMENT '父sku的id',
  `pic` varchar(500) NOT NULL COMMENT '子sku的图片',
  `stock` bigint(20) unsigned NOT NULL COMMENT '商品库存',
  `version` bigint(20) NOT NULL COMMENT '乐观锁',
  `on_shelf_status` tinyint(1) NOT NULL COMMENT '0待上架;1已上架;2下架',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `on_marketing` tinyint(1) NOT NULL COMMENT '是否促销 0否;1是',
  `is_delete` tinyint(1) NOT NULL COMMENT '软删除状态 0删除;1存在',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT  ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ic_children_sku` */

/*Table structure for table `ic_goods` */

DROP TABLE IF EXISTS `ic_goods`;

CREATE TABLE `ic_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '二级ID',
  `item_pic` varchar(500) NOT NULL DEFAULT '' COMMENT '商品图片',
  `item_price` bigint(20) unsigned DEFAULT 0 NOT NULL COMMENT '商品价格',
  `item_long_title` varchar(40) DEFAULT '' NOT NULL COMMENT '商品长名称',
  `item_short_title` varchar(25) DEFAULT '' NOT NULL COMMENT '商品短名称',
  `item_spu_id` bigint(20) DEFAULT 0 NOT NULL COMMENT '商品spuID',
  `item_tab_info` varchar(1024) DEFAULT '' NOT NULL COMMENT 'type1:图片;type2:文字',
  `item_scroll_images` varchar(500) DEFAULT '' NOT NULL COMMENT '商品轮播图',
  `item_tag` varchar(500) DEFAULT '' NOT NULL COMMENT '所含标签的json',
  `item_is_delete` tinyint(1) NOT NULL COMMENT '软删除状态0删除1存在',
  `internal` tinyint(1) NOT NULL COMMENT '是否自营 0否;1是',
  `item_shop_id` int DEFAULT 0 NOT NULL COMMENT '所属店铺id',
  `item_sales` int DEFAULT 0 NOT NULL COMMENT '商品销量',  
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT  ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  Index idx_shop_id('item_shop_id'),
  Index idx_spu_id('item_spu_id')
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ic_goods` */

/*Table structure for table `ic_item_sku` */

DROP TABLE IF EXISTS `ic_item_sku`;

CREATE TABLE `ic_item_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sku_describe` varchar(10) DEFAULT '' NOT NULL COMMENT 'sku文本描述',
  `sku_node_id` bigint(20) DEFAULT 0 NOT NULL COMMENT '父SkuID',
  `sku_pid` bigint(20) DEFAULT 0 NOT NULL COMMENT '子skuID',
  `level` int NOT NULL,
  `sort` int  NOT NULL,
  `item_id` bigint(20) DEFAULT 0 NOT NULL COMMENT '归属于哪个商品',
  `sku_detail_id` bigint(20) DEFAULT 0 NOT NULL COMMENT '规格id',
  PRIMARY KEY (`id`),
  Index idx_item_id('item_id'),
  Index idx_sku_node_id (`sku_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ic_item_sku` */

/*Table structure for table `ic_tags` */

DROP TABLE IF EXISTS `ic_tags`;

CREATE TABLE `ic_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `title` varchar(7) NOT NULL COMMENT '标签名称',
  `contain_item` varchar(500) NOT NULL COMMENT '包含此标签的商品id',
  `is_delete` tinyint(1) NOT NULL COMMENT '软删除状态0删除1存在',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ic_tags` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
