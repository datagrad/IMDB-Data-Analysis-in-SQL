![glow (1)](https://user-images.githubusercontent.com/73750698/166188931-4626fcad-4b1d-4abb-bbd7-dc4ad0b6cee2.png)

<a href="https://datagrad.github.io/"><img src="https://img.shields.io/badge/My%20Data%20Science%20Projects-Click%20here%20to%20Check%20my%20other%20Projects-blue">

***

**Table of Content (TOC)**

1. [Overview](#Overview)
2. [Database Creation for the Project](#Database-Creation)
3. [Table Creation](#Table-Creation)
4. [Data Insertion](#Data-Insertion)
5. [Data Analysis](#Data-Analysis)

***

# 1. Overview {#Overview}


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

# 2. Database Creation for the Project {#Database-Creation}


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

# 3. Table Creation {#Table-Creation}


#### Steps to follow before creating the table:

* Download the IMDb dataset. And try to understanding every table and its importance.
* Understand the ERD and the table details. Study them carefully and understand the relationships between the table.

							
![image](https://user-images.githubusercontent.com/73750698/166613322-f9ede9ac-15ce-4f59-98b4-4d50f3831db1.png)

	
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

	
	
| 	Table Name: Movie	| 	Column Description	| 
| 	----------- 	| 	----------- 	| 
| 	id	| 	Movie Id is a unique ID associated with each movie	| 
| 	title	| 	Title of the movie	| 
| 	year	| 	year of Release	| 
| 	date_published	| 	Date of Movie Release	| 
| 	duration	| 	Duration of Movie	| 
| 	country	| 	Country of Release	| 
| 	worlwide_gross_income	| 	worlwide_gross_income	| 
| 	languages	| 	Languages released in	| 
| 	production_company	| 	production company associated with the movie	| 

***

#### b. Create Table Genre
```
CREATE TABLE genre (
	movie_id VARCHAR(10),
        genre VARCHAR(20),
	PRIMARY KEY (movie_id, genre)
);
```

| 	Table Name: Genre	| 	Column Description	| 
| 	----------- 	| 	----------- 	| 
| 	movie_id	| 	Movie Id of the movie	| 
| 	genre	| 	Genre tagged for movie	| 


***

#### c. Create Table director_mapping
```
CREATE TABLE director_mapping (
	movie_id VARCHAR(10),
        name_id VARCHAR(10),
	PRIMARY KEY (movie_id, name_id)
);

```
| 	Table Name: director_mapping	| 	Column Description	| 
| 	----------- 	| 	----------- 	| 
| 	movie_id	| 	Movie Id of the movie directed by a director	| 
| 	name_id	| 	Name ID of the director	| 



	
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

| 	Table Name: Role_Mapping	| 	Column Description	| 
| 	----------- 	| 	----------- 	| 
| 	movie_id	| 	Movie Id of the movies	| 
| 	name_id	| 	Name ID of the associated person	| 
| 	category	| 	Associated responsibility like Actor, director on a movie	| 



	
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

| 	Table Name: Names	| 	Column Description	| 
| 	----------- 	| 	----------- 	| 
| 	id	| 	Name ID of each individual	| 
| 	name	| 	Name of each individual	| 
| 	height	| 	Height of individual	| 
| 	date_of_birth	| 	DOB	| 
| 	known_for_movies	| 	Famous or well known movie	| 
	

	
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
	
| 	Table Name: Ratings	| 	Column Description	| 
| 	----------- 	| 	----------- 	| 
| 	movie_id	| 	Movie Id of the movie	| 
| 	avg_rating	| 	Average Rating of Movie	| 
| 	total_votes	| 	Total vote counts	| 
| 	median_rating	| 	Median Rating of the movie	| 

	

***

Now, Run `show tables;` to ensure that all the six tables are created.

***
***

# 4. Data Insertion {#Data-Insertion}


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

## Insert Complete data {#AAAA}

Run the command to insert complete data:
[IMDB File 3 Insert all data](https://github.com/datagrad/IMDB-Analysis-in-SQL/blob/main/IMDB%20File%203%20Insert%20all%20data.sql)



	
	
# Data Analysis {#Data-Analysis}
	
## 1. Find the total number of rows in each table of the schema?

### Alternative 1:
**Number of Rows after ignoring the Null Rows**

```
SELECT COUNT(*) AS "Number of Rows in Movie Table"
FROM movie;
```
> 7997

```
SELECT COUNT(*) AS "Number of Rows in Genre Table"
FROM genre;
```
> 14662


```

SELECT COUNT(*) AS "Number of Rows in director_mapping Table"
FROM director_mapping;
```
> 3867

```
SELECT COUNT(*) AS "Number of Rows in role_mapping Table"
FROM role_mapping;
```
> 15615


```

SELECT COUNT(*) AS "Number of Rows in names Table"
FROM names;
```
> 25735


```

SELECT COUNT(*) AS "Number of Rows in Ratings Table"
FROM ratings;
```
> 7997


### Alternative 2:
**Rows count inclusive of Null Rows:**

```
SELECT table_name, table_rows
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'imdb';
```
**ANSWER:**

>
>| 	 TABLE_NAME 	 | 	Tables_in_imdb	 |
>| 	----------- 	 | 	----------- 	 |
>| 	director_mapping	 | 	3867	 |
>| 	genre	 | 	14662	 |
>| 	movie	 | 	8519	 |
>| 	names	 | 	23714	 |
>| 	ratings	 | 	8230	 |
>| 	role_mapping	 | 	15173	 |


***
***

## 2. Which columns in the movie table have null values?



***

### Alternative 1:

```
SELECT
	SUM(CASE WHEN m.id IS NULL THEN 1 ELSE 0 END ) AS id_null,
	SUM(CASE WHEN m.title IS NULL THEN 1 ELSE 0 END ) AS title_null,
	SUM(CASE WHEN m.year IS NULL THEN 1 ELSE 0 END ) AS year_null,
	SUM(CASE WHEN m.date_published IS NULL THEN 1 ELSE 0 END ) AS date_null,
	SUM(CASE WHEN m.duration IS NULL THEN 1 ELSE 0 END ) AS duration_null,
	SUM(CASE WHEN m.country IS NULL THEN 1 ELSE 0 END ) AS country_null,
	SUM(CASE WHEN m.worlwide_gross_income IS NULL THEN 1 ELSE 0 END ) AS world_null,
	SUM(CASE WHEN m.languages IS NULL THEN 1 ELSE 0 END ) AS language_null,
	SUM(CASE WHEN m.production_company IS NULL THEN 1 ELSE 0 END ) AS production_null
FROM movie AS m;
```

>| 	id_null	| 	title_null	| 	year_null	| 	date_null	| 	duration_null	| 	country_null	| 	world_null	| 	language_null	| 	production_null	| 
>| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 
>| 	0	| 	0	| 	0	| 	0	| 	0	| 	20	| 	3724	| 	194	| 	528	| 



***


### Alternative 2:

```
SELECT 
	(select count(*) from movie where id is NULL) as id_null,
	(select count(*) from movie where title is NULL) as title_null,
	(select count(*) from movie where year is NULL) as year_null,
	(select count(*) from movie where date_published is NULL) as date_published_null,
	(select count(*) from movie where duration is NULL) as duration_null,
	(select count(*) from movie where country is NULL) as country_null,
	(select count(*) from movie where worlwide_gross_income is NULL) as worldwide_gross_income_null,
	(select count(*) from movie where languages is NULL) as laguages_null,
	(select count(*) from movie where production_company is NULL) as production_company_null
;
```


>| 	id_null	| 	title_null	| 	year_null	| 	date_null	| 	duration_null	| 	country_null	| 	world_null	| 	language_null	| 	production_null	| 
>| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 	----------- 	| 
>| 	0	| 	0	| 	0	| 	0	| 	0	| 	20	| 	3724	| 	194	| 	528	| 


***
***

## 3.1. Find the total number of movies released each year?


***

### Movies per year:

```
select year, count(id) as "number_of_movies"
from movie
group by year
order by year;
```


***
## 3.2. Find the total number of movies released each year?



### Movies Per Month

```
SELECT month(date_published) as "Month", count(id) as "number_of_movies"
FROM movie
GROUP BY Month
ORDER BY Month;
```




***
***



## 4.1 Find the count of Indian Movies.

### Code:

```
SELECT count(id) as "Indian Movies"
from movie
where country like "%INDIA%";
```

***

## 4.2 Find the count of Movies from USA

### Code:

```
SELECT count(id) as "Movies from USA"
from movie
where country like "%USA%";
```

***

## 4.3 Find the count of Movies which are either from India or USA

### Code:

```
SELECT count(id) as "Movies count from USA and India"
FROM movie
WHERE (country like "%USA%" OR country like "%INDIA%")
;
```

***

## 4.4 Find the count of Movies that are either from India or USA and released in 2019.

### Code:

```
SELECT count(id) as "Movies count from USA and India in 2019"
FROM movie
WHERE (country like "%USA%" OR country like "%INDIA%") AND (YEAR = 2019)
;
```
> 1059


***
***


## 5. Find the unique list of the genres present in the data set?

### 

```
SELECT genre
FROM genre
GROUP BY genre;
```

***
***

## 6.1 Find the movies count for each Genre.

### Answer:

```
SELECT Genre, count(movie_id) as "Movies_Count"
FROM Genre
Group by Genre
Order by Movies_count desc;

```

***


## 6.2 Find the Genre with the Maximum number of movies.

### Answer:

```
SELECT Genre, count(movie_id) as "Movies_Count"
FROM Genre
Group by Genre
Order by Movies_count desc
Limit 1;

```

***


## 6.3 Find the Genre with Minimum number of movies.

### Answer:

```
SELECT Genre, count(movie_id) as "Movies_Count"
FROM Genre
Group by Genre
Order by Movies_count ASC
Limit 1;

```


***


## 6.4 Find the Top-3 Genre with the Maximum number of movies.

### Answer:

```
SELECT Genre, count(movie_id) as "Movies_Count"
FROM Genre
Group by Genre
Order by Movies_count desc
Limit 3;

```


***


## 6.4 Find the Movies count for Action Genre.

### Answer:

```
SELECT Genre, count(movie_id) as "Movies_Count"
FROM Genre
Group by Genre
having Genre = "ACTION";

```

***


## 6.5 Find the Genre count for Each Movie.

### Answer:

```
SELECT g.movie_id, m.Title, count(g.movie_id)  AS genre_count
FROM genre as g
    inner join movie as m
    on g.movie_id = m.id
GROUP BY g.movie_id
ORDER BY count(g.movie_id) desc;

```

## 6.6 Find the List of Indian Movies that belongs to 3 genre.

### Answer:

```
SELECT g.movie_id, m.Title, count(g.movie_id)  AS genre_count
FROM genre as g
    inner join movie as m
    on g.movie_id = m.id
WHERE country like "%INDIA%"
GROUP BY g.movie_id
HAVING count(g.genre)=3;

```

## 6.7 Longest Indian movie tagged with 3 genre.

### Answer:

```
SELECT g.movie_id, m.Title, duration,count(g.movie_id)  AS genre_count
	FROM genre as g
    inner join movie as m
    on g.movie_id = m.id
    where country like "%INDIA%" 
	GROUP BY g.movie_id
    HAVING count(g.genre)=3
    order by duration desc
    limit 1;

```
> 'tt6200656', 'Kammara Sambhavam', '182', '3'

## 6.8 Which genres are tagged with 'Kammara Sambhavam' movie.

### Answer:

```
SELECT g.genre
	FROM genre as g
    inner join movie as m
    on g.movie_id = m.id
    where m.Title like 'Kammara Sambhavam';

```
> genre
>> Action
>> Comedy
>> Drama



***
***


## 7.1. How many movies belong to only one genre?

### Approach:

> Create a list of Movies with a genre count

> Restrict the list to Genre count = 1

> Count the total number of rows


```
	SELECT movie_id, count(movie_id)  AS genre_count
	FROM genre
	GROUP BY movie_id;
```

```
	SELECT movie_id, count(movie_id)  AS genre_count
	FROM genre
	GROUP BY movie_id
	HAVING count(genre)=1;
```

```
With one_genre_movies as
	(
	SELECT movie_id, count(movie_id)  AS genre_count
	FROM genre
	GROUP BY movie_id
	HAVING count(genre)=1
    )
    select count(*)
    from one_genre_movies;

```
> > 3289

***
***

## 7.2. How many movies belong to two genres?

### Approach:


```
With two_genre_movies as
	(
	SELECT movie_id, count(movie_id)  AS genre_count
	FROM genre
	GROUP BY movie_id
	HAVING count(genre)=2
    )
    select count(*)
    from two_genre_movies;

```
> > 2751


***
***

## 7.3. How many movies belong to three genres?

### Approach:


```
With three_genre_movies as
	(
	SELECT movie_id, count(movie_id)  AS genre_count
	FROM genre
	GROUP BY movie_id
	HAVING count(genre)=3
    )
    select count(*)
    from three_genre_movies;

```
> > 1957


***
***

## 8.1. What is the average duration of movies in each genre?

### Answer
```
Select g.genre, avg(m.duration) as Average_Duration,
From Movie m
INNER JOIN Genre g
ON m.id = g.movie_id
GROUP BY g.genre;

```
***


## 8.2. Rank the Genre by the average duration of movies in each genre.

### Answer

```
Select g.genre, avg(m.duration) as Average_Duration, row_number() over(order by avg(m.duration) desc) as Ranking
From Movie m
INNER JOIN Genre g
ON m.id = g.movie_id
GROUP BY g.genre
Order by Average_Duration desc
;

```

***
***


## 9. What is the rank of the ‘thriller’ genre of movies among all the genres in terms of the number of movies produced?

#### Answer:

```
SELECT genre, count(id) AS Movie_count, 
	RANK() OVER (ORDER BY count(id) DESC) AS Genre_rank
FROM movie AS m
INNER JOIN genre AS g
	ON m.id=g.movie_id
GROUP BY genre;

```

***
***


## 10.  Find the minimum and maximum values in each column of the rating table except the movie_id column?

```

SELECT 
    MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    MIN(total_votes) AS min_total_votes,
    MAX(total_votes) AS max_total_votes,
    MIN(median_rating) AS min_median_rating,
    MAX(median_rating) AS max_median_rating
FROM ratings;

```

***
***

## 11. Which are the top 10 movies based on average rating?

```
SELECT title, avg_rating, 
	RANK() OVER (ORDER BY avg_rating DESC) AS movie_rank
FROM movie AS m
INNER JOIN ratings AS r
	ON m.id=r.movie_id
LIMIT 10;


```

***
***


## 12. Summarize the ratings table based on the movie counts by median ratings.

```
SELECT median_rating, count(movie_id) AS movie_count
FROM ratings
GROUP BY median_rating
ORDER BY median_rating;

```

***
***

## 13. Which production house has produced the most number of hit movies (average rating > 8)?

### Approach:
>>  Create list of production house with count of movies where average rating > 8 and Ranked over "Movies count"

>> Applied CTE to pull the production house with Rank = 1

```
WITH movie_rank as(
	SELECT production_company, count(id) AS movie_count,
		RANK() OVER( ORDER BY count(id) DESC) AS prod_company_rank
	FROM movie AS m 
	JOIN ratings AS r
		ON r.movie_id=m.id
	WHERE avg_rating>8 AND production_company IS NOT NULL
	GROUP BY production_company
) 
SELECT production_company 
FROM movie_rank
where prod_company_rank = 1;
```

>>>> NOTE: applied (production_company IS NOT NULL) as there are few movies without production house name

***
***

## 14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?

```
SELECT  genre, count(m.id) AS movie_count
FROM movie m 
INNER JOIN ratings r 
		ON m.id=r.movie_id
	JOIN genre g 
		ON m.id=g.movie_id
WHERE 
    (total_votes > 1000) AND 
    (MONTH(date_published)= 3) AND 
    (m.year=2017) AND 
    (m.country LIKE '%USA%')
GROUP BY genre
ORDER BY 2 DESC;
```

***
***

## 15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?


```
SELECT title, avg_rating, genre
FROM movie AS m
	INNER JOIN genre AS g
		ON g.movie_id=m.id
	INNER JOIN ratings AS r 
		ON r.movie_id=m.id
WHERE avg_rating>8 AND title LIKE 'the%'
ORDER BY Genre;
```

***
***

## 16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?

```
SELECT count(id) as movie_count_with_median_rating_of_8
FROM movie as m
	INNER JOIN ratings as r
	ON r.movie_id=m.id
WHERE (median_rating=8) AND (date_published BETWEEN '2018-04-01' AND '2019-04-01');
```

***
***

## 17. Do German movies get more votes than Italian movies? 

```
SELECT country, sum(total_votes) AS votes_count
FROM movie as m 
	INNER JOIN ratings as r
		ON r.movie_id=m.id
WHERE country = 'germany' OR country = 'italy'
GROUP BY country;
```
***
***


## Q18. Which columns in the names table have null values?

```
SELECT 
	sum(CASE WHEN name IS NULL THEN 1 ELSE 0 END) as name_nulls,
	sum(CASE WHEN height IS NULL THEN 1 ELSE 0 END) as height_nulls,
	sum(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) as date_of_birth_nulls,
    sum(CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) as known_for_movies_nulls
FROM names;

```

***
***

## 19. Who are the top three directors in the top three genres whose movies have an average rating > 8?

### Approach:

#### Step 1:

Pull the Top three Genre by Movie count where avg_rating > 8

```
	SELECT genre, count(g.movie_id) as movie_counts
	FROM genre as g
		INNER JOIN ratings as r 
			ON r.movie_id=g.movie_id
	WHERE avg_rating>8
	GROUP BY genre
	ORDER BY count(g.movie_id) DESC
	LIMIT 3;
```

#### Step 2:

Pull the Directors with Movie count where avg_rating > 8

```
	SELECT n.name as director_name, 
		count(g.movie_id) as movie_count
	FROM names n
	INNER JOIN director_mapping as d
		ON n.id=d.name_id
	INNER JOIN genre as g
		ON d.movie_id=g.movie_id
	INNER JOIN ratings as r
		ON r.movie_id=g.movie_id
		
	-- top_3_genres
	WHERE 
	-- g.genre IN (top_3_genres.genre) AND 
	avg_rating> 8           
	GROUP BY director_name
	ORDER BY movie_count DESC;

```


#### Step 3:

Keeping "top_3_genres" as CTE, restrict the 2nd code to avg_rating > 8 and directors of top_3_genre

```
WITH top_3_genres aS 
	(
		SELECT genre, count(g.movie_id) as movie_counts
		FROM genre as g
			INNER JOIN ratings as r 
				ON r.movie_id=g.movie_id
		WHERE avg_rating > 8
		GROUP BY genre
		ORDER BY count(g.movie_id) DESC
		LIMIT 3
	)    
SELECT n.name as director_name, count(g.movie_id) as movie_count
FROM names n
	INNER JOIN director_mapping as d
		ON n.id=d.name_id
	INNER JOIN genre as g
		ON d.movie_id=g.movie_id
	INNER JOIN ratings as r
		ON r.movie_id=g.movie_id, top_3_genres
WHERE 
	g.genre IN (top_3_genres.genre)
	AND avg_rating> 8           
GROUP BY director_name
ORDER BY movie_count DESC
limit 3;
```

***
***
***

## Trying Row_Number() function:

```
Select * from names;

select
		G.Genre,
		N.NAME as director,
		count(distinct G.Movie_ID) as "Movie Count",
		row_number() over (partition by G.Genre order by count(distinct G.Movie_ID) desc) as "Row Number"

FROM
	Genre as G
	Inner Join Movie as M
	on 	G.movie_id = M.ID

	inner Join director_mapping as D
    ON D.Movie_ID = M.ID
    
    Inner Join Names as N
    ON N.ID = D.Name_ID
    
    Inner Join Ratings as R
    ON R.Movie_ID = M.ID
    
    where avg_rating > 8
    
    group by n.name, genre
    order by count(distinct G.Movie_ID) desc
    ;
    
```

***
***

## 20. Who are the top two actors whose movies have a median rating >= 8?


```
SELECT n.name as actor_name, count(r.movie_id) as movie_count
FROM role_mapping as rm
INNER JOIN names as n
	ON rm.name_id=n.id
INNER JOIN ratings as r
	ON rm.movie_id=r.movie_id
WHERE r.median_rating>=8 AND rm.category LIKE 'actor'
GROUP BY name
ORDER BY movie_count DESC
Limit 2;
```


***
***

## 21. Which are the top three production houses based on the number of votes received by their movies?

```
SELECT production_company, total_votes as vote_count
FROM movie as m 
INNER JOIN ratings as r 
	ON m.id=r.movie_id
GROUP BY production_company
order by vote_count desc
LIMIT 3;


```

***
***

## 22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 

### ALTERNTIVE 1 (Using Rank Window Function):
```
        SELECT
		n.name as actor_name,
		sum( total_votes) as total_votes, 
		count(r.movie_id) as movie_count, 	
		round(sum(avg_rating*total_votes)/sum(total_votes),2) as actor_avg_rating,
                row_number() over(order by round(sum(avg_rating*total_votes)/sum(total_votes),2) desc, count(r.movie_id) desc)

	FROM movie as  m
	INNER JOIN ratings as r 
		ON m.id=r.movie_id
	INNER JOIN role_mapping as rm 
		ON m.id=rm.movie_id
	INNER JOIN names as n
		ON rm.name_id=n.id

	WHERE country LIKE 'India' AND category ='actor'

	GROUP BY name

        HAVING movie_count > 4
;

```


#### ALTERNATIVE 2 (Using CTE):

```
With Top_Actors as (
	SELECT
			n.name as actor_name,
			sum( total_votes) as total_votes, 
			count(r.movie_id) as movie_count, 	
			round(sum(avg_rating*total_votes)/sum(total_votes),2) as actor_avg_rating
	FROM movie as  m
	INNER JOIN ratings as r 
		ON m.id=r.movie_id
	INNER JOIN role_mapping as rm 
		ON m.id=rm.movie_id
	INNER JOIN names as n
		ON rm.name_id=n.id
	WHERE country LIKE 'India' AND category ='actor'
	GROUP BY name
    HAVING movie_count > 4
    )
Select *,
    row_number() over( order by actor_avg_rating desc, movie_count desc)
FROM Top_Actors
;

```

***
***


## 23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 

```
WITH hindi_actress_rank as
	(
	SELECT
		n.name as actress_name,
		sum( total_votes) as total_votes, 
		count(r.movie_id) as movie_count, 	
		round(sum(avg_rating*total_votes)/sum(total_votes),2) as actress_avg_rating
	FROM movie as  m
	INNER JOIN ratings as r 
		ON m.id=r.movie_id
	INNER JOIN role_mapping as rm 
		ON m.id=rm.movie_id
	INNER JOIN names as n
		ON rm.name_id=n.id
	WHERE country LIKE 'India' AND category ='actress' AND languages='hindi'
	GROUP BY name
	)
SELECT * , 	
	RANK () OVER (ORDER BY actress_avg_rating DESC,total_votes DESC) AS actress_rank
FROM hindi_actress_rank
WHERE movie_count>=3;


```

***
***

## 24. Select thriller movies as per avg rating and classify them in the following category: 

> Rating > 8: Superhit movies

> Rating between 7 and 8: Hit movies

> Rating between 5 and 7: One-time-watch movies

> Rating < 5: Flop movies

--------------------------------------------------------------------------------------------*/

```
SELECT 
	title,
	CASE 
		WHEN avg_rating>8 THEN 'Superhit Movie' 
		WHEN avg_rating>7 THEN 'Hit Movie'
		WHEN avg_rating >5 THEN 'One-time-watch Movie' 
		ELSE 'Flop Movie'
	END AS movie_category
FROM movie as m 
INNER JOIN  genre as g
	ON m.id=g.movie_id
INNER JOIN ratings as r 
	ON m.id=r.movie_id
WHERE genre ='thriller';

```

***
***
