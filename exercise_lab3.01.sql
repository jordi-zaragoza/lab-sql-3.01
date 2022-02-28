-- Activity 1
USE sakila;
-- 1. Drop column picture from staff.
ALTER TABLE sakila.staff DROP picture;
SELECT * FROM staff; -- Done

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO sakila.staff(first_name,last_name,store_id,address_id,username)
VALUES
('Tammy','Sanders',2,4,'Tammy'); -- Done

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., 
-- you would notice that you need customer_id information as well. To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.
select film_id from sakila.film
where title = 'Academy Dinosaur';
select staff_id from sakila.staff
where store_id = 1;

select * from sakila.rental;

INSERT INTO sakila.rental(rental_date,inventory_id,customer_id,staff_id)
VALUES
(now(),1,130,1); 

select * from sakila.rental
ORDER BY rental_id DESC; -- done

-- Activity 2
-- 1. Use dbdiagram.io or draw.io to propose a new structure for the Sakila database.
--  Define primary keys and foreign keys for the new database.

CREATE DATABASE IF NOT EXISTS sakila_jordi;
USE sakila_jordi;

CREATE Table FILM(
  FILM_ID SERIAL PRIMARY KEY, 
  LENGTH int,
  RELEASE_YEAR int,
  REPLACEMENT_COST int ,
  LAST_UPDATE timestamp
);

CREATE Table ACTOR (
  ACTOR_ID SERIAL PRIMARY KEY,
  NAME_ varchar(20),
  LAST_UPDATE timestamp
 );
 
CREATE Table FILM_ACTOR(
  ACTOR_ID int,
  FILM_ID int,
  LAST_UPDATE timestamp,
  FOREIGN KEY (ACTOR_ID) REFERENCES ACTOR(ACTOR_ID),
  CONSTRAINT FOREIGN KEY (FILM_ID) REFERENCES FILM(FILM_ID)
 );
 
 DROP Table FILM_ACTOR;
 
CREATE Table INVENTORY(
  INVENTORY_ID  int,
  FILM_ID int,
  STORE_ID int,
  LAST_UPDATE timestamp,
  CONSTRAINT FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID),
  CONSTRAINT FOREIGN KEY (FILM_ID) REFERENCES FILM(FILM_ID)
 );
 
CREATE Table STORE(
  STORE_ID  SERIAL PRIMARY KEY,
  MANAGER_STAFF_ID int,
  LAST_UPDATE timestamp,
  CONSTRAINT FOREIGN KEY (MANAGER_STAFF_ID) REFERENCES STAFF(STAFF_ID)
);
 
CREATE Table STAFF(
  STAFF_ID SERIAL PRIMARY KEY,
  NAME_ varchar(20),
  USERNAME  varchar(20),
  PASSWORD_ID int,
  CONSTRAINT FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID),
  CONSTRAINT FOREIGN KEY (PASSWORD_ID) REFERENCES PASSWORDS(PASSWORD_ID)
);

CREATE Table PASSWORDS(
  PASSWORD_ID SERIAL PRIMARY KEY,
  PASSWORDD varchar(20)
);
 
CREATE Table PAYMENT(
  PAYMENT_ID SERIAL PRIMARY KEY,
  CUSTOMER_ID int,
  STAFF_ID int,
  CONSTRAINT FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
  CONSTRAINT FOREIGN KEY (STAFF_ID) REFERENCES STAFF(STAFF_ID)
 );

CREATE Table CUSTOMER(
  CUSTOMER_ID SERIAL PRIMARY KEY,
  STORE_ID int,
  NAME varchar(20),
  ACTIVE boolean,
  CREATE_DATE datetime,
  LAST_UPDATE datetime,
  USERNAME  varchar(29),
  PASSWORD_ID int,
  CONSTRAINT FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID),
  CONSTRAINT FOREIGN KEY (PASSWORD_ID) REFERENCES PASSWORDS(PASSWORD_ID)
  );

CREATE Table FILMTXT (
  FILM_ID int,
  TITLE varchar(29),
  DESCRIPTION text,
  LANGUAGE varchar(20),
  ORIGINAL_LANGUAGE varchar(20),
  CATEGORY varchar(20),
  SPECIAL_FEATURES varchar(20),
  CONSTRAINT FOREIGN KEY (FILM_ID) REFERENCES FILM(FILM_ID)
)
  