create database if not exists furama_web_demo;
use furama_web_demo;

drop table if exists contract_detail;
drop table if exists contract;
drop table if exists customer;
drop table if exists customer_type;
drop table if exists employee;
drop table if exists education_degree;
drop table if exists positions;
drop table if exists user_role;
drop table if exists user;
drop table if exists role;
drop table if exists facility;
drop table if exists facility_type;
drop table if exists rent_type;
drop table if exists attach_facility;
drop table if exists division;

start transaction;

create table facility_type
(
facility_type_id integer primary key auto_increment,
facility_type_name varchar(45),
is_delete bit(1)
);

create table rent_type
(
rent_type_id integer primary key auto_increment,
rent_type_name varchar(45),
is_delete bit(1)
);

create table facility
(
facilityId integer primary key auto_increment,
facility_name varchar(50),
area int,
cost double,
max_people int,
rent_type_id integer,
foreign key (rent_type_id) references rent_type (rent_type_id),
facility_type_id integer,
foreign key (facility_type_id) references facility_type (facility_type_id),
standard_room varchar(45),
description_other_convenience varchar(255),
pool_area double,
number_of_floors int,
facility_free text,
is_delete bit(1)
);

create table customer_type
(
customer_type_id integer primary key auto_increment,
customer_type_name varchar(50),
is_delete bit(1)
);

create table attach_facility
(
attach_facility_id integer primary key auto_increment,
attach_facility_name varchar(45),
cost double,
unit varchar(10),
status varchar(45),
is_delete bit(1)
);

create table customer
(
customerId integer primary key auto_increment,
customer_type_id integer,
foreign key (customer_type_id) references customer_type (customer_type_id),
customer_name varchar(50),
gender bit(1),
date_of_birth datetime,
id_card varchar(12),
phone_number varchar(12),
email varchar(45),
address varchar(50),
is_delete bit(1)
);

create table user 
(
username varchar(255) primary key not null,
password varchar(255),
is_delete bit(1)
);

create table role
(
role_id integer primary key auto_increment,
rolename varchar(255),
is_delete bit(1)
);

create table user_role
(
role_id integer,
foreign key (role_id) references role (role_id),
username varchar(255),
foreign key (username) references user (username),
is_delete bit(1)
);

create table positions
(
positionId integer primary key auto_increment,
position_name varchar (45),
is_delete bit(1)
);

create table education_degree
(
education_degree_id integer primary key auto_increment,
education_degree_name varchar (45),
is_delete bit(1)
); 

create table division 
(
divisionId integer primary key auto_increment,
division_name varchar (45),
is_delete bit(1)
);

create table employee 
(
employeeId integer primary key auto_increment,
employee_name varchar(50),
date_of_birth datetime,
id_card varchar(12),
salary double,
phone_number varchar(12),
email varchar(45),
address varchar(50),
positionId integer,
foreign key (positionId) references positions (positionId),
education_degree_id integer,
foreign key (education_degree_id) references education_degree (education_degree_id),
divisionId integer,
foreign key (divisionId) references division (divisionId),
username varchar(255),
foreign key (username) references user (username),
is_delete bit(1)
);

create table contract 
(
contractID integer primary key auto_increment,
start_date datetime,
end_date datetime,
deposit double,
employeeId integer,
foreign key (employeeId) references employee(employeeId),
customerId integer,
foreign key (customerId) references customer(customerId),
facilityId integer,
foreign key (facilityId) references facility(facilityId),
is_delete bit(1)
);

create table contract_detail
(
quantityId integer primary key auto_increment,
contractId integer,
foreign key (contractId) references contract(contractId),
attach_facility_id integer,
foreign key (attach_facility_id) references attach_facility (attach_facility_id),
is_delete bit(1)
);

INSERT INTO facility_type (facility_type_name, is_delete) VALUES
('Villa', 0),
('House', 0),
('Room', 0);

INSERT INTO rent_type (rent_type_name, is_delete) VALUES
('Year', 0),
('Month', 0),
('Day', 0),
('Hour', 0);

INSERT INTO facility (facility_name, area, cost, max_people, rent_type_id, facility_type_id, standard_room, description_other_convenience, pool_area, number_of_floors, facility_free, is_delete)
VALUES
('Phòng Standard', 30, 1000000, 2, 1, 1, 'Giường đôi', 'Wi-Fi miễn phí, TV, Điều hòa không khí', NULL, 1, 'Bao gồm bữa sáng', 0),
('Phòng Deluxe', 40, 1500000, 3, 1, 1, 'Giường King', 'Wi-Fi miễn phí, TV, Điều hòa không khí, Mini Bar', NULL, 1, 'Truy cập phòng tập và xông hơi', 0),
('Biệt thự riêng', 200, 5000000, 6, 2, 2, 'Nhiều phòng ngủ', 'Wi-Fi miễn phí, TV, Điều hòa không khí, Hồ bơi riêng', 50, 2, 'Dọn dẹp hàng ngày bao gồm', 0);


INSERT INTO customer_type (customer_type_name, is_delete) VALUES
('Diamon', 0),
('Platium', 0),
('Gold', 0),
('Silver', 0),
('Member', 0);


INSERT INTO attach_facility (attach_facility_name, cost, unit, status, is_delete)
VALUES
('Breakfast', 50000, 'person', 'Available', 0),
('WiFi', 20000, 'room', 'Available', 0),
('Mini Bar', 100000, 'room', 'Available', 0),
('Gym Access', 100000, 'person', 'Available', 0),
('Airport Transfer', 200000, 'booking', 'Available', 0);

