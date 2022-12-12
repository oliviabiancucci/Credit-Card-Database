CREATE DATABASE A3;

CREATE TABLE IF NOT EXISTS vendor(
	Vno varchar(4) unique not null,
	Vname varchar(25) not null,
	City varchar(25) not null,
	Vbalance numeric not null,
	PRIMARY KEY (Vno)
);

CREATE TABLE IF NOT EXISTS customer(
	Account varchar(4) unique not null,
	Cname varchar(25) not null,
	Province varchar(10) not null,
	Cbalance numeric not null,
	Crlimit numeric not null,
	PRIMARY KEY (Account)
);

CREATE TABLE IF NOT EXISTS transaction(
	Tno varchar(4) unique not null,
	Vno varchar(4) not null,
	Account varchar(4) not null,
	T_date date not null,
	Amount numeric not null,
	PRIMARY KEY (Tno),
	FOREIGN KEY (Vno) REFERENCES vendor(Vno),
	FOREIGN KEY (Account) REFERENCES customer(Account)
);

INSERT INTO vendor VALUES 
('V1', 'IKEA', 'Toronto', 200.00),
('V2', 'Walmart', 'Waterloo', 671.05),
('V3', 'Esso', 'Windsor', 0.00),
('V4', 'Esso', 'Waterloo', 225.00);

INSERT INTO customer VALUES 
('A1', 'Smith', 'ONT', 2515.00, 2000),
('A2', 'Jones', 'BC', 2014.00, 2500),
('A3', 'Doc', 'ONT', 150.00, 1000); 

INSERT INTO transaction VALUES 
('T1', 'V2', 'A1', '2022-07-15', 1325.00),
('T2', 'V2', 'A3', '2021-12-16', 1900.00),
('T3', 'V3', 'A1', '2022-09-01', 2500.00),
('T4', 'V4', 'A2', '2022-03-20', 1613.00),
('T5', 'V4', 'A3', '2022-07-31', 2212.00);
