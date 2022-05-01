show databases;

Create database IMDB;

use imdb;

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



CREATE TABLE genre
 (
	movie_id VARCHAR(10),
    genre VARCHAR(20),
	PRIMARY KEY (movie_id, genre)
);

CREATE TABLE director_mapping (
	movie_id VARCHAR(10),
    name_id VARCHAR(10),
    PRIMARY KEY (movie_id, name_id)
);


CREATE TABLE role_mapping (
	movie_id VARCHAR(10) NOT NULL,
    name_id VARCHAR(10) NOT NULL,
    category VARCHAR(10),
	PRIMARY KEY (movie_id, name_id)
);


CREATE TABLE names (
  id varchar(10) NOT NULL,
  name varchar(100) DEFAULT NULL,
  height int DEFAULT NULL,
  date_of_birth date DEFAULT null,
  known_for_movies varchar(100),
  PRIMARY KEY (id)
);


CREATE TABLE ratings (
	movie_id VARCHAR(10) NOT NULL,
	avg_rating DECIMAL(3,1),
	total_votes INT,
	median_rating INT,
    PRIMARY KEY (movie_id)
);

show tables;