INSERT INTO customer (customer_type_id, customer_name, gender, date_of_birth, id_card, phone_number, email, address, is_delete)
VALUES
(1, 'Nguyễn Văn A', 1, '1990-05-15', '123456789', '0987654321', 'nguyenvana@example.com', '123 Đường ABC, Quận XYZ, Thành phố HCM', 0),
(2, 'Công ty ABC', 0, NULL, '789012345', '0987123456', 'contact@companyabc.com', '456 Đường XYZ, Quận ABC, Thành phố HCM', 0),
(1, 'Trần Thị B', 0, '1985-10-20', '987654321', '0901234567', 'tranthib@example.com', '789 Đường XYZ, Quận ABC, Thành phố HCM', 0),
(3, 'Lê Văn C', 1, '1978-03-25', '456789012', '0912345678', 'levanc@example.com', '321 Đường XYZ, Quận ABC, Thành phố HCM', 0),
(1, 'Phạm Thị D', 0, '1995-12-12', '654321098', '0976543210', 'phamthid@example.com', '987 Đường XYZ, Quận ABC, Thành phố HCM', 0);


insert into customer (customer_type_id, customer_name, gender, date_of_birth, id_card, phone_number, email, address, is_delete) 
values 
(4, 'Nguyễn Thị E', 0, '1993-08-08', '012345678', '0909876543', 'nguyenthie@example.com', '456 Đường ABC, Quận XYZ, Thành phố HCM', 0),
(3, 'Trần Văn F', 1, '1987-06-20', '123456789', '0987654321', 'tranvanf@example.com', '789 Đường XYZ, Quận ABC, Thành phố HCM', 0),
(2, 'Phạm Văn G', 1, '1982-11-15', '987654321', '0912345678', 'phamvang@example.com', '123 Đường XYZ, Quận ABC, Thành phố HCM', 0),
(1, 'Lê Thị H', 0, '1975-04-25', '654321098', '0976543210', 'lethih@example.com', '987 Đường XYZ, Quận ABC, Thành phố HCM', 0),
(5, 'Hoàng Văn I', 1, '1998-02-10', '456789012', '0987654321', 'hoangvani@example.com', '321 Đường XYZ, Quận ABC, Thành phố HCM', 0);

INSERT INTO user (username, password, is_delete)
VALUES
('john_doe', 'password123', 0),
('jane_smith', 'p@ssw0rd', 0),
('admin', 'admin123', 0),
('alice_wonderland', 'w0nd3rl@nd', 0);

INSERT INTO role (rolename, is_delete)
VALUES
('Administrator', 0),
('Manager', 0),
('Staff', 0),
('Customer Service', 0);

INSERT INTO user_role (role_id, username, is_delete)
VALUES
(1, 'admin', 0),
(2, 'john_doe', 0),
(3, 'jane_smith', 0),
(4, 'john_doe', 0);

INSERT INTO positions (position_name, is_delete)
VALUES
('CEO', 0),
('Manager', 0),
('Sales Representative', 0),
('Customer Service Representative', 0),
('Accountant', 0);

INSERT INTO education_degree (education_degree_name, is_delete)
VALUES
('Cao đẳng', 0),
('Đại học', 0),
('Thạc sĩ', 0),
('Tiến sĩ', 0);

INSERT INTO division (division_name, is_delete)
VALUES
('Phòng Kế toán', 0),
('Phòng Nhân sự', 0),
('Phòng Kinh doanh', 0),
('Phòng Marketing', 0),
('Phòng Kỹ thuật', 0);

INSERT INTO employee (employee_name, date_of_birth, id_card, salary, phone_number, email, address, positionId, education_degree_id, divisionId, username, is_delete)
VALUES
('Nguyễn Văn An', '1980-05-15', '123456789', 15000000, '0987654321', 'nguyenvanan@example.com', '123 Đường ABC, Quận XYZ, Thành phố HCM', 1, 3, 1, 'admin', 0),
('Trần Thị Bình', '1990-07-20', '987654321', 12000000, '0901234567', 'tranbinh@example.com', '456 Đường XYZ, Quận ABC, Thành phố HCM', 2, 2, 2, 'alice_wonderland', 0),
('Lê Quang Cường', '1985-03-10', '456789012', 18000000, '0912345678', 'lecuong@example.com', '789 Đường XYZ, Quận ABC, Thành phố HCM', 3, 4, 3, 'jane_smith', 0),
('Phạm Thị Dung', '1992-12-01', '654321098', 10000000, '0976543210', 'phamdung@example.com', '987 Đường XYZ, Quận ABC, Thành phố HCM', 4, 1, 4, 'john_doe', 0);



INSERT INTO contract (start_date, end_date, deposit, employeeId, customerId, facilityId, is_delete)
VALUES
('2024-04-01', '2024-04-30', 20000000, 1, 1, 1, 0),
('2024-04-05', '2024-05-05', 15000000, 2, 2, 2, 0),
('2024-04-10', '2024-04-20', 18000000, 3, 3, 3, 0),
('2024-04-15', '2024-05-15', 22000000, 4, 4, 1, 0);


INSERT INTO contract_detail (contractId, attach_facility_id, is_delete)
VALUES
(1, 1, 0), -- Hợp đồng số 1 gắn thêm dịch vụ Bữa sáng
(2, 2, 0), -- Hợp đồng số 1 gắn thêm dịch vụ Truy cập WiFi
(3, 3, 0), -- Hợp đồng số 2 gắn thêm dịch vụ Mini Bar
(4, 4, 0); -- Hợp đồng số 3 gắn thêm dịch vụ Truy cập phòng tập






















