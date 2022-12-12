CIS 3530 Database Systems and Concepts A3
Olivia Biancucci
1136788

OVERVIEW:
I was tasked to use PostgreSQL to create a database for a small credit card company. It contains
three tables: customers, vendors, and transactions.

INSTALLATION/HOW TO USE:
After downloading all of the files, create a PostgreSQL database. Then, open the file "a3data.sql"
and copy and run each section into the terminal individually (this will create the tables and
insert the starting values).

To create an SQL function, enter the command: \i p1.sql at the psql prompt (replacing "p1.sql"
with the respective filename). If the system returns "CREATE FUNCTION" it has successfully
created the function. To execute it, enter the command: select p1(); (replacing p1 with the
respective filename). 
