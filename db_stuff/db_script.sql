CREATE SCHEMA `cfx` ;

CREATE TABLE `projectResources` (
  `id` int(11) NOT NULL,
  `projectID` int(11) DEFAULT NULL,
  `resourceID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `image` varchar(45) DEFAULT NULL,
  `currentVersion` varchar(45) DEFAULT NULL,
  `projected` int(11) NOT NULL DEFAULT '0',
  `progress` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
);


CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `image` varchar(45) DEFAULT NULL,
  `last10builds` varchar(45) DEFAULT NULL,
  `openTickets` int(11) NOT NULL DEFAULT '0',
  `closedTickets` int(11) NOT NULL DEFAULT '0',
  `position` varchar(45) DEFAULT NULL,
  `ticketTrend` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
);



/* Populate ProjectResources Table */
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (1,1,1);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (2,1,4);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (3,1,8);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (4,2,2);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (5,2,5);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (6,2,9);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (7,3,3);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (8,3,6);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (9,3,10);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (10,4,2);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (11,4,7);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (12,4,8);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (13,5,1);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (14,5,4);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (15,5,5);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (16,6,3);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (17,6,6);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (18,6,10);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (19,3,4);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (20,6,1);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (21,6,4);
INSERT INTO `projectResources` (`id`,`projectID`,`resourceID`) VALUES (22,6,5);

/* Populate Projects Table */
INSERT INTO `projects` (`id`,`name`,`image`,`currentVersion`,`projected`,`progress`) VALUES (1,'Orion','or_icon_057.png','1.3.2',70,80);
INSERT INTO `projects` (`id`,`name`,`image`,`currentVersion`,`projected`,`progress`) VALUES (2,'Pluto','pl_icon_057.png','12.7',50,56);
INSERT INTO `projects` (`id`,`name`,`image`,`currentVersion`,`projected`,`progress`) VALUES (3,'Quasar','qu_icon_057.png','0.9.1',30,35);
INSERT INTO `projects` (`id`,`name`,`image`,`currentVersion`,`projected`,`progress`) VALUES (4,'Red Dwarf','re_icon_057.png','7.0.1',85,25);
INSERT INTO `projects` (`id`,`name`,`image`,`currentVersion`,`projected`,`progress`) VALUES (5,'Saturn','sa_icon_057.png','4.4',65,45);
INSERT INTO `projects` (`id`,`name`,`image`,`currentVersion`,`projected`,`progress`) VALUES (6,'Taurus','ta_icon_057.png','3.4.13',10,0);

/* Populate Resources Table */
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (1,'Cindy Hodges','cindy.png','',0,0,'Manager',NULL);
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (2,'Julia Jones','julia.png',NULL,0,0,'Manager',NULL);
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (3,'Charles Kline','ching.png',NULL,0,0,'Manager',NULL);
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (4,'Ben Gold','ben.png','1,1,1,1,1,-1,1,1,1,1',0,4,'Developer','down');
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (5,'Grace McGuire','grrl.png','1,1,1,1-,1,1,1,1,-1,-1',0,6,'Developer','down');
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (6,'Leo LaCrosse','leo.png','1,1,1,1,1,1,-1,-1,1,1',0,14,'Developer','up');
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (7,'Mike Garza','mike.png','1,1,1,1,1,1,1,1,1,1',0,9,'Developer','up');
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (8,'Kara Lott','kara.png',NULL,12,29,'QA','up');
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (9,'Lakshmi Mehra','lakshmi.png',NULL,8,20,'QA','down');
INSERT INTO `resources` (`id`,`name`,`image`,`last10builds`,`openTickets`,`closedTickets`,`position`,`ticketTrend`) VALUES (10,'Sonny Carroll','sonny.png',NULL,7,22,'QA','down');

