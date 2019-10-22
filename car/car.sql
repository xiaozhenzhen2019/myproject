CREATE TABLE bus_cars (
  carnumber varchar(255) NOT NULL,
  cartype varchar(255) DEFAULT NULL,
  color varchar(255) DEFAULT NULL,
  price double(255,2) DEFAULT NULL,
  rentprice double(255,2) DEFAULT NULL,
  deposit double DEFAULT NULL,
  isrenting int(11) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  carimg varchar(255) DEFAULT NULL,
  PRIMARY KEY (carnumber)
);


INSERT INTO bus_cars VALUES ('京A66666', 'SUV', '白色', '280000.00', '500.00', '5000', '0', '宝马X1', '/upload/2018-07-21/20180721110548561_3995.png');
INSERT INTO bus_cars VALUES ('京A77777', 'SUV', '白色', '350000.00', '1500.00', '12000', '0', '宝马X3', '/upload/2018-07-21/20180721110602215_2157.png');
INSERT INTO bus_cars VALUES ('京A88888', '轿车', '黑色', '880000.00', '1000.00', '10000', '0', '保时捷 卡宴', '/upload/2018-07-21/20180721110617581_6401.png');

----------------------------------------------------------------------

CREATE TABLE bus_checks (
  checkid varchar(255) NOT NULL,
  checkdate datetime DEFAULT NULL,
  checkdesc varchar(255) DEFAULT NULL,
  problem varchar(255) DEFAULT NULL,
  paymoney double(255,0) DEFAULT NULL,
  opername varchar(255) DEFAULT NULL,
  rentid varchar(255) DEFAULT NULL,
  PRIMARY KEY (checkid)
);

INSERT INTO bus_checks VALUES ('JC_20180612_170407_0385_63960', '2018-06-12 00:00:00', '在G50高速超速', '超速', '500', '习大大', 'CZ_20180611_171304_0732_57330');
INSERT INTO bus_checks VALUES ('JC_20180612_172559_0323_71959', '2018-06-13 00:00:00', '无', '无', '0', '习大大', 'CZ_20180612_164747_0573_26177');
INSERT INTO bus_checks VALUES ('JC_20180718_091454_0191_93480', '2018-07-18 00:00:00', '无', '无', '0', '习大大', 'CZ_20180718_091206_0365_62161');
INSERT INTO bus_checks VALUES ('JC_20180721172509547_8735', '2018-07-21 00:00:00', '222', '222', '22', '超级管理员', 'CZ_20180721164647645_6913');

--------------------------------------------------------------

CREATE TABLE bus_customers (
  identity varchar(255) NOT NULL COMMENT '身份证',
  custname varchar(255) DEFAULT NULL COMMENT '姓名',
  sex int(255) DEFAULT NULL COMMENT '性别',
  address varchar(255) DEFAULT NULL COMMENT '地址',
  phone varchar(255) DEFAULT NULL COMMENT '电话',
  career varchar(255) DEFAULT NULL COMMENT '职位',
  PRIMARY KEY (identity)
);

INSERT INTO bus_customers VALUES ('421087133414144412', '张小明', '1', '武昌', '13456788987', '程序员');
INSERT INTO bus_customers VALUES ('431321199291331131', '张三', '1', '武昌', '13431334113', '程序员');
INSERT INTO bus_customers VALUES ('431321199291331132', '孙中山', '1', '汉口', '134131314131', '总统');
INSERT INTO bus_customers VALUES ('431341134191311311', '李四', '0', '汉阳', '13451313113', 'CEO');
INSERT INTO bus_customers VALUES ('431341134191311314', '王小明', '1', '蔡甸', '13413131113', 'CEO');

-----------------------------------------------------------------

CREATE TABLE bus_rents (
  rentid varchar(255) NOT NULL,
  price double(10,2) DEFAULT NULL,
  begindate datetime DEFAULT NULL,
  returndate datetime DEFAULT NULL,
  rentflag int(11) DEFAULT NULL,
  identity varchar(255) DEFAULT NULL,
  carnumber varchar(255) DEFAULT NULL,
  opername varchar(255) DEFAULT NULL,
  PRIMARY KEY (rentid)
);

INSERT INTO bus_rents VALUES ('CZ_20180612_164747_0573_26177', '500.00', '2018-06-13 00:00:00', '2018-06-23 00:00:00', '1', '431321199291331131', '鄂A66666', '习大大');
INSERT INTO bus_rents VALUES ('CZ_20180721164647645_6913', '500.00', '2018-07-21 00:00:00', '2018-07-28 00:00:00', '1', '431321199291331131', '鄂A66666', '超级管理员');

----------------------------------------------------------------------

CREATE TABLE sys_log_login (
  id int(11) NOT NULL AUTO_INCREMENT,
  loginname varchar(255) DEFAULT NULL,
  loginip varchar(255) DEFAULT NULL,
  logintime datetime DEFAULT NULL,
  PRIMARY KEY (id)
);

-------------------------------------------------------------

CREATE TABLE sys_menus (
  id int(11) NOT NULL AUTO_INCREMENT,
  pid int(11) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  href varchar(255) DEFAULT NULL,
  open int(255) DEFAULT NULL COMMENT '0不打1打开',
  parent int(255) DEFAULT NULL COMMENT '0非父节点1父节点',
  target varchar(255) DEFAULT NULL,
  icon varchar(255) DEFAULT NULL,
  tabicon varchar(255) DEFAULT NULL,
  available int(255) DEFAULT NULL COMMENT '0不可用1可用',
  PRIMARY KEY (id)
);

INSERT INTO sys_menus VALUES ('1', '0', '汽车出租系统', '', '1', '1', '', '../resources/css/icons/FUNC20082.gif', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('2', '1', '客户管理', '../customer/toCustomerManager.action', '0', '0', '', '../resources/css/icons/FUNC20001.gif', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('3', '1', '车辆管理', '../car/toCarManager.action', '0', '0', '', '../resources/css/icons/FUNC20065.gif', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('4', '1', '业务管理', '', '1', '1', '', '../resources/css/icons/FUNC20024.gif', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('5', '1', '系统管理', '', '1', '1', '', '../resources/css/icons/advancedsettings.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('6', '4', '汽车出租', '../rent/toRentCarManager.action', '0', '0', '', '../resources/css/icons/FUNC20088.gif', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('7', '4', '出租单管理', '../rent/toRentManager.action', '0', '0', '', '../resources/css/icons/drive_edit.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('8', '4', '汽车入库', '../check/toCheckCarManager.action', '0', '0', '', '../resources/css/icons/FUNC55000.gif', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('9', '4', '检查单管理', '../check/toCheckManager.action', '0', '0', '', '../resources/css/icons/feed_edit.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('10', '5', '菜单管理', '../menu/toMenuManager.action', '0', '0', '', '../resources/css/icons/page_white_paste_table.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('11', '5', '角色管理', '../role/toRoleManager.action', '0', '0', '', '../resources/css/icons/FUNC241000.gif', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('12', '5', '用户管理', '../user/toUserManager.action', '0', '0', '', '../resources/css/icons/group_add.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('13', '5', '修改密码', '', '0', '0', '', '../resources/css/icons/group_add.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('14', '1', '数据统计', '', '1', '1', '', '../resources/css/icons/application_edit.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('15', '14', '客户地区统计', '../tjfx/toCountCustomerArea.action', '0', '0', '', '../resources/css/icons/page_white_paste_table.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('16', '14', '客户男女比例统计', '../tjfx/toCircleSex.action', '0', '0', '', '../resources/css/icons/book_addresses_edit.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('17', '14', '车辆类型统计', '', '0', '0', '', '../resources/css/icons/book_link.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('18', '5', '日志管理', '../syslog/toSysLogManager.action', '0', '0', null, '../resources/css/icons/book_link.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('20', '14', '年销售额统计', '', '0', '0', '1', '../resources/css/icons/book_link.png', 'icon-add', '1');
INSERT INTO sys_menus VALUES ('21', '5', '系统公告', '../news/toNewsManager.action', '0', '0', '', '../resources/css/icons/application_edit.png', 'icon-save', '1');

-----------------------------------------------------------------

CREATE TABLE sys_news (
  id int(11) NOT NULL AUTO_INCREMENT,
  title varchar(255) DEFAULT NULL,
  content text,
  createtime datetime DEFAULT NULL,
  opername varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

INSERT INTO sys_news VALUES ('4', '12312312', '亚运会闭幕', '2018-06-14 17:23:52', '习大大');
INSERT INTO sys_news VALUES ('5', '关系系统升级公告', '找个系统深处的男人', '2018-06-14 18:05:22', '习大大');
INSERT INTO sys_news VALUES ('6', '12321321', '亚运会', '2018-07-24 14:12:34', '超级管理员');
INSERT INTO sys_news VALUES ('7', '习近平的基加利时间：中卢共“舞”迎未来', '中非合作', '2018-07-24 00:00:00', '超级管理员');

-------------------------------------------------------------------

CREATE TABLE sys_role_menu (
  rid int(11) NOT NULL,
  mid int(11) NOT NULL,
  PRIMARY KEY (rid,mid)
);

INSERT INTO sys_role_menu VALUES ('1', '1');
INSERT INTO sys_role_menu VALUES ('1', '2');
INSERT INTO sys_role_menu VALUES ('1', '3');
INSERT INTO sys_role_menu VALUES ('1', '4');
INSERT INTO sys_role_menu VALUES ('1', '5');
INSERT INTO sys_role_menu VALUES ('1', '6');
INSERT INTO sys_role_menu VALUES ('1', '7');
INSERT INTO sys_role_menu VALUES ('1', '8');
INSERT INTO sys_role_menu VALUES ('1', '9');
INSERT INTO sys_role_menu VALUES ('1', '10');
INSERT INTO sys_role_menu VALUES ('1', '11');
INSERT INTO sys_role_menu VALUES ('1', '12');
INSERT INTO sys_role_menu VALUES ('1', '13');
INSERT INTO sys_role_menu VALUES ('1', '14');
INSERT INTO sys_role_menu VALUES ('1', '15');
INSERT INTO sys_role_menu VALUES ('1', '16');
INSERT INTO sys_role_menu VALUES ('1', '17');
INSERT INTO sys_role_menu VALUES ('1', '18');
INSERT INTO sys_role_menu VALUES ('1', '20');
INSERT INTO sys_role_menu VALUES ('1', '21');
INSERT INTO sys_role_menu VALUES ('2', '1');
INSERT INTO sys_role_menu VALUES ('2', '2');
INSERT INTO sys_role_menu VALUES ('2', '3');
INSERT INTO sys_role_menu VALUES ('2', '4');
INSERT INTO sys_role_menu VALUES ('2', '6');
INSERT INTO sys_role_menu VALUES ('2', '7');
INSERT INTO sys_role_menu VALUES ('2', '8');
INSERT INTO sys_role_menu VALUES ('2', '9');
INSERT INTO sys_role_menu VALUES ('3', '1');
INSERT INTO sys_role_menu VALUES ('3', '5');
INSERT INTO sys_role_menu VALUES ('3', '10');
INSERT INTO sys_role_menu VALUES ('3', '11');
INSERT INTO sys_role_menu VALUES ('3', '12');
INSERT INTO sys_role_menu VALUES ('3', '13');
INSERT INTO sys_role_menu VALUES ('3', '18');
INSERT INTO sys_role_menu VALUES ('3', '21');
INSERT INTO sys_role_menu VALUES ('4', '1');
INSERT INTO sys_role_menu VALUES ('4', '14');
INSERT INTO sys_role_menu VALUES ('4', '15');
INSERT INTO sys_role_menu VALUES ('4', '16');
INSERT INTO sys_role_menu VALUES ('4', '17');
INSERT INTO sys_role_menu VALUES ('4', '20');

-----------------------------------------------------------------------

CREATE TABLE sys_role_user (
  uid int(11) NOT NULL,
  rid int(11) NOT NULL,
  PRIMARY KEY (uid,rid)
);

INSERT INTO sys_role_user VALUES ('1', '1');
INSERT INTO sys_role_user VALUES ('3', '1');
INSERT INTO sys_role_user VALUES ('3', '2');
INSERT INTO sys_role_user VALUES ('3', '3');
INSERT INTO sys_role_user VALUES ('3', '4');
INSERT INTO sys_role_user VALUES ('4', '2');
INSERT INTO sys_role_user VALUES ('5', '3');

--------------------------------------------------------------------

CREATE TABLE sys_roles (
  roleid int(11) NOT NULL AUTO_INCREMENT,
  rolename varchar(255) DEFAULT NULL,
  roledesc varchar(255) DEFAULT NULL,
  PRIMARY KEY (roleid)
);

INSERT INTO sys_roles VALUES ('1', '超级管理员', '拥有所有菜单权限');
INSERT INTO sys_roles VALUES ('2', '业务管理员', '拥有所以业务菜单');
INSERT INTO sys_roles VALUES ('3', '系统管理员', '管理系统');
INSERT INTO sys_roles VALUES ('4', '数据统计管理员', '数据统计管理员');

-----------------------------------------------------------------------

CREATE TABLE sys_users (
  userid int(11) NOT NULL AUTO_INCREMENT,
  loginname varchar(255) DEFAULT NULL,
  identity varchar(255) DEFAULT NULL,
  realname varchar(255) DEFAULT NULL,
  sex int(255) DEFAULT NULL COMMENT '0女1男',
  address varchar(255) DEFAULT NULL,
  phone varchar(255) DEFAULT NULL,
  pwd varchar(255) DEFAULT NULL,
  position varchar(255) DEFAULT NULL,
  type int(255) DEFAULT '2' COMMENT '1，超级管理员,2，系统用户',
  PRIMARY KEY (userid)
);

INSERT INTO sys_users VALUES ('1', 'admin', '4313341334413', '超级管理员', '1', '武汉', '134441331311', '123456', 'CEO', '1');
INSERT INTO sys_users VALUES ('3', 'zhangsan', '3413334134131131', '张三', '1', '武汉', '134131313111', '123456', 'BA', '2');
INSERT INTO sys_users VALUES ('4', 'lisi', '43311341311314341', '李四', '1', '武汉', '1341314113131', '123456', '扫地的', '2');
INSERT INTO sys_users VALUES ('5', 'wangwu', '4313133131331312', '王五', '1', '武汉', '13413131131', '123456', '领导', '2');
INSERT INTO sys_users VALUES ('8', 'zhaoliu', '431333133312221', '赵六', '1', '武汉', '135133331131', '123456', 'BA', '2');
