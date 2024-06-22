CREATE TABLE `rex_postal_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `depart` varchar(50) DEFAULT NULL,
  `arrive` varchar(50) DEFAULT NULL,
  `arrive_label` varchar(50) DEFAULT NULL,
  `sentfrom` varchar(50) DEFAULT NULL,
  `sentto` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `deliverytime` int(3) NOT NULL DEFAULT 60,
  `status` varchar(50) DEFAULT NULL,
  `payment` double(11,2) NOT NULL DEFAULT 0.00,
  `paymentmade` int(1) NOT NULL DEFAULT 0,
  `arrivemsgsent` int(1) NOT NULL DEFAULT 0,
  `paymentmsgsent` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
