create database project;

use project;


-- 1

create table salespeople(
snum int primary key,
sname varchar(100) not null,
city varchar(100) not null,
comm decimal(3,2) check(comm>0)
);

select * from salespeople;

desc salespeople;

insert into salespeople(snum,sname,city,comm) values(1001,"Peel","London",0.12),
													(1002,"Serres","San Jose",0.13),
                                                    (1003,"Axelrod","New York",0.10),
                                                    (1004,"Motika","London",0.11),
                                                    (1007,"Rafkin","Barcelona",0.15);

-- 2

create table cust(
cnum int Primary key,
cname varchar(100) not null,
city varchar(100) not null,
rating int check(rating>0),
snum int,
foreign key(snum) references salespeople(snum)
);

select * from cust;

desc cust;

insert into cust(cnum,cname,city,rating,snum) values(2001,"Hoffman","London",100,1001);

insert into cust(cnum,cname,city,rating,snum) values(2002,"Giovanne","Rome",200,1003),
											  (2003,"Liu","San Jose",300,1002),
                                              (2004,"Grass","Berlin",100,1002),
                                              (2006,"Clemens","London",300,1007),
                                              (2007,"Pereira","Rome",100,1004),
                                              (2008,"James","London",200,1007);
                                              
-- 3

create table orders(
onum int primary key,
amt float check(amt>0),
odate date,
cnum int,
foreign key(cnum) references cust(cnum),
snum int,
foreign key(snum) references salespeople(snum)
);

select * from orders;

desc orders;

insert into orders(onum,amt,odate,cnum,snum) values(3001,18.69,"1994-10-03",2008,1007),
												   (3002,1900.10,"1994-10-03",2007,1004),
                                                   (3003,767.19,"1994-10-03",2001,1001),
                                                   (3005,5160.45,"1994-10-03",2003,1002),
                                                   (3006,1098.16,"1994-10-04",2008,1007),
                                                   (3007,755.75,"1994-10-05",2004,1002),
                                                   (3008,4723.23,"1994-10-05",2006,1001),
                                                   (3009,1713.23,"1994-10-04",2002,1003),
                                                   (3010,1309.95,"1994-10-06",2004,1002),
                                                   (3011,9891.88,"1994-10-06",2006,1001);

-- 4  Write a query to match the salespeople to the customers according to the city they are living.

select * from salespeople;

select * from cust;
                                                   
select a.snum,a.sname,a.city,a.comm,b.cnum,b.cname,b.rating from salespeople as a
inner join
cust as b
on a.city = b.city;

-- 5  Write a query to select the names of customers and the salespersons who are providing service to them.

select * from salespeople;

select * from cust;

select a.cname,b.sname from cust as a
inner join
salespeople as b
on a.snum = b.snum;

-- 6  Write a query to find out all orders by customers not located in the same cities as that of their salespeople.

select * from cust;

select * from salespeople;

select * from orders;

select c.cnum,c.cname,c.city,c.rating,c.snum,s.sname,s.city,o.onum,o.odate from orders as o
inner join
cust as c
on c.cnum = o.cnum
inner join
salespeople as s
on c.snum = s.snum
where c.city != s.city;


-- 7  Write a query that lists each order number followed by name of customer who made that order

select * from orders; -- cnum

select * from cust;

select o.onum,c.cname from orders as o
inner join
cust as c
on c.cnum = o.cnum;


-- 8  Write a query that finds all pairs of customers having the same rating………………

select * from cust;

select a.cname,b.cname,b.rating from cust as a
join
cust as b
on a.rating = b.rating
where a.cnum != b.cnum;

-- 9 Write a query to find out all pairs of customers served by a single salesperson………………..

select * from cust;

select * from salespeople; 

select a.cname,b.cname,s.sname from cust as a
join
cust as b
on a.snum = b.snum and a.cnum < b.cnum
join
salespeople as s
on s.snum = a.snum;

-- 10  Write a query that produces all pairs of salespeople who are living in same city………………..

select * from salespeople;

select a.sname,b.sname from salespeople as a
join
salespeople as b
on a.city = b.city
where a.snum > b.snum;

-- 11 Write a Query to find all orders credited to the same salesperson who services Customer 2008

select * from orders;

select * from salespeople;

select * from cust;

select * from orders as o
inner join
salespeople as s
on o.snum = s.snum
inner join
cust as c
on c.snum = o.snum
where c.cnum = 2008;

-- 12 Write a Query to find out all orders that are greater than the average for Oct 4th

select * from orders;

select * from orders
where amt > (select avg(amt) from orders where month(odate)=10 and day(odate)=4) and odate = "1994-10-4";

-- 13 Write a Query to find all orders attributed to salespeople in London

select * from orders;

select * from salespeople;

select * from orders as o
inner join
salespeople as s
on o.snum = s.snum
where s.city = "London";

-- 14 Write a query to find all the customers whose cnum is 1000 above the snum of Serres. 

select * from cust;

select * from salespeople;

select * from cust
where cnum > ( select snum from salespeople where sname = "Serres");

-- 15 Write a query to count customers with ratings above San Jose’s average rating.

select * from cust;

select Count(cnum) from cust
where rating > (select avg(rating) from cust 
where city = "San Jose");

-- 16 Write a query to show each salesperson with multiple customers.

select * from salespeople;

select * from cust;

select s.snum,s.sname,count(c.cnum) from salespeople as s
inner join
cust as c
on s.snum = c.snum
group by s.snum,s.sname;





