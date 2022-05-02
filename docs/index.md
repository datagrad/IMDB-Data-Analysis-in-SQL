# IMDB-Analysis-in-SQL

## 1. Overview
This analysis is carried out to support RSVP Movies with a well-analyzed list of global stars to plan a movie for the global audience in 2022.

With this, we will be able to answer a set of analytical questions to suggest RSVP Production House on which set of actors, directors, and production houses would be the best fit for a super hit commercial movie.

![IMDB Data Analysis in MySQL](https://user-images.githubusercontent.com/73750698/166145297-0e4eaa5f-1eaa-45c1-873a-2834a5ff8747.png)

***
***

### About RSVP
RSVP Movies is an Indian film production company that has produced many super-hit movies. They have usually released movies for the Indian audience but for their next project, they are planning to release a movie for the global audience in 2022.

### Why this Analysis?
The production company wants to plan its every move analytically based on data and has approached for help with this new project.

We have been provided with the data of the movies that have been released in the past three years.
Let's analyze the data set and draw meaningful insights that can help them start their new project. 

 
### Tool Stack
We will use SQL to analyze the given data and give recommendations to RSVP Movies based on the insights.

We will be carrying out the entire analytics process into four segments, where each segment leads to significant insights from different combinations of tables.

***
***

## 1. Database Creation for the Project


### a. Check the List of Database

* The very first step of any MySQL analysis is to access the database and check if related data is available or not.
* Use `show databases;` to access the list of databases:

| Database      |
| -----------      |
| classicmodels      |
| company      |
| information_schema      |
| market_star_schema      |
| org      |


### b. Create Database
* Create a new database for this project.
* Use `Create database IMDB;`
* Use `show databases;` to confirm the list of databases:

| Database      |
| -----------      |
| classicmodels      |
| company      |
| imdb      |
| information_schema      |
| market_star_schema      |
| org      |

### c. Use Database
* Instruct the system to use `*IMDB Database*` by running `use imdb;`


***
***

## 2. Creating Table

#### Steps to follow before creating the table:

* Download the IMDb dataset. And try to understanding every table and its importance.
* Understand the ERD and the table details. Study them carefully and understand the relationships between the table.
* Inspect each table given in the subsequent tabs and understand the features associated with each of them.
* Draft your table with the correct Data Type and Constraints in a paper or note file.
* Open your MySQL Workbench and start writing the DDL and DML commands to create the database.

### Create Table

For this project we need a total of 6 tables:

| Table Number      	| Tables_in_imdb      |
| ----------- 	| -----------      |
| 1      	| director_mapping      |
| 2      	| genre      |
| 3	| movie      |
| 4	| names      |
| 5	| ratings      |
| 6	| role_mapping      |


#### a. Create Table Movie
```
CREATE TABLE movie (
  id VARCHAR(10) NOT NULL primary key,
  title VARCHAR(200) DEFAULT NULL,
  year INT DEFAULT NULL,
  date_published DATE DEFAULT null,
  duration INT,
  country VARCHAR(250),
  worlwide_gross_income VARCHAR(30),
  languages VARCHAR(200),
  production_company VARCHAR(200)
);

```

***

#### b. Create Table Genre
```
CREATE TABLE genre (
	movie_id VARCHAR(10),
        genre VARCHAR(20),
	PRIMARY KEY (movie_id, genre)
);
```

***

#### c. Create Table director_mapping
```
CREATE TABLE director_mapping (
	movie_id VARCHAR(10),
        name_id VARCHAR(10),
	PRIMARY KEY (movie_id, name_id)
);

```
***


#### d. Create Table role_mapping
```
CREATE TABLE role_mapping (
	movie_id VARCHAR(10) NOT NULL,
        name_id VARCHAR(10) NOT NULL,
        category VARCHAR(10),
	PRIMARY KEY (movie_id, name_id)
);

```

***


#### e. Create Table names
```
CREATE TABLE names (
  id varchar(10) NOT NULL,
  name varchar(100) DEFAULT NULL,
  height int DEFAULT NULL,
  date_of_birth date DEFAULT null,
  known_for_movies varchar(100),
  PRIMARY KEY (id)
);
```


***

#### f. Create Table ratings
```
CREATE TABLE ratings (
	movie_id VARCHAR(10) NOT NULL,
	avg_rating DECIMAL(3,1),
	total_votes INT,
	median_rating INT,
        PRIMARY KEY (movie_id)
);

```
***

Now, Run `show tables;` to ensure that all the six tables are created.

***
***

## 3. Data Insertion

In the previous steps, we created six tables. Now, we will insert the data into these tables.
Here, we will be showing the syntax of 5 rows insertion into each table. (The complete data insertion syntax is available in the Repository)

### a. Inserting data into Movie Table

```
INSERT INTO movie VALUES
('tt0012494','Der müde Tod',2017,'2017-06-09',97,'Germany','$ 12156','German','Decla-Bioscop AG'),
('tt0038733','A Matter of Life and Death',2017,'2017-12-08',104,'UK','$ 124241','English, French, Russian','The Archers'),
('tt0361953','The Nest of the Cuckoo Birds',2017,'2017-10-16',81,'USA',null,'English','Bert Williams Motion Pictures and Distributor'),
('tt0235166','Against All Hope',2017,'2017-10-20',90,'USA',null,'English',null),
('tt0337383','Vaikai is Amerikos viesbucio',2017,'2017-03-09',88,'Soviet Union',null,'Lithuanian, Russian','Lietuvos Kinostudija');
```
***

### b. Inserting data into Genre Table

```
INSERT INTO genre VALUES
('tt0012494','Thriller'),
('tt0012494','Fantasy'),
('tt0012494','Drama'),
('tt0038733','Fantasy'),
('tt0038733','Drama');

```
***


### c. Inserting data into Director_Mapping Table

```
INSERT INTO director_mapping VALUES
('tt0038733','nm0003836'),
('tt0038733','nm0696247'),
('tt0060908','nm0003606'),
('tt0069049','nm0000080'),
('tt0082620','nm0716460');

```
***


### d. Inserting data into Role_Mapping Table

```
INSERT INTO role_mapping VALUES
('tt0038733','nm0000057','actor'),
('tt0038733','nm0001375','actress'),
('tt0038733','nm0178509','actor'),
('tt0038733','nm0126402','actress'),
('tt0060908','nm0000869','actor');

```
***



### e. Inserting data into Names Table

```
INSERT INTO names VALUES
('nm0000002','Lauren Bacall','174','1924-09-16',null),
('nm0000110','Kenneth Branagh','177','1960-12-10','tt3402236'),
('nm0000009','Richard Burton','175','1925-11-10',null),
('nm0000114','Steve Buscemi','175','1957-12-13','tt4686844'),
('nm0000014','Olivia de Havilland','163','1916-07-01',null);

```
***


### f. Inserting data into Ratings Table

```
INSERT INTO ratings VALUES
('tt0012494',7.7,4695,8),
('tt0038733',8.1,17693,8),
('tt0060908',7.5,3392,8),
('tt0069049',6.9,5014,7),
('tt0071145',8.2,789,8);

```
***


### Checking tables for inserted Values:

`Select * from Movie;`


`Select * from Genre; `


`Select * from Director_Mapping;`


`Select * from Role_Mapping;`


`Select * from Names;`


`Select * from Ratings;`

All the sample data inserted looks good. SO, we can go ahead with insertion of complete data. 
For insertion to work smoothly, lets drop all data from tables using `TRUNCATE` : 

```
TRUNCATE Movie;
TRUNCATE  Genre;
TRUNCATE  Director_Mapping;
TRUNCATE Role_Mapping;
TRUNCATE Names;
TRUNCATE Ratings;
```

***
***

## Insert Complete data

Run the command to insert complete data:
[IMDB File 3 Insert all data](https://github.com/datagrad/IMDB-Analysis-in-SQL/blob/main/IMDB%20File%203%20Insert%20all%20data.sql)
