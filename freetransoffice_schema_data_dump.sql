-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: freetransoffice
-- ------------------------------------------------------
-- Server version	5.7.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `address_1` varchar(80) NOT NULL,
  `address_2` varchar(80) DEFAULT NULL,
  `city` varchar(30) NOT NULL,
  `state` varchar(3) DEFAULT NULL,
  `postalcode` varchar(10) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `uc_addr1_city` (`domain_id`,`address_1`,`city`),
  KEY `fk_add_country` (`country_id`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE,
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE,
  CONSTRAINT `addresses_ibfk_3` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_contacts`
--

DROP TABLE IF EXISTS `client_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_contacts` (
  `contact_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `primary_contact` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`contact_id`,`client_id`),
  KEY `fk_clc_client` (`client_id`),
  CONSTRAINT `client_contacts_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `client_contacts_ibfk_2` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `client_contacts_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_contacts`
--

LOCK TABLES `client_contacts` WRITE;
/*!40000 ALTER TABLE `client_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `client_name` varchar(100) NOT NULL,
  `other_name` varchar(100) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `package_id` int(11) DEFAULT NULL,
  `vendor_code` varchar(30) DEFAULT NULL,
  `client_status` int(11) NOT NULL,
  `last_completed_job` datetime DEFAULT NULL,
  `currency_id` int(11) NOT NULL,
  `timezone` varchar(30) NOT NULL,
  `invoice_to` int(11) DEFAULT NULL,
  `invoice_to_email` varchar(120) DEFAULT NULL,
  `invoice_notes` longtext,
  `inv_report_id` int(11) DEFAULT NULL,
  `invoice_by` int(11) DEFAULT NULL,
  `invoice_paid` int(11) DEFAULT NULL,
  `last_invoice` datetime DEFAULT NULL,
  `notes` longtext,
  `user_defined_1` varchar(255) DEFAULT NULL,
  `user_defined_2` varchar(255) DEFAULT NULL,
  `user_defined_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE KEY `uc_clientname` (`domain_id`,`client_name`),
  KEY `fk_cln_address` (`address_id`),
  KEY `fk_cln_package` (`package_id`),
  KEY `fk_cln_status` (`client_status`),
  KEY `fk_cln_currency` (`currency_id`),
  KEY `fk_cln_invoiceto` (`invoice_to`),
  KEY `fk_cln_cinvreport` (`inv_report_id`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_10` FOREIGN KEY (`client_status`) REFERENCES `statuses` (`status_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_11` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`currency_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_12` FOREIGN KEY (`invoice_to`) REFERENCES `contacts` (`contact_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_13` FOREIGN KEY (`inv_report_id`) REFERENCES `report_config` (`report_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_3` FOREIGN KEY (`client_status`) REFERENCES `statuses` (`status_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_4` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`currency_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_5` FOREIGN KEY (`invoice_to`) REFERENCES `contacts` (`contact_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_6` FOREIGN KEY (`inv_report_id`) REFERENCES `report_config` (`report_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_7` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_8` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `clients_ibfk_9` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `email` varchar(120) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `position_held` varchar(80) DEFAULT NULL,
  `contact_status` int(11) NOT NULL,
  `notes` longtext,
  PRIMARY KEY (`contact_id`),
  UNIQUE KEY `uc_name_email` (`domain_id`,`first_name`,`last_name`,`email`),
  KEY `fk_con_language` (`language_id`),
  KEY `fk_con_status` (`contact_status`),
  CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`) ON UPDATE CASCADE,
  CONSTRAINT `contacts_ibfk_2` FOREIGN KEY (`contact_status`) REFERENCES `statuses` (`status_id`) ON UPDATE CASCADE,
  CONSTRAINT `contacts_ibfk_3` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE,
  CONSTRAINT `contacts_ibfk_4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`) ON UPDATE CASCADE,
  CONSTRAINT `contacts_ibfk_5` FOREIGN KEY (`contact_status`) REFERENCES `statuses` (`status_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(2) NOT NULL,
  `country_name` varchar(120) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=736 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (491,'AF','Afghanistan'),(492,'AL','Albania'),(493,'DZ','Algeria'),(494,'DS','American Samoa'),(495,'AD','Andorra'),(496,'AO','Angola'),(497,'AI','Anguilla'),(498,'AQ','Antarctica'),(499,'AG','Antigua and Barbuda'),(500,'AR','Argentina'),(501,'AM','Armenia'),(502,'AW','Aruba'),(503,'AU','Australia'),(504,'AT','Austria'),(505,'AZ','Azerbaijan'),(506,'BS','Bahamas'),(507,'BH','Bahrain'),(508,'BD','Bangladesh'),(509,'BB','Barbados'),(510,'BY','Belarus'),(511,'BE','Belgium'),(512,'BZ','Belize'),(513,'BJ','Benin'),(514,'BM','Bermuda'),(515,'BT','Bhutan'),(516,'BO','Bolivia'),(517,'BA','Bosnia and Herzegovina'),(518,'BW','Botswana'),(519,'BV','Bouvet Island'),(520,'BR','Brazil'),(521,'IO','British Indian Ocean Territory'),(522,'BN','Brunei Darussalam'),(523,'BG','Bulgaria'),(524,'BF','Burkina Faso'),(525,'BI','Burundi'),(526,'KH','Cambodia'),(527,'CM','Cameroon'),(528,'CA','Canada'),(529,'CV','Cape Verde'),(530,'KY','Cayman Islands'),(531,'CF','Central African Republic'),(532,'TD','Chad'),(533,'CL','Chile'),(534,'CN','China'),(535,'CX','Christmas Island'),(536,'CC','Cocos (Keeling) Islands'),(537,'CO','Colombia'),(538,'KM','Comoros'),(539,'CG','Congo'),(540,'CK','Cook Islands'),(541,'CR','Costa Rica'),(542,'HR','Croatia (Hrvatska)'),(543,'CU','Cuba'),(544,'CY','Cyprus'),(545,'CZ','Czech Republic'),(546,'DK','Denmark'),(547,'DJ','Djibouti'),(548,'DM','Dominica'),(549,'DO','Dominican Republic'),(550,'TP','East Timor'),(551,'EC','Ecuador'),(552,'EG','Egypt'),(553,'SV','El Salvador'),(554,'GQ','Equatorial Guinea'),(555,'ER','Eritrea'),(556,'EE','Estonia'),(557,'ET','Ethiopia'),(558,'FK','Falkland Islands (Malvinas)'),(559,'FO','Faroe Islands'),(560,'FJ','Fiji'),(561,'FI','Finland'),(562,'FR','France'),(563,'FX','France, Metropolitan'),(564,'GF','French Guiana'),(565,'PF','French Polynesia'),(566,'TF','French Southern Territories'),(567,'GA','Gabon'),(568,'GM','Gambia'),(569,'GE','Georgia'),(570,'DE','Germany'),(571,'GH','Ghana'),(572,'GI','Gibraltar'),(573,'GK','Guernsey'),(574,'GR','Greece'),(575,'GL','Greenland'),(576,'GD','Grenada'),(577,'GP','Guadeloupe'),(578,'GU','Guam'),(579,'GT','Guatemala'),(580,'GN','Guinea'),(581,'GW','Guinea-Bissau'),(582,'GY','Guyana'),(583,'HT','Haiti'),(584,'HM','Heard and Mc Donald Islands'),(585,'HN','Honduras'),(586,'HK','Hong Kong'),(587,'HU','Hungary'),(588,'IS','Iceland'),(589,'IN','India'),(590,'IM','Isle of Man'),(591,'ID','Indonesia'),(592,'IR','Iran (Islamic Republic of)'),(593,'IQ','Iraq'),(594,'IE','Ireland'),(595,'IL','Israel'),(596,'IT','Italy'),(597,'CI','Ivory Coast'),(598,'JE','Jersey'),(599,'JM','Jamaica'),(600,'JP','Japan'),(601,'JO','Jordan'),(602,'KZ','Kazakhstan'),(603,'KE','Kenya'),(604,'KI','Kiribati'),(605,'KP','Korea, Democratic People\'s Republic of'),(606,'KR','Korea, Republic of'),(607,'XK','Kosovo'),(608,'KW','Kuwait'),(609,'KG','Kyrgyzstan'),(610,'LA','Lao People\'s Democratic Republic'),(611,'LV','Latvia'),(612,'LB','Lebanon'),(613,'LS','Lesotho'),(614,'LR','Liberia'),(615,'LY','Libyan Arab Jamahiriya'),(616,'LI','Liechtenstein'),(617,'LT','Lithuania'),(618,'LU','Luxembourg'),(619,'MO','Macau'),(620,'MK','Macedonia'),(621,'MG','Madagascar'),(622,'MW','Malawi'),(623,'MY','Malaysia'),(624,'MV','Maldives'),(625,'ML','Mali'),(626,'MT','Malta'),(627,'MH','Marshall Islands'),(628,'MQ','Martinique'),(629,'MR','Mauritania'),(630,'MU','Mauritius'),(631,'TY','Mayotte'),(632,'MX','Mexico'),(633,'FM','Micronesia, Federated States of'),(634,'MD','Moldova, Republic of'),(635,'MC','Monaco'),(636,'MN','Mongolia'),(637,'ME','Montenegro'),(638,'MS','Montserrat'),(639,'MA','Morocco'),(640,'MZ','Mozambique'),(641,'MM','Myanmar'),(642,'NA','Namibia'),(643,'NR','Nauru'),(644,'NP','Nepal'),(645,'NL','Netherlands'),(646,'AN','Netherlands Antilles'),(647,'NC','New Caledonia'),(648,'NZ','New Zealand'),(649,'NI','Nicaragua'),(650,'NE','Niger'),(651,'NG','Nigeria'),(652,'NU','Niue'),(653,'NF','Norfolk Island'),(654,'MP','Northern Mariana Islands'),(655,'NO','Norway'),(656,'OM','Oman'),(657,'PK','Pakistan'),(658,'PW','Palau'),(659,'PS','Palestine'),(660,'PA','Panama'),(661,'PG','Papua New Guinea'),(662,'PY','Paraguay'),(663,'PE','Peru'),(664,'PH','Philippines'),(665,'PN','Pitcairn'),(666,'PL','Poland'),(667,'PT','Portugal'),(668,'PR','Puerto Rico'),(669,'QA','Qatar'),(670,'RE','Reunion'),(671,'RO','Romania'),(672,'RU','Russian Federation'),(673,'RW','Rwanda'),(674,'KN','Saint Kitts and Nevis'),(675,'LC','Saint Lucia'),(676,'VC','Saint Vincent and the Grenadines'),(677,'WS','Samoa'),(678,'SM','San Marino'),(679,'ST','Sao Tome and Principe'),(680,'SA','Saudi Arabia'),(681,'SN','Senegal'),(682,'RS','Serbia'),(683,'SC','Seychelles'),(684,'SL','Sierra Leone'),(685,'SG','Singapore'),(686,'SK','Slovakia'),(687,'SI','Slovenia'),(688,'SB','Solomon Islands'),(689,'SO','Somalia'),(690,'ZA','South Africa'),(691,'GS','South Georgia South Sandwich Islands'),(692,'ES','Spain'),(693,'LK','Sri Lanka'),(694,'SH','St. Helena'),(695,'PM','St. Pierre and Miquelon'),(696,'SD','Sudan'),(697,'SR','Suriname'),(698,'SJ','Svalbard and Jan Mayen Islands'),(699,'SZ','Swaziland'),(700,'SE','Sweden'),(701,'CH','Switzerland'),(702,'SY','Syrian Arab Republic'),(703,'TW','Taiwan'),(704,'TJ','Tajikistan'),(705,'TZ','Tanzania, United Republic of'),(706,'TH','Thailand'),(707,'TG','Togo'),(708,'TK','Tokelau'),(709,'TO','Tonga'),(710,'TT','Trinidad and Tobago'),(711,'TN','Tunisia'),(712,'TR','Turkey'),(713,'TM','Turkmenistan'),(714,'TC','Turks and Caicos Islands'),(715,'TV','Tuvalu'),(716,'UG','Uganda'),(717,'UA','Ukraine'),(718,'AE','United Arab Emirates'),(719,'GB','United Kingdom'),(720,'US','United States'),(721,'UM','United States minor outlying islands'),(722,'UY','Uruguay'),(723,'UZ','Uzbekistan'),(724,'VU','Vanuatu'),(725,'VA','Vatican City State'),(726,'VE','Venezuela'),(727,'VN','Vietnam'),(728,'VG','Virgin Islands (British)'),(729,'VI','Virgin Islands (U.S.)'),(730,'WF','Wallis and Futuna Islands'),(731,'EH','Western Sahara'),(732,'YE','Yemen'),(733,'ZR','Zaire'),(734,'ZM','Zambia'),(735,'ZW','Zimbabwe');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_code` varchar(3) NOT NULL,
  `currency_name` varchar(100) NOT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=331 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (166,'AED','UAE Dirham'),(167,'AFN','Afghani'),(168,'ALL','Lek'),(169,'AMD','Armenian Dram'),(170,'ANG','Netherlands Antillean Guilder'),(171,'AOA','Kwanza'),(172,'ARS','Argentine Peso'),(173,'AUD','Australian Dollar'),(174,'AWG','Aruban Florin'),(175,'AZN','Azerbaijan Manat'),(176,'BAM','Convertible Mark'),(177,'BBD','Barbados Dollar'),(178,'BDT','Taka'),(179,'BGN','Bulgarian Lev'),(180,'BHD','Bahraini Dinar'),(181,'BIF','Burundi Franc'),(182,'BMD','Bermudian Dollar'),(183,'BND','Brunei Dollar'),(184,'BOB','Boliviano'),(185,'BOV','Mvdol'),(186,'BRL','Brazilian Real'),(187,'BSD','Bahamian Dollar'),(188,'BTN','Ngultrum'),(189,'BWP','Pula'),(190,'BYN','Belarusian Ruble'),(191,'BZD','Belize Dollar'),(192,'CAD','Canadian Dollar'),(193,'CDF','Congolese Franc'),(194,'CHE','WIR Euro'),(195,'CHF','Swiss Franc'),(196,'CHW','WIR Franc'),(197,'CLF','Unidad de Fomento'),(198,'CLP','Chilean Peso'),(199,'CNY','Yuan Renminbi'),(200,'COP','Colombian Peso'),(201,'COU','Unidad de Valor Real'),(202,'CRC','Costa Rican Colon'),(203,'CUC','Peso Convertible'),(204,'CUP','Cuban Peso'),(205,'CVE','Cabo Verde Escudo'),(206,'CZK','Czech Koruna'),(207,'DJF','Djibouti Franc'),(208,'DKK','Danish Krone'),(209,'DOP','Dominican Peso'),(210,'DZD','Algerian Dinar'),(211,'EGP','Egyptian Pound'),(212,'ERN','Nakfa'),(213,'ETB','Ethiopian Birr'),(214,'EUR','Euro'),(215,'FJD','Fiji Dollar'),(216,'FKP','Falkland Islands Pound'),(217,'GBP','Pound Sterling'),(218,'GEL','Lari'),(219,'GHS','Ghana Cedi'),(220,'GIP','Gibraltar Pound'),(221,'GMD','Dalasi'),(222,'GNF','Guinean Franc'),(223,'GTQ','Quetzal'),(224,'GYD','Guyana Dollar'),(225,'HKD','Hong Kong Dollar'),(226,'HNL','Lempira'),(227,'HRK','Kuna'),(228,'HTG','Gourde'),(229,'HUF','Forint'),(230,'IDR','Rupiah'),(231,'ILS','New Israeli Sheqel'),(232,'INR','Indian Rupee'),(233,'IQD','Iraqi Dinar'),(234,'IRR','Iranian Rial'),(235,'ISK','Iceland Krona'),(236,'JMD','Jamaican Dollar'),(237,'JOD','Jordanian Dinar'),(238,'JPY','Yen'),(239,'KES','Kenyan Shilling'),(240,'KGS','Som'),(241,'KHR','Riel'),(242,'KMF','Comorian Franc '),(243,'KPW','North Korean Won'),(244,'KRW','Won'),(245,'KWD','Kuwaiti Dinar'),(246,'KYD','Cayman Islands Dollar'),(247,'KZT','Tenge'),(248,'LAK','Lao Kip'),(249,'LBP','Lebanese Pound'),(250,'LKR','Sri Lanka Rupee'),(251,'LRD','Liberian Dollar'),(252,'LSL','Loti'),(253,'LYD','Libyan Dinar'),(254,'MAD','Moroccan Dirham'),(255,'MDL','Moldovan Leu'),(256,'MGA','Malagasy Ariary'),(257,'MKD','Denar'),(258,'MMK','Kyat'),(259,'MNT','Tugrik'),(260,'MOP','Pataca'),(261,'MRO','Ouguiya'),(262,'MUR','Mauritius Rupee'),(263,'MVR','Rufiyaa'),(264,'MWK','Malawi Kwacha'),(265,'MXN','Mexican Peso'),(266,'MXV','Mexican Unidad de Inversion (UDI)'),(267,'MYR','Malaysian Ringgit'),(268,'MZN','Mozambique Metical'),(269,'NAD','Namibia Dollar'),(270,'NGN','Naira'),(271,'NIO','Cordoba Oro'),(272,'NOK','Norwegian Krone'),(273,'NPR','Nepalese Rupee'),(274,'NZD','New Zealand Dollar'),(275,'OMR','Rial Omani'),(276,'PAB','Balboa'),(277,'PEN','Sol'),(278,'PGK','Kina'),(279,'PHP','Philippine Piso'),(280,'PKR','Pakistan Rupee'),(281,'PLN','Zloty'),(282,'PYG','Guarani'),(283,'QAR','Qatari Rial'),(284,'RON','Romanian Leu'),(285,'RSD','Serbian Dinar'),(286,'RUB','Russian Ruble'),(287,'RWF','Rwanda Franc'),(288,'SAR','Saudi Riyal'),(289,'SBD','Solomon Islands Dollar'),(290,'SCR','Seychelles Rupee'),(291,'SDG','Sudanese Pound'),(292,'SEK','Swedish Krona'),(293,'SGD','Singapore Dollar'),(294,'SHP','Saint Helena Pound'),(295,'SLL','Leone'),(296,'SOS','Somali Shilling'),(297,'SRD','Surinam Dollar'),(298,'SSP','South Sudanese Pound'),(299,'STD','Dobra'),(300,'SVC','El Salvador Colon'),(301,'SYP','Syrian Pound'),(302,'SZL','Lilangeni'),(303,'THB','Baht'),(304,'TJS','Somoni'),(305,'TMT','Turkmenistan New Manat'),(306,'TND','Tunisian Dinar'),(307,'TOP','Pa anga'),(308,'TRY','Turkish Lira'),(309,'TTD','Trinidad and Tobago Dollar'),(310,'TWD','New Taiwan Dollar'),(311,'TZS','Tanzanian Shilling'),(312,'UAH','Hryvnia'),(313,'UGX','Uganda Shilling'),(314,'USD','US Dollar'),(315,'UYI','Uruguay Peso en Unidades Indexadas (URUIURUI)'),(316,'UYU','Peso Uruguayo'),(317,'UZS','Uzbekistan Sum'),(318,'VEF','Bolívar'),(319,'VND','Dong'),(320,'VUV','Vatu'),(321,'WST','Tala'),(322,'XAF','CFA Franc BEAC'),(323,'XCD','East Caribbean Dollar'),(324,'XOF','CFA Franc BCEAO'),(325,'XPD','Palladium'),(326,'XPF','CFP Franc'),(327,'YER','Yemeni Rial'),(328,'ZAR','Rand'),(329,'ZMW','Zambian Kwacha'),(330,'ZWL','Zimbabwe Dollar');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `document_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `document_path` varchar(255) NOT NULL,
  PRIMARY KEY (`document_id`),
  KEY `documents_ibfk_1_idx` (`domain_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domains` (
  `domain_id` int(11) NOT NULL AUTO_INCREMENT,
  `primary_user_id` int(11) NOT NULL,
  PRIMARY KEY (`domain_id`),
  UNIQUE KEY `primary_user_id` (`primary_user_id`),
  CONSTRAINT `domains_ibfk_1` FOREIGN KEY (`primary_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domains`
--

LOCK TABLES `domains` WRITE;
/*!40000 ALTER TABLE `domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `end_clients`
--

DROP TABLE IF EXISTS `end_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `end_clients` (
  `end_client_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `end_client_name` varchar(120) NOT NULL,
  `client_id` int(11) NOT NULL,
  `industry_id` int(11) DEFAULT NULL,
  `date_first_job` datetime DEFAULT NULL,
  `date_last_job` datetime DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`end_client_id`),
  UNIQUE KEY `uc_endclientname` (`domain_id`,`end_client_name`),
  KEY `end_clients_ibfk_3_idx` (`client_id`),
  KEY `end_clients_ibfk_2` (`industry_id`),
  CONSTRAINT `end_clients_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE,
  CONSTRAINT `end_clients_ibfk_2` FOREIGN KEY (`industry_id`) REFERENCES `industries` (`industry_id`) ON DELETE SET NULL,
  CONSTRAINT `end_clients_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `end_clients`
--

LOCK TABLES `end_clients` WRITE;
/*!40000 ALTER TABLE `end_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `end_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_list`
--

DROP TABLE IF EXISTS `field_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_list` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(30) NOT NULL,
  `column_name` varchar(60) NOT NULL,
  `alt_field_name` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `table_name_column_name_UNIQUE` (`table_name`,`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_list`
--

LOCK TABLES `field_list` WRITE;
/*!40000 ALTER TABLE `field_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `industries`
--

DROP TABLE IF EXISTS `industries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industries` (
  `industry_id` int(11) NOT NULL AUTO_INCREMENT,
  `industry_name` varchar(100) NOT NULL,
  PRIMARY KEY (`industry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `industries`
--

LOCK TABLES `industries` WRITE;
/*!40000 ALTER TABLE `industries` DISABLE KEYS */;
INSERT INTO `industries` VALUES (21,'Agriculture, Forestry, Fishing and Hunting'),(22,'Mining'),(23,'Utilities'),(24,'Construction'),(25,'Manufacturing'),(26,'Wholesale Trade'),(27,'Retail Trade'),(28,'Transportation and Warehousing'),(29,'Information'),(30,'Finance and Insurance'),(31,'Real Estate Rental and Leasing'),(32,'Professional, Scientific, and Technical Services'),(33,'Management of Companies and Enterprises'),(34,'Administrative and Support and Waste Management and Remediation Services'),(35,'Educational Services'),(36,'Health Care and Social Assistance'),(37,'Arts, Entertainment, and Recreation'),(38,'Accommodation and Food Services'),(39,'Other Services (except Public Administration)'),(40,'Public Administration');
/*!40000 ALTER TABLE `industries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_header_temp`
--

DROP TABLE IF EXISTS `invoice_header_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_header_temp` (
  `temp_invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_number` varchar(12) DEFAULT NULL,
  `invoice_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `invoice_total` decimal(19,4) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`temp_invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_header_temp`
--

LOCK TABLES `invoice_header_temp` WRITE;
/*!40000 ALTER TABLE `invoice_header_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_header_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_jobs_temp`
--

DROP TABLE IF EXISTS `invoice_jobs_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_jobs_temp` (
  `temp_invoice_id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`temp_invoice_id`,`domain_id`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_jobs_temp`
--

LOCK TABLES `invoice_jobs_temp` WRITE;
/*!40000 ALTER TABLE `invoice_jobs_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_jobs_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `invoice_number` varchar(12) NOT NULL,
  `invoice_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `client_id` int(11) NOT NULL,
  `invoice_total` decimal(19,4) NOT NULL,
  `received_amount` decimal(19,4) DEFAULT NULL,
  `received_date` datetime DEFAULT NULL,
  `invoice_status` int(11) NOT NULL,
  `invoice_document_id` int(11) DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`invoice_id`),
  UNIQUE KEY `uc_invoice_number` (`domain_id`,`invoice_number`),
  KEY `fk_inv_client` (`client_id`),
  KEY `fk_inv_status` (`invoice_status`),
  KEY `invoices_ibfk_7` (`invoice_document_id`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`invoice_status`) REFERENCES `statuses` (`status_id`) ON UPDATE CASCADE,
  CONSTRAINT `invoices_ibfk_3` FOREIGN KEY (`invoice_document_id`) REFERENCES `documents` (`document_id`) ON UPDATE CASCADE,
  CONSTRAINT `invoices_ibfk_4` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE,
  CONSTRAINT `invoices_ibfk_5` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `invoices_ibfk_6` FOREIGN KEY (`invoice_status`) REFERENCES `statuses` (`status_id`) ON UPDATE CASCADE,
  CONSTRAINT `invoices_ibfk_7` FOREIGN KEY (`invoice_document_id`) REFERENCES `documents` (`document_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_profiles`
--

DROP TABLE IF EXISTS `job_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_profiles` (
  `job_profile_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `job_profile_name` varchar(50) NOT NULL,
  `job_type_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `end_client_id` int(11) DEFAULT NULL,
  `package_id` int(11) DEFAULT NULL,
  `words_per_hour` int(11) DEFAULT NULL,
  `job_type_multiplier` int(11) DEFAULT NULL,
  `notes` longtext,
  PRIMARY KEY (`job_profile_id`),
  UNIQUE KEY `uc_jobprofilename` (`domain_id`,`job_profile_name`),
  KEY `fk_prf_client` (`client_id`),
  KEY `fk_prf_package` (`package_id`),
  KEY `fk_prf_endclient` (`end_client_id`),
  KEY `job_profiles_ibfk_6` (`job_type_id`),
  CONSTRAINT `job_profiles_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `job_profiles_ibfk_2` FOREIGN KEY (`job_type_id`) REFERENCES `job_types` (`job_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `job_profiles_ibfk_3` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`) ON UPDATE CASCADE,
  CONSTRAINT `job_profiles_ibfk_4` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE,
  CONSTRAINT `job_profiles_ibfk_5` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `job_profiles_ibfk_6` FOREIGN KEY (`job_type_id`) REFERENCES `job_types` (`job_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `job_profiles_ibfk_7` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`) ON UPDATE CASCADE,
  CONSTRAINT `job_profiles_ibfk_8` FOREIGN KEY (`end_client_id`) REFERENCES `end_clients` (`end_client_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_profiles`
--

LOCK TABLES `job_profiles` WRITE;
/*!40000 ALTER TABLE `job_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_types`
--

DROP TABLE IF EXISTS `job_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_types` (
  `job_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `job_type` varchar(40) NOT NULL,
  `words_per_hour` int(11) NOT NULL,
  `notes` longtext,
  PRIMARY KEY (`job_type_id`),
  KEY `fk_jtp_domain` (`domain_id`),
  CONSTRAINT `job_types_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_types`
--

LOCK TABLES `job_types` WRITE;
/*!40000 ALTER TABLE `job_types` DISABLE KEYS */;
INSERT INTO `job_types` VALUES (7,0,'Default Translation',250,''),(8,0,'Default Proof Reading',350,''),(9,0,'Default Editing',450,''),(10,0,'Default Post Editing',500,'');
/*!40000 ALTER TABLE `job_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `job_number` varchar(12) NOT NULL,
  `client_id` int(11) NOT NULL,
  `end_client_id` int(11) DEFAULT NULL,
  `client_job_number` varchar(20) NOT NULL,
  `job_type_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `package_id` int(11) DEFAULT NULL,
  `date_received` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_due` datetime NOT NULL,
  `word_count` int(11) DEFAULT NULL,
  `price_currency_id` int(11) DEFAULT NULL,
  `price` decimal(19,4) DEFAULT NULL,
  `job_profile_id` int(11) DEFAULT NULL,
  `estimated_time` int(11) DEFAULT NULL,
  `actual_time` int(11) DEFAULT NULL,
  `job_status` int(11) NOT NULL,
  `completed_date` datetime DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `notes` longtext,
  `user_defined_1` varchar(255) DEFAULT NULL,
  `user_defined_2` varchar(255) DEFAULT NULL,
  `user_defined_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`job_id`),
  UNIQUE KEY `uc_job_number` (`domain_id`,`job_number`),
  UNIQUE KEY `uc_client_job_number` (`domain_id`,`client_job_number`),
  KEY `fk_job_client` (`client_id`),
  KEY `fk_job_endclient` (`end_client_id`),
  KEY `fk_job_package` (`package_id`),
  KEY `fk_job_pricecurrency` (`price_currency_id`),
  KEY `fk_job_jobprofile` (`job_profile_id`),
  KEY `fk_job_status` (`job_status`),
  KEY `fk_job_invoice` (`invoice_id`),
  KEY `jobs_ibfk_3` (`job_type_id`),
  CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_10` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_11` FOREIGN KEY (`end_client_id`) REFERENCES `end_clients` (`end_client_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_12` FOREIGN KEY (`job_type_id`) REFERENCES `job_types` (`job_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_13` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_14` FOREIGN KEY (`price_currency_id`) REFERENCES `currencies` (`currency_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_15` FOREIGN KEY (`job_profile_id`) REFERENCES `job_profiles` (`job_profile_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_16` FOREIGN KEY (`job_status`) REFERENCES `statuses` (`status_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_17` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_2` FOREIGN KEY (`end_client_id`) REFERENCES `end_clients` (`end_client_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_3` FOREIGN KEY (`job_type_id`) REFERENCES `job_types` (`job_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_4` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_5` FOREIGN KEY (`price_currency_id`) REFERENCES `currencies` (`currency_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_6` FOREIGN KEY (`job_profile_id`) REFERENCES `job_profiles` (`job_profile_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_7` FOREIGN KEY (`job_status`) REFERENCES `statuses` (`status_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_8` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_9` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `language_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_code` varchar(3) NOT NULL,
  `language_name` varchar(30) NOT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=365 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (183,'aa','Afar'),(184,'ab','Abkhazian'),(185,'ae','Avestan'),(186,'af','Afrikaans'),(187,'ak','Akan'),(188,'am','Amharic'),(189,'an','Aragonese'),(190,'ar','Arabic'),(191,'as','Assamese'),(192,'av','Avaric'),(193,'ay','Aymara'),(194,'az','Azerbaijani'),(195,'ba','Bashkir'),(196,'be','Belarusian'),(197,'bg','Bulgarian'),(198,'bh','Bihari languages'),(199,'bi','Bislama'),(200,'bm','Bambara'),(201,'bn','Bengali'),(202,'bo','Tibetan'),(203,'br','Breton'),(204,'bs','Bosnian'),(205,'ca','Catalan'),(206,'ce','Chechen'),(207,'ch','Chamorro'),(208,'co','Corsican'),(209,'cr','Cree'),(210,'cs','Czech'),(211,'cu','Church Slavic'),(212,'cv','Chuvash'),(213,'cy','Welsh'),(214,'da','Danish'),(215,'de','German'),(216,'dv','Maldivian'),(217,'dz','Dzongkha'),(218,'ee','Ewe'),(219,'el','Greek Modern'),(220,'en','English'),(221,'eo','Esperanto'),(222,'es','Spanish'),(223,'et','Estonian'),(224,'eu','Basque'),(225,'fa','Persian'),(226,'ff','Fulah'),(227,'fi','Finnish'),(228,'fj','Fijian'),(229,'fo','Faroese'),(230,'fr','French'),(231,'fy','Western Frisian'),(232,'ga','Irish'),(233,'gd','Scottish Gaelic'),(234,'gl','Galician'),(235,'gu','Gujarati'),(236,'gv','Manx'),(237,'ha','Hausa'),(238,'he','Hebrew'),(239,'hi','Hindi'),(240,'ho','Hiri Motu'),(241,'hr','Croatian'),(242,'ht','Haitian'),(243,'hu','Hungarian'),(244,'hy','Armenian'),(245,'hz','Herero'),(246,'ia','Interlingua'),(247,'id','Indonesian'),(248,'ig','Igbo'),(249,'ii','Sichuan Yi'),(250,'ik','Inupiaq'),(251,'io','Ido'),(252,'is','Icelandic'),(253,'it','Italian'),(254,'iu','Inuktitut'),(255,'ja','Japanese'),(256,'jv','Javanese'),(257,'ka','Georgian'),(258,'kg','Kongo'),(259,'ki','Kikuyu'),(260,'kj','Kwanyama'),(261,'kk','Kazakh'),(262,'kl','Greenlandic'),(263,'km','Central Khmer'),(264,'kn','Kannada'),(265,'ko','Korean'),(266,'kr','Kanuri'),(267,'ks','Kashmiri'),(268,'ku','Kurdish'),(269,'kv','Komi'),(270,'kw','Cornish'),(271,'ky','Kirghiz'),(272,'la','Latin'),(273,'lb','Luxembourgish'),(274,'lg','Ganda'),(275,'li','Limburgan'),(276,'ln','Lingala'),(277,'lo','Lao'),(278,'lt','Lithuanian'),(279,'lu','Luba-Katanga'),(280,'lv','Latvian'),(281,'mg','Malagasy'),(282,'mh','Marshallese'),(283,'mi','Maori'),(284,'mk','Macedonian'),(285,'ml','Malayalam'),(286,'mn','Mongolian'),(287,'mr','Marathi'),(288,'ms','Malay'),(289,'mt','Maltese'),(290,'my','Burmese'),(291,'na','Nauru'),(292,'nb','Norwegian Bokmål'),(293,'nd','North Ndebele'),(294,'ne','Nepali'),(295,'ng','Ndonga'),(296,'nl','Dutch'),(297,'nn','Norwegian Nynorsk'),(298,'no','Norwegian'),(299,'nr','South Ndebele'),(300,'nv','Navajo'),(301,'ny','Chichewa'),(302,'oc','Occitan'),(303,'oj','Ojibwa'),(304,'om','Oromo'),(305,'or','Oriya'),(306,'os','Ossetian'),(307,'pa','Punjabi'),(308,'pi','Pali'),(309,'pl','Polish'),(310,'ps','Pashto'),(311,'pt','Portuguese'),(312,'qu','Quechua'),(313,'rm','Romansh'),(314,'rn','Rundi'),(315,'ro','Romanian'),(316,'ru','Russian'),(317,'rw','Kinyarwanda'),(318,'sa','Sanskrit'),(319,'sc','Sardinian'),(320,'sd','Sindhi'),(321,'se','Northern Sami'),(322,'sg','Sango'),(323,'si','Sinhalese'),(324,'sk','Slovak'),(325,'sl','Slovenian'),(326,'sm','Samoan'),(327,'sn','Shona'),(328,'so','Somali'),(329,'sq','Albanian'),(330,'sr','Serbian'),(331,'ss','Swati'),(332,'st','Southern Sotho'),(333,'su','Sundanese'),(334,'sv','Swedish'),(335,'sw','Swahili'),(336,'ta','Tamil'),(337,'te','Telugu'),(338,'tg','Tajik'),(339,'th','Thai'),(340,'ti','Tigrinya'),(341,'tk','Turkmen'),(342,'tl','Tagalog'),(343,'tn','Tswana'),(344,'to','Tonga'),(345,'tr','Turkish'),(346,'ts','Tsonga'),(347,'tt','Tatar'),(348,'tw','Twi'),(349,'ty','Tahitian'),(350,'ug','Uighur'),(351,'uk','Ukrainian'),(352,'ur','Urdu'),(353,'uz','Uzbek'),(354,'ve','Venda'),(355,'vi','Vietnamese'),(356,'vo','Volapük'),(357,'wa','Walloon'),(358,'wo','Wolof'),(359,'xh','Xhosa'),(360,'yi','Yiddish'),(361,'yo','Yoruba'),(362,'za','Zhuang'),(363,'zh','Chinese'),(364,'zu','Zulu');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packages` (
  `package_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `package_name` varchar(120) NOT NULL,
  `notes` longtext,
  PRIMARY KEY (`package_id`),
  KEY `fk_pck_domain` (`domain_id`),
  CONSTRAINT `packages_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` VALUES (16,0,'PDF',NULL),(17,0,'MS Word',NULL),(18,0,'MS Excel',NULL),(19,0,'MS PowerPoint',NULL);
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_config`
--

DROP TABLE IF EXISTS `report_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_config` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `report_name` varchar(120) NOT NULL,
  `report_type` int(11) NOT NULL,
  `report_format_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `date_format` int(11) NOT NULL,
  `greeting_text` varchar(120) DEFAULT NULL,
  `opening_text` varchar(255) DEFAULT NULL,
  `invoice_number_label` varchar(20) DEFAULT NULL,
  `col_a_label` varchar(30) DEFAULT NULL,
  `col_a_field` varchar(50) DEFAULT NULL,
  `col_b_label` varchar(30) DEFAULT NULL,
  `col_b_field` varchar(50) DEFAULT NULL,
  `col_c_label` varchar(30) DEFAULT NULL,
  `col_c_field` varchar(50) DEFAULT NULL,
  `col_d_label` varchar(30) DEFAULT NULL,
  `col_d_field` varchar(50) DEFAULT NULL,
  `col_e_label` varchar(30) DEFAULT NULL,
  `col_e_field` varchar(50) DEFAULT NULL,
  `col_f_label` varchar(30) DEFAULT NULL,
  `col_f_field` varchar(50) DEFAULT NULL,
  `col_g_label` varchar(30) DEFAULT NULL,
  `col_g_field` varchar(50) DEFAULT NULL,
  `col_h_label` varchar(30) DEFAULT NULL,
  `col_h_field` varchar(50) DEFAULT NULL,
  `invoice_total_label` varchar(30) DEFAULT NULL,
  `section_a_label` varchar(30) DEFAULT NULL,
  `section_a_field_label_1` varchar(30) DEFAULT NULL,
  `section_a_field_1` varchar(50) DEFAULT NULL,
  `section_a_field_label_2` varchar(30) DEFAULT NULL,
  `section_a_field_2` varchar(50) DEFAULT NULL,
  `section_a_field_label_3` varchar(30) DEFAULT NULL,
  `section_a_field_3` varchar(50) DEFAULT NULL,
  `section_b_label` varchar(30) DEFAULT NULL,
  `section_b_field_label_1` varchar(30) DEFAULT NULL,
  `section_b_field_1` varchar(50) DEFAULT NULL,
  `section_b_field_label_2` varchar(30) DEFAULT NULL,
  `section_b_field_2` varchar(50) DEFAULT NULL,
  `section_b_field_label_3` varchar(30) DEFAULT NULL,
  `section_b_field_3` varchar(50) DEFAULT NULL,
  `closing_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `uc_report_name` (`domain_id`,`report_name`),
  KEY `fk_rep_reptype` (`report_type`),
  KEY `report_config_ibfk_5_idx` (`report_format_id`),
  KEY `report_config_ibfk_5_idx1` (`template_id`),
  CONSTRAINT `report_config_ibfk_1` FOREIGN KEY (`report_type`) REFERENCES `report_types` (`report_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `report_config_ibfk_20` FOREIGN KEY (`report_format_id`) REFERENCES `report_formats` (`report_format_id`) ON UPDATE CASCADE,
  CONSTRAINT `report_config_ibfk_3` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON UPDATE CASCADE,
  CONSTRAINT `report_config_ibfk_4` FOREIGN KEY (`report_type`) REFERENCES `report_types` (`report_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `report_config_ibfk_5` FOREIGN KEY (`template_id`) REFERENCES `templates` (`template_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_config`
--

LOCK TABLES `report_config` WRITE;
/*!40000 ALTER TABLE `report_config` DISABLE KEYS */;
INSERT INTO `report_config` VALUES (1,0,'Default Invoice PDF',1,1,1,3,'Dear Sir / Madam','Please see below an invoice for all completed work within the last 30 days.','Invoice Number','Client Job Number','client_job_number','Word Count','word_count','Description','job_description','Date Completed','completed_date','Notes','job_notes',NULL,NULL,NULL,NULL,NULL,NULL,'Invoice total','My Details:','My Name','user_full_name',NULL,'user_email',NULL,'user_company_name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Best regards,');
/*!40000 ALTER TABLE `report_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_formats`
--

DROP TABLE IF EXISTS `report_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_formats` (
  `report_format_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_format` varchar(20) NOT NULL,
  PRIMARY KEY (`report_format_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_formats`
--

LOCK TABLES `report_formats` WRITE;
/*!40000 ALTER TABLE `report_formats` DISABLE KEYS */;
INSERT INTO `report_formats` VALUES (1,'PDF'),(2,'DOCX');
/*!40000 ALTER TABLE `report_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_types`
--

DROP TABLE IF EXISTS `report_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_types` (
  `report_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_type` varchar(20) NOT NULL,
  PRIMARY KEY (`report_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_types`
--

LOCK TABLES `report_types` WRITE;
/*!40000 ALTER TABLE `report_types` DISABLE KEYS */;
INSERT INTO `report_types` VALUES (1,'Invoice');
/*!40000 ALTER TABLE `report_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_questions`
--

DROP TABLE IF EXISTS `security_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_questions` (
  `security_question_id` int(11) NOT NULL AUTO_INCREMENT,
  `security_question` varchar(255) NOT NULL,
  PRIMARY KEY (`security_question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_questions`
--

LOCK TABLES `security_questions` WRITE;
/*!40000 ALTER TABLE `security_questions` DISABLE KEYS */;
INSERT INTO `security_questions` VALUES (7,'What is your oldest cousin\'s first and last name?'),(8,'What is your maternal grandmother\'s maiden name?'),(9,'What is the first name of the boy or girl that you first kissed?'),(10,'What is the name of a college you applied to but didn\'t attend?'),(11,'In what city did you meet your spouse/significant other?'),(12,'What was the name of your first stuffed animal?');
/*!40000 ALTER TABLE `security_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statuses` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` VALUES (8,'Active'),(9,'Inactive'),(10,'Dormant'),(11,'Open'),(12,'Complete'),(13,'Invoiced'),(14,'Voided');
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templates` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(50) NOT NULL,
  `template_path` varchar(100) NOT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `password_hash` char(60) NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `email` varchar(120) NOT NULL,
  `phone_number` varchar(25) DEFAULT NULL,
  `security_question` int(11) NOT NULL,
  `security_answer` char(60) NOT NULL,
  `company_name` varchar(120) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `logo_document_id` int(11) DEFAULT NULL,
  `jobnum_prefix` varchar(5) DEFAULT NULL,
  `jobnum_next` int(11) DEFAULT NULL,
  `invnum_prefix` varchar(5) DEFAULT NULL,
  `invnum_next` int(11) DEFAULT NULL,
  `user_defined_1` varchar(255) DEFAULT NULL,
  `user_defined_2` varchar(255) DEFAULT NULL,
  `user_defined_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `fk_usr_domain` (`domain_id`),
  KEY `fk_usr_address` (`address_id`),
  KEY `fk_usr_currency` (`currency_id`),
  KEY `fk_usr_document` (`logo_document_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_10` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_11` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`currency_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_12` FOREIGN KEY (`logo_document_id`) REFERENCES `documents` (`document_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_3` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`currency_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_4` FOREIGN KEY (`logo_document_id`) REFERENCES `documents` (`document_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_5` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_6` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_7` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`currency_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_8` FOREIGN KEY (`logo_document_id`) REFERENCES `documents` (`document_id`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_9` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`domain_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_invoice_report_details`
--

DROP TABLE IF EXISTS `vw_invoice_report_details`;
/*!50001 DROP VIEW IF EXISTS `vw_invoice_report_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_invoice_report_details` AS SELECT 
 1 AS `invoice_id`,
 1 AS `domain_id`,
 1 AS `job_id`,
 1 AS `job_number`,
 1 AS `end_client_name`,
 1 AS `end_client_notes`,
 1 AS `client_job_number`,
 1 AS `job_type`,
 1 AS `job_description`,
 1 AS `package_name`,
 1 AS `date_received`,
 1 AS `date_due`,
 1 AS `word_count`,
 1 AS `price_with_currency`,
 1 AS `price_no_currency`,
 1 AS `completed_date`,
 1 AS `job_udf1`,
 1 AS `job_udf2`,
 1 AS `job_udf3`,
 1 AS `job_notes`,
 1 AS `unused_column`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_invoice_report_headers`
--

DROP TABLE IF EXISTS `vw_invoice_report_headers`;
/*!50001 DROP VIEW IF EXISTS `vw_invoice_report_headers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_invoice_report_headers` AS SELECT 
 1 AS `invoice_id`,
 1 AS `domain_id`,
 1 AS `invoice_contact_full_name`,
 1 AS `invoice_contact_first_name`,
 1 AS `invoice_contact_last_name`,
 1 AS `invoice_contact_email`,
 1 AS `invoice_contact_phone`,
 1 AS `invoice_contact_position`,
 1 AS `invoice_contact_notes`,
 1 AS `client_vendor_code`,
 1 AS `client_notes`,
 1 AS `client_udf1`,
 1 AS `client_udf2`,
 1 AS `client_udf3`,
 1 AS `client_invoice_notes`,
 1 AS `client_invoice_by_date`,
 1 AS `client_invoice_paid_date`,
 1 AS `client_last_invoice`,
 1 AS `invoice_notes`,
 1 AS `user_email`,
 1 AS `user_full_name`,
 1 AS `user_first_name`,
 1 AS `user_last_name`,
 1 AS `user_company_name`,
 1 AS `user_udf1`,
 1 AS `user_udf2`,
 1 AS `user_udf3`,
 1 AS `unused_column`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'freetransoffice'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_address_lookup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_address_lookup`(

    IN u_domain_id INT,
    IN u_address_1 varchar(80),
    IN u_city varchar(30),
    IN u_country_id INT

)
BEGIN

	SELECT `addresses`.`address_id`,
    `addresses`.`domain_id`,
    `addresses`.`address_1`,
    `addresses`.`address_2`,
    `addresses`.`city`,
    `addresses`.`state`,
    `addresses`.`postalcode`,
    `addresses`.`region`,
    `addresses`.`county`,
    `addresses`.`country_id`
FROM `freetransoffice`.`addresses`
WHERE domain_id = u_domain_id
AND address_1 = u_address_1
AND city = u_city
AND country_id = u_country_id;
 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_invoice_attachment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_add_invoice_attachment`(

	OUT u_document_id INT,
	IN u_domain_id int,
    IN u_document_path varchar(255),
    IN u_invoice_id int

)
BEGIN

-- add document record with path set to invoice report (pdf / word doc)
CALL `freetransoffice`.`sys_documents_create`
(@u_document_id, 
u_domain_id, 
u_document_path);

-- update the invoice record with the document_id just created
update invoices
set invoice_document_id = @u_document_id
where domain_id = u_domain_id
and invoice_id = u_invoice_id;

select @u_document_id as u_document_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_client_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_client_details`(

	IN u_client_id int,
    IN u_domain_id int

)
BEGIN

IF IFNULL(u_client_id, -1) = -1 THEN

	select 
	cl.client_id,
	cl.client_name,
	cl.other_name,
	cl.address_id,
	ad.address_1,
	ad.address_2,
	ad.city,
	ad.region,
	ad.state,
	ad.county,
	ad.postalcode,
	ad.country_id,
	co.country_code,
	co.country_name,
	cl.package_id,
	pk.package_name,
    cl.vendor_code,
	cl.client_status,
	st.status_name,
	cl.currency_id,
	cu.currency_code,
	cu.currency_name,
	cl.timezone,
	cl.last_completed_job,
	cl.notes,
	cl.user_defined_1,
	cl.user_defined_2,
	cl.user_defined_3,
	cl.invoice_to,
	ct.first_name,
	ct.last_name,
	cl.invoice_to_email,
	cl.invoice_notes,
	cl.inv_report_id,
	rc.report_name,
	cl.last_invoice,
	cl.invoice_by,
	cl.invoice_paid
	FROM clients cl
	left join addresses ad on cl.address_id = ad.address_id and cl.domain_id = ad.domain_id
	left join countries co on ad.country_id = co.country_id
	left join currencies cu on cl.currency_id = cu.currency_id
	inner join statuses	st on cl.client_status = st.status_id
	left join packages pk on cl.package_id = pk.package_id and pk.domain_id IN (cl.domain_id, 0)
	left join contacts ct on cl.invoice_to = ct.contact_id and cl.domain_id = ct.domain_id
	inner join report_config rc on inv_report_id = rc.report_id and rc.domain_id IN (cl.domain_id, 0)
	where cl.domain_id = u_domain_id;

ELSE 

	select 
	cl.client_id,
	cl.client_name,
	cl.other_name,
	cl.address_id,
	ad.address_1,
	ad.address_2,
	ad.city,
	ad.region,
	ad.state,
	ad.county,
	ad.postalcode,
	ad.country_id,
	co.country_code,
	co.country_name,
	cl.package_id,
	pk.package_name,
    cl.vendor_code,
	cl.client_status,
	st.status_name,
	cl.currency_id,
	cu.currency_code,
	cu.currency_name,
	cl.timezone,
	cl.last_completed_job,
	cl.notes,
	cl.user_defined_1,
	cl.user_defined_2,
	cl.user_defined_3,
	cl.invoice_to,
	ct.first_name,
	ct.last_name,
	cl.invoice_to_email,
	cl.invoice_notes,
	cl.inv_report_id,
	rc.report_name,
	cl.last_invoice,
	cl.invoice_by,
	cl.invoice_paid
	FROM clients cl
	left join addresses ad on cl.address_id = ad.address_id and cl.domain_id = ad.domain_id
	left join countries co on ad.country_id = co.country_id
	left join currencies cu on cl.currency_id = cu.currency_id
	inner join statuses	st on cl.client_status = st.status_id
	left join packages pk on cl.package_id = pk.package_id and pk.domain_id IN (cl.domain_id, 0)
	left join contacts ct on cl.invoice_to = ct.contact_id and cl.domain_id = ct.domain_id
	inner join report_config rc on inv_report_id = rc.report_id and rc.domain_id IN (cl.domain_id, 0)
	where cl.client_id = u_client_id
	and cl.domain_id = u_domain_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_client_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_client_list`(
	IN u_domain_id INT
)
BEGIN

select
cl.client_id,
cl.client_name,
ad.city,
co.country_name,
cu.currency_code,
st.status_name,
cl.last_completed_job,
cl.last_invoice
FROM clients cl
left join addresses ad on cl.address_id = ad.address_id and cl.domain_id = ad.domain_id
left join countries co on ad.country_id = co.country_id
left join currencies cu on cl.currency_id = cu.currency_id
inner join statuses	st on cl.client_status = st.status_id
where cl.domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_contact_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_contact_details`(
	IN u_contact_id INT,
	IN u_client_id INT,    
    IN u_domain_id INT
)
BEGIN

-- if contact_id and client_id are null then return all contacts
IF (IFNULL(u_contact_id, -1) = -1 AND IFNULL(u_client_id, -1) = -1) THEN

	select 
    ct.contact_id,
	ct.first_name,
	ct.last_name,
    cc.client_id,
	cl.client_name,
	ct.email,
	ct.phone,
    ct.contact_status,
	st.status_name,
	cc.primary_contact,
    ct.language_id,
    la.language_name,
    ct.position_held,
    ct.notes
	from contacts ct
	left join client_contacts cc on cc.contact_id = ct.contact_id
	left join clients cl on cc.client_id = cl.client_id
	inner join statuses st on ct.contact_status = st.status_id
    left join languages la on ct.language_id = la.language_id
	where ct.domain_id = u_domain_id;

-- if contact_id is null but client_id is not null then return all contacts per client
ELSEIF (IFNULL(u_contact_id, -1) = -1 AND IFNULL(u_client_id, -1) <> -1) THEN

	select 
    ct.contact_id,
	ct.first_name,
	ct.last_name,
    cc.client_id,
	cl.client_name,
	ct.email,
	ct.phone,
    ct.contact_status,
	st.status_name,
	cc.primary_contact,
    ct.language_id,
    la.language_name,
    ct.position_held,
    ct.notes
	from contacts ct
	inner join client_contacts cc on cc.contact_id = ct.contact_id
	inner join clients cl on cc.client_id = cl.client_id
	inner join statuses st on ct.contact_status = st.status_id
    left join languages la on ct.language_id = la.language_id
	where ct.domain_id = u_domain_id
    and cc.client_id = u_client_id;

-- else return contact per contact_id
ELSE

	select 
    ct.contact_id,
	ct.first_name,
	ct.last_name,
    cc.client_id,
	cl.client_name,
	ct.email,
	ct.phone,
    ct.contact_status,
	st.status_name,
	cc.primary_contact,
    ct.language_id,
    la.language_name,
    ct.position_held,
    ct.notes
	from contacts ct
	left join client_contacts cc on cc.contact_id = ct.contact_id
	left join clients cl on cc.client_id = cl.client_id
	inner join statuses st on ct.contact_status = st.status_id
    left join languages la on ct.language_id = la.language_id
	where ct.domain_id = u_domain_id
    and ct.contact_id = u_contact_id;    

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_temp_invoices` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_create_temp_invoices`(

	IN u_domain_id int,
    IN u_client_id int,
	IN jobstring varchar(255)

)
BEGIN

-- insert domain & client into invoice header temp
	INSERT INTO invoice_header_temp (domain_id, client_id)
    VALUES (u_domain_id, u_client_id);

-- set variable as auto incremented value    
    SET @TEMPINVID = LAST_INSERT_ID();
    
-- insert temp_invoice_id set in header table to the job line, and add the domain and the jobs as given from the IN parameter    
    INSERT INTO invoice_jobs_temp (temp_invoice_id, domain_id, job_id)
    SELECT
    @TEMPINVID,
    u_domain_id,
    j.job_id
-- FIND_IN_SET can be slow, so reduce list of jobs to search for by only including completed jobs for that client / domain
    FROM (select job_id from jobs where domain_id = u_domain_id and client_id = u_client_id and job_status = 5) as j
    where FIND_IN_SET(j.job_id, jobstring);

-- use list of jobs to set invoice total in the header table
	update invoice_header_temp iht
	inner join (
		select ijt.temp_invoice_id, sum(j.price) as invoice_total
        from invoice_jobs_temp ijt
		inner join jobs j on ijt.job_id = j.job_id
        group by ijt.temp_invoice_id
	) as jj on iht.temp_invoice_id = jj.temp_invoice_id
    set iht.invoice_total = jj.invoice_total
    where iht.temp_invoice_id = @TEMPINVID;

-- output header info only, include the last invoice number used for this domain so the next one can be calculated
	select
    'header' as linetype,
    iht.temp_invoice_id,
    cl.client_name,
    i.last_invoice as invoice_number, 
    cast(iht.invoice_date as DATE) AS invoice_date,
    CONCAT(cast(round(iht.invoice_total, 2) as char) , ' ' , cu.currency_code) as invoice_total,
	null as date_received, 
    null as job_number,
    null as client_job_number, 
    null as description, 
    null as end_client_name, 
    null as job_type, 
    null as word_count,
    null as price,
    null as completed_date
    from invoice_header_temp iht
    inner join clients cl on iht.client_id = cl.client_id
    inner join currencies cu on cl.currency_id = cu.currency_id
	left join (
		select domain_id, max(invoice_number) as last_invoice 
		from invoices 
		where domain_id = u_domain_id
		group by domain_id
	) as i on iht.domain_id = i.domain_id
    where iht.temp_invoice_id = @TEMPINVID

	UNION

-- output job level information    
	select
    'job' as linetype,
    ijt.temp_invoice_id,
    null, -- cl.client_name,
    null, -- invoice_number
    null, -- iht.invoice_date,
    null,  -- iht.invoice_total,
	j.date_received, -- Date Received
    j.job_number, -- Job Number
    j.client_job_number, -- Client Job Number
    j.description, -- Job Description
    ec.end_client_name, -- End Client Name
    jt.job_type, -- Job Type
    j.word_count, -- Word Count
    concat(cast(round(j.price, 2) as char), ' ', cu.currency_code) as price, -- Price
    j.completed_date -- Completed Date
    from invoice_header_temp iht
    inner join clients cl on iht.client_id = cl.client_id
    inner join currencies cu on cl.currency_id = cu.currency_id
    inner join invoice_jobs_temp ijt on iht.temp_invoice_id = ijt.temp_invoice_id
    inner join jobs j on j.job_id = ijt.job_id
    left join end_clients ec on j.end_client_id = ec.end_client_id
    inner join job_types jt on j.job_type_id = jt.job_type_id
    where iht.temp_invoice_id = @TEMPINVID;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_create_user`(
  OUT u_user_id int,
  IN u_first_name varchar(50) ,
  IN u_last_name varchar(80) ,
  IN u_user_name varchar(20) ,
  IN u_password_hash char(60) ,
  IN u_email varchar(120) ,
  IN u_security_question int(11) ,
  IN u_security_answer char(60) 
)
BEGIN

/* 

10/23/2017 RT Base sp created
Additional work needed on password hash
Update of domain_id needs to be moved to Update SP

*/


INSERT INTO users (
first_name,
last_name,
user_name,
password_hash,
email,
security_question,
security_answer,
jobnum_prefix,
jobnum_next,
invnum_prefix,
invnum_next
)
VALUES (
u_first_name,
u_last_name,
u_user_name,
u_password_hash,
u_email,
u_security_question,
u_security_answer,
'JOB',
00001,
'INV',
00001
);

-- Add auto generated user_id into userid parameter
select last_insert_id() into u_user_id;

-- call domain creation proc using userid
call sys_domains_create(@domain_id, u_user_id);

-- update the user record with newly created domain_id
update users
set domain_id = @domain_id
where user_id = u_user_id;

select user_name from users where user_id = u_user_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_tempinvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_delete_tempinvoice`(

	IN u_domain_id int,
    IN u_temp_invoice_id int	
	
)
BEGIN

	delete from invoice_jobs_temp where domain_id = u_domain_id and temp_invoice_id = u_temp_invoice_id;
    delete from invoice_header_temp where domain_id = u_domain_id and temp_invoice_id = u_temp_invoice_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_end_client_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_end_client_details`(

    IN u_end_client_id INT,
	IN u_client_id INT,
    IN u_domain_id INT

)
BEGIN

-- return all end clients per client / per domain unless specific end client id provided
IF IFNULL(u_end_client_id, -1) = -1 THEN
	select
	ec.end_client_id,
	ec.end_client_name,
	ec.client_id,
	cl.client_name,
	ec.industry_id,
	ind.industry_name,
	ec.date_first_job,
	ec.date_last_job,
	ec.notes
	from end_clients ec
	inner join clients cl on ec.client_id = cl.client_id and ec.domain_id = cl.domain_id
	left join industries ind on ec.industry_id = ind.industry_id
	where ec.domain_id = u_domain_id
	and ec.client_id = u_client_id;
	
ELSE 

	select
	ec.end_client_id,
	ec.end_client_name,
	ec.client_id,
	cl.client_name,
	ec.industry_id,
	ind.industry_name,
	ec.date_first_job,
	ec.date_last_job,
	ec.notes
	from end_clients ec
	inner join clients cl on ec.client_id = cl.client_id and ec.domain_id = cl.domain_id
	left join industries ind on ec.industry_id = ind.industry_id
    where ec.domain_id = u_domain_id
    and ec.end_client_id = u_end_client_id;

end if;    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_find_next_jobnum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_find_next_jobnum`(

	IN u_todaysdate varchar(8),
    IN u_domain_id int

)
BEGIN

select concat(u_todaysdate, lpad(max(right(job_number, 4)) + 1, 4, 0)) as new_job_number
	from jobs
	where domain_id = u_domain_id
	and left(job_number, 8) = u_todaysdate
	group by left(job_number, 8);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_invoice_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_invoice_details`(

	IN u_invoice_id INT,
	IN u_client_id INT,   
    IN u_domain_id INT

)
BEGIN

-- if invoice_id and client_id are null then return all invoices per domain
IF (IFNULL(u_invoice_id, -1) = -1 AND IFNULL(u_client_id, -1) = -1) THEN

	select 
	i.invoice_id,
	i.invoice_number,
	i.invoice_date,
	i.client_id,
	cl.client_name,
	i.invoice_total,
	concat(cast(round(i.invoice_total, 2) as char), ' ', cl_cu.currency_code) as invoice_total,
	cl_cu.currency_code as client_currency,
	concat(cast(round(i.received_amount, 2) as char), ' ', coalesce(usr_cu.currency_code, cl_cu.currency_code)) as received_amount,
	coalesce(usr_cu.currency_code, cl_cu.currency_code) as user_currency,
	i.received_date,
	st.status_name,
	doc.document_path,
	i.notes
	from invoices i
	inner join clients cl on i.client_id = cl.client_id
	inner join currencies cl_cu on cl.currency_id = cl_cu.currency_id
	inner join users usr on i.domain_id = usr.domain_id
	inner join currencies usr_cu on usr.currency_id = usr_cu.currency_id
	inner join statuses st on i.invoice_status = st.status_id
	left join documents doc on i.invoice_document_id = doc.document_id and i.domain_id = doc.domain_id
    where i.domain_id = u_domain_id;

-- if invoice_id is null but client_id is not null then return all invoices per client
ELSEIF (IFNULL(u_invoice_id, -1) = -1 AND IFNULL(u_client_id, -1) <> -1) THEN

	select 
	i.invoice_id,
	i.invoice_number,
	i.invoice_date,
	i.client_id,
	cl.client_name,
	i.invoice_total,
	concat(cast(round(i.invoice_total, 2) as char), ' ', cl_cu.currency_code) as invoice_total,
	cl_cu.currency_code as client_currency,
	concat(cast(round(i.received_amount, 2) as char), ' ', coalesce(usr_cu.currency_code, cl_cu.currency_code)) as received_amount,
	coalesce(usr_cu.currency_code, cl_cu.currency_code) as user_currency,
	i.received_date,
	st.status_name,
	doc.document_path,
	i.notes
	from invoices i
	inner join clients cl on i.client_id = cl.client_id
	inner join currencies cl_cu on cl.currency_id = cl_cu.currency_id
	inner join users usr on i.domain_id = usr.domain_id
	inner join currencies usr_cu on usr.currency_id = usr_cu.currency_id
	inner join statuses st on i.invoice_status = st.status_id
	left join documents doc on i.invoice_document_id = doc.document_id and i.domain_id = doc.domain_id
	where i.domain_id = u_domain_id
	and i.client_id = u_client_id;

-- else return only invoice info
ELSE

	select 
	i.invoice_id,
	i.invoice_number,
	i.invoice_date,
	i.client_id,
	cl.client_name,
	i.invoice_total,
	concat(cast(round(i.invoice_total, 2) as char), ' ', cl_cu.currency_code) as invoice_total,
	cl_cu.currency_code as client_currency,
	concat(cast(round(i.received_amount, 2) as char), ' ', coalesce(usr_cu.currency_code, cl_cu.currency_code)) as received_amount,
	coalesce(usr_cu.currency_code, cl_cu.currency_code) as user_currency,
    i.received_date,
	st.status_name,
	doc.document_path,
	i.notes
	from invoices i
	inner join clients cl on i.client_id = cl.client_id
	inner join currencies cl_cu on cl.currency_id = cl_cu.currency_id
	inner join users usr on i.domain_id = usr.domain_id
	inner join currencies usr_cu on usr.currency_id = usr_cu.currency_id
	inner join statuses st on i.invoice_status = st.status_id
	left join documents doc on i.invoice_document_id = doc.document_id and i.domain_id = doc.domain_id
	where i.domain_id = u_domain_id
	and i.invoice_id = u_invoice_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_job_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_job_details`(
	IN u_job_id INT,
	IN u_client_id INT,   
    IN u_domain_id INT
)
BEGIN

-- if job_id and client_id are null then return all jobs per domain
IF (IFNULL(u_job_id, -1) = -1 AND IFNULL(u_client_id, -1) = -1) THEN

	select
	j.job_id,
	j.job_number,
	j.date_received,
	j.client_job_number,
	j.client_id,
	cl.client_name,
	j.description,
	j.package_id,
	pk.package_name,
	j.end_client_id,
	ec.end_client_name,
	j.job_type_id,
	jt.job_type,
	j.word_count,
	j.price_currency_id,
	j.price,
	cu.currency_code,
	j.date_due,
	j.job_status,
	st.status_name,
	j.invoice_id,
	inv.invoice_number,
	inv.invoice_date,
	j.job_profile_id,
    jp.job_profile_name,
	j.estimated_time,
	j.completed_date,
	j.actual_time,
	j.user_defined_1,
	j.user_defined_2,
	j.user_defined_3,
	j.notes
	from jobs j
	inner join clients cl on j.client_id = cl.client_id and j.domain_id = cl.domain_id
	left join end_clients ec on j.end_client_id = ec.end_client_id and j.domain_id = ec.domain_id
	inner join job_types jt on j.job_type_id = jt.job_type_id and jt.domain_id IN (0, j.domain_id)
	inner join currencies cu on j.price_currency_id = cu.currency_id
	inner join statuses st on j.job_status = st.status_id
	left join invoices inv on j.invoice_id = inv.invoice_id and j.domain_id = inv.domain_id
	left join packages pk on j.package_id = pk.package_id
	left join job_profiles jp on j.job_profile_id = jp.job_profile_id
	where j.domain_id = u_domain_id;

-- if job_id is null but client_id is not null then return all jobs per client
ELSEIF (IFNULL(u_job_id, -1) = -1 AND IFNULL(u_client_id, -1) <> -1) THEN

	select
	j.job_id,
	j.job_number,
	j.date_received,
	j.client_job_number,
	j.client_id,
	cl.client_name,
	j.description,
	j.package_id,
	pk.package_name,
	j.end_client_id,
	ec.end_client_name,
	j.job_type_id,
	jt.job_type,
	j.word_count,
	j.price_currency_id,
	j.price,
	cu.currency_code,
	j.date_due,
	j.job_status,
	st.status_name,
	j.invoice_id,
	inv.invoice_number,
	inv.invoice_date,
	j.job_profile_id,
	j.estimated_time,
	j.completed_date,
	j.actual_time,
	j.user_defined_1,
	j.user_defined_2,
	j.user_defined_3,
	j.notes
	from jobs j
	inner join clients cl on j.client_id = cl.client_id and j.domain_id = cl.domain_id
	left join end_clients ec on j.end_client_id = ec.end_client_id and j.domain_id = ec.domain_id
	inner join job_types jt on j.job_type_id = jt.job_type_id and jt.domain_id IN (0, j.domain_id)
	inner join currencies cu on j.price_currency_id = cu.currency_id
	inner join statuses st on j.job_status = st.status_id
	left join invoices inv on j.invoice_id = inv.invoice_id and j.domain_id = inv.domain_id
	left join packages pk on j.package_id = pk.package_id
	left join job_profiles jp on j.job_profile_id = jp.job_profile_id
	where j.domain_id = u_domain_id
	and j.client_id = u_client_id;

-- else return only job info
ELSE

	select
	j.job_id,
	j.job_number,
	j.date_received,
	j.client_job_number,
	j.client_id,
	cl.client_name,
	j.description,
	j.package_id,
	pk.package_name,
	j.end_client_id,
	ec.end_client_name,
	j.job_type_id,
	jt.job_type,
	j.word_count,
	j.price_currency_id,
	j.price,
	cu.currency_code,
	j.date_due,
	j.job_status,
	st.status_name,
	j.invoice_id,
	inv.invoice_number,
	inv.invoice_date,
	j.job_profile_id,
	j.estimated_time,
	j.completed_date,
	j.actual_time,
	j.user_defined_1,
	j.user_defined_2,
	j.user_defined_3,
	j.notes
	from jobs j
	inner join clients cl on j.client_id = cl.client_id and j.domain_id = cl.domain_id
	left join end_clients ec on j.end_client_id = ec.end_client_id and j.domain_id = ec.domain_id
	inner join job_types jt on j.job_type_id = jt.job_type_id and jt.domain_id IN (0, j.domain_id)
	inner join currencies cu on j.price_currency_id = cu.currency_id
	inner join statuses st on j.job_status = st.status_id
	left join invoices inv on j.invoice_id = inv.invoice_id and j.domain_id = inv.domain_id
	left join packages pk on j.package_id = pk.package_id
	left join job_profiles jp on j.job_profile_id = jp.job_profile_id
	where j.domain_id = u_domain_id
	and j.job_id = u_job_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_job_profile_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_job_profile_details`(

	IN u_job_profile_id INT,
	IN u_domain_id INT

)
BEGIN

IF IFNULL(u_job_profile_id, -1) = -1 THEN

	select
	jp.job_profile_id,
	jp.job_profile_name,
	jp.job_type_id,
	jp.client_id,
	cl.client_name,
	jp.end_client_id,
	ec.end_client_name,
	jp.package_id,
	pk.package_name,
	jp.words_per_hour,
	jp.job_type_multiplier,
	jp.notes
	FROM job_profiles jp
	left join job_types jt on jt.job_type_id = jp.job_type_id and jt.domain_id = jp.domain_id
	left join clients cl on cl.client_id = jp.client_id and cl.domain_id = jp.domain_id
	left join end_clients ec on ec.end_client_id = jp.end_client_id and cl.client_id = ec.client_id and jp.domain_id = ec.domain_id
	left join packages pk on pk.package_id = jp.package_id and pk.domain_id = jp.package_id
    where jp.domain_id = u_domain_id;

ELSE

	select
	jp.job_profile_id,
	jp.job_profile_name,
	jp.job_type_id,
	jp.client_id,
	cl.client_name,
	jp.end_client_id,
	ec.end_client_name,
	jp.package_id,
	pk.package_name,
	jp.words_per_hour,
	jp.job_type_multiplier,
	jp.notes
	FROM job_profiles jp
	left join job_types jt on jt.job_type_id = jp.job_type_id and jt.domain_id = jp.domain_id
	left join clients cl on cl.client_id = jp.client_id and cl.domain_id = jp.domain_id
	left join end_clients ec on ec.end_client_id = jp.end_client_id and cl.client_id = ec.client_id and jp.domain_id = ec.domain_id
	left join packages pk on pk.package_id = jp.package_id and pk.domain_id = jp.package_id
    where jp.domain_id = u_domain_id
    and jp.job_profile_id = u_job_profile_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_readjobsforinvoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_readjobsforinvoice`(

	IN u_domain_id int,
	IN jobstring varchar(255)

)
BEGIN
	
    drop temporary table if exists tempjobs;
    
    create temporary table tempjobs 
		select
        j.domain_id,
		j.job_id,
		j.client_id,
		j.price
		from jobs j
		where j.domain_id = u_domain_id
		and j.job_status <> 6;
    
	select 
    tj.client_id, 
    max(i.last_invoice) as last_invoice,
    sum(tj.price) as invoice_total 
    from tempjobs tj
    left join (
		select domain_id, max(invoice_number) as last_invoice 
        from invoices 
        where domain_id = u_domain_id
        group by domain_id
        ) as i on tj.domain_id = i.domain_id
    where FIND_IN_SET(tj.job_id, jobstring) 
    group by tj.client_id;

	drop temporary table tempjobs;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_read_invoice_report_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_read_invoice_report_details`()
BEGIN

	SELECT column_name 
	FROM `INFORMATION_SCHEMA`.`COLUMNS` 
	where TABLE_SCHEMA = 'freetransoffice'
	AND `TABLE_NAME`='vw_invoice_report_details'
	and column_name not in 
	('invoice_id', 'domain_id', 'job_id', 'unused_column');


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_read_invoice_report_headers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_read_invoice_report_headers`()
BEGIN

SELECT column_name 
FROM `INFORMATION_SCHEMA`.`COLUMNS` 
where TABLE_SCHEMA = 'freetransoffice'
AND `TABLE_NAME`='vw_invoice_report_headers'
and column_name not in 
('invoice_id', 'domain_id', 'unused_column');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rpt_invoice_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_rpt_invoice_details`(
	IN u_invoice_id int,
    IN u_domain_id int
)
BEGIN

-- DECLARE all the invoice details variables to be used in the dynamic statement

	DECLARE inv_details_a varchar(30);
	DECLARE inv_details_b varchar(30);
	DECLARE inv_details_c varchar(30);
	DECLARE inv_details_d varchar(30);
	DECLARE inv_details_e varchar(30);
	DECLARE inv_details_f varchar(30);
	DECLARE inv_details_g varchar(30);
	DECLARE inv_details_h varchar(30);    

-- Set the invoice details variables to the fields selected on the report config screen. Include table (view) alias so the fields can be found appropriately
-- unused column needs to be used for blank (unchosen) report fields
	select 
    ifnull(CONCAT('vid.', rc.col_a_field), 'vid.unused_column'),
    ifnull(CONCAT('vid.', rc.col_b_field), 'vid.unused_column'),
    ifnull(CONCAT('vid.', rc.col_c_field), 'vid.unused_column'),
    ifnull(CONCAT('vid.', rc.col_d_field), 'vid.unused_column'),
    ifnull(CONCAT('vid.', rc.col_e_field), 'vid.unused_column'),
    ifnull(CONCAT('vid.', rc.col_f_field), 'vid.unused_column'),
    ifnull(CONCAT('vid.', rc.col_g_field), 'vid.unused_column'),
    ifnull(CONCAT('vid.', rc.col_h_field), 'vid.unused_column')    
    INTO
	inv_details_a,
    inv_details_b,
    inv_details_c,
    inv_details_d,
    inv_details_e,
    inv_details_f,
    inv_details_g,
    inv_details_h
    from report_config rc
    inner join clients cl on rc.report_id = cl.inv_report_id
    inner join invoices inv on inv.client_id = cl.client_id
    where inv.invoice_id = u_invoice_id
    and inv.domain_id = u_domain_id;
    
-- set dynamic statement as variable, include the invoice headers from above

	drop temporary table IF EXISTS tempinvdets;

	SET @s = CONCAT('
    CREATE TEMPORARY TABLE IF NOT EXISTS tempinvdets AS (
		select
		rc.col_a_label,
		', inv_details_a, ' as col_a_field,
		rc.col_b_label,
		', inv_details_b, ' as col_b_field,
		rc.col_c_label,
		', inv_details_c, ' as col_c_field,
		rc.col_d_label,
		', inv_details_d, ' as col_d_field,
		rc.col_e_label,
		', inv_details_e, ' as col_e_field,
		rc.col_f_label,
		', inv_details_f, ' as col_f_field,
		rc.col_g_label,
		', inv_details_g, ' as col_g_field,
		rc.col_h_label,
		', inv_details_h, ' as col_h_field
		from
		invoices inv
        inner join clients cl on inv.client_id = cl.client_id and cl.domain_id = inv.domain_id
        inner join report_config rc on rc.domain_id IN (0, inv.domain_id) and rc.report_id = cl.inv_report_id
		inner join vw_invoice_report_details vid on vid.domain_id = inv.domain_id and vid.invoice_id = inv.invoice_id
		where inv.invoice_id = ', u_invoice_id, '
        and inv.domain_id = ', u_domain_id, ')'
    );
	
    PREPARE stmt from @s;
    execute stmt;
    deallocate PREPARE stmt;
    
    select * from tempinvdets;
    
    drop temporary table IF EXISTS tempinvdets;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rpt_invoice_header` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_rpt_invoice_header`(
	IN u_invoice_id int,
    IN u_domain_id int
)
BEGIN

-- DECLARE all the invoice header variables to be used in the dynamic statement

	DECLARE inv_header_a1 varchar(30);
    DECLARE inv_header_a2 varchar(30);
    DECLARE inv_header_a3 varchar(30);
    DECLARE inv_header_b1 varchar(30);
    DECLARE inv_header_b2 varchar(30);
    DECLARE inv_header_b3 varchar(30);

-- Set the invoice header variables to the fields selected on the report config screen. Include table (view) alias so the fields can be found appropriately
-- unused column needs to be used for blank (unchosen) report fields
	select 
    ifnull(CONCAT('vih.', rc.section_a_field_1), 'vih.unused_column'),
    ifnull(CONCAT('vih.', rc.section_a_field_2), 'vih.unused_column'),
    ifnull(CONCAT('vih.', rc.section_a_field_3), 'vih.unused_column'),
    ifnull(CONCAT('vih.', rc.section_b_field_1), 'vih.unused_column'),
    ifnull(CONCAT('vih.', rc.section_b_field_2), 'vih.unused_column'),
    ifnull(CONCAT('vih.', rc.section_b_field_3), 'vih.unused_column')
    INTO
	inv_header_a1,
    inv_header_a2,
    inv_header_a3,
    inv_header_b1,
    inv_header_b2,
    inv_header_b3
    from report_config rc
    inner join clients cl on rc.report_id = cl.inv_report_id
    inner join invoices inv on inv.client_id = cl.client_id
    where inv.invoice_id = u_invoice_id
    and inv.domain_id = u_domain_id;
    
-- set dynamic statement as variable, include the invoice headers from above

	drop temporary table IF EXISTS tempinvhead;

	SET @s = CONCAT('
    CREATE TEMPORARY TABLE IF NOT EXISTS tempinvhead AS (
		select
		concat(usr.first_name, '' '', usr.last_name) as user_fullname,
		usr.first_name as user_first_name,
		usr.last_name as user_last_name,
        usr.email as user_email,
        usr.company_name as user_company_name,
        usr.phone_number as user_phone_number,
		ad_us.address_1 as user_address_1,
		ad_us.address_2 as user_address_2,
		ad_us.city as user_city,
		ad_us.postalcode as user_postalcode,
		co_us.country_name as user_country,
		concat(invcon.first_name, '' '', invcon.last_name) as invoice_to_fullname,    
		invcon.first_name as invoice_to_firstname,
		invcon.last_name as invoice_to_lastname,
		cl.client_name,
		ad_cl.address_1 as client_address_1,
		ad_cl.address_2 as client_address_2,
		ad_cl.city as client_city,
		ad_cl.postalcode as client_postalcode,
		co_cl.country_name as client_country,
		inv.invoice_date,
        rc.report_format_id,
        tp.template_path,
		rc.date_format,
		rc.greeting_text,
		rc.opening_text,
		rc.invoice_number_label,
		inv.invoice_number,
		rc.invoice_total_label,
		inv.invoice_total,
        cu.currency_code as client_currency_code,
			if(rc.col_a_field is null or rc.col_a_field  = '''', 0, 1) +
			if(rc.col_b_field is null or rc.col_b_field  = '''', 0, 1) +
			if(rc.col_c_field is null or rc.col_c_field  = '''', 0, 1) +
			if(rc.col_d_field is null or rc.col_d_field  = '''', 0, 1) +
			if(rc.col_e_field is null or rc.col_e_field  = '''', 0, 1) +
			if(rc.col_f_field is null or rc.col_f_field  = '''', 0, 1) +
			if(rc.col_g_field is null or rc.col_g_field  = '''', 0, 1) +
			if(rc.col_h_field is null or rc.col_h_field  = '''', 0, 1) 
		as num_columns,
        rc.col_a_label,
        rc.col_b_label,
        rc.col_c_label,
        rc.col_d_label,
        rc.col_e_label,
        rc.col_f_label,
        rc.col_g_label,
        rc.col_h_label,
		rc.section_a_label,
		rc.section_a_field_label_1,
		', inv_header_a1, ' as section_a_field_1,
		rc.section_a_field_label_2,
		', inv_header_a2, ' as section_a_field_2,
		rc.section_a_field_label_3,
		', inv_header_a3, ' as section_a_field_3,
		rc.section_b_label,
		rc.section_b_field_label_1,
		', inv_header_b1, ' as section_b_field_1,
		rc.section_b_field_label_2,
		', inv_header_b2, ' as section_b_field_2,
		rc.section_b_field_label_3,
		', inv_header_b3, ' as section_b_field_3,
		rc.closing_text
		from
		invoices inv
		inner join clients cl on inv.client_id = cl.client_id and cl.domain_id = inv.domain_id
        inner join currencies cu on cl.currency_id = cu.currency_id
		left join addresses ad_cl on cl.address_id = ad_cl.address_id and cl.domain_id = ad_cl.domain_id
		left join countries co_cl on ad_cl.country_id = co_cl.country_id
		inner join users usr on inv.domain_id = usr.domain_id
		left join addresses ad_us on usr.address_id = ad_us.address_id and usr.domain_id = ad_us.domain_id
		left join countries co_us on ad_us.country_id = co_us.country_id
		left join contacts invcon on cl.invoice_to = invcon.contact_id and cl.domain_id = invcon.domain_id
		inner join report_config rc on rc.domain_id IN (0, inv.domain_id) and rc.report_id = cl.inv_report_id
        inner join templates tp on rc.template_id = tp.template_id
		inner join vw_invoice_report_headers vih on vih.domain_id = inv.domain_id and vih.invoice_id = inv.invoice_id
		where inv.invoice_id = ', u_invoice_id, '
        and inv.domain_id = ', u_domain_id, ')'
    );
	
    PREPARE stmt from @s;
    execute stmt;
    deallocate PREPARE stmt;
    
    select * from tempinvhead;
    
    drop temporary table IF EXISTS tempinvhead;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_submit_invoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_submit_invoice`(

	OUT u_invoice_id int,
	IN u_domain_id int,
    IN u_temp_invoice_id int,
    IN u_new_invoice_num varchar(12)
	
)
BEGIN

	SELECT client_id, invoice_total
    INTO @client_id, @invoice_total
    FROM invoice_header_temp
    WHERE temp_invoice_id = u_temp_invoice_id;

	CALL sys_invoices_create (
		@u_invoice_id, 
        u_domain_id,
        u_new_invoice_num,
        NOW(),
        @client_id,
        @invoice_total, 
        null, 
        null, 
        6, 
        null, 
        null);

	UPDATE jobs j
    inner join invoice_jobs_temp ijt on j.job_id = ijt.job_id and j.domain_id = ijt.domain_id
    set j.invoice_id = @u_invoice_id,
    j.job_status = 6
    where ijt.temp_invoice_id = u_temp_invoice_id;
    
    CALL `freetransoffice`.`sp_delete_tempinvoice`(u_domain_id, u_temp_invoice_id);

	select @u_invoice_id as u_invoice_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_usersettings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_update_usersettings`(
	IN u_user_id int,
    IN u_first_name varchar(50),
    IN u_last_name varchar(80),
    IN u_company_name varchar(120),
    IN u_address_1 varchar(80),
    IN u_address_2 varchar(80),
    IN u_city varchar(30),
    IN u_state varchar(3),
    IN u_postalcode varchar(10),
    IN u_region varchar(50),
    IN u_county varchar(50),
    IN u_country_id int,
    IN u_currency_id int,
    IN u_timezone varchar(30),
    IN u_logo_document_id int,
    IN u_jobnum_prefix varchar(5),
    IN u_jobnum_next int,
    IN u_invnum_prefix varchar(5),
    IN u_invnum_next int
)
BEGIN

declare u_address_id int;
declare u_domain_id int;
select address_id into u_address_id from users where user_id = u_user_id;
select domain_id into u_domain_id from users where user_id = u_user_id;

-- check to see if the user has an address
-- if the user does not have an address already associated, then run the insert address proc, else update the address
IF u_address_id is null 
	THEN call sys_addresses_create(@address_id, u_domain_id, u_address_1, u_address_2, u_city, u_state, u_postalcode, u_region, u_county, u_country_id);
    set u_address_id = @address_id;
	ELSE call sys_addresses_update(u_address_id, u_domain_id, u_address_1, u_address_2, u_city, u_state, u_postalcode, u_region, u_county, u_country_id);
END IF;

UPDATE `freetransoffice`.`users`
	SET `first_name` = ifnull(u_first_name, first_name),
	`last_name` = ifnull(u_last_name, last_name),
	`address_id` = ifnull(u_address_id, address_id),
	`company_name` = ifnull(u_company_name, company_name),
	`currency_id` = ifnull(u_currency_id, currency_id),
	`timezone` = ifnull(u_timezone, timezone),
	`logo_document_id` = ifnull(u_logo_document_id, logo_document_id),
	`jobnum_prefix` = ifnull(u_jobnum_prefix, jobnum_prefix),
	`jobnum_next` = ifnull(u_jobnum_next, jobnum_next),
	`invnum_prefix` = ifnull(u_invnum_prefix, invnum_prefix),
	`invnum_next` = ifnull(u_invnum_prefix, invnum_next)
WHERE `user_id` = u_user_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_user_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_user_details`(

	IN u_user_id INT,
    IN u_domain_id INT

)
BEGIN

	select 
	u.user_id,
	u.first_name,
	u.last_name,
	u.user_name,
	u.email,
    u.phone_number,
	u.company_name,
	u.address_id,
	a.address_1,
	a.address_2,
	a.city,
	a.county,
	a.region,
	a.state,
	a.postalcode,
	a.country_id,
	cn.country_code,
	cn.country_name,
	u.currency_id,
	cu.currency_code,
	cu.currency_name,
	u.timezone,
	u.logo_document_id,
	doc.document_path,
	u.jobnum_prefix,
	u.jobnum_next,
	u.invnum_prefix,
	u.invnum_next,
    u.user_defined_1,
    u.user_defined_2,
    u.user_defined_3
	from users u
	left join addresses a on u.address_id = a.address_id
	left join countries cn on a.country_id = cn.country_id
	left join currencies cu on u.currency_id = cu.currency_id
	left join documents doc on u.logo_document_id = doc.document_id and u.domain_id = doc.domain_id
    where u.user_id = u_user_id
    and u.domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_validateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_validateUser`(
    IN u_user_name varchar(20)
)
BEGIN

	select user_id, domain_id, password_hash
    from users
    where user_name = u_user_name; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_void_invoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sp_void_invoice`(

	u_domain_id int,
    u_invoice_id int

)
BEGIN

	update invoices
	set invoice_status = 7
	where invoice_id = u_invoice_id;

	update jobs 
	set job_status = 5,
	invoice_id = null
	where invoice_id = u_invoice_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_addresses_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_addresses_create`(
  OUT u_address_id int(11) ,
  IN u_domain_id int(11) ,
  IN u_address_1 varchar(80) ,
  IN u_address_2 varchar(80) ,
  IN u_city varchar(30) ,
  IN u_state varchar(3) ,
  IN u_postalcode varchar(10) ,
  IN u_region varchar(50) ,
  IN u_county varchar(50) ,
  IN u_country_id int(11) 
)
BEGIN

INSERT INTO `freetransoffice`.`addresses` (
	`domain_id`,
	`address_1`,
	`address_2`,
	`city`,
	`state`,
	`postalcode`,
	`region`,
	`county`,
	`country_id`
)
VALUES (
	u_domain_id,
	u_address_1,
	u_address_2,
	u_city,
	u_state,
	u_postalcode,
	u_region,
	u_county,
	u_country_id
);

select last_insert_id() as u_address_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_addresses_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_addresses_delete`(
	IN u_address_id int,
    IN u_domain_id int
)
BEGIN

DELETE FROM `freetransoffice`.`addresses`
WHERE address_id = u_address_id
AND domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_addresses_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_addresses_read`(
	IN u_address_id int,
    IN u_domain_id int
)
BEGIN

SELECT `addresses`.`address_id`,
    `addresses`.`domain_id`,
    `addresses`.`address_1`,
    `addresses`.`address_2`,
    `addresses`.`city`,
    `addresses`.`state`,
    `addresses`.`postalcode`,
    `addresses`.`region`,
    `addresses`.`county`,
    `addresses`.`country_id`
FROM `freetransoffice`.`addresses`
WHERE address_id = u_address_id
AND domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_addresses_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_addresses_update`(
  IN u_address_id int(11) ,
  IN u_domain_id int(11) ,
  IN u_address_1 varchar(80) ,
  IN u_address_2 varchar(80) ,
  IN u_city varchar(30) ,
  IN u_state varchar(3) ,
  IN u_postalcode varchar(10) ,
  IN u_region varchar(50) ,
  IN u_county varchar(50) ,
  IN u_country_id int(11) 
)
BEGIN

UPDATE freetransoffice.addresses
SET
address_1 = u_address_1, 
address_2 = u_address_2, 
city = u_city, 
state = u_state, 
postalcode = u_postalcode, 
region = u_region,
county = u_county,
country_id = u_country_id
WHERE address_id = u_address_id
and domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_clients_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_clients_create`(
OUT	u_client_id	int(11),
IN	u_domain_id	int(11),
IN	u_client_name	varchar(100),
IN	u_other_name	varchar(100),
IN	u_address_id	int(11),
IN	u_package_id	int(11),
IN	u_vendor_code	varchar(30),
IN	u_client_status	int(11),
IN	u_last_completed_job	datetime,
IN	u_currency_id	int(11),
IN	u_timezone	varchar(30),
IN	u_invoice_to	int(11),
IN	u_invoice_to_email	varchar(120),
IN	u_invoice_notes	longtext,
IN	u_inv_report_id	int(11),
IN	u_invoice_by	int(11),
IN	u_invoice_paid	int(11),
IN	u_last_invoice	datetime,
IN	u_notes	longtext,
IN	u_user_defined_1	varchar(255),
IN	u_user_defined_2	varchar(255),
IN	u_user_defined_3	varchar(255)
)
BEGIN

INSERT INTO `freetransoffice`.`clients`
( 	`domain_id`,
	`client_name`,
	`other_name`,
	`address_id`,
	`package_id`,
    vendor_code,
	`client_status`,
	`last_completed_job`,
	`currency_id`,
	`timezone`,
	`invoice_to`,
	`invoice_to_email`,
	`invoice_notes`,
	`inv_report_id`,
	`invoice_by`,
	`invoice_paid`,
	`last_invoice`,
	`notes`,
	`user_defined_1`,
	`user_defined_2`,
	`user_defined_3`)
VALUES
(	u_domain_id	,
	u_client_name ,
	u_other_name	,
	u_address_id	,
	u_package_id	,
    u_vendor_code	,
	u_client_status	,
	u_last_completed_job	,
	u_currency_id	,
	u_timezone	,
	u_invoice_to	,
	u_invoice_to_email	,
	u_invoice_notes	,
	u_inv_report_id	,
	u_invoice_by	,
	u_invoice_paid	,
	u_last_invoice	,
	u_notes	,
	u_user_defined_1	,
	u_user_defined_2	,
	u_user_defined_3);

select last_insert_id() into u_client_id;
select u_client_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_clients_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_clients_delete`(
	IN u_client_id int,
    IN u_domain_id int
)
BEGIN

	delete from clients 
    where client_id = u_client_id
    and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_clients_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_clients_read`(
	IN u_client_id int,
    IN u_domain_id int
)
BEGIN

IF IFNULL(u_client_id, -1) = -1
THEN

		SELECT `clients`.`client_id`,
		`clients`.`domain_id`,
		`clients`.`client_name`,
		`clients`.`other_name`,
		`clients`.`address_id`,
		`clients`.`package_id`,
        clients.vendor_code,
		`clients`.`client_status`,
		`clients`.`last_completed_job`,
		`clients`.`currency_id`,
		`clients`.`timezone`,
		`clients`.`invoice_to`,
		`clients`.`invoice_to_email`,
		`clients`.`invoice_notes`,
		`clients`.`inv_report_id`,
		`clients`.`invoice_by`,
		`clients`.`invoice_paid`,
		`clients`.`last_invoice`,
		`clients`.`notes`,
		`clients`.`user_defined_1`,
		`clients`.`user_defined_2`,
		`clients`.`user_defined_3`
	FROM `freetransoffice`.`clients`
	WHERE domain_id = u_domain_id;
    
ELSE 

	SELECT `clients`.`client_id`,
		`clients`.`domain_id`,
		`clients`.`client_name`,
		`clients`.`other_name`,
		`clients`.`address_id`,
		`clients`.`package_id`,
        clients.vendor_code,
		`clients`.`client_status`,
		`clients`.`last_completed_job`,
		`clients`.`currency_id`,
		`clients`.`timezone`,
		`clients`.`invoice_to`,
		`clients`.`invoice_to_email`,
		`clients`.`invoice_notes`,
		`clients`.`inv_report_id`,
		`clients`.`invoice_by`,
		`clients`.`invoice_paid`,
		`clients`.`last_invoice`,
		`clients`.`notes`,
		`clients`.`user_defined_1`,
		`clients`.`user_defined_2`,
		`clients`.`user_defined_3`
	FROM `freetransoffice`.`clients`
	WHERE client_id = u_client_id
	AND domain_id = u_domain_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_clients_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_clients_update`(
IN	u_client_id	int(11),
IN	u_domain_id	int(11),
IN	u_client_name	varchar(100),
IN	u_other_name	varchar(100),
IN	u_address_id	int(11),
IN	u_package_id	int(11),
IN	u_vendor_code	varchar(30),
IN	u_client_status	int(11),
IN	u_last_completed_job	datetime,
IN	u_currency_id	int(11),
IN	u_timezone	varchar(30),
IN	u_invoice_to	int(11),
IN	u_invoice_to_email	varchar(120),
IN	u_invoice_notes	longtext,
IN	u_inv_report_id	int(11),
IN	u_invoice_by	int(11),
IN	u_invoice_paid	int(11),
IN	u_last_invoice	datetime,
IN	u_notes	longtext,
IN	u_user_defined_1	varchar(255),
IN	u_user_defined_2	varchar(255),
IN	u_user_defined_3	varchar(255)
)
BEGIN

UPDATE `freetransoffice`.`clients`
SET
`client_name` = u_client_name, 
`other_name` = u_other_name, 
`address_id` = u_address_id, 
`package_id` = u_package_id, 
vendor_code = u_vendor_code, 
`client_status` = u_client_status, 
`last_completed_job` = u_last_completed_job, 
`currency_id` = u_currency_id, 
`timezone` = u_timezone, 
`invoice_to` = u_invoice_to, 
`invoice_to_email` = u_invoice_to_email, 
`invoice_notes` = u_invoice_notes, 
`inv_report_id` = u_inv_report_id, 
`invoice_by` = u_invoice_by, 
`invoice_paid` = u_invoice_paid, 
`last_invoice` = u_last_invoice, 
`notes` = u_notes, 
`user_defined_1` = u_user_defined_1,
`user_defined_2` = u_user_defined_2,
`user_defined_3` = u_user_defined_3
WHERE `client_id` = u_client_id
AND domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_client_contacts_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_client_contacts_create`(
	IN u_contact_id int,
    in u_client_id int,
    in u_primary_contact tinyint(1)
)
BEGIN

INSERT INTO `freetransoffice`.`client_contacts`
(`contact_id`,
`client_id`,
`primary_contact`)
VALUES
(
u_contact_id,
u_client_id,
u_primary_contact
);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_client_contacts_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_client_contacts_delete`(
	IN u_contact_id int,
    in u_client_id int
)
BEGIN

delete from client_contacts where client_id = u_client_id and contact_id = u_contact_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_client_contacts_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_client_contacts_read`(
	IN u_contact_id int,
    in u_client_id int
)
BEGIN

SELECT `client_contacts`.`contact_id`,
    `client_contacts`.`client_id`,
    `client_contacts`.`primary_contact`
FROM `freetransoffice`.`client_contacts`
WHERE `contact_id` = u_contact_id
AND `client_id` = u_client_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_client_contacts_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_client_contacts_update`(
	IN u_contact_id int,
    in u_client_id int,
    in u_primary_contact tinyint(1)	
)
BEGIN

UPDATE `freetransoffice`.`client_contacts`
SET
`contact_id` = u_contact_id,
`client_id` = u_client_id, 
`primary_contact` = u_primary_contact
WHERE `contact_id` = u_contact_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_contacts_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_contacts_create`(
	OUT u_contact_id int,
    IN u_domain_id int,
    IN u_first_name varchar(50),
    IN u_last_name varchar(80),
    IN u_email varchar(120),
    IN u_phone varchar(20),
    IN u_language_id int,
    IN u_position_held varchar(80),
    IN u_contact_status int,
    IN u_notes longtext
)
BEGIN

INSERT INTO `freetransoffice`.`contacts` (
	`domain_id`,
	`first_name`,
	`last_name`,
	`email`,
	`phone`,
	`language_id`,
	`position_held`,
	`contact_status`,
	`notes`)
VALUES (
	u_domain_id,
	u_first_name,
	u_last_name,
	u_email,
	u_phone,
	u_language_id,
	u_position_held,
	u_contact_status,
	u_notes
);

select last_insert_id() as u_contact_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_contacts_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_contacts_delete`(
	IN u_contact_id int,
    IN u_domain_id int
)
BEGIN

	delete from contacts 
    where contact_id = u_contact_id 
    and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_contacts_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_contacts_read`(
	IN u_contact_id int,
    IN u_domain_id int
)
BEGIN

SELECT `contacts`.`first_name`,
    `contacts`.`last_name`,
    `contacts`.`email`,
    `contacts`.`phone`,
    `contacts`.`language_id`,
    `contacts`.`position_held`,
    `contacts`.`contact_status`,
    `contacts`.`notes`
FROM `freetransoffice`.`contacts`
where `contact_id` = u_contact_id
AND `domain_id` = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_contacts_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_contacts_update`(
	IN u_contact_id int,
    IN u_domain_id int,
    IN u_first_name varchar(50),
    IN u_last_name varchar(80),
    IN u_email varchar(120),
    IN u_phone varchar(20),
    IN u_language_id int,
    IN u_position_held varchar(80),
    IN u_contact_status int,
    IN u_notes longtext	
)
BEGIN

UPDATE `freetransoffice`.`contacts`
SET
`first_name` = u_first_name, 
`last_name` = u_last_name, 
`email` = u_email, 
`phone` = u_phone, 
`language_id` = u_language_id,
`position_held` = u_position_held,
`contact_status` = u_contact_status, 
`notes` = u_notes
WHERE `contact_id` = u_contact_id
AND `domain_id` = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_countries_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_countries_read`(
	IN u_country_id INT
)
BEGIN

IF IFNULL(u_country_id, -1) = -1 THEN

	SELECT *
	FROM `freetransoffice`.`countries`
    LIMIT 500;

ELSE 
	SELECT `countries`.`country_id`,
		`countries`.`country_code`,
		`countries`.`country_name`
	FROM `freetransoffice`.`countries`
	WHERE country_id = u_country_id;
    
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_currencies_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_currencies_read`(
	IN u_currency_id INT
)
BEGIN

IF IFNULL(u_currency_id, -1) = -1 THEN

	select * from currencies limit 1000;

ELSE
	
    select * from currencies where currency_id = u_currency_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_documents_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_documents_create`(
	OUT u_document_id int,
    IN u_domain_id int,
    IN u_document_path varchar(255)
)
BEGIN

INSERT INTO `freetransoffice`.`documents` (
	domain_id,
	`document_path`
)
VALUES
(
	u_domain_id,
    u_document_path
);

select last_insert_id() into u_document_id;

select u_document_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_documents_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_documents_delete`(
	IN u_document_id int
)
BEGIN

DELETE FROM `freetransoffice`.`documents`
where document_id = u_document_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_documents_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_documents_read`(
	IN u_document_id int,
    IN u_domain_id int
)
BEGIN

SELECT `documents`.`document_id`,
	documents.domain_id,
    `documents`.`document_path`
FROM `freetransoffice`.`documents`
where document_id = u_document_id
and domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_documents_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_documents_update`(
	IN u_document_id int,
    IN domain_id int,
    IN u_document_path varchar(255)
)
BEGIN

update documents
set
document_path = u_document_path
WHERE document_id = u_document_id
and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_domains_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_domains_create`(
	OUT u_domain_id int,
    IN u_primary_user_id int
)
BEGIN

INSERT INTO domains 
(
	domain_id,
    primary_user_id
)
VALUES 
(
	u_domain_id,
    u_primary_user_id
);

select last_insert_id() as u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_end_clients_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_end_clients_create`(
	OUT	u_end_client_id	int(11)	,
	IN	u_domain_id	int(11)	,
	IN	u_end_client_name	varchar(120)	,
    IN	u_client_id INT,
	IN	u_industry_id	int(11)	,
	IN	u_date_first_job	datetime	,
	IN	u_date_last_job	datetime	,
	IN	u_notes	longtext	
)
BEGIN

	INSERT INTO `freetransoffice`.`end_clients`
	(`domain_id`,
	`end_client_name`,
    `client_id`,
	`industry_id`,
	`date_first_job`,
	`date_last_job`,
	`notes`)
	VALUES (
	u_domain_id,
	u_end_client_name,
    u_client_id,
	u_industry_id,
	u_date_first_job,
	u_date_last_job,
	u_notes
    );

select last_insert_id() as u_end_client_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_end_clients_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_end_clients_delete`(
	IN u_end_client_id int,
    IN u_domain_id int
)
BEGIN

	delete from end_clients where end_client_id = u_end_client_id and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_end_clients_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_end_clients_read`(
	IN u_end_client_id int,
    IN u_domain_id int
)
BEGIN

SELECT `end_clients`.`end_client_id`,
    `end_clients`.`domain_id`,
    `end_clients`.`end_client_name`,
    `end_clients`.`client_id`,
    `end_clients`.`industry_id`,
    `end_clients`.`date_first_job`,
    `end_clients`.`date_last_job`,
    `end_clients`.`notes`
FROM `freetransoffice`.`end_clients`
WHERE `end_client_id` = u_end_client_id
AND `domain_id` = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_end_clients_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_end_clients_update`(
	IN	u_end_client_id	int(11)	,
	IN	u_domain_id	int(11)	,
	IN	u_end_client_name	varchar(120)	,
    IN 	u_client_id INT,
	IN	u_industry_id	int(11)	,
	IN	u_date_first_job	datetime	,
	IN	u_date_last_job	datetime	,
	IN	u_notes	longtext	
)
BEGIN

UPDATE `freetransoffice`.`end_clients`
SET
`end_client_id` = u_end_client_id, 
`domain_id` = u_domain_id, 
`end_client_name` = u_end_client_name, 
`client_id` = u_client_id, 
`industry_id` = u_industry_id, 
`date_first_job` = u_date_first_job, 
`date_last_job` = u_date_last_job, 
`notes` = u_notes
WHERE `end_client_id` = u_end_client_id 
and `domain_id` = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_industries_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_industries_create`(
	OUT u_industry_id int,
    IN u_industry_name varchar(100)
)
BEGIN

INSERT INTO `freetransoffice`.`industries` (
	`industry_name`
)
VALUES (
    u_industry_name
);

select last_insert_id() as u_industry_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_industries_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_industries_delete`(
	IN u_industry_id int
)
BEGIN

DELETE FROM `freetransoffice`.`industries`
where industry_id = u_industry_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_industries_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_industries_read`(
	IN u_industry_id int
)
BEGIN

IF IFNULL(u_industry_id, -1) = -1 THEN

	SELECT `industries`.`industry_id`,
		`industries`.`industry_name`
	FROM `freetransoffice`.`industries`;

ELSE

	SELECT `industries`.`industry_id`,
		`industries`.`industry_name`
	FROM `freetransoffice`.`industries`
	where industry_id = u_industry_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_industries_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_industries_update`(
	IN u_industry_id int,
    IN u_industry_name varchar(100)
)
BEGIN

update industries
set
industry_name = u_industry_name 
WHERE industry_id = u_industry_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_invoices_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_invoices_create`(
	OUT u_invoice_id int(11),
	IN u_domain_id int(11),
	IN u_invoice_number varchar(12),
	IN u_invoice_date datetime,
	IN u_client_id int(11),
	IN u_invoice_total decimal(19,4),
	IN u_received_amount decimal(19,4),
	IN u_received_date datetime,
	IN u_invoice_status int(11),
	IN u_invoice_document_id int(11),
	IN u_notes longtext
)
BEGIN

INSERT INTO `freetransoffice`.`invoices`
(`domain_id`,
`invoice_number`,
`invoice_date`,
`client_id`,
`invoice_total`,
`received_amount`,
`received_date`,
`invoice_status`,
`invoice_document_id`,
`notes`)
VALUES (
u_domain_id,
u_invoice_number,
u_invoice_date,
u_client_id,
u_invoice_total,
u_received_amount,
u_received_date,
u_invoice_status,
u_invoice_document_id,
u_notes
);

select last_insert_id() into u_invoice_id;
select u_invoice_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_invoices_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_invoices_delete`(
	IN u_invoice_id int,
    IN u_domain_id int
)
BEGIN

	delete from invoices where invoice_id = u_invoice_id and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_invoices_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_invoices_read`(
	IN u_invoice_id int,
    IN u_domain_id int
)
BEGIN

SELECT `invoices`.`invoice_id`,
    `invoices`.`domain_id`,
    `invoices`.`invoice_number`,
    `invoices`.`invoice_date`,
    `invoices`.`client_id`,
    `invoices`.`invoice_total`,
    `invoices`.`received_amount`,
    `invoices`.`received_date`,
    `invoices`.`invoice_status`,
    `invoices`.`invoice_document_id`,
    `invoices`.`notes`
FROM `freetransoffice`.`invoices`
WHERE invoice_id = u_invoice_id
AND domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_invoices_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_invoices_update`(
	IN u_invoice_id int(11),
	IN u_domain_id int(11),
	IN u_invoice_number varchar(12),
	IN u_invoice_date datetime,
	IN u_client_id int(11),
	IN u_invoice_total decimal(19,4),
	IN u_received_amount decimal(19,4),
	IN u_received_date datetime,
	IN u_invoice_status int(11),
	IN u_invoice_document_id int(11),
	IN u_notes longtext
)
BEGIN

UPDATE `freetransoffice`.`invoices`
SET
invoice_number = u_invoice_number, 
invoice_date = u_invoice_date, 
client_id = u_client_id, 
invoice_total = u_invoice_total, 
received_amount = u_received_amount, 
received_date = u_received_date, 
invoice_status = u_invoice_status, 
invoice_document_id = u_invoice_document_id, 
notes = u_notes
WHERE `invoice_id` = u_invoice_id 
and domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_jobs_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_jobs_create`(
	OUT	u_job_id	int(11)	,
	IN	u_domain_id	int(11)	,
	IN	u_job_number	varchar(12)	,
	IN	u_client_id	int(11)	,
	IN	u_end_client_id	int(11)	,
	IN	u_client_job_number	varchar(20)	,
	IN	u_job_type_id	int(11)	,
	IN	u_description	varchar(255)	,
	IN	u_package_id	int(11)	,
	IN	u_date_received	datetime	,
	IN	u_date_due	datetime	,
	IN	u_word_count	int(11)	,
	IN	u_price_currency_id	int(11)	,
	IN	u_price	decimal(19,4)	,
	IN	u_job_profile_id	int(11)	,
	IN	u_estimated_time	int(11)	,
	IN	u_actual_time	int(11)	,
	IN	u_job_status	int(11)	,
	IN	u_completed_date	datetime	,
	IN	u_invoice_id	int(11)	,
	IN	u_notes	longtext,	
	IN	u_user_defined_1	varchar(255)	,
	IN	u_user_defined_2	varchar(255)	,
	IN	u_user_defined_3	varchar(255)	
)
BEGIN

INSERT INTO `freetransoffice`.`jobs`
(`domain_id`,
`job_number`,
`client_id`,
`end_client_id`,
`client_job_number`,
`job_type_id`,
`description`,
`package_id`,
`date_received`,
`date_due`,
`word_count`,
`price_currency_id`,
`price`,
`job_profile_id`,
`estimated_time`,
`actual_time`,
`job_status`,
`completed_date`,
`invoice_id`,
`notes`,
`user_defined_1`,
`user_defined_2`,
`user_defined_3`)
VALUES
(u_domain_id	,
u_job_number	,
u_client_id	,
u_end_client_id	,
u_client_job_number	,
u_job_type_id	,
u_description	,
u_package_id	,
u_date_received	,
u_date_due	,
u_word_count	,
u_price_currency_id	,
u_price	,
u_job_profile_id	,
u_estimated_time	,
u_actual_time	,
u_job_status	,
u_completed_date	,
u_invoice_id	,
u_notes	,
u_user_defined_1	,
u_user_defined_2	,
u_user_defined_3	
);

select last_insert_id() as u_job_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_jobs_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_jobs_delete`(
	IN	u_job_id	int(11)	,
	IN	u_domain_id	int(11)
)
BEGIN

	delete from jobs where job_id = u_job_id and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_jobs_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_jobs_read`(
	IN	u_job_id	int(11)	,
	IN	u_domain_id	int(11)
)
BEGIN

SELECT `jobs`.`job_id`,
    `jobs`.`domain_id`,
    `jobs`.`job_number`,
    `jobs`.`client_id`,
    `jobs`.`end_client_id`,
    `jobs`.`client_job_number`,
    `jobs`.`job_type_id`,
    `jobs`.`description`,
    `jobs`.`package_id`,
    `jobs`.`date_received`,
    `jobs`.`date_due`,
    `jobs`.`word_count`,
    `jobs`.`price_currency_id`,
    `jobs`.`price`,
    `jobs`.`job_profile_id`,
    `jobs`.`estimated_time`,
    `jobs`.`actual_time`,
    `jobs`.`job_status`,
    `jobs`.`completed_date`,
    `jobs`.`invoice_id`,
    `jobs`.`notes`,
    `jobs`.`user_defined_1`,
    `jobs`.`user_defined_2`,
    `jobs`.`user_defined_3`
FROM `freetransoffice`.`jobs`
WHERE job_id = u_job_id 
and domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_jobs_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_jobs_update`(
	IN	u_job_id	int(11)	,
	IN	u_domain_id	int(11)	,
	IN	u_job_number	varchar(12)	,
	IN	u_client_id	int(11)	,
	IN	u_end_client_id	int(11)	,
	IN	u_client_job_number	varchar(20)	,
	IN	u_job_type_id	int(11)	,
	IN	u_description	varchar(255)	,
	IN	u_package_id	int(11)	,
	IN	u_date_received	datetime	,
	IN	u_date_due	datetime	,
	IN	u_word_count	int(11)	,
	IN	u_price_currency_id	int(11)	,
	IN	u_price	decimal(19,4)	,
	IN	u_job_profile_id	int(11)	,
	IN	u_estimated_time	int(11)	,
	IN	u_actual_time	int(11)	,
	IN	u_job_status	int(11)	,
	IN	u_completed_date	datetime	,
	IN	u_invoice_id	int(11)	,
	IN	u_notes	longtext,	
	IN	u_user_defined_1	varchar(255)	,
	IN	u_user_defined_2	varchar(255)	,
	IN	u_user_defined_3	varchar(255)	
)
BEGIN

UPDATE `freetransoffice`.`jobs`
SET
job_number = u_job_number, 
client_id = u_client_id, 
end_client_id = u_end_client_id, 
client_job_number = u_client_job_number, 
job_type_id = u_job_type_id, 
description = u_description,
package_id = u_package_id, 
date_received = u_date_received, 
date_due = u_date_due, 
word_count = u_word_count, 
price_currency_id = u_price_currency_id, 
price = u_price, 
job_profile_id = u_job_profile_id, 
estimated_time = u_estimated_time, 
actual_time = u_actual_time, 
job_status = u_job_status, 
completed_date = u_completed_date, 
invoice_id = u_invoice_id, 
notes = u_notes,
user_defined_1 = u_user_defined_1,
user_defined_2 = u_user_defined_2,
user_defined_3 = u_user_defined_3
WHERE job_id = u_job_id
and domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_job_profiles_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_job_profiles_create`(
	OUT u_job_profile_id int(11),
	IN u_domain_id int(11),
	IN u_job_profile_name varchar(50),
	IN u_job_type_id int(11),
	IN u_client_id int(11),
	IN u_end_client_id int(11),
	IN u_package_id int(11),
	IN u_words_per_hour int(11),
	IN u_job_type_multiplier int(11),
	IN u_notes longtext
)
BEGIN

INSERT INTO `freetransoffice`.`job_profiles` (
	`domain_id`,
	`job_profile_name`,
	`job_type_id`,
	`client_id`,
	`end_client_id`,
	`package_id`,
	`words_per_hour`,
	`job_type_multiplier`,
	`notes`
)
VALUES (
	u_domain_id,
	u_job_profile_name,
	u_job_type_id,
	u_client_id,
	u_end_client_id,
	u_package_id,
	u_words_per_hour,
	u_job_type_multiplier,
	u_notes
);

select last_insert_id() as u_job_profile_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_job_profiles_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_job_profiles_delete`(
	IN u_job_profile_id int,
    IN u_domain_id int
)
BEGIN

delete from job_profiles where job_profile_id = u_job_profile_id and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_job_profiles_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_job_profiles_read`(
	IN u_job_profile_id int,
    IN u_domain_id int
)
BEGIN

SELECT `job_profiles`.`job_profile_id`,
    `job_profiles`.`domain_id`,
    `job_profiles`.`job_profile_name`,
    `job_profiles`.`job_type_id`,
    `job_profiles`.`client_id`,
    `job_profiles`.`end_client_id`,
    `job_profiles`.`package_id`,
    `job_profiles`.`words_per_hour`,
    `job_profiles`.`job_type_multiplier`,
    `job_profiles`.`notes`
FROM `freetransoffice`.`job_profiles`
WHERE job_profile_id = u_job_profile_id
AND domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_job_profiles_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_job_profiles_update`(
	IN u_job_profile_id int(11),
	IN u_domain_id int(11),
	IN u_job_profile_name varchar(50),
	IN u_job_type_id int(11),
	IN u_client_id int(11),
	IN u_end_client_id int(11),
	IN u_package_id int(11),
	IN u_words_per_hour int(11),
	IN u_job_type_multiplier int(11),
	IN u_notes longtext
)
BEGIN

UPDATE job_profiles
SET
job_profile_name = u_job_profile_name, 
job_type_id = u_job_type_id, 
client_id = u_client_id, 
end_client_id = u_end_client_id, 
package_id = u_package_id, 
words_per_hour = u_words_per_hour, 
job_type_multiplier = u_job_type_multiplier, 
notes = u_notes
WHERE job_profile_id = u_job_profile_id
and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_job_types_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_job_types_create`(
	OUT u_job_type_id int,
    IN u_domain_id int,
    IN u_job_type varchar(40),
	IN u_words_per_hour int,
    IN u_notes longtext
)
BEGIN

INSERT INTO `freetransoffice`.`job_types` (
	`domain_id`,
	`job_type`,
    `words_per_hour`,
	`notes`
)
VALUES
(
    u_domain_id ,
    u_job_type ,
    u_words_per_hour,
    u_notes 
);

select last_insert_id() as u_job_type_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_job_types_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_job_types_delete`(
	IN u_job_type_id int,
    IN u_domain_id int
)
BEGIN

DELETE FROM `freetransoffice`.`job_types`
where job_type_id = u_job_type_id
and domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_job_types_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_job_types_read`(
	IN u_job_type_id int,
    IN u_domain_id int
)
BEGIN

IF IFNULL(u_job_type_id, -1) = -1 THEN

	SELECT `job_types`.`job_type_id`,
		`job_types`.`domain_id`,
		`job_types`.`job_type`,
		`job_types`.`words_per_hour`,
		`job_types`.`notes`
	FROM `freetransoffice`.`job_types`
	where domain_id IN (0, u_domain_id);

ELSE    

	SELECT `job_types`.`job_type_id`,
		`job_types`.`domain_id`,
		`job_types`.`job_type`,
		`job_types`.`words_per_hour`,
		`job_types`.`notes`
	FROM `freetransoffice`.`job_types`
	where job_type_id = u_job_type_id
	and domain_id IN (0, u_domain_id);

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_job_types_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_job_types_update`(
	IN u_job_type_id int,
    IN u_domain_id int,
    IN u_job_type varchar(40),
	IN u_words_per_hour int,    
    IN u_notes longtext
)
BEGIN

update job_types
set
job_type = u_job_type, 
words_per_hour = u_words_per_hour, 
notes = u_notes
WHERE job_type_id = u_job_type_id
AND domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_languages_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_languages_read`(

	IN u_language_id INT

)
BEGIN

IF IFNULL(u_language_id, -1) = -1
THEN

	select language_id, language_code, language_name from languages order by language_name limit 1000;

ELSE
	
	select language_id, language_code, language_name from languages where language_id = u_language_id order by language_name limit 1000;
    
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_packages_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_packages_create`(
	OUT u_package_id int,
    IN u_domain_id int,
    IN u_package_name varchar(120),
    IN u_notes longtext
)
BEGIN

INSERT INTO `freetransoffice`.`packages` (
	`domain_id`,
	`package_name`,
	`notes`
)
VALUES
(
    u_domain_id ,
    u_package_name ,
    u_notes 
);

select last_insert_id() as u_package_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_packages_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_packages_delete`(
	IN u_package_id int,
    IN u_domain_id int
)
BEGIN

DELETE FROM `freetransoffice`.`packages`
where package_id = u_package_id
and domain_id = u_domain_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_packages_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_packages_read`(
	IN u_package_id int,
    IN u_domain_id int
)
BEGIN

IF IFNULL(u_package_id, -1) = -1 THEN

	SELECT *
	FROM `freetransoffice`.`packages`
    where domain_id IN (0, u_domain_id)
    LIMIT 1000;

ELSE 

SELECT `packages`.`package_id`,
    `packages`.`domain_id`,
    `packages`.`package_name`,
    `packages`.`notes`
FROM `freetransoffice`.`packages`
where package_id = u_package_id
and domain_id IN (0, u_domain_id);

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_packages_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_packages_update`(
	IN u_package_id int,
    IN u_domain_id int,
    IN u_package_name varchar(120),
    IN u_notes longtext
)
BEGIN

update packages
set
package_name = u_package_name,
notes = u_notes
WHERE package_id = u_package_id
AND domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_config_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_config_create`(
	OUT u_report_id int(11),
	IN u_domain_id int(11),
	IN u_report_name varchar(120),
	IN u_report_type int(11),
	IN u_report_format_id int(11),
    IN u_template_id int(11),
    IN u_date_format int(11),
	IN u_greeting_text varchar(120),
	IN u_opening_text varchar(255),
    IN u_invoice_number_label varchar(30),
	IN u_col_a_label varchar(30),
	IN u_col_a_field varchar(50),
	IN u_col_b_label varchar(30),
	IN u_col_b_field varchar(50),
	IN u_col_c_label varchar(30),
	IN u_col_c_field varchar(50),
	IN u_col_d_label varchar(30),
	IN u_col_d_field varchar(50),
	IN u_col_e_label varchar(30),
	IN u_col_e_field varchar(50),
	IN u_col_f_label varchar(30),
	IN u_col_f_field varchar(50),
	IN u_col_g_label varchar(30),
	IN u_col_g_field varchar(50),
	IN u_col_h_label varchar(30),
	IN u_col_h_field varchar(50),
    IN u_invoice_total_label varchar(30),
    IN u_section_a_label varchar(30),
	IN u_section_a_field_label_1 varchar(30),
	IN u_section_a_field_1 varchar(50),
	IN u_section_a_field_label_2 varchar(30),
	IN u_section_a_field_2 varchar(50),
	IN u_section_a_field_label_3 varchar(30),
	IN u_section_a_field_3 varchar(50),
    IN u_section_b_label varchar(30),
	IN u_section_b_field_label_1 varchar(30),
	IN u_section_b_field_1 varchar(50),
	IN u_section_b_field_label_2 varchar(30),
	IN u_section_b_field_2 varchar(50),
	IN u_section_b_field_label_3 varchar(30),
	IN u_section_b_field_3 varchar(50),
	IN u_closing_text varchar(255)
)
BEGIN

INSERT INTO `freetransoffice`.`report_config`
(
`domain_id`,
`report_name`,
`report_type`,
`report_format_id`,
`template_id`,
`date_format`,
`greeting_text`,
`opening_text`,
`invoice_number_label`,
`col_a_label`,
`col_a_field`,
`col_b_label`,
`col_b_field`,
`col_c_label`,
`col_c_field`,
`col_d_label`,
`col_d_field`,
`col_e_label`,
`col_e_field`,
`col_f_label`,
`col_f_field`,
`col_g_label`,
`col_g_field`,
`col_h_label`,
`col_h_field`,
`invoice_total_label`,
`section_a_label`,
`section_a_field_label_1`,
`section_a_field_1`,
`section_a_field_label_2`,
`section_a_field_2`,
`section_a_field_label_3`,
`section_a_field_3`,
`section_b_label`,
`section_b_field_label_1`,
`section_b_field_1`,
`section_b_field_label_2`,
`section_b_field_2`,
`section_b_field_label_3`,
`section_b_field_3`,
`closing_text`)
VALUES
(	u_domain_id,
	u_report_name,
	u_report_type,
	u_report_format_id,
    u_template_id,
    u_date_format,
	u_greeting_text,
	u_opening_text,
    u_invoice_number_label,
	u_col_a_label,
	u_col_a_field,
	u_col_b_label,
	u_col_b_field,
	u_col_c_label,
	u_col_c_field,
	u_col_d_label,
	u_col_d_field,
	u_col_e_label,
	u_col_e_field,
	u_col_f_label,
	u_col_f_field,
	u_col_g_label,
	u_col_g_field,
	u_col_h_label,
	u_col_h_field,
    u_invoice_total_label,
    u_section_a_label,
	u_section_a_field_label_1,
	u_section_a_field_1,
	u_section_a_field_label_2,
	u_section_a_field_2,
	u_section_a_field_label_3,
	u_section_a_field_3,
    u_section_b_label,
	u_section_b_field_label_1,
	u_section_b_field_1,
	u_section_b_field_label_2,
	u_section_b_field_2,
	u_section_b_field_label_3,
	u_section_b_field_3,
	u_closing_text);

select last_insert_id() into u_report_id;
select u_report_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_config_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_config_delete`(
	IN u_report_id int,
    IN u_domain_id int
)
BEGIN

delete from report_config where report_id = u_report_id and domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_config_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_config_read`(
	IN u_report_id int,
    IN u_domain_id int
)
BEGIN

IF IFNULL(u_report_id, -1) = -1 THEN

	SELECT `report_config`.`report_id`,
    `report_config`.`domain_id`,
    `report_config`.`report_name`,
    `report_config`.`report_type`,
    `report_config`.`report_format_id`,
    `report_config`.`template_id`,
    `report_config`.`date_format`,
    `report_config`.`greeting_text`,
    `report_config`.`opening_text`,
    `report_config`.`invoice_number_label`,
    `report_config`.`col_a_label`,
    `report_config`.`col_a_field`,
    `report_config`.`col_b_label`,
    `report_config`.`col_b_field`,
    `report_config`.`col_c_label`,
    `report_config`.`col_c_field`,
    `report_config`.`col_d_label`,
    `report_config`.`col_d_field`,
    `report_config`.`col_e_label`,
    `report_config`.`col_e_field`,
    `report_config`.`col_f_label`,
    `report_config`.`col_f_field`,
    `report_config`.`col_g_label`,
    `report_config`.`col_g_field`,
    `report_config`.`col_h_label`,
    `report_config`.`col_h_field`,
    `report_config`.`invoice_total_label`,
    `report_config`.`section_a_label`,
    `report_config`.`section_a_field_label_1`,
    `report_config`.`section_a_field_1`,
    `report_config`.`section_a_field_label_2`,
    `report_config`.`section_a_field_2`,
    `report_config`.`section_a_field_label_3`,
    `report_config`.`section_a_field_3`,
    `report_config`.`section_b_label`,
    `report_config`.`section_b_field_label_1`,
    `report_config`.`section_b_field_1`,
    `report_config`.`section_b_field_label_2`,
    `report_config`.`section_b_field_2`,
    `report_config`.`section_b_field_label_3`,
    `report_config`.`section_b_field_3`,
    `report_config`.`closing_text`
    from report_config where domain_id IN (0, u_domain_id) limit 500;

ELSE

SELECT `report_config`.`report_id`,
    `report_config`.`domain_id`,
    `report_config`.`report_name`,
    `report_config`.`report_type`,
    `report_config`.`report_format_id`,
    `report_config`.`template_id`,
    `report_config`.`date_format`,
    `report_config`.`greeting_text`,
    `report_config`.`opening_text`,
    `report_config`.`invoice_number_label`,
    `report_config`.`col_a_label`,
    `report_config`.`col_a_field`,
    `report_config`.`col_b_label`,
    `report_config`.`col_b_field`,
    `report_config`.`col_c_label`,
    `report_config`.`col_c_field`,
    `report_config`.`col_d_label`,
    `report_config`.`col_d_field`,
    `report_config`.`col_e_label`,
    `report_config`.`col_e_field`,
    `report_config`.`col_f_label`,
    `report_config`.`col_f_field`,
    `report_config`.`col_g_label`,
    `report_config`.`col_g_field`,
    `report_config`.`col_h_label`,
    `report_config`.`col_h_field`,
    `report_config`.`invoice_total_label`,
    `report_config`.`section_a_label`,
    `report_config`.`section_a_field_label_1`,
    `report_config`.`section_a_field_1`,
    `report_config`.`section_a_field_label_2`,
    `report_config`.`section_a_field_2`,
    `report_config`.`section_a_field_label_3`,
    `report_config`.`section_a_field_3`,
    `report_config`.`section_b_label`,
    `report_config`.`section_b_field_label_1`,
    `report_config`.`section_b_field_1`,
    `report_config`.`section_b_field_label_2`,
    `report_config`.`section_b_field_2`,
    `report_config`.`section_b_field_label_3`,
    `report_config`.`section_b_field_3`,
    `report_config`.`closing_text`
FROM `freetransoffice`.`report_config`
WHERE report_id = u_report_id
AND domain_id IN (0, u_domain_id);
	
end if;    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_config_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_config_update`(
	IN u_report_id int(11),
	IN u_domain_id int(11),
	IN u_report_name varchar(120),
	IN u_report_type int(11),
	IN u_report_format_id int(11),
    IN u_template_id int(11),
    IN u_date_format int(11),
	IN u_greeting_text varchar(120),
	IN u_opening_text varchar(255),
    IN u_invoice_number_label varchar(30),
	IN u_col_a_label varchar(30),
	IN u_col_a_field varchar(50),
	IN u_col_b_label varchar(30),
	IN u_col_b_field varchar(50),
	IN u_col_c_label varchar(30),
	IN u_col_c_field varchar(50),
	IN u_col_d_label varchar(30),
	IN u_col_d_field varchar(50),
	IN u_col_e_label varchar(30),
	IN u_col_e_field varchar(50),
	IN u_col_f_label varchar(30),
	IN u_col_f_field varchar(50),
	IN u_col_g_label varchar(30),
	IN u_col_g_field varchar(50),
	IN u_col_h_label varchar(30),
	IN u_col_h_field varchar(50),
    IN u_invoice_total_label varchar(30),
    IN u_section_a_label varchar(30),
	IN u_section_a_field_label_1 varchar(30),
	IN u_section_a_field_1 varchar(50),
	IN u_section_a_field_label_2 varchar(30),
	IN u_section_a_field_2 varchar(50),
	IN u_section_a_field_label_3 varchar(30),
	IN u_section_a_field_3 varchar(50),
    IN u_section_b_label varchar(30),
	IN u_section_b_field_label_1 varchar(30),
	IN u_section_b_field_1 varchar(50),
	IN u_section_b_field_label_2 varchar(30),
	IN u_section_b_field_2 varchar(50),
	IN u_section_b_field_label_3 varchar(30),
	IN u_section_b_field_3 varchar(50),
	IN u_closing_text varchar(255))
BEGIN

UPDATE report_config
SET
report_name	=	u_report_name,
report_type	=	u_report_type,
report_format_id	=	u_report_format_id,
template_id	=	u_template_id,
date_format	=	u_date_format,
greeting_text	=	u_greeting_text,
opening_text	=	u_opening_text,
invoice_number_label	=	u_invoice_number_label,
col_a_label	=	u_col_a_label,
col_a_field	=	u_col_a_field,
col_b_label	=	u_col_b_label,
col_b_field	=	u_col_b_field,
col_c_label	=	u_col_c_label,
col_c_field	=	u_col_c_field,
col_d_label	=	u_col_d_label,
col_d_field	=	u_col_d_field,
col_e_label	=	u_col_e_label,
col_e_field	=	u_col_e_field,
col_f_label	=	u_col_f_label,
col_f_field	=	u_col_f_field,
col_g_label	=	u_col_g_label,
col_g_field	=	u_col_g_field,
col_h_label	=	u_col_h_label,
col_h_field	=	u_col_h_field,
invoice_total_label	=	u_invoice_total_label,
section_a_label	=	u_section_a_label,
section_a_field_label_1	=	u_section_a_field_label_1,
section_a_field_1	=	u_section_a_field_1,
section_a_field_label_2	=	u_section_a_field_label_2,
section_a_field_2	=	u_section_a_field_2,
section_a_field_label_3	=	u_section_a_field_label_3,
section_a_field_3	=	u_section_a_field_3,
section_b_label	=	u_section_b_label,
section_b_field_label_1	=	u_section_b_field_label_1,
section_b_field_1	=	u_section_b_field_1,
section_b_field_label_2	=	u_section_b_field_label_2,
section_b_field_2	=	u_section_b_field_2,
section_b_field_label_3	=	u_section_b_field_label_3,
section_b_field_3	=	u_section_b_field_3,
closing_text	=	u_closing_text
WHERE report_id = u_report_id
AND domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_formats_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_formats_read`(
	IN u_report_format_id int
)
BEGIN

IF IFNULL(u_report_format_id, -1) = -1 THEN

	select * from report_formats LIMIT 1000;

ELSE

	select * from report_formats where report_format_id = u_report_format_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_types_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_types_create`(
	OUT u_report_type_id int,
    IN u_report_type varchar(20)
)
BEGIN

INSERT INTO `freetransoffice`.`report_types` (
	`report_type`
)
VALUES (
    u_report_type
);

select last_insert_id() as u_report_type_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_types_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_types_delete`(
	IN u_report_type_id int
)
BEGIN

DELETE FROM `freetransoffice`.`report_types`
where report_type_id = u_report_type_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_types_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_types_read`(
	IN u_report_type_id int
)
BEGIN

SELECT `report_types`.`report_type_id`,
    `report_types`.`report_type`
FROM `freetransoffice`.`report_types`
where report_type_id = u_report_type_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_report_types_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_report_types_update`(
	IN u_report_type_id int,
    IN u_report_type varchar(20)
)
BEGIN

update report_types
set
report_type = u_report_type
WHERE report_type_id = u_report_type_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_securityquestions_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_securityquestions_read`(
	IN u_security_question_id int
)
BEGIN

IF ifnull(u_security_question_id, -1) = -1 THEN 

	SELECT *
	FROM `freetransoffice`.`security_questions`
    LIMIT 100;
ELSE
	SELECT `security_questions`.`security_question_id`,
		`security_questions`.`security_question`
	FROM `freetransoffice`.`security_questions`
	where `security_questions`.`security_question_id` < u_security_question_id;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_statuses_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_statuses_read`(
	IN u_status_id int
)
BEGIN

IF IFNULL(u_status_id, -1) = -1 THEN

	select * from statuses LIMIT 1000;

ELSE

	select * from statuses where status_id = u_status_id;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_templates_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_templates_create`(
	OUT u_template_id int,
    IN u_template_name varchar(50),
    IN u_template_path varchar(100)
)
BEGIN

INSERT INTO `freetransoffice`.`templates` (
	`template_name`,
    `template_path`
)
VALUES (
    u_template_name,
    u_template_path
);

select last_insert_id() into u_template_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_templates_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_templates_delete`(
	IN u_template_id int
)
BEGIN

DELETE FROM `freetransoffice`.`templates`
where template_id = u_template_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_templates_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_templates_read`(
	IN u_template_id int
)
BEGIN

SELECT `templates`.`template_id`,
    `templates`.`template_name`,
    `templates`.`template_path`
FROM `freetransoffice`.`templates`
where template_id = u_template_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_templates_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_templates_update`(
	IN u_template_id int,
    IN u_template_name varchar(50),
    IN u_template_path varchar(100)
)
BEGIN

update templates
set
template_name = u_template_name, 
template_path = u_template_path 
WHERE template_id = u_template_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_users_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_users_create`(
	OUT u_user_id int(11),
	IN u_domain_id int(11),
	IN u_first_name varchar(50),
	IN u_last_name varchar(80),
	IN u_user_name varchar(20),
	IN u_password_hash char(60),
	IN u_address_id int(11),
	IN u_email varchar(120),
	IN u_security_question int(11),
	IN u_security_answer char(60),
	IN u_company_name varchar(120),
	IN u_currency_id int(11),
	IN u_timezone varchar(30),
	IN u_logo_document_id int(11),
	IN u_jobnum_prefix varchar(5),
	IN u_jobnum_next int(11),
	IN u_invnum_prefix varchar(5),
	IN u_invnum_next int(11),
	IN u_user_defined_1 varchar(255),
	IN u_user_defined_2 varchar(255),
	IN u_user_defined_3 varchar(255) 
)
BEGIN

INSERT INTO `freetransoffice`.`users` (
	`domain_id`,
	`first_name`,
	`last_name`,
	`user_name`,
	`password_hash`,
	`address_id`,
	`email`,
	`security_question`,
	`security_answer`,
	`company_name`,
	`currency_id`,
	`timezone`,
	`logo_document_id`,
	`jobnum_prefix`,
	`jobnum_next`,
	`invnum_prefix`,
	`invnum_next`,
	`user_defined_1`,
	`user_defined_2`,
	`user_defined_3`
)
VALUES (
	u_domain_id,
	u_first_name,
	u_last_name,
	u_user_name,
	u_password_hash,
	u_address_id,
	u_email,
	u_security_question,
	u_security_answer,
	u_company_name,
	u_currency_id,
	u_timezone,
	u_logo_document_id,
	u_jobnum_prefix,
	u_jobnum_next,
	u_invnum_prefix,
	u_invnum_next,
	u_user_defined_1,
	u_user_defined_2,
	u_user_defined_3
);


select last_insert_id() as u_user_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_users_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_users_delete`(
	IN u_user_id int
)
BEGIN

	delete from domains where primary_user_id = u_user_id;
	delete from users where user_id = u_user_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_users_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_users_read`(
	IN u_user_id int(11) 
)
BEGIN

	SELECT `users`.`user_id`,
		`users`.`domain_id`,
		`users`.`first_name`,
		`users`.`last_name`,
		`users`.`user_name`,
		`users`.`password_hash`,
		`users`.`address_id`,
		`users`.`email`,
		`users`.`security_question`,
		`users`.`security_answer`,
		`users`.`company_name`,
		`users`.`currency_id`,
		`users`.`timezone`,
		`users`.`logo_document_id`,
		`users`.`jobnum_prefix`,
		`users`.`jobnum_next`,
		`users`.`invnum_prefix`,
		`users`.`invnum_next`,
		`users`.`user_defined_1`,
		`users`.`user_defined_2`,
		`users`.`user_defined_3`
	FROM `freetransoffice`.`users`
	where `users`.`user_id` = u_user_id;

-- SELECT IF(FOUND_ROWS()=0, 'No results found', null) AS errormsg;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_users_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_users_update`(
	IN u_user_id int(11),
	IN u_domain_id int(11),
	IN u_first_name varchar(50),
	IN u_last_name varchar(80),
    IN u_phone_number varchar(25),
	IN u_address_id int(11),
	IN u_company_name varchar(120),
	IN u_currency_id int(11),
	IN u_timezone varchar(30),
	IN u_logo_document_id int(11),
	IN u_jobnum_prefix varchar(5),
	IN u_jobnum_next int(11),
	IN u_invnum_prefix varchar(5),
	IN u_invnum_next int(11),
	IN u_user_defined_1 varchar(255),
	IN u_user_defined_2 varchar(255),
	IN u_user_defined_3 varchar(255) 
)
BEGIN

-- for security reasons, updates cannot be made to the following user fields via this procedure:
-- user_name, password_hash, email, security_question, security_answer
-- separate proc to be generated which can only be run by dbowner, and will not have public access

UPDATE users
SET
first_name = u_first_name, 
last_name = u_last_name, 
phone_number = u_phone_number, 
address_id = u_address_id, 
company_name = u_company_name, 
currency_id = u_currency_id, 
timezone = u_timezone, 
logo_document_id = u_logo_document_id, 
jobnum_prefix = u_jobnum_prefix, 
jobnum_next = u_jobnum_next, 
invnum_prefix = u_invnum_prefix, 
invnum_next = u_invnum_next, 
user_defined_1 = u_user_defined_1,
user_defined_2 = u_user_defined_2,
user_defined_3 = u_user_defined_3
WHERE user_id = u_user_id
AND domain_id = u_domain_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sys_users_update_usersettings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`rmturner`@`%` PROCEDURE `sys_users_update_usersettings`(
	IN u_user_id int,
    IN u_first_name varchar(50),
    IN u_last_name varchar(80),
    IN u_company_name varchar(120),
    IN u_address_1 varchar(80),
    IN u_address_2 varchar(80),
    IN u_city varchar(30),
    IN u_state varchar(3),
    IN u_postalcode varchar(10),
    IN u_region varchar(50),
    IN u_county varchar(50),
    IN u_country_id int,
    IN u_currency_id int,
    IN u_timezone varchar(30),
    IN u_logo_document_id int,
    IN u_jobnum_prefix varchar(5),
    IN u_jobnum_next int,
    IN u_invnum_prefix varchar(5),
    IN u_invnum_next int
)
BEGIN

declare u_address_id int;
declare u_domain_id int;
select address_id into u_address_id from users where user_id = u_user_id;
select domain_id into u_domain_id from users where user_id = u_user_id;

-- check to see if the user has an address
-- if the user does not have an address already associated, then run the insert address proc, else update the address
IF u_address_id is null 
	THEN call sys_addresses_create(@address_id, u_domain_id, u_address_1, u_address_2, u_city, u_state, u_postalcode, u_region, u_county, u_country_id);
    set u_address_id = @address_id;
	ELSE call sys_addresses_update(u_address_id, u_domain_id, u_address_1, u_address_2, u_city, u_state, u_postalcode, u_region, u_county, u_country_id);
END IF;

UPDATE `freetransoffice`.`users`
	SET `first_name` = ifnull(u_first_name, first_name),
	`last_name` = ifnull(u_last_name, last_name),
	`address_id` = ifnull(u_address_id, address_id),
	`company_name` = ifnull(u_company_name, company_name),
	`currency_id` = ifnull(u_currency_id, currency_id),
	`timezone` = ifnull(u_timezone, timezone),
	`logo_document_id` = ifnull(u_logo_document_id, logo_document_id),
	`jobnum_prefix` = ifnull(u_jobnum_prefix, jobnum_prefix),
	`jobnum_next` = ifnull(u_jobnum_next, jobnum_next),
	`invnum_prefix` = ifnull(u_invnum_prefix, invnum_prefix),
	`invnum_next` = ifnull(u_invnum_prefix, invnum_next)
WHERE `user_id` = u_user_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_invoice_report_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_invoice_report_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`rmturner`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_invoice_report_details` AS select `j`.`invoice_id` AS `invoice_id`,`j`.`domain_id` AS `domain_id`,`j`.`job_id` AS `job_id`,`j`.`job_number` AS `job_number`,`ec`.`end_client_name` AS `end_client_name`,`ec`.`notes` AS `end_client_notes`,`j`.`client_job_number` AS `client_job_number`,`jt`.`job_type` AS `job_type`,`j`.`description` AS `job_description`,`pk`.`package_name` AS `package_name`,cast(`j`.`date_received` as date) AS `date_received`,cast(`j`.`date_due` as date) AS `date_due`,`j`.`word_count` AS `word_count`,concat(round(`j`.`price`,2),' ',`cu`.`currency_code`) AS `price_with_currency`,round(`j`.`price`,2) AS `price_no_currency`,cast(`j`.`completed_date` as date) AS `completed_date`,`j`.`user_defined_1` AS `job_udf1`,`j`.`user_defined_2` AS `job_udf2`,`j`.`user_defined_3` AS `job_udf3`,`j`.`notes` AS `job_notes`,NULL AS `unused_column` from ((((`jobs` `j` left join `end_clients` `ec` on(((`j`.`end_client_id` = `ec`.`end_client_id`) and (`j`.`domain_id` = `ec`.`domain_id`)))) join `job_types` `jt` on(((`j`.`job_type_id` = `jt`.`job_type_id`) and (`jt`.`domain_id` in (0,`j`.`domain_id`))))) left join `packages` `pk` on(((`j`.`package_id` = `pk`.`package_id`) and (`pk`.`domain_id` in (0,`j`.`domain_id`))))) left join `currencies` `cu` on((`j`.`price_currency_id` = `cu`.`currency_id`))) where (`j`.`job_status` = 6) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_invoice_report_headers`
--

/*!50001 DROP VIEW IF EXISTS `vw_invoice_report_headers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`rmturner`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_invoice_report_headers` AS select distinct `inv`.`invoice_id` AS `invoice_id`,`inv`.`domain_id` AS `domain_id`,concat(`invcon`.`first_name`,' ',`invcon`.`last_name`) AS `invoice_contact_full_name`,`invcon`.`first_name` AS `invoice_contact_first_name`,`invcon`.`last_name` AS `invoice_contact_last_name`,`invcon`.`email` AS `invoice_contact_email`,`invcon`.`phone` AS `invoice_contact_phone`,`invcon`.`position_held` AS `invoice_contact_position`,`invcon`.`notes` AS `invoice_contact_notes`,`cl`.`vendor_code` AS `client_vendor_code`,`cl`.`notes` AS `client_notes`,`cl`.`user_defined_1` AS `client_udf1`,`cl`.`user_defined_2` AS `client_udf2`,`cl`.`user_defined_3` AS `client_udf3`,`cl`.`invoice_notes` AS `client_invoice_notes`,`cl`.`invoice_by` AS `client_invoice_by_date`,`cl`.`invoice_paid` AS `client_invoice_paid_date`,`cl`.`last_invoice` AS `client_last_invoice`,`inv`.`notes` AS `invoice_notes`,`usr`.`email` AS `user_email`,concat(`usr`.`first_name`,' ',`usr`.`last_name`) AS `user_full_name`,`usr`.`first_name` AS `user_first_name`,`usr`.`last_name` AS `user_last_name`,`usr`.`company_name` AS `user_company_name`,`usr`.`user_defined_1` AS `user_udf1`,`usr`.`user_defined_2` AS `user_udf2`,`usr`.`user_defined_3` AS `user_udf3`,NULL AS `unused_column` from (((`invoices` `inv` join `clients` `cl` on(((`inv`.`client_id` = `cl`.`client_id`) and (`inv`.`domain_id` = `cl`.`domain_id`)))) left join `contacts` `invcon` on(((`cl`.`invoice_to` = `invcon`.`contact_id`) and (`cl`.`domain_id` = `invcon`.`domain_id`)))) join `users` `usr` on((`inv`.`domain_id` = `usr`.`domain_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-22  8:32:34
