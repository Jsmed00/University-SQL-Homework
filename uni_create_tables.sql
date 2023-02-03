--Create a schema named university in the csci_3700 database that you created in class. 
CREATE SCHEMA IF NOT EXISTS university;

--Set schema search path to university
SET search_path TO university;


--Show search path to ensure that it is set to university
SHOW search_path;



/*
Write the create table statements for each of the entities in the E-R diagram. 

Recall in class that we discussed when FK constraints can be included in the create table statements and when they needed to be
added later via alter table statements. 

For this assignment, include the FK in the create table statement. This means that the tables will have to be created in the correct order, meaning you cannot create a table that has a foreign key
that references another table that does not yet exist. 

Use the E-R diagram, relational schema, and csv files to guide you on how to create the tables, such as for the attributes, data types, PK, FK, and the order to create the tables. 

*/


--Create the table for department
CREATE TABLE department(
	dept_id         INT    PRIMARY KEY,
	dept_name       VARCHAR,
	dept_location   VARCHAR,
	dept_budget     NUMERIC
);




/*
Load department data into department table. 

Make sure that you copied the data files to the correct directory for your system. You may need to run the command again in the terminal to grant postgres access to the files. 

Recall in class that we discussed when you need to specify the column names and when you do not. You may need to preview the csv file to know if you need
to include column names in the copy statement. If in doubt, include them. 

*/

COPY department(dept_id, dept_name, dept_location, dept_budget)
FROM 'C:\Users\Public\uni_clean\uni_dept.csv'
DELIMITER ','
CSV HEADER;


--View the department table to check that data was loaded in correctly. 
SELECT *
FROM department;



--Create the instructor table
CREATE TABLE instructor(
	instructor_id   INT        PRIMARY KEY,
	dept_id         INT,
	first_name      VARCHAR,
	last_name       VARCHAR,
	salary          NUMERIC,
	FOREIGN KEY (dept_id) REFERENCES department
);



--Load in the data for instructor
COPY instructor(instructor_id, dept_id, first_name, last_name, salary)
FROM 'C:\Users\Public\uni_clean\uni_instructor.csv'
DELIMITER ','
CSV HEADER;





--View the instructor table
SELECT *
FROM instructor;



--Create the course table
CREATE TABLE course(
	course_id    VARCHAR        PRIMARY KEY,
	dept_id      INT,
	credits      INT,
	FOREIGN KEY (dept_id) REFERENCES department
);




--Load in the data for course
COPY course(course_id, dept_id, credits)
FROM 'C:\Users\Public\uni_clean\uni_courses.csv'
DELIMITER ','
CSV HEADER;



--View the course table
SELECT *
FROM course;


--Create the prereq table
CREATE TABLE prereq(
	course_id    VARCHAR,
	prereq_id    VARCHAR,
	PRIMARY KEY(course_id, prereq_id),
	FOREIGN KEY(course_id) REFERENCES course(course_id),
	FOREIGN KEY(prereq_id) REFERENCES course(course_id)
);



--Load table into prereq
COPY prereq(course_id, prereq_id)
FROM 'C:\Users\Public\uni_clean\uni_prereq.csv'
DELIMITER ','
CSV HEADER;



--View the prereq table
SELECT *
FROM prereq;



--Create the class table
CREATE TABLE class(
	course_id       VARCHAR,
	sec_id          VARCHAR,
	year            INT,
	semester        VARCHAR,
	instructor_id   INT,
	building        VARCHAR,
	room_number     INT,
	time_slot_id    TIME,
	PRIMARY KEY(course_id, sec_id, year, semester),
	FOREIGN KEY(course_id) REFERENCES course,
	FOREIGN KEY(instructor_id) REFERENCES instructor
);



--Load in class data
COPY class(course_id, sec_id, year, semester, instructor_id, building, room_number, time_slot_id)
FROM 'C:\Users\Public\uni_clean\uni_class.csv'
DELIMITER ','
CSV HEADER;



--View the class table
SELECT *
FROM class;




--Submit this completed sql file on Canvas.
