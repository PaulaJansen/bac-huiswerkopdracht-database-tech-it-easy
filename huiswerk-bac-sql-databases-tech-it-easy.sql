drop table if exists users;
drop table if exists televisions cascade;
drop table if exists remote_controllers;
drop table if exists cimodules;
drop table if exists televisions_wall_brackets;
drop table if exists wall_brackets;

create table users
(
username varchar(255) primary key,
password varchar(255) not null,
address varchar(255),
role varchar(127) not null,
payment_scale int not null,
vacation_days int not null
);

create table remote_controllers
(
remote_id bigint generated always as identity primary key,
name varchar(255) not null unique,
brand varchar(127) not null,
price real not null,
current_stock int not null,
sold int not null,
smart_remote boolean,
battery_type varchar(127)
);

create table cimodules 
(
ci_id bigint generated always as identity primary key,
name varchar(255) not null unique,
brand varchar(127)not null,
price real not null,
current_stock int not null,
sold int not null,
provider varchar(127),
encoding varchar(127)
);

create table wall_brackets
(
bracket_id bigint generated always as identity primary key,
name varchar(255) not null unique,
brand varchar(127) not null,
price real not null,
current_stock int not null,
sold int not null,
adjustable boolean,
mount varchar(127),
height real,
width real
);

create table televisions
(
television_id bigint generated always as identity primary key,
name varchar(255) not null unique,
brand varchar(127) not null,
price real not null,
current_stock int not null,
sold int not null,
height real,
width real,
diagonal int generated always as ((sqrt((height * height) + (width * width))) / 2.54) stored, 
screen_quality varchar(127),
screen_type varchar(127),
wifi boolean,
smart_tv boolean,
voice_control boolean,
hdr boolean,
remote_id int,
foreign key (remote_id) references remote_controllers (remote_id),
ci_id int,
foreign key (ci_id) references cimodules (ci_id)
);

create table televisions_wall_brackets
(
television_id bigint,
bracket_id bigint,
foreign key (television_id) references televisions (television_id),
foreign key (bracket_id) references wall_brackets (bracket_id)
);

insert into users (username, password, address, role, payment_scale, vacation_days) values
('HenkDeVries', 'wachtwoord123', 'Dorpsstraat 1', 'employee', 9, 20),
('MarjaJansen', 'wachtwoord456', 'Kerklaan 451', 'employee', 10, 14),
('MarietjeBaas', 'password', 'Boslaan 13', 'manager', 12, 25);

insert into televisions (name, brand, price, current_stock, sold, height, width, screen_quality, screen_type, wifi, smart_tv, voice_control, hdr) values
('Panasonic smart 65', 'Panasonic', 899, 5, 1, 81, 145, '4k', 'oled', 'true', 'true', 'false', 'true'),
('Philips ambilight', 'Philips', 350, 11, 13, 71, 123, 'full hd', 'lcd', 'false', 'false', 'false', 'true'),
('Samsung Ultra Oled', 'Samsung', 1899.99, 5, 4, 125, 221, '8k', 'amoled', 'true', 'true', 'true', 'true');

insert into remote_controllers (name, brand, price, current_stock, sold, smart_remote, battery_type) values
('Universal remote', 'OK', 10.95, 34, 22,'false', 'AAA'),
('KPN basic', 'KPN', 15.95, 41, 22, 'true', 'AAA'),
('The Ultimate', 'Samsung', 44.95, 4, 11, 'true', 'CR25');

insert into cimodules (name, brand, price, current_stock, sold, provider, encoding) values
('Basic CI', 'Ziggo', 29.99, 18, 57, 'Ziggo', 'UTF-16'),
('CI what', 'KPN', 29.99, 20, 60, 'KPN', 'UTF-16'),
('Another CI', 'Odido', 27.99, 11, 44, 'Odido', 'UTF-8');

insert into wall_brackets (name, brand, price, current_stock, sold, adjustable, mount, height, width) values
('Super mount', 'Samsung', 54.99, 30, 12, 'true', 'screws', 20, 40),
('Basic bracket', 'OK', 21.99, 12, 55, 'false', 'adhesive', 30, 40),
('Bracket McBracket', 'Coolblue', 35, 22, 22, 'true', 'screws', 18, 44);

insert into televisions_wall_brackets (television_id, bracket_id) values
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 2),
(3, 3);

update televisions set remote_id = 3 where brand = 'Samsung';
update televisions set ci_id = 1 where television_id = 1;
update televisions set remote_id = 1 where brand not in ('Samsung', 'Panasonic');

select * from users;
select * from televisions;
select * from remote_controllers;
select * from cimodules;
select * from wall_brackets;
select * from televisions_wall_brackets;

select * from users where role = 'manager';

select concat('Buy ', televisions.name, ' of the brand ', televisions.brand, ' together with ', remote_controllers.name, '.')
from televisions
join remote_controllers on televisions.remote_id = remote_controllers.remote_id;








