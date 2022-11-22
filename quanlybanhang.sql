drop database quanlybanhang;
create database quanlybanhang;

create table product(
productid int auto_increment primary key not null,
product_code int unique,
product_name varchar(50),
procuct_price varchar(20),
procuct_date_create datetime,
product_amount int
);

create table customers(
customerid int auto_increment primary key not null,
customer_name varchar(50) not null,
customer_age int check(customer_age between 0 and 120),
customer_address varchar(50) not null
);

create table orders(
orderid int auto_increment primary key not null,
order_date_create datetime,
customerid int,
foreign key(customerid) references customers(customerid)
);

create table orderdetail(
orderid int, 
productid int,
foreign key (orderid) references orders(orderid),
foreign key (productid) references product(productid),
primary key( orderid, productid),
quantity int not null
);


insert into product
values(1,1,'Iphone x', '15000000', '2022-10-10',10),
(2,2,'Iphone xs', '18000000', '2022-5-10',10),
(3,3,'Iphone 11', '22000000', '2022-5-10',10),
(4,4,'Iphone 11promax', '25000000', '2022-6-10',10),
(5,5,'Iphone 12pro', '30000000', '2022-11-10',10);


insert into customers
values(1,"A Hoang", 20, "Ha Noi"),
(2,"A Hung", 24, "Bac Ninh"),
(3,'A Minh', 18 , 'Ha Noi'),
(4,"A Tuan", 25, "HCM"),
(5,"A Truong", 21, "Ha Noi"),
(6,"C Ngoc", 17, "Ha Nam"),
(7,"C Quynh", 19, "Hung Yen"),
(8,"A Khanh", 20, "Vinh Phuc");

insert into orders
values(1,'2022-11-1',1),
(2,'2022-11-1',1),
(3,'2022-11-1',2),
(4,'2022-11-1',3),
(5,'2022-11-2',4),
(6,'2022-11-2',5),
(7,'2022-11-3',6),
(8,'2022-11-4',7),
(9,'2022-11-5',8),
(10,'2022-11-6',1),
(11,'2022-11-7',7);

insert into orderdetail
values(1,2,1),
(1,3,1),
(1,4,1),
(1,5,1),
(1,1,1),
(2,4,1),
(7,3,1),
(2,2,1),
(6,2,1),
(2,3,1),
(3,1,1),
(4,3,1),
(5,4,1),
(6,5,1),
(7,2,1),
(8,1,1);


-- hien thi san pham co so luong cao nhat
select * from product
where product_amount = (select max(product_amount) from product);

-- hien thi cac san pham theo gia giam dan
select * from product
order by procuct_price desc;

-- hien thi cac san pham co date create truoc ngay 10-6-2022
select * from product
where procuct_date_create <= cast('2022-6-10' as date);

-- hien thi tong tien cua tat ca order va ma order

-- hien thi san pham dc mua nhieu nhat
select * from product
join orderdetail on product.productid = orderdetail.productid
group by product.productid, product.product_name,
where orderdetail.quantity > (select max(sum(orderdetail) from orderdetail) from orderdetail);

-- hien thi tong tien cua tat ca order va ma order tuong ung
select *, sum(




