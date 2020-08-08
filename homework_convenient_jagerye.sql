-- 重生DATABASE
DROP DATABASE homework_convenient_jagerye;
CREATE DATABASE IF NOT EXISTS `homework_convenient_jagerye` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `homework_convenient_jagerye`;

-- 創建各表格
DROP TABLE IF EXISTS `members`;
CREATE TABLE `members`(
    `member_id` VARCHAR(20) NOT NULL,
    `password` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `restaurant_type`;
CREATE TABLE `restaurant_type` (
  `restaurant_type_id` varchar(20) NOT NULL,
  `restaurant_type_name` varchar(20) NOT NULL,
  PRIMARY KEY (`restaurant_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `restaurants`;
CREATE TABLE `restaurants` (
  `restaurant_id` varchar(20) NOT NULL,
  `restaurant_type_id` varchar(20) NOT NULL,
  `restaurant_name` varchar(20) NOT NULL,
  `restaurant_address` varchar(100) NOT NULL,
  `restaurant_phone` varchar(20) NOT NULL,
  PRIMARY KEY (`restaurant_id`),
  FOREIGN KEY (`restaurant_type_id`) REFERENCES `restaurant_type`(`restaurant_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `meal_type`;
CREATE TABLE `meal_type` (
  `meal_type_id` varchar(20) NOT NULL,
  `restaurant_id` varchar(20) NOT NULL,
  `meal_type_name` varchar(20) NOT NULL,
  PRIMARY KEY (`meal_type_id`),
  FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants`(`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `meals`;
CREATE TABLE `meals` (
  `meal_id` varchar(20) NOT NULL,
  `meal_type_id` varchar(20) NOT NULL,
  `meal_name` varchar(20) NOT NULL,
  `meal_price` int NOT NULL,
  `meal_status` int NOT NULL,
  PRIMARY KEY (`meal_id`),
  FOREIGN KEY (`meal_type_id`) REFERENCES `meal_type`(`meal_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `menu_id` varchar(20) NOT NULL,
  `restaurant_id` varchar(20) NOT NULL,
  `menu_name` varchar(20) NOT NULL,
  `menu_status` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`),
  FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants`(`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `menu_details`;
CREATE TABLE `menu_details` (
  `menu_destail_id` varchar(20) NOT NULL,
  `menu_id` varchar(20) NOT NULL,
  `meal_id` varchar(20) NOT NULL,
  PRIMARY KEY (`menu_destail_id`),
  FOREIGN KEY (`menu_id`) REFERENCES `menus`(`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` varchar(20) NOT NULL,
  `member_id` varchar(20) NOT NULL,
  `restaurant_id` varchar(20) NOT NULL,
  `order_status` int(11) NOT NULL,
  `order_time` datetime NOT NULL,
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (`member_id`) REFERENCES `members`(`member_id`),
  FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants`(`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `order_id` varchar(20) NOT NULL,
  `menu_destail_id` varchar(20) NOT NULL,
  `meal_quantity` int(11) NOT NULL,
  `meal_unit_price` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`menu_destail_id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`order_id`),
  FOREIGN KEY (`menu_destail_id`) REFERENCES `menu_details`(`menu_destail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 載入資料
INSERT INTO `members` (`member_id`, `password`) VALUES
('Jager', '123456'),
('Johnson', '123456'),
('Peter', '123456'),
('Rose', '123456'),
('Tom', '123456');

INSERT INTO `restaurant_type` (`restaurant_type_id`, `restaurant_type_name`) VALUES
('rt001', '台式'),
('rt002', '西式'),
('rt003', '日式'),
('rt004', '泰式'),
('rt005', '手搖飲');

INSERT INTO `restaurants` (`restaurant_id`, `restaurant_type_id`, `restaurant_name`, `restaurant_address`, `restaurant_phone`) VALUES
('r0001', 'rt002', '台中牛排館', '407台中市西屯區西屯路三段299-1號', '0424652121'),
('r0002', 'rt003', 'Nagi豚骨拉麵 凪 - 台中店', '407台中市西屯區河南路三段120號3樓', '0436062511'),
('r0003', 'rt004', '卷卷泰式廚房料理', '40360台中市西區台灣大道二段563號', '0423239650'),
('r0004', 'rt005', '可不可熟成紅茶-台中向上店', '40358台中市西區向上路一段191號', '0423013552'),
('r0005', 'rt001', '康寶十全藥燉排骨', '404台中市北區美德街302號', '0422035655');

INSERT INTO `meal_type` (`meal_type_id`, `restaurant_id`, `meal_type_name`) VALUES
('mt001', 'r0003', '飯'),
('mt002', 'r0003', '麵條'),
('mt003', 'r0003', '小菜'),
('mt004', 'r0003', '湯');

INSERT INTO `meals` (`meal_id`, `meal_type_id`, `meal_name`, `meal_price`, `meal_status`) VALUES
('mm00001', 'mt001', '打拋豬飯', 100, 1),
('mm00002', 'mt001', '打拋雞飯', 100, 1),
('mm00003', 'mt001', '辣炒雞飯', 110, 1),
('mm00004', 'mt001', '紅咖哩雞飯', 120, 1),
('mm00005', 'mt001', '泰式炒飯', 90, 1),
('mm00006', 'mt002', '番茄豬肉麵', 70, 1),
('mm00007', 'mt003', '打拋豬', 150, 1),
('mm00008', 'mt004', '泰式海鮮酸辣湯', 140, 1);

INSERT INTO `menus` (`menu_id`, `restaurant_id`, `menu_name`, `menu_status`) VALUES
('mn00001', 'r0003', '夏季菜單', 1),
('mn00002', 'r0003', '冬季菜單', 0);

INSERT INTO `menu_details` (`menu_destail_id`, `menu_id`, `meal_id`) VALUES
('md000001', 'mn00001', 'mm00001'),
('md000002', 'mn00001', 'mm00007'),
('md000003', 'mn00001', 'mm00008'),
('md000004', 'mn00002', 'mm00003'),
('md000005', 'mn00002', 'mm00006'),
('md000006', 'mn00002', 'mm00008');

INSERT INTO `orders` (`order_id`, `member_id`, `restaurant_id`, `order_status`, `order_time`) VALUES
('od0000001', 'Jager', 'r0003', 1, '2020-08-08 17:00:00');

INSERT INTO `order_details` (`order_id`, `menu_destail_id`, `meal_quantity`, `meal_unit_price`) VALUES
('od0000001', 'md000001', 2, 100),
('od0000001', 'md000002', 1, 150),
('od0000001', 'md000003', 1, 140);

-- 查詢所有訂單明細
SELECT od.order_id, o.member_id, m.meal_name, meal_quantity, meal_unit_price, r.restaurant_name
FROM order_details AS od
INNER JOIN orders AS o ON o.order_id = od.order_id
INNER JOIN restaurants AS r ON o.restaurant_id = r.restaurant_id
INNER JOIN menu_details AS md ON od.menu_destail_id = md.menu_destail_id
INNER JOIN meals AS m ON md.meal_id = m.meal_id;

-- 查詢各餐廳所存儲的菜色
SELECT meal_id, r.restaurant_name, mt.meal_type_name, meal_name, meal_price, meal_status
FROM meals AS m
INNER JOIN meal_type AS mt ON m.meal_type_id = mt.meal_type_id
INNER JOIN restaurants AS r ON r.restaurant_id = mt.restaurant_id;

-- 查詢各餐廳的菜單組合
SELECT menu_destail_id, m.menu_name, meals.meal_name
FROM menu_details AS md
INNER JOIN menus AS m ON m.menu_id = md.menu_id
INNER JOIN meals ON meals.meal_id = md.meal_id;