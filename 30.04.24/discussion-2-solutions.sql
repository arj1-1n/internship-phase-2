--employees table
create table `employees` (
    `employeenumber` int(11) unsigned not null auto_increment,
    `lastname` varchar(50) not null,
    `firstname` varchar(50) not null,
    `extension` varchar(50),
    `email` varchar(50) not null,
    `officecode` int(11),
    `reportsto` int(11),
    `jobtitle` varchar(50),
    constraint `pk_employees` primary key (`employeenumber`),
    constraint `uq_employees_email` unique (`email`),
    constraint `fk_offices_employees` foreign key (`officecode`) references `offices` (`officecode`),
    constraint `fk_employees_employees` foreign key (`reportsto`) references `employees` (`employeenumber`)
);

--offices table
create table `offices` (
    `officecode` int(11) unsigned not null auto_increment,
    `city` varchar(25) not null,
    `phone` varchar(10) not null,
    `addressline1` varchar(75) not null,
    `addressline2` varchar(75) default null,
    `state` varchar(15) not null,
    `country` varchar(15) not null,
    `postalcode` int(8) not null,
    `territory` varchar(15) not null,
    constraint `pk_offices` primary key (`officecode`),
    constraint `uq_offices_phone` unique (`phone`)
);

--products table
create table `products` (
    `productcode` int(11) unsigned not null auto_increment,
    `productname` varchar(50) not null,
    `productline` int(11) unsigned not null,
    `productscale` varchar(25),
    `productvendor` varchar(30) not null,
    `productdescription` varchar(100),
    `quantityinstock` int(11) unsigned not null,
    `buyprice` decimal(11, 2) unsigned not null,
    `msrp` decimal(11, 2) unsigned not null,
    constraint `pk_products` primary key (`productcode`),
    constraint `uq_products_productname` unique (`productname`),
    constraint `fk_productlines_products` foreign key (`productline`) references `productlines` (`productline`)
);


--productlines table
create table `productlines` (
    `productline` int(11) unsigned not null auto_increment,
    `textdescription` varchar(255),
    `htmldescription` varchar(255),
    `image` varchar(255),
    constraint `pk_productlines` primary key (`productline`)
);

--orderdetails table
create table `orderdetails` (
    `ordernumber` int(11) unsigned not null auto_increment,
    `productcode` int(11) unsigned not null,
    `quantityordered` int(11) unsigned not null,
    `priceeach` decimal(11, 2) not null,
    `orderlinenumber` int(11),
    constraint `pk_orderdetails` primary key (`ordernumber`, `productcode`),
    constraint `fk_orderdetails_productcode` foreign key (`productcode`) references `products` (`productcode`)
);


--orders table
create table `orders` (
    `ordernumber` int(11) unsigned not null,
    `orderdate` datetime not null,
    `requireddate` datetime,
    `shippeddate` datetime not null,
    `status` varchar(255) not null,
    `comments` varchar(255),
    `customernumber` int(11) unsigned not null,
    constraint `pk_orders` primary key (`ordernumber`),
    constraint `fk_orderdetails_orders` foreign key (`ordernumber`) references `orderdetails` (`ordernumber`),
    constraint `fk_customers_orders` foreign key (`customernumber`) references `customers` (`customernumber`)
);

--customers table
create table `customers` (
    `customernumber` int(11) unsigned not null auto_increment,
    `customername` varchar(50) not null,
    `contactlastname` varchar(25),
    `contactfirstname` varchar(25),
    `phone` varchar(10) not null,
    `addressline1` varchar(100) not null,
    `addressline2` varchar(100),
    `city` varchar(15) not null,
    `state` varchar(15) not null,
    `postalcode` varchar(6) not null,
    `country` varchar(15) not null,
    `salesrepemployeenumber` int(11) unsigned,
    `creditlimit` decimal(11, 2) unsigned,
    constraint `pk_customers` primary key (`customernumber`),
    constraint `uq_customers_phone` unique (`phone`),
    constraint `fk_employees_customers` foreign key (`salesrepemployeenumber`) references `employees` (`employeenumber`)
);

--payments table
create table `payments` (
    `customernumber` int(11) unsigned not null,
    `checknumber` int(11) unsigned,
    `paymentdate` datetime not null,
    `amount` decimal(11, 2) not null,
    constraint `pk_payments` primary key (`customernumber`, `checknumber`),
    constraint `uq_payments_checknumber` unique (`checknumber`),
    constraint `fk_customers_payments` foreign key (`customernumber`) references `customers` (`customernumber`)
);