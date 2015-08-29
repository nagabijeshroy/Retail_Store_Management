drop database if exists `nrscm`;
CREATE DATABASE IF NOT EXISTS `nrscm` /*!40100 DEFAULT CHARACTER SET utf8 */;
use `nrscm`;

CREATE TABLE `bill` (
  `bill_id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_amount` float DEFAULT NULL,
  `discount_availed` float DEFAULT NULL,
  `old_bill_ref` int(11) DEFAULT NULL,
  `card_id` int(11) DEFAULT NULL,
  `bill_date` varchar(20) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,	
  PRIMARY KEY (`bill_id`),
  KEY `billcardfk_idx` (`card_id`),
  KEY `oldbillreffk_idx` (`old_bill_ref`),
  KEY `storeidfk_idx` (`store_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `billitems` (
  `bill_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `store_id` int(11) DEFAULT NULL,
  `quantity` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`bill_id`,`item_id`),
  KEY `billitemsItemfk_idx` (`item_id`),
  KEY `storeidfk_idx` (`store_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `clearance` (
  `clearance_id` int(11) NOT NULL AUTO_INCREMENT,
  `clearance_name` varchar(30) DEFAULT NULL,
  `clearance_discount` float DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`clearance_id`),
  KEY `store_idclearancefk_idx` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `clearance_item` (
  `clearance_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`clearance_id`,`item_id`),
  KEY `itemclearancefk_idx` (`item_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `customercard` (
  `card_id` int(11) NOT NULL DEFAULT '0',
  `customer_name` varchar(20) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`card_id`),
  KEY `storeidfk_idx` (`store_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `department` (
  `departmentid` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(45) DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `department_head` varchar(45) DEFAULT NULL,
  `employee_id` int(11),
  PRIMARY KEY (`departmentid`),
  KEY `empldeptfk_idx` (`employee_id`),
  KEY `deptstoreidfk_idx` (`store_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(20) DEFAULT NULL,
  `item_ppu` decimal(10,2) DEFAULT NULL,
  `item_quantity` int(11) DEFAULT NULL,
  `dept_id` int(11) NOT NULL,
  `last_updated_by` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `itemdeptfk_idx` (`dept_id`),
  KEY `itemlastfk_idx` (`last_updated_by`),
  KEY `storeidfk_idx` (`store_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `login` (
  `username` varchar(10) NOT NULL,
  `password` varchar(15) DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`username`),
  KEY `loginempfk_idx` (`employee_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `promotion` (
  `promotion_id` int(11) NOT NULL AUTO_INCREMENT,
  `discountpercent` float DEFAULT NULL,
  `item_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`promotion_id`),
  KEY `itempromotionfk_idx` (`item_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `store` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(20) DEFAULT NULL,
  `store_location` varchar(20) DEFAULT NULL,
  `store_head` int(11) DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  KEY `empstoreheadfk_idx` (`store_head`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(30) DEFAULT NULL,
  `employee_designation` varchar(20) DEFAULT NULL,
  `employee_address` varchar(40) DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `is_storehead` tinyint(1) DEFAULT NULL,
  `is_depthead` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `storeidfk_idx` (`store_id`),
  KEY `empdeptfk_idx` (`dept_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Constraints-------------------------------------

ALTER TABLE `bill`
 ADD CONSTRAINT `billcardfk` FOREIGN KEY (`card_id`) REFERENCES `customercard` (`card_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 ADD CONSTRAINT `oldbillreffk` FOREIGN KEY (`old_bill_ref`) REFERENCES `bill` (`bill_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 ADD CONSTRAINT `storeidfk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `billitems`
ADD CONSTRAINT `billidfk` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 ADD CONSTRAINT `billitemsItemfk` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 ADD CONSTRAINT `billstoreidfk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `clearance`
 ADD CONSTRAINT `store_idclearancefk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `clearance_item`
 ADD CONSTRAINT `clearancefk` FOREIGN KEY (`clearance_id`) REFERENCES `clearance` (`clearance_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `itemclearancefk` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `storeidclritemfk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
  

ALTER TABLE `customercard`
ADD CONSTRAINT `cardstoreidfk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `department`
ADD CONSTRAINT `deptstoreidfk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 ADD CONSTRAINT `empldeptfk` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `item`
ADD CONSTRAINT `itemdeptfk` FOREIGN KEY (`dept_id`) REFERENCES `department` (`departmentid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 ADD CONSTRAINT `itemstorefk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 ADD CONSTRAINT `lastemplfk` FOREIGN KEY (`last_updated_by`) REFERENCES `employee` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `login`
ADD  CONSTRAINT `loginempfk` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `promotion`
ADD CONSTRAINT `itempromotionfk` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `storeidpromotionfk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `store`
ADD CONSTRAINT `empstoreheadfk` FOREIGN KEY (`store_head`) REFERENCES `employee` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `employee`
ADD CONSTRAINT `empdeptfk` FOREIGN KEY (`dept_id`) REFERENCES `department` (`departmentid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 ADD CONSTRAINT `empstoreidfk` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;