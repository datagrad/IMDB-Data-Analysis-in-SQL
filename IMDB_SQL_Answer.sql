USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/


-- Segment 1:


-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

select table_name, table_rows
from INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'imdb';

/* Answer_1

TABLE_NAME,TABLE_ROWS
director_mapping,3867
genre,14662
movie,9282
names,23785
ratings,8230
role_mapping,15176
 */
 
 
/*Number of Rows after ignoring the Null Rows

SELECT COUNT(*) AS movie
FROM movie;
-- There are total 7,997 rows

SELECT COUNT(*) AS genre
FROM genre;
-- There are total of 14,662 rows 

SELECT COUNT(*) AS director_mapping
FROM director_mapping;
-- There are total of 3,867 rows 

SELECT COUNT(*) AS role_mapping
FROM role_mapping;
-- There are total of 15,615 rows 

SELECT COUNT(*) AS 'names'
FROM names;
-- There are total of 25,735 rows 

SELECT COUNT(*) AS ratings
FROM ratings;
-- There are total of 7,997 rows */



-- Q2. Which columns in the movie table have null values?
-- Type your code below:
select
SUM(CASE when m.id is null then 1 else 0 end ) as id_null,
SUM(CASE when m.title is null then 1 else 0 end ) as title_null,
SUM(CASE when m.year is null then 1 else 0 end ) as year_null,
SUM(CASE when m.date_published is null then 1 else 0 end ) as date_null,
SUM(CASE when m.duration is null then 1 else 0 end ) as duration_null,
SUM(CASE when m.country is null then 1 else 0 end ) as country_null,
SUM(CASE when m.worlwide_gross_income is null then 1 else 0 end ) as world_null,
SUM(CASE when m.languages is null then 1 else 0 end ) as language_null,
SUM(CASE when m.production_company is null then 1 else 0 end ) as production_null
from movie as m;

/* Answer_2
id_null,title_null,year_null,date_null,duration_null,country_null,world_null,language_null,production_null
0,0,0,0,0,20,3724,194,528

 */

-- the columns which have null values in the table MOVIES are country, worldwide_gross_income,languages and production_company

-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
select  year,
		count(id) as number_of_movies
from movie
group by year;

/* Answer_3.1

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	3052			|
|	2018		|	2944			|
|	2019		|	2001			|

+---------------+-------------------+ */
-- we got count movies by each year 


select month(date_published) as month,
		count(id) as number_of_movies
from movie
group by month
order by month;

/* Answer_3.2

+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|		804			|
|	2			|		640			|
|	3			|		824			|
|	4			|		680			|
|	5			|		625			|
|	6			|		580			|
|	7			|		493			|
|	8			|		678			|
|	9			|		809			|
|	10			|		801			|
|	11			|		625			|
|	12			|		438			|
+---------------+-------------------+ */
/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

select count(id) as number_of_movies_released_in_India_or_USA
from movie
where (country like '%USA%' or country like '%India%') and year = 2019;

/*Answer4:

number_of_movies_released_in_India_or_USA
1059
USA and India produced 1059 movies together*/

/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:
SELECT genre
from genre
group by genre;

/* Answer_5
+---------------+
|	genre		|
+---------------+
|	Drama	    |
|	Fantasy 	|
|	Thriller    |
| 	Comedy      |
|	Horror      |
| 	Family      |
| 	Romance     |
| 	Adventure   |
| 	Action   	|
| 	Sci-Fi   	|
| 	Crime   	|
| 	Mystery   	|
| 	Others   	|
+---------------+

 */

/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:
select genre, count(*) as movies_produced 
from genre
group by genre
order by 2 desc
Limit 1;


/* Answer_6
genre,movies_made
Drama,4285
 */

/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:
with one_genre as
(
select count(movie_id)  as one_genre_movies
from genre
group by movie_id
having count(genre)=1
)
select count(*)
from one_genre;

/* Answer_7
count(*)
3289

 */

/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
select genre,
		avg(duration) as avg_duration
from movie as m 
join genre as g
on m.id=g.movie_id
group by genre;

/* Answer_8
genre,avg_duration
Drama,106.7746
Fantasy,105.1404
Thriller,101.5761
Comedy,102.6227
Horror,92.7243
Family,100.9669
Romance,109.5342
Adventure,101.8714
Action,112.8829
Sci-Fi,97.9413
Crime,107.0517
Mystery,101.8000
Others,100.1600

 */

/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
select genre, 
		count(id) as movie_count, 
		rank() over (order by count(id) desc) as genre_rank
from movie as m
join genre as g
on m.id=g.movie_id
group by genre;

/* Answer_9
genre,movie_count,genre_rank
Drama,4285,1
Comedy,2412,2
Thriller,1484,3
Action,1289,4
Horror,1208,5
Romance,906,6
Crime,813,7
Adventure,591,8
Mystery,555,9
Sci-Fi,375,10
Fantasy,342,11
Family,302,12
Others,100,13

 */

/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:

-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|max_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:
select min(avg_rating) as min_avg_rating,
		max(avg_rating) as max_avg_rating,
        min(total_votes) as min_total_votes,
        max(total_votes) as max_total_votes,
        min(median_rating) as min_median_rating,
        max(median_rating) as max_median_rating
	from ratings;

/* Answer_10
min_avg_rating,max_avg_rating,min_total_votes,max_total_votes,min_median_rating,max_median_rating
1.0,10.0,100,725138,1,10

 */

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too
select title, 
		avg_rating, 
		rank() over (order by avg_rating desc) as movie_rank
from movie as m
join ratings as r
on m.id=r.movie_id
limit 10;

/* Answer_11
title,avg_rating,movie_rank
Kirket,10.0,1
"Love in Kilnerry",10.0,1
"Gini Helida Kathe",9.8,3
Runam,9.7,4
Fan,9.6,5
"Android Kunjappan Version 5.25",9.6,5
"Yeh Suhaagraat Impossible",9.5,7
Safe,9.5,7
"The Brighton Miracle",9.5,7
Shibu,9.4,10
 */

/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have
select median_rating, count(movie_id) as movie_count
from ratings
group by median_rating
order by median_rating;

/* Answer_12
median_rating,movie_count
1,94
2,119
3,283
4,479
5,985
6,1975
7,2257
8,1030
9,429
10,346

 */

/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:
select production_company,
		count(id) as movie_count,
		rank() over( order by count(id) desc) as prod_company_rank
	from movie as m 
    join ratings as r
    on r.movie_id=m.id
    where avg_rating>8 and production_company is not null
    group by production_company ;
    
 /* Answer_13
production_company,count(id),prod_company_rank
"Dream Warrior Pictures",3,1
"National Theatre Live",3,1
"Lietuvos Kinostudija",2,3
"Swadharm Entertainment",2,3
"Panorama Studios",2,3
"Marvel Studios",2,3
"Central Base Productions",2,3
"Painted Creek Productions",2,3
"National Theatre",2,3
"Colour Yellow Productions",2,3
"The Archers",1,11
"Blaze Film Enterprises",1,11
"Bradeway Pictures",1,11
"Bert Marcus Productions",1,11
"A Studios",1,11
"Ronk Film",1,11
"Benaras Mediaworks",1,11
"Bioscope Film Framers",1,11
"Bestwin Production",1,11
"Studio Green",1,11
"AKS Film Studio",1,11
"Kaargo Cinemas",1,11
"Animonsta Studios",1,11
"O3 Turkey Medya",1,11
StarVision,1,11
"Synergy Films",1,11
"PVP Cinema",1,11
"Plan J Studios",1,11
"20 Steps Productions",1,11
"Prime Zero Productions",1,11
"Shreya Films International",1,11
"SLN Cinemas",1,11
"Epiphany Entertainments",1,11
"3 Ng Film",1,11
"Eastpool Films",1,11
"A square productions",1,11
"Oak Entertainments",1,11
"Doha Film Institute",1,11
"Fenrir Films",1,11
"Fábrica de Cine",1,11
"Chernin Entertainment",1,11
"Cross Creek Pictures",1,11
"Loaded Dice Films",1,11
"WM Films",1,11
"Walt Disney Pictures",1,11
"Excel Entertainment",1,11
Ancine,1,11
"Twentieth Century Fox",1,11
"Ave Fenix Pictures",1,11
"Runaway Productions",1,11
"Aletheia Films",1,11
"70 MM Entertainments",1,11
"Moho Film",1,11
"BR Productions and Riding High Pictures",1,11
"Cana Vista Films",1,11
"Gurbani Media",1,11
"Sony Pictures Entertainment (SPE)",1,11
"InnoVate Productions",1,11
"Saanvi Pictures",1,11
"The SPA Studios",1,11
"Rotten Productions",1,11
"Film Village",1,11
"Arka Mediaworks",1,11
"Atresmedia Cine",1,11
"Goopy Bagha Productions Limited",1,11
Maxmedia,1,11
"1234 Cine Creations",1,11
"Silent Hills Studio",1,11
"Blueprint Pictures",1,11
"Archangel Studios",1,11
"HI Film Productions",1,11
"Tin Drum Beats",1,11
"Frío Frío",1,11
"Warnuts Entertainment",1,11
"Potential Studios",1,11
Adrama,1,11
"Dark Steel Entertainment",1,11
Allfilm,1,11
"Nokkhottro Cholochitra",1,11
"BOB Film Sweden AB",1,11
"Smash Entertainment!",1,11
EFilm,1,11
"Urvashi Theaters",1,11
"Angel Capital Film Group",1,11
"Grass Root Film Company",1,11
"Art Movies",1,11
"Lost Legends",1,11
Ra.Mo.,1,11
"Avocado Media",1,11
"Tigmanshu Dhulia Films",1,11
"Think Music",1,11
"Anwar Rasheed Entertainment",1,11
"Dwarakish Chitra",1,11
"Anto Joseph Film Company",1,11
"Dijital Sanatlar Production",1,11
"Missart produkcija",1,11
"Jayanna Combines",1,11
"Jar Pictures",1,11
"British Muslim TV",1,11
"Crossing Bridges Films",1,11
"BrightKnight Entertainment",1,11
"Mirror Images LTD.",1,11
"Mango Pickle Entertainment",1,11
Detailfilm,1,11
"Archway Pictures",1,11
"Vehli Janta Films",1,11
"Grooters Productions",1,11
"Fulwell 73",1,11
Participant,1,11
"Madras Enterprises",1,11
"Alchemy Vision Workz",1,11
"Axess Film Factory",1,11
"PRK Productions",1,11
"Dashami Studioz",1,11
Fablemaze,1,11
"StarFab Production",1,11
"RGK Cinema",1,11
"Shreyasree Movies",1,11
"BRON Studios",1,11
"Bhadrakali Pictures",1,11
"The Icelandic Filmcompany",1,11
"The Church of Almighty God Film Center",1,11
"Maha Sithralu",1,11
"Mythri Movie Makers",1,11
"Orange Médias",1,11
"Mumbai Film Company",1,11
"Swapna Cinema",1,11
"Vivid Films",1,11
"HRX Films",1,11
"Wonder Head",1,11
"Sixteen by Sixty-Four Productions",1,11
"Akshar Communications",1,11
"Moviee Mill",1,11
"Happy Hours Entertainments",1,11
M-Films,1,11
"Cineddiction Films",1,11
"Heyday Films",1,11
"Diamond Works",1,11
"Shree Raajalakshmi Films",1,11
"Dream Tree Film Productions",1,11
"Cine Sarasavi Productions",1,11
"Acropolis Entertainment",1,11
"RedhanThe Cinema People",1,11
"Hombale Films",1,11
"Swonderful Pictures",1,11
"COMETE Films",1,11
"Cinepro Lanka International",1,11
"Williams 4 Productions",1,11
"Touch Wood Multimedia Creations",1,11
"Rocket Beans Entertainment",1,11
Hepifilms,1,11
"SRaj Productions",1,11
"Kharisma Starvision Plus PT",1,11
"MD productions",1,11
"Ataraxia Entertainment",1,11
"NBW Films",1,11
"Kannamthanam Films",1,11
"Brainbox Studios",1,11
"Matchbox Pictures",1,11
"Reliance Entertainment",1,11
"Neelam Productions",1,11
"Jyot & Aagnya Anusaare Productions",1,11
"Clown Town Productions",1,11
"Special Treats Production Company",1,11
"Mooz Films",1,11
"Bulb Chamka",1,11
"GreenTouch Entertainment",1,11
"Crystal Paark Cinemas",1,11
"Kangaroo Broadcasting",1,11
"Swami Samartha Creations",1,11
"DreamReality Movies",1,11
"Fahadh Faasil and Friends",1,11
Narrator,1,11
"Kineo Filmproduktion",1,11
"Appu Pathu Pappu Production House",1,11
"Rishab Shetty Films",1,11
"Namah Pictures",1,11
"Annai Tamil Cinemas",1,11
"Viacom18 Motion Pictures",1,11
"MNC Pictures",1,11
"Clyde Vision Films",1,11
"Adenium Productions",1,11
"Trafalgar Releasing",1,11
"Lovely World Entertainment",1,11
"Hayagriva Movie Adishtana",1,11
"OPM Cinemas",1,11
"Sithara Entertainments",1,11
"French Quarter Film",1,11
"Mumba Devi Motion Pictures",1,11
"Fox STAR Studios",1,11
"Aries Telecasting",1,11
"Abis Studio",1,11
"Rapi Films",1,11
"Ay Yapim",1,11
"Aatpaat Production",1,11
"Channambika Films",1,11
"Cinenic Film",1,11
"The United Team of Art",1,11
"Grahalakshmi Productions",1,11
"Mahesh Manjrekar Movies",1,11
"Manikya Productions",1,11
"Bombay Walla Films",1,11
"Viva Inen Productions",1,11
"Banana Film DOOEL",1,11
"Toei Animation",1,11
"Golden Horse Cinema",1,11
"V. Creations",1,11
"Moonshot Entertainments",1,11
"Humble Motion Pictures",1,11
"Coconut Motion Pictures",1,11
"Bayview Projects",1,11
"Piecewing Productions",1,11
"Manyam Productions",1,11
"Suresh Productions",1,11
"Benzy Productions",1,11
"RMCC Productions",1,11

 */
    
-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
select genre , count(m.id) as movie_count
from movie m 
join ratings r on m.id=r.movie_id
join genre g on m.id=g.movie_id
where total_votes > 1000 AND month(date_published)= 3 AND m.year=2017
and m.country like '%USA%'
group by genre
order by 2 desc;

/* Answer_14
genre,movie_count
Drama,24
Comedy,9
Action,8
Thriller,8
Sci-Fi,7
Crime,6
Horror,6
Mystery,4
Romance,4
Fantasy,3
Adventure,3
Family,1
 */

-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
select title, avg_rating, genre
from movie as m
join genre as g
on g.movie_id=m.id
join ratings as r 
on r.movie_id=m.id
where avg_rating>8 and title like 'the%'
group by title;

/* Answer_15
title,avg_rating,genre
"The Blue Elephant 2",8.8,Drama
"The Brighton Miracle",9.5,Drama
"The Irishman",8.7,Crime
"The Colour of Darkness",9.1,Drama
"Theeran Adhigaaram Ondru",8.3,Action
"The Mystery of Godliness: The Sequel",8.5,Drama
"The Gambinos",8.4,Crime
"The King and I",8.2,Drama
 */

-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:
select count(id) as movie_count_with_median_rating_of_8
from movie as m
join ratings as r
on r.movie_id=m.id
where median_rating=8 and date_published between '2018-04-01' and '2019-04-01';

/* Answer_16
movie_count_with_median_rating_of_8
361
 */

-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:
select country, sum(total_votes) as total_number_of_votes
from movie as m 
join ratings as r
on r.movie_id=m.id
where country = 'germany' or country = 'italy'
group by country;

/* Answer_17
country,total_number_of_votes
Germany,106710
Italy,77965
 */

-- Answer is Yes (German vote count is 106710, against 77965 count of Italian)

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:

-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
select sum(case when name is null then 1 else 0 end) as name_nulls,
		sum(case when height is null then 1 else 0 end) as height_nulls,
		sum(case when date_of_birth is null then 1 else 0 end) as date_of_birth_nulls,
        sum(case when known_for_movies is null then 1 else 0 end) as known_for_movies_nulls
from names;

/*Answer_18
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|		17335		|	       13431	  |	      15226      	 |
+---------------+-------------------+---------------------+----------------------+*/


/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

with top_3_genres as (
select genre, count(g.movie_id) as movie_counts
			from genre as g
			join ratings as r on r.movie_id=g.movie_id
            where avg_rating>8
            group by genre
            order by movie_counts desc
            limit 3
            )
select n.name as director_name, count(g.movie_id) as movie_count
from names n
join director_mapping as d
on n.id=d.name_id
join genre as g
on d.movie_id=g.movie_id
join ratings as r
on r.movie_id=g.movie_id,
top_3_genres
where g.genre in (top_3_genres.genre)  and avg_rating> 8           
group by director_name
order by movie_count desc;

/* Answer_19
 director_name,movie_count
"James Mangold",4
"Soubin Shahir",3
"Joe Russo",3
"Anthony Russo",3
"H. Vinoth",2
Harsha,2
"Nitesh Tiwari",2
"Manoj K. Jha",2
"Prince Singh",2
"Amr Gamal",2
"Jeral Clyde Jr.",2
"Madhu C. Narayanan",2
"Mandeep Benipal",2
"Aditya Dhar",2
"Clarence Williams IV",2
"Noah Baumbach",2
"Sandeep Reddy Vanga",2
"Marianne Elliott",2
"Tim Van Someren",2
"Raj B. Shetty",2
"Mahesh Narayan",2
"Tigmanshu Dhulia",2
"Arshad Siddiqui",2
"Emeric Pressburger",2
"Michael Powell",2
"Oskars Rupenheits",2
"Khalid Rahman",2
"Aaron K. Carter",2
"Ivo van Hove",1
"Vipul Mehta",1
"Milcho Manchevski",1
"Sudheer Konderi",1
"Manu Ashokan",1
"Putrama Tuta",1
"Ahmet Katiksiz",1
"Alexis Sweet Cahill",1
"Brigitte Drodtloff",1
"Alexis Cahill",1
"Jonathan Munby",1
"Levan Akin",1
"Monty Tiwa",1
"Arsel Arumugam",1
"Jagdeep Sidhu",1
"Rishab Shetty",1
"M. Padmakumar",1
"Josh Oreck",1
"Nadine Labaki",1
"Ray Nayoan",1
"Rahi Anil Barve",1
"Adesh Prasad",1
"Anand Gandhi",1
"Mari Selvaraj",1
Prabunath,1
"Vinit Kanojia",1
"Rahul Bhole",1
"Christina Kyi",1
"Kaushik Ganguly",1
"Sunil Ariyaratne",1
"Khalid Abdulrahim Al-Zadjali",1
"Tong Wu",1
"Junxiu Yin",1
"Wei Chen",1
"Vikas Bahl",1
"Chu Wen",1
Nithilan,1
"Aida Begic",1
"John Grooters",1
"Harry Bhatti",1
"Taranvir Singh Jagpal",1
"Nuri Bilge Ceylan",1
"Gui Pereira",1
"Antoneta Kastrati",1
"Aditya Kripalani",1
"Scott A. Hamilton",1
"Tauquir Ahmed",1
"Prithvi Konanur",1
"Milos Avramovic",1
"Raam Reddy",1
Bijon,1
"Michael Matteo Rossi",1
"Robert Rippberger",1
"Zoya Akhtar",1
"Mel Gibson",1
"Arunas Zebriunas",1
"Mong-Hong Chung",1
"Balavalli Darshith Bhat",1
"Venkat Ramji",1
"Ginatri S. Noer",1
"Annie Silverstein",1
Pushkar,1
Gayatri,1
"Bob Persichetti",1
"Rodney Rothman",1
"Peter Ramsey",1
"Juliano Dornelles",1
"Kleber Mendonça Filho",1
"Pradeep Kalipurayath",1
"Ramesh Varma",1
"Vivek Athreya",1
"Abhinav Thakur",1
"Marc-André Lavoie",1
"Oz Arshad",1
"Girish A.D.",1
"Arjun Prabhakaran",1

 */

/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
select n.name as actor_name, count(r.movie_id) as movie_count
from  role_mapping as rm
join names as n
on rm.name_id=n.id
join ratings as r
on rm.movie_id=r.movie_id
where r.median_rating>=8 and rm.category like 'actor'
group by name
order by movie_count desc;

/* Answer_20
actor_name,movie_count
Mammootty,8
Mohanlal,5
"Amrinder Gill",4
"Amit Sadh",4
"Johnny Yong Bosch",4
"Tovino Thomas",4
"Dulquer Salmaan",4
Siddique,4
"Rajkummar Rao",4
"Fahadh Faasil",4
"Pankaj Tripathi",4
"Dileesh Pothan",4
"Joju George",4
"Ayushmann Khurrana",4
"Jimmy Sheirgill",3
"Andrew Garfield",3
"Robert Downey Jr.",3
"Eric Roberts",3
"Raj Arjun",3
"Adil Hussain",3
"Hiroshi Kamiya",3
"John Eric Bentley",3
"Vic Mignogna",3
"Robbie Daymond",3
"Kunal Kapoor",3
"Ranvir Shorey",3
Nassar,3
"Murali Gopy",3
Sudeep,3
"Achyuth Kumar",3
"Shane Nigam",3
"Ranjit Bawa",3
"Dharmajan Bolgatty",3
"Asif Ali",3
"Ammy Virk",3
"Jagapathi Babu",3
"Karamjit Anmol",3
"Shine Tom Chacko",3
"Vijay Deverakonda",3
"Sree Vishnu",3
"Navid Mohammadzadeh",3
"Faizal Hussein",2
"Robert Patrick",2
"Yoav Levi",2
"Bruce Dern",2
"Tanikella Bharani",2
"Varun Sharma",2
"Naveen Chandra",2
Vetri,2
"Vijay Raaz",2
"Sanjay Mishra",2
"Kevin Costner",2
"Hugh Jackman",2
"Christian Bale",2
"Jon Bernthal",2
"Vernon Wells",2
"Bill Oberst Jr.",2
"Tomasz Zietek",2
"Alex Hassell",2
"Aleksander Ristic",2
"Emir Hadzihafizbegovic",2
"Zachary Laoutides",2
"Kevin Sizemore",2
"Ed Begley Jr.",2
"Jon Hamm",2
"Lucas Hedges",2
"Chris Evans",2
"Mark Ruffalo",2
"Chris Hemsworth",2
"Zul Ariffin",2
"Mahershala Ali",2
"Haluk Bilginer",2
"Serkan Keskin",2
"John Savage",2
"Bret Roberts",2
"Saurabh Shukla",2
"Justin Lebrun",2
"Takahiro Sakurai",2
"Carlo Aquino",2
"Keith Sutliff",2
"Sebastian Cavazza",2
"Leon Lucev",2
"Nahuel Pérez Biscayart",2
"Fazlur Rahman Babu",2
"Talat Hussain",2
"Justin Briner",2
"Humayun Saeed",2
"Zahid Hasan",2
"Mosharraf Karim",2
"Armand Assante",2
"Reza Rahadian",2
"Raghuvir Yadav",2
"Annu Kapoor",2
"Akshay Kumar",2
"Arpit Chaudhary",2
Mukesh,2
"Jacob Gregory",2
"Vivek Oberoi",2
"Takumi Kitamura",2
"Bayyumi Fuad",2
"Vijay Sethupathi",2
Kathir,2
"Meka Srikanth",2
"Gurmeet Saajan",2
"Renji Panicker",2
"Allu Sirish",2
"M.G. Srinivas",2
"S.J. Surya",2
"Ritwick Chakraborty",2
"Sraman Chatterjee",2
"Mahesh Babu",2
"Bharath Srinivasan",2
"Marthino Lio",2
"Hareesh Kanaran",2
"Shakib Khan",2
"Anoop Menon",2
"Arkadiusz Jakubik",2
"Tarsem Jassar",2
"Siam Ahmed",2
"Jaswinder Bhalla",2
"Teeradon Supapunpinyo",2
"Kin Wah Chew",2
"Nathan Lane",2
"Russell Tovey",2
"Nathan Stewart-Jarrett",2
"N.T. Rama Rao Jr.",2
"Ajith Kumar",2
"Jun Fukuyama",2
"Atul Sharma",2
"Sammy John Heaney",2
"Nedumudi Venu",2
Nani,2
"Prakash Raj",2
Brahmanandam,2
Avinash,2
"Anant Nag",2
"Binnu Dhillon",2
"Deepak Raj Giri",2
"Guggu Gill",2
"Harish Verma",2
"Zizan Razak",2
Devaraj,2
"Tommy Flanagan",2
"Suraj Venjaramoodu",2
"Nandish Singh",2
Sreenivasan,2
"Adam Driver",2
"Rajsekhar Aningi",2
"Srinivas Avasarala",2
"Puneeth Rajkumar",2
Chikkanna,2
"Arjun Sarja",2
"Yogi Babu",2
"Farhad Aslani",2
"Mehmet Özgür",2
"B.N. Sharma",2
"Sushant Singh Rajput",2
"Santilal Mukherjee",2
"Rwitobroto Mukherjee",2
"Abhinav Gomatam",2
"Sujiwo Tejo",2
"Mahesh Achanta",2
"Chemban Vinod Jose",2
"Naga Chaitanya Akkineni",2
"Gurpreet Ghuggi",2
"Jassie Gill",2
Prateik,2
"Gurnam Bhullar",2
"Maria Petrano",2
"David Niven",1
"Robert Coote",1
"Alan Bates",1
"Pierre Brasseur",1
"Jean-Claude Brialy",1
"Bruce Campbell",1
"Richard DeManincor",1
"Ashok Kumar",1
"Sanjeev Kumar",1
"Borislav Brondukov",1
"Daniil Ilchenko",1
"Ivan Mykolaichuk",1
"Boris Savchenko",1
"Chris Pine",1
"Ramli Hassan",1
"Rob Morgan",1
"Savas Barutçu",1
"Cihan Köse",1
"Bekir Behrem",1
"Ali Kaan Serez",1
"Amitay Yaish Ben Ousilio",1
"Yehuda Nahari Halevi",1
"Mohsin Ejaz",1
"Mehmood Aslam",1
Saravanan,1
"Sai Srinivas Bellamkonda",1
"Keshav Deepak",1
"Alden Richards",1
"Issa Perica",1
"Damien Bonnard",1
"Alexis Manenti",1
"Djibril Zonga",1
"Ha-kyun Shin",1
"Hae-hyo Kwon",1
"Cheol-min Park",1
"Kwang-il Choi",1
"Jung-ki Kim",1
"Kwang-Soo Lee",1
"Min-Seok Kim",1
"Wes Studi",1
"Kevin Makely",1
"Paritosh Sand",1
"Divyendu Sharma",1
"Dmytro Iaroshenko",1
"Tal Friedman",1
"Tsahi Halevi",1
"Gopi Krishna",1
"Shilpa Mahendar",1
"Priyanka Augustin",1
Carter,1
"David E. Cazares",1
"Johann Urb",1
"Rogelio Douglas Jr.",1
"Henrik Kalmet",1
"Lukman Sardi",1
"Dion Wiyoko",1
"Salim Kumar",1
"Karthik Ramakrishnan",1
"Michael Winters",1
"Lathrop Walker",1
"Ahmed Ezz",1
"Ahmed Falawkas",1
"Mahmoud Hijazi",1
"Mohamed Goma",1
"Mohamed Farraag",1
"Haggag Abdulazim",1
"Narsing Yadav",1
Vardhan,1
"Sri Pawar",1
"Kriti Garg",1
"Angga Yunanda",1
"Arswendy Bening Swara",1
"Dwi Sasono",1
"Saheoiyn Aophachat",1
"Prawit Boonprakong",1
"Mohammed Saad",1
"Mohamad Ramadan",1
"Priyansh Jora",1
Badshah,1
"Murli Sharma",1
"Adivi Sesh",1
"Mathew Thomas",1
"Nalsen K. Gafoor",1
"Vineeth Sreenivasan",1
Karunakaran,1
"Pratik Gandhi",1
"Vishal Shah",1
"Nicholas Michael Jacobs",1
"Shawn C. Phillips",1
"Iftikhar Thakur",1
"Akram Udaas",1
Joseph,1
"Mo Han",1
"Hao Chen",1
"Wei Yang",1
"Jiaming Zhang",1
"Baskara Mahendra",1
"Batuhan Zeybek",1
"Berkay Berkman",1
"Önem Piskin",1
"Soner Türker",1
"Murat Deniz",1
"Kahraman Sivri",1
"Ali Ertem",1
"Aaryan Menghji",1
"Petrônio Gontijo",1
"Dalton Vigh",1
"Lakshya Sinha",1
"Vinay Varma",1
"Chin-Hua Tseng",1
"Meng-Po Fu",1
"Govind Namdeo",1
"Priyanshu Chatterjee",1
"Bhavesh Kumar",1
"Kumud Mishra",1
"Aryan Gowda",1
"Naveen D. Padil",1
"Ravi Bhat",1
"Siju Wilson",1
Prasanth,1
"Adhin Abdul Hakim",1
"Fauzi Baadila",1
"Yi-wen Chen",1
"Chien-Ho Wu",1
Indhra,1
"Ravi Babu",1
Priyadarshi,1
"Michael Paré",1
"Tauras Ragalevicius",1
"Arvidas Samukas",1
"Jean-Claude Van Damme",1
"John Colton",1
"Josef Cannon",1
"Marcus Hondro",1
"Milo Ventimiglia",1
"Zac Efron",1
"Kevin Tracy",1
"Kamal Nandi",1
"Mukesh Asopa",1
"Katherine Stefanski",1
"Michael B. Jordan",1
"Chadwick Boseman",1
"Brad Pennington",1
"Clint Browning",1
"Larena Reyna",1
"Matt Damon",1
"Tom Hanks",1
"Tim Allen",1
"Tony Hale",1
"Craig Rees",1
"Jamie Bell",1
"Richard Madden",1
"Taron Egerton",1
"Sam Worthington",1
"Luke Bracey",1
"Alan Davies",1
"Jamie Foreman",1
"Brenock O Connor",1
"Tom Konkle",1
"Michael Keaton",1
"Tom Holland",1
"Chip Lane",1
"Raza Jaffrey",1
"Jan Uddin",1
"Jon Jacobs",1
"David Proval",1
"William Wayne",1
"F. Murray Abraham",1
"Jay Baruchel",1
"Ranveer Singh",1
"Siddhant Chaturvedi",1
"Jonathan Banks",1
"Jason Clarke",1
"Garrett Hedlund",1
"Owen Wilson",1
"Jacob Tremblay",1
"Bill Watterson",1
"Arthur Diennet",1
"Marcel Diennet",1
"Gary Cross",1
"Kemal Yildirim",1
"Christopher Cousins",1
"George Loomis",1
"Glen Powell",1
"Paul Iacono",1
"Erik Stocklin",1
"Thardelly Lima",1
"Thomas Aquino",1
"Silvero Pereira",1
"Parrish Randall",1
"Roger Edwards",1
"Bryan Brewer",1
"Michael Aaron Milligan",1
"Daniel Paton",1
"Fin Banks",1
"Vergil J. Smith",1
"Miroslaw Haniszewski",1
"Robert Venable",1
"Nick Rhys",1
"Jon Briddell",1
"Eric Goins",1
"Jason Burkey",1
"James Badge Dale",1
"Frank Grillo",1
"Luke Grimes",1
"Matthew Oliva",1
"Jerome Flynn",1
"Douglas Booth",1
"Robert Gulaczyk",1
"Peter J. Morton",1
"Alex LiMandri",1
"Luis de La Rosa",1
"Jonathan Rhys Meyers",1
"Mads Sjøgård Pettersen",1
"Thomas Gullestad",1
"Patrick Stewart",1
"Boyd Holbrook",1
"Colby Arps",1
"Jinglin Guo",1
"Xu Dai",1
"Shubham Tukaram",1
"Shubham Chintamani",1
Yug,1
"Ofer Hayoun",1
"Maor Schwitzer",1
"Nimrod Hochenberg",1
"Judd Nelson",1
"Burton Gilliam",1
"Jesse James",1
"Kharaj Mukherjee",1
"Ratan Sarkhel",1
"Suman Mukhopadhyay",1
"Jeffrey Mundell",1
"Josh Collins",1
"Kris Saddler",1
"Kevin McKelvey",1
"Aleksandar Seksan",1
"Mirsad Tuka",1
"Moamer Kasumovic",1
"Ric Morgan",1
"Joseph Mennella",1
"Danny Glover",1
"Mark Ashworth",1
"Terry Serpico",1
"Clint James",1
"James Franco",1
"Seth Rogen",1
"Dave Franco",1
"Hugh Quarshie",1
"Dan Richardson",1
"Cengiz Dervis",1
"Samuel Younan",1
"Alex Villarreal",1
"Jim O Heir",1
"Craig T. Nelson",1
"Huck Milner",1
"Tim Progosh",1
"Greg Hovanessian",1
"Victor Verbitsky",1
"Mark Rolston",1
"Jaime Camil",1
"Jon Gries",1
"Xavier Tchili",1
"Tyler Christopher",1
"Preston Bailey",1
"Claude Duhamel",1
"Ryan Carnes",1
"Martin Sensmeier",1
"Emmanuel Garijo",1
"Tom Hudson",1
"Baptiste Goy",1
"Axel Devillers",1
"Silvio Simac",1
"Lucas Tavernier",1
"John Flanders",1
"Guy Bleyaert",1
"Lee Charles",1
"Don Wilson",1
"Matt Mullins",1
"Miko Hughes",1
"Dev Patel",1
"Sunny Pawar",1
"Richard Dreyfuss",1
"Cuba Gooding Jr.",1
"Cheyenne Jackson",1
"Ryan Gosling",1
"J.K. Simmons",1
"Abhishek Bharate",1
"Eddie Jemison",1
"Najee De-Tiege",1
"John Kellar",1
"John Mead",1
"Dominique Purdy",1
"Joseph Ansalvish",1
"Jon Campling",1
"Toby Osmond",1
"Ansel Elgort",1
"Vin Diesel",1
"Chris Pratt",1
"Dave Bautista",1
"Noorin Gulamgaus",1
"Kelso Ashby III",1
"John Alston",1
"Brian Babulic",1
"Alberto Agraz",1
"Dave Bald Eagle",1
"Richard Ray Whitman",1
"Christopher Sweeney",1
"Jason Flemyng",1
"Satinder Sartaaj",1
"Raúl Tejón",1
"Luis Mottola",1
"Parker Croft",1
"Jake Lockett",1
"Casey Affleck",1
"Kyle Chandler",1
"Peter Simonischek",1
"Michael Wittenborn",1
"Thomas Loibl",1
"David Zayas",1
"Artem Chigvintsev",1
"Rolf Lassgård",1
"Filip Berg",1
"Robert Gant",1
"Dan Gauthier",1
"Andrzej Chyra",1
"Steve Royal",1
"Stanislaw Banach",1
"Michael Ironside",1
"Charles Baker",1
"Ryan Buggle",1
"Frankie Faison",1
"Harris Yulin",1
"Teddy Sears",1
"Doug Rand",1
"Philip Schurer",1
"Fabrice Pierre",1
"Ali Fazal",1
"Amitosh Nagpal",1
"Rajit Kapur",1
"Mathieu Lourdel",1
"Léo Pochat",1
"Nicolas Lancelin",1
"Chase Austin Mosely",1
"Jay Bowles",1
"Wilford Brimley",1
"Jeremy London",1
"Matt Lindquist",1
"Rowan Smyth",1
"Doug Bollinger",1
"Keith Collins",1
"Michael Billy",1
"Christopher Ellison",1
"Terry Stone",1
"Josh Myers",1
"Sam Strike",1
"Gregory Linington",1
"Amir Motlagh",1
"Rey Deegan",1
"Keanu Reeves",1
"Ian McShane",1
"Riccardo Scamarcio",1
"Brendan Bacon",1
"Andy Hazel",1
"Drew McAnany",1
"Hugh Grant",1
"Hugh Bonneville",1
"Ben Whishaw",1
"Ron Jeremy",1
"Malcolm McDowell",1
"Tyler Mane",1
"Jason Turner",1
"Rich Zvosec",1
"David Tittone",1
"Matthew James",1
"Eddie Perino",1
"Andrew Caldwell",1
"Seth Meriwether",1
"Casper Van Dien",1
"Peter Mayer",1
"Zachary Mooren",1
"Jeff Kober",1
"Farid Kamil",1
"Ewan McGregor",1
"Mark Gatiss",1
"Kirk Curran",1
"Jeremy O Shea",1
"Mike Blejer",1
"Arif Zakaria",1
"Anurag Arora",1
"Jake Johnson",1
"Shameik Moore",1
"Doug Purdy",1
"Maxwell Purdy",1
"Dariush Moslemi",1
"Bobby E. Erickson",1
"Eugene Kizzier",1
"Stephen Marcus",1
"Christopher Dunne",1
"Simon J. Berger",1
"Emil Algpeus",1
"Taner Ölmez",1
"Dhvanit Thaker",1
"Smit Pandya",1
"Prem Gadhavi",1
"Aaron Guerrero",1
"Mel Novak",1
"Frankie Pozos",1
"Marcel Iures",1
"Andi Vasluianu",1
"Jonathan Cheban",1
"Thomas Gipson",1
"Brian Letscher",1
"Tyson Turrou",1
"David Christian Welborn",1
"James Snyder",1
"Hamed Behdad",1
"Joe Lewis",1
"Benjamin Nathan-Serio",1
"Banipal Shoomoon",1
"Daniel Giménez Cacho",1
"Oscar Isaac",1
"Taso Mikroulis",1
"Darrin Dewitt Henson",1
"Tauras Cizas",1
"Saulius Ciucelis",1
"Gabriele Anicaite",1
"Ian McLaren",1
"Benjamin Barrett",1
"Gregory Kasyan",1
"Monir Ahmed",1
"Mahmudur Anindo",1
"Thomas Burks",1
"Thammegowda S.",1
"Abhishek H.N.",1
"Pooja S.M.",1
Channegowda,1
"Dorian Gregory",1
"Daniel Lench",1
"Frank Krueger",1
"Mario Toñanez",1
"Tomás Arredondo",1
"Cecilia Torres",1
"Christian Ferreira",1
"Tracy Letts",1
"Brett Cullen",1
"Sunny Deol",1
"Ravi Kishan",1
"Mukesh Tiwari",1
"Kurry Damon",1
"Johnny Rey Diaz",1
"Shane Samples",1
"Tony Gardner",1
"Heath Hampson",1
"Sandy Jamieson",1
"Finn H. Drude",1
"Trevante Rhodes",1
"Alex R. Hibbert",1
"Daniel Wilkinson",1
"Ryan Moore",1
"Brian Raetz",1
"Barun Sobti",1
"Grant Swanby",1
"Israel Matseke-Zulu",1
"Lemogang Tsipa",1
"Félix Arcarazo",1
"Josu Cubero",1
"Andrea Alzuri",1
"Ernst Stötzner",1
"Pierre Niney",1
"Sarm Heng",1
"Thanawut Kasro",1
"Saichia Wongwirot",1
"Mony Ros",1
"Richard Hope",1
"Phill Martin",1
"William Mark McCullough",1
"Riccardo Berdini",1
"John Ryan Howard",1
"Ross Mac Mahon",1
"Sebastian Jessen",1
"Nikolaj Groth",1
"Paulo Américo",1
"Isam Ahmad Issa",1
"Giuseppe di Noto",1
"Rossella Cardaci",1
"Giulio Fodale",1
"Matteo Martorana",1
"Burt Young",1
"Conleth Hill",1
"Fisayo Akinade",1
"Vas Blackwood",1
"Stu Bennett",1
"Daniel O Reilly",1
"Nicholas Hoult",1
"Clifton Collins Jr.",1
"Peter Vack",1
"Patrick Bruel",1
"Batyste Fleurial",1
"Dorian Le Clech",1
"Mon Confiado",1
"Arron Villaflor",1
"Paulo Avelino",1
"Josh Duhamel",1
"Nick Robinson",1
"Adonis Danieletto",1
"Guillaume Duhesme",1
"Zuri François",1
"Ljubomir Bandovic",1
"Nenad Okanovic",1
"Vuk Jovanovic",1
"Marko Vasiljevic",1
"Nazo Bravo",1
"Dragan Bjelogrlic",1
"Nebojsa Glogovac",1
"Milos Bikovic",1
"Miodrag Radonjic",1
"José Carlos Ruiz",1
"Hoze Meléndez",1
"Shaun Michael McNamara",1
"Travis Leonard",1
"Tyler Trace Rojas",1
"A.J. Villarreal",1
"Eucir de Souza",1
"Nicolas Prattes",1
"André Hendges",1
"Lester Speight",1
"Boris Isakovic",1
"Billy Howerdel",1
"Dave Rogers",1
"Ditlev Darmakaya",1
"Niels Arestrup",1
"Albert Dupontel",1
"Laurent Lafitte",1
"Tom Sizemore",1
"Shaun Gerardo",1
"David Hov",1
"Dennis Haskins",1
"T.J. Storm",1
"Denis Khoroshko",1
"Filip Mayer",1
"Velton Lishke",1
"Emil Johnsen",1
"Sam Schweikert",1
"John Redlinger",1
"Olle Sarri",1
"Bo Lundmark",1
"Teodor Corban",1
"Laurentiu Bãnescu",1
"Maria Simona Arsu",1
"Misa Sawdagar",1
"Yash Rohan",1
"Julian Vergov",1
"Zachary Baharov",1
"Aleksandar Aleksiev",1
"Stoyan Doychev",1
"Jose Canseco",1
"Michael Irvin",1
"Ryan Gunnarson",1
"Chris Staples",1
"Jeremy Renner",1
"Teo Briones",1
"Ralph Fiennes",1
"Matthew Goode",1
"Satish Acharya",1
Chinnu,1
"Yash Shetty",1
Basavaraju,1
"Thomas Schmuckert",1
"Arndt Schwering-Sohnrey",1
"Anton Spieker",1
"Ahsan Khan",1
"Faizan Khawaja",1
"Kyle Hebert",1
"Terry Byrne",1
"Peter Coonan",1
"Barry McGovern",1
"Padhraig Parkinson",1
"Shaan Shahid",1
"Mohib Mirza",1
"Shawn Dixon",1
"Yasir Hussain",1
"Adam Lazarus",1
"Vikram Gaikwad",1
"Anil Gawas",1
"Martin Copping",1
"Mohan Agashe",1
"Mohan Joshi",1
"Gavie Chahal",1
"Lom Harsh",1
"Lukas Miko",1
"Michael Pink",1
"Yoshitsugu Matsuoka",1
"Billy Zane",1
"Jason Riddington",1
"Ervin Nagy",1
"Zoltán Schneider",1
"Géza Morcsányi",1
"Juan Monsalvez",1
"Mike Kopera",1
"Axel Harney",1
"Lou Ferrigno",1
"Christopher Showerman",1
"Ian Lauer",1
"Shahed Ali",1
"Leslie Jordan",1
"George Babluani",1
"Mose Khachvani",1
"Nukri Khachvani",1
"Girshel Chelidze",1
"Timothy Lee DePriest",1
"Rudy Dobrev",1
"William Galatis",1
"Max MacKenzie",1
"Richard Wingert",1
"Jesse Walters",1
"Lehel Salat",1
"László Mátray",1
"András Mészáros",1
"Clifford Bañagale",1
"Lisa Alvillar",1
"Shirô Sano",1
"Ryû Morioka",1
"Shôta Sometani",1
"Daisuke Kuroda",1
"Reiya Masaki",1
"Pietro De Silva",1
"Simon Phillips",1
"Orfeo Orlando",1
"Mario Diodati",1
"Julian Nicholson",1
"Tom Felton",1
"Clive Owen",1
"Justin Deas",1
"Dana Ashbrook",1
"Daniel Roebuck",1
"Jørgen Langhelle",1
"Bjørn Sundquist",1
"Torstein Bjørklund",1
"Michael Stuhlbarg",1
"Armie Hammer",1
"Timothée Chalamet",1
"Ramesh Aravind",1
"Daniel Day-Lewis",1
"Ian Beattie",1
"Matthew Jure",1
"Paul McGuinness",1
"Sam Wilkinson",1
"Thomas Beatty",1
"Will Janowitz",1
"Sathya Sridharan",1
"Francisco Pérez-Bannen",1
"Eliseo Fernández",1
"Andrew Bargsted",1
"Lior Ashkenazi",1
"Branko Djuric",1
"Johnny Alonso",1
"Vincent Young",1
"Christopher Mann",1
"Billy Slaughter",1
"James Moses Black",1
"Jody Mullins",1
"Dave Davis",1
"Saïd Amadis",1
"Slimane Dazi",1
"David Lynch",1
"Harry Dean Stanton",1
"Ron Livingston",1
"César Farrait",1
"Luis A. Lozada Jr.",1
"Drew Fuller",1
"Robin Duran",1
"David Gobble",1
"Rob Walker",1
"Fard Muhammad",1
"Warren Abbott",1
"Jonah Anderson",1
"David Baker",1
"Jonathan Park",1
"Calum Worthy",1
"Jackie Long",1
Aaran,1
"Pavan Malhotra",1
"Diljit Dosanjh",1
"Prithviraj Sukumaran",1
"Sujith Sankar",1
"Aamir Qureshi",1
"Sheheryar Munawar Siddiqui",1
"Adnan Jaffar",1
"D.B. Sweeney",1
"Chris Mulkey",1
Denden,1
"Ik-joon Yang",1
"Masaki Suda",1
"Riku Hagiwara",1
"Michael LaCour",1
"Jeff Haltom",1
"Parker Arnold",1
"Matt Blais",1
"Harjap Singh Bhangal",1
"Gulshan Devaiah",1
"Vikrant Massey",1
"Jesse Hlubik",1
"Nahuel Gorosito",1
"Lior Kolontarov",1
"Luis Santos",1
"Michael Copon",1
"Chris O Flyng",1
"Michael Hill",1
"Fedi Nuril",1
"Tanta Ginting",1
"John Goodman",1
"Jonathan Majors",1
"Ashton Sanders",1
"Mahmud Shalaby",1
"Vicky Ahuja",1
"William Leroy",1
"Rob Franco",1
"Saharsh Kumar Shukla",1
"Michael Beach",1
"Robbie Kay",1
"George Blagden",1
Lishoy,1
"Rony David",1
"Venkatesh Daggubati",1
"Ananth Narayan Mahadevan",1
"Devansh Doshi",1
"Rajesh Gopie",1
"Rory Booth",1
"C. Thomas Howell",1
"Richard T. Jones",1
"T.C. Stallings",1
"Branko Sturbej",1
"Matjaz Tribuson",1
"Andrés Gertrúdix",1
"César Sarachu",1
"Eduardo Rejón",1
"Jordi Mollà",1
"Alessandro Haber",1
"Umberto Orsini",1
"Shun Oguri",1
"Kenneth Desai",1
"Mohit Marwah",1
"Andrew J. West",1
"Adam Astill",1
"Ben Porter",1
"Sandy Batchelor",1
"Sanjay Suri",1
"Anshuman Jha",1
"Sanoop Santhosh",1
"Aamir Khan",1
Meghanadhan,1
"Pranav Mohanlal",1
Sharafudheen,1
"Ahmet Aslan",1
"Jeffery Desalu",1
"Amr Sad",1
"Ahmad Magdy",1
"Singh Bhupesh",1
Madhavan,1
"Óscar Rodríguez",1
"Israel Gómez Romero",1
"Francisco José Gómez Romero",1
"Arvo Kukumägi",1
"Jörgen Liik",1
"Anurag Kashyap",1
"Atharvaa Murali",1
"Mostafa Monwar",1
"Tanvir Ahmed Chowdhury",1
"Mir Mosharrof Hossen",1
"Velislav Pavlov",1
"Philip Boyd",1
"Jim Fitzpatrick",1
Dileep,1
Siddharth,1
Shivarajkumar,1
"Prabhu Mundkur",1
"Madhukar Niyogi",1
"Shiladitya Sen",1
"Rahul Patel",1
"Amal Shah",1
"Govind V. Pai",1
Mooney,1
"Brady Jandreau",1
"Tim Jandreau",1
Karthik,1
Suriya,1
"Marco Ricca",1
"Pedro Nercessian",1
"Joey Lever",1
"Jak Beasley",1
"Wade Keeling",1
"Zachary Levi",1
"Brenton Thwaites",1
"Karan Soni",1
"Martin Klebba",1
"Ari Lehman",1
"Tony Moran",1
"Khalil Ramos",1
"Jameson Blake",1
"Ethan Salvador",1
"Phil LaMarr",1
"Marcus Johns",1
"Pavle Heidler",1
"David Thomas Jenkins",1
"Matt Dallas",1
"Kiowa Gordon",1
"Vladimir Brichta",1
"Augusto Madeira",1
"Richa Meena",1
"Arsh Bajwa",1
"Aleksey Rozin",1
"Matvey Novikov",1
"Juhan Ulfsak",1
"Tambet Tuisk",1
"Helena Maria Reisner",1
"Kunchacko Boban",1
"Prakash Belawadi",1
"Saugat Malla",1
"Karma Shakya",1
"Dayahang Rai",1
"Bipin Karki",1
"Ryûji Akiyama",1
"Gen Hoshino",1
"Rafik Ali Ahmad",1
"Bshara Atallah",1
"Hadi Bou Ayash",1
"Saeed Sheikhzadeh",1
"Nasser Tahmasb",1
"Hossein Erfani",1
Chetan,1
"Aanantharaman Karthik",1
"Arunoday Singh",1
"Jack Anawak",1
"Fred Bailey",1
"Seth Burke",1
"Andrei Ciopec",1
"Laur Dragan",1
"Gabriel Sloyer",1
"Ramon O. Torres",1
"Sheldon Best",1
"Myles Clohessy",1
"Natalia Reyes",1
"José Acosta",1
"Jhon Narváez",1
"António Fonseca",1
"Anthony Alvarez",1
"Manny Perez",1
"Aristides de Sousa",1
"Murilo Caliari",1
"Danny Ashok",1
"Wahab Sheikh",1
"Steven J. Mihaljevich",1
"Caleb Galati",1
"Leonidas Kakouris",1
"Kostas Antoniadis",1
"Christos Batzios",1
"Vasilis Tsikaras",1
"Dimitris Papadopoulos",1
"Kyriakos Chrysidhs",1
"Nick Tag",1
"Cory De Silva",1
"Dexter Masland",1
"Zeph Foster",1
"Dennis Quaid",1
"Trace Adkins",1
"J. Michael Finley",1
"Dean J. West",1
"Aaron Jay Rome",1
"Jaren Mitchell",1
"Astrit Kabashi",1
"Mensur Safqiu",1
"Gurmeet Ram Rahim Singh",1
"Bhushan Insan",1
"Aditya Insan",1
"Antonio Calloni",1
"Ary Fontoura",1
"Marcelo Serrado",1
"Cole Sprouse",1
"Moises Arias",1
"Joseph Vijay",1
"Alan Powell",1
"Garry Nation",1
"Biswanath Basu",1
"Bradley Laborman",1
"Curtis McGann",1
"Logan Marshall-Green",1
"Steve Danielsen",1
"Arjun Mathur",1
"Manav Vij",1
"Abu Hurayra Tanvir",1
"Animesh Aich",1
"Chanchal Chowdhury",1
"Raditya Dika",1
"Phongsiree Bunluewong",1
"Borys Szyc",1
"Tomasz Kot",1
"Jorge Ameer",1
"Matthew Lynn",1
"Cesar DeFuentes",1
"Jackson Antunes",1
"Guile Branco",1
"Gabriel Sater",1
"Mehul Adwani",1
"Wataru Hatano",1
"Makoto Furukawa",1
"Gabriel Yammine",1
"Sam Lahoud",1
"Alex Abbad",1
"Abdurrahman Arif",1
"Agus Nur Amal",1
"Edward Akbar",1
"Biju Menon",1
"Aju Varghese",1
"Deepak Parambol",1
"Tom Gramenz",1
"Isaiah Michalski",1
"Leonard Scheicher",1
"Vijay Chendoor",1
"Danish Sait",1
"Marios Ioannou",1
"Andreas Vasileiou",1
"Heikki Kinnunen",1
"Jani Volanen",1
"Víctor Clavijo",1
"Secun de la Rosa",1
"Enrique Arce",1
"Eric da Silva",1
"Francisco Menezes",1
"Luis Ismael",1
Vishal,1
"John Schneider",1
"Matthew Fahey",1
"Luke Benjamin Bernard",1
"Deepak Rai Panaje",1
"Murat Cemcir",1
"Dogu Demirkol",1
"Ashok Insan",1
"Divya Insan",1
"Ishwar Insan",1
"Amardeep Insan",1
Rajakumaran,1
"John Krasinski",1
"Noah Jupe",1
"James Smith",1
"Andy Rush",1
"James Bloor",1
"Sai Kumar",1
"Ashish Vidyarthi",1
Ganesh,1
"Stunt Silva",1
"Nélson Diniz",1
"Thalles Cabral",1
"Douglas Florence",1
"Mohammad Bakri",1
"Saleh Bakri",1
"Tarik Kopty",1
"Ozan Güven",1
"Özkan Ugur",1
"Cem Yilmaz",1
"André Dussollier",1
Kheiron,1
"Thesingu Rajendar",1
"Bose Venkat",1
"Sôichirô Hoshi",1
"Tetsu Inada",1
"Ryohei Kimura",1
"Yoshimasa Hosoya",1
"Kaito Ishikawa",1
"Kanta Satô",1
"Janusz Gajos",1
"Artur Zmijewski",1
"Jakub Gierszal",1
"Unni Rajan P. Dev",1
"M.S. Bhaskar",1
Bapparaj,1
"Rana Ranbir",1
"Zsolt Kovács",1
"Gábor Reisz",1
"Danny Aiello",1
"John Ashton",1
"Francesco Antonio",1
"Emil Mandanac",1
"Virgil Aioanei",1
"Eduard Adam",1
"Jay Bhatt",1
"Mayur Chauhan",1
"Chetan Daiya",1
"Santhosh Pandit",1
"Saju Navodaya",1
Innocent,1
"Ozan Aksu",1
"Cetin Altindal",1
"Lutfi Alacalar",1
"Chanon Santinatornkul",1
"Antonio de la Torre",1
"Alfonso Tort",1
"César Troncoso",1
"Chino Darín",1
"Pedro Casablanc",1
"Miguel Ángel Muñoz",1
"Nathan Wilson",1
"Jake Arvizo",1
"Jshaun Allen",1
"Jaylon Allen",1
"Akhil Akkineni",1
"Renan Bilek",1
"Onur Dilber",1
"Dorman Borisman",1
"Ben Joshua",1
"Bima Azriel",1
"David Haig",1
"Daniel Radcliffe",1
"Joshua McGuire",1
"Matthew Durkan",1
"Mohamed Abdel Azim",1
"Osama Abdallah",1
"Rady Gamal",1
"Ahmed Abdelhafiz",1
"Mark Arnold",1
"Tarik Akan",1
"Hikmet Çelik",1
"Halil Ergün",1
"Güven Sengil",1
"Necmettin Çobanoglu",1
"James McArdle",1
"Charlie Ian",1
Brahmaji,1
"Richard Neil",1
"Jordi Vilasuso",1
"Alexander Aguila",1
"Isabella Racco",1
"Thomas Kretschmann",1
"Kang-ho Song",1
"Hae-jin Yoo",1
"Jun-yeol Ryu",1
"Wes Ramsey",1
"Max Jenkins",1
"Mark Haldor",1
"Seumas F. Sargent",1
"Scott Turner Schofield",1
"Benjamin Wainwright",1
"Mahendra Bajgai",1
"Amir Gurung",1
"Salon Basnet",1
"Buddhi Tamang",1
"Salin Man Bania",1
"Aleksandr Yatsenko",1
"Maksim Lagashkin",1
"Nikolay Shrayber",1
"Rajesh Tailang",1
"Blake Allan",1
"Dharun Bala",1
"T. Arul Ezhilan",1
"Marudhu Mohan",1
"Mk Mani",1
"Ismail Hakki Ürün",1
"Isa Demlakhi",1
"Motaz Faez Basha",1
"Byung-Hun Lee",1
"Jung-min Park",1
"Akshaye Khanna",1
"Anupam Kher",1
Aadhi,1
"Aaron Altaras",1
"Jürg Plüss",1
"Max Hubacher",1
"Leon Dai",1
"Shao-Huai Chang",1
"Bamboo Chu-Sheng Chen",1
"Cres Chuang",1
"Slamet Rahardjo",1
"Morgan Oey",1
"Josh Hamilton",1
"Jake Ryan",1
Sivakarthikeyan,1
"Chandani Grover",1
"Arya Dave",1
"Erik Heger",1
"Jeremy Holm",1
"Wyatt Ralff",1
"Andrzej Szeremeta",1
"Bartlomiej Topa",1
"Zoran Markovic",1
"Goran Vujovic",1
"Aleksandar Radunovic-Popaj",1
"Veselin Gajovic",1
"Sejdo Alijaj",1
"Ljubo Kalicanin",1
"Rajesh Balachandiran",1
"Gokul Anand",1
"Shiva Keshav",1
"Emcee Jesz",1
Krishnan,1
"Ha-Neul Kang",1
"Seong-kun Mun",1
"Mu-Yeol Kim",1
"Vidyadhar Joshi",1
"Sachin Khedekar",1
"Pradeep Khadka",1
"Shishir Bhandari",1
"Kailash Katuwal",1
"Kumar Karki",1
"Mukta Babu Acharya",1
"Ran Danker",1
"Yaakov Aderet",1
"Osher Amara",1
"Chicco Kurniawan",1
"Faiz Fadhil",1
"Kevin Ardilova",1
"Master Bharath",1
"Miles Dewar",1
"Mahabir Bhullar",1
"Parmish Verma",1
Karanveer,1
"Bojan Zirovic",1
"Mihajlo Milavic",1
"Karl Fischer",1
"Alexander E. Fennon",1
"Massimiliano Tortora",1
"Alessandro Borghi",1
"Jake Busey",1
"Royce Johnson",1
"Aric Coppola",1
"Luca Malacrino",1
"David Kross",1
"Friedrich Mücke",1
"Brian Krause",1
"Dane Rhodes",1
"Jackson Trent",1
"Chris Kozlowski",1
"Gabriel Miller",1
"Lassiter Holmes",1
"Ashok Raj",1
"Madhava Karkada",1
"Ishai Golan",1
"Kamel El Basha",1
"Mohammad Eid",1
"Tae-Hyun Cha",1
"Jung-woo Ha",1
"Ji-Hoon Ju",1
"Hiphop Tamizha Adhi",1
Anbu,1
"Ma ka Pa Anand",1
"Rif Hutton",1
"Taylor Girard",1
"Lynn Andrews III",1
"Evan Myles Horsley",1
Anandraj,1
"Ajmal Ameer",1
Arulnithi,1
Gajaraj,1
Abhinayashree,1
"Rohit Saraf",1
Gurunandan,1
"Jeetu Nepal",1
"Kedar Ghimire",1
"Mahiro Takasugi",1
"Yuma Uchida",1
"Gippy Grewal",1
"Gurcharan Aulakh",1
Bharathiraja,1
" Ganja  Karuppu",1
Krishnamoorthy,1
"Tyler Gallant",1
"Kevin Pollak",1
"David Dastmalchian",1
"Curtis Edward Jackson",1
"Sajin Saleem",1
"Ah-in Yoo",1
"Steven Yeun",1
"A. Galak",1
"Acey Bocey",1
"Wak Doyok",1
"Olgun Toker",1
"Aybars Kartal Özson",1
"Ramazan Dogan",1
"Selim Karakaya",1
"Manoj Joshi",1
"Bhavya Gandhi",1
"Boloram Das",1
"Rômulo Estrela",1
"Julio Machado",1
"Sunil Shetty",1
"Kabir Duhan Singh",1
"Bartu Küçükçaglayan",1
"Tolga Tekin",1
"Hiroaki Hirata",1
"Miyu Irino",1
"Sardar Sohi",1
"Rahul Jungral",1
"Yog Japee",1
"Anson Paul",1
Jayasurya,1
"Saiju Kurup",1
Harikrishnan,1
"Bhagath Baby Manuel",1
"Çetin Tekindor",1
"Erkan Kolçak Köstendil",1
"Berker Güven",1
"Ming Cao",1
"Mingzhi Li",1
"Anders Matthesen",1
"Alfred Bjerre Larsen",1
"Marquis Wood",1
"Adam Stern-Rand",1
"Shane Silman",1
"Mike Amason",1
"Darelle D. Dove",1
"Cheng Cheng",1
"Xiao Cheng",1
"Joy Mathew",1
"Jai Jagdeesh",1
"Bobby Beshro",1
"Emmanuel Bilodeau",1
"Piolo Pascual",1
"Lou Veloso",1
"Joey Marquez",1
"Shant Hovhannisyan",1
"K.S. Maniam",1
"Mohana Raj",1
"Mahesan Poobalan",1
"Emre Altug",1
"Mustafa Dinç",1
"Cemil Agacikoglu",1
Anish,1
"Aditya Alluri",1
Abel,1
"Mahmood Hemaidah",1
"Taner Birsel",1
"Tansu Biçer",1
"Ercan Kesal",1
"Dainius Kazlauskas",1
"Dmitrijus Denisiukas",1
"Darius Bagdziunas",1
"Hrithik Roshan",1
"Virendra Saxena",1
"Chiwetel Ejiofor",1
"Felix Lemburo",1
"Robert Agengo",1
"Maxwell Simba",1
"Cengiz Bozkurt",1
"Baris Arduç",1
"Hakan Kurtas",1
"Kaan Yildirim",1
"Aykut Akdere",1
"Bor Jeng Chen",1
"Te-Sheng Wei",1
"Gilles Lellouche",1
"Kelton Jones",1
"Bora Akkas",1
"Hilmi Cem Intepe",1
"Emanuele Cerman",1
"Alessio Cherubini",1
"Zurab Kavtaradze",1
"Lasha Abuladze",1
"Aleko Abashidze",1
"Ednar Bolkvadze",1
"Ramaz Bolkvadze",1
"Roin Surmanidze",1
"Bhausaheb Shinde",1
"Abhay Chavan",1
"Yogesh Dimble",1
"Erwin Bagindo",1
"Jefri Nichol",1
"Jean Paul Hage",1
"Laeticia Semaan",1
"Shravan Mukesh",1
"Sam Neill",1
"Sullivan Stapleton",1
"Richard Grieco",1
"Shray Rai Tiwari",1
"Zain Khan Durrani",1
"Feridun Düzagaç",1
"Kivanç Tatlitug",1
"Alihan Türkdemir",1
"Guanghui Li",1
"Chen Lu",1
"Metin Yildirim",1
"Ersin Korkut",1
"Alay Cihan",1
"Metin Keçeci",1
"Afrikali Ali",1
"Nicky Evans",1
"Richard Sandling",1
"Adam McNab",1
"Jean-Paul Ly",1
"M.R. Gopakumar",1
"Ali Al-Amri",1
"Goran Markovic",1
"Ravdeep Singh Bajwa",1
"Sivaji Raja",1
"Raj Madiraju",1
"Umut Karadag",1
"Ilker Kizmaz",1
"Cem Uçan",1
"Ahmet Arslan",1
Sashikumar,1
"Daniel Balaji",1
"Vinoth Kishan",1
Ali,1
"Giri Babu",1
"Mohan Babu",1
"Bruno Bitenieks",1
"Endijs Zuks",1
"Alekss Taurins",1
"Sandris Broks",1
"Paul Logan",1
"Kyle Clarke",1
"Mohammad Ahmad",1
"Adnan Malik",1
Vineeth,1
"G.V. Prakash Kumar",1
"Chih-Tian Shih",1
"Jasper Liu",1
"Olivier Bonjour",1
"Maksym Lozynskyj",1
"Gizem Takma",1
"Karan Dave",1
"Aryan Mishra",1
"Andris Keiss",1
"Kaspars Znotins",1
"Igors Selegovskis",1
"Christopher Sabat",1
"Ray Chase",1
"Cezmi Baskin",1
"Sezai Paracikoglu",1
"Ata Berk Mutlu",1
"Ahmet Mümtaz Taylan",1
"Alper Kul",1
"Sarp Apak",1
"Amiel Cayo",1
"Junior Bejar",1
"Mauro Chuchon",1
"Rafael Schmauch",1
"Fabio Gianfrancesco",1
"Marian Meder",1
"Aaron Hilmer",1
"Ernest Prakasa",1
"Refal Hady",1
"Sadhu Kokila",1
"Gabriel Byrne",1
"Alex Wolff",1
"Tobias Moretti",1
"Ulrich Noethen",1
"Tom Gronau",1
"Levi Eisenblätter",1
"Hari Bansha Acharya",1
"Kiran K.C.",1
"Sarath Kumar",1
"Allu Arjun",1
"Dineth De Silva",1
"Sujan Mukherjee",1
"Indrasish Roy",1
"Riddhi Sen",1
"Karra Elejalde",1
"Eduard Fernández",1
"Santi Prego",1
"Shazad Latif",1
"Amir Rahimzadeh",1
"Sad Al-Faraj",1
"Mansoor Alfeeli",1
"Salloum Haddad",1
"Marei Al Halyan",1
Dinesh,1
"Ahmad El-Fishawi",1
"Tarek Lotfy",1
"Ahmed Dawood",1
"Andrew Legatt",1
"Andrew Ringate",1
"Carter Luedtke",1
"Stephen Legatt",1
"Demick Lopes",1
"Yuri Yamamoto",1
"Rafael Martins",1
"Farid Sajjadi Hosseini",1
"Zenn Kyi",1
"Aung Myint Myat",1
"Irrfan Khan",1
Dhananjay,1
"Hiro Shimono",1
"Yûki Kaji",1
"Rosyam Nor",1
"Syamsul Yusof",1
"Fattah Amin",1
Ram,1
Myshkin,1
"Maris Micerevskis",1
"Lauris Klavins",1
"Andris Daugavins",1
"Juris Riekstins",1
"Armands Brakmanis",1
"Janis Plaudis",1
"Rudolfs Putans",1
"Brede Fristad",1
"Aleksander Holmen",1
"Toshio Furukawa",1
"Ryô Horikawa",1
"Takeshi Kusao",1
"Ryûsei Nakao",1
"Kôichi Yamadera",1
"Avery Anthony",1
"Mitchell Edwards",1
Diganth,1
"Ashwin Rao Pallaki",1
"Moammar Rana",1
"Javed Sheikh",1
"Nadeem Baig",1
"Daumantas Ciunis",1
"Arnas Danusas",1
"David Dadunashvili",1
"Aleksandr Buleyko",1
"Gennadiy Egorov",1
"Abrar Qazi",1
"Avinash Tiwary",1
"Sumit Kaul",1
"Corey Kerr",1
"Bram Zwingli",1
"Don Tjernagel",1
"Congxi Li",1
"Yuchang Peng",1
"Yu Zhang",1
Sathyaraj,1
Karthi,1
"Livio Badurina",1
"Igor Samobor",1
"Taylor Gerard Hart",1
"Samuel D. Evans",1
"Prabhu Deva",1
"Ditya Bhande",1
"Satyajit Ganu",1
"Abhimanyu Dasani",1
"Prateek Parmar",1
"Adrian Alandy",1
"James Reid",1
"Jon Lovitz",1
"Eddie Mills",1
"Neal Genys",1
"Varun Tandjung",1
"Ram Pothineni",1
"Yashpal Sharma",1
"Lily Franky",1
"Mayank Agarwal",1
"Anil Bhavnani",1
"Kalpesh Chaudhari",1
"Avinash Baviskar",1
"Ali Atay",1
"Arin Kusaksizoglu",1
"Ji-seob So",1
"Chang-Seok Ko",1
"Yoo-ram Bae",1
"Jun Hyeok Lee",1
"Seo-joon Park",1
"Abhinay Banker",1
"Prashant Barot",1
"Feroz Bhagat",1
"Serkan Kuru",1
"Gökhan Keser",1
"Eren Pekgöz",1
"Erdogan Bilici",1
"Julien Cesario",1
"Matthew Webb",1
"Cheyenne Buchanan",1
"Sezai Aydin",1
"Kivanç Baran Aslan",1
"Ihsan Berk Aydin",1
"Efe Aydin",1
"Anil Dhawan",1
"Manoj Bajpayee",1
"Mithun Chakraborty",1
"Naseeruddin Shah",1
"Amitabh Bachchan",1
"Antonio Aakeel",1
"Anindya Pulak Banerjee",1
"Raajorshi Dey",1
"Nara Rohith",1
"Damien Puckler",1
"Richard Riehle",1
"Lazar Ristovski",1
"Ivan Vujic",1
"Radovan Vujovic",1
"Milan Kolak",1
"Kevin Vechiatto",1
"Gabriel Moreira",1
Ozuna,1
"Shanmugha Rajan",1
Hari,1
Lijeesh,1
"Jett Bryant",1
"Anjan Dutt",1
"Koushik Sen",1
"Alex Kendrick",1
"Ben Davies",1
"Jae-Hyun Choi",1
"Duk-moon Choi",1
"Jae-hong Ahn",1
"Umut Demirdelen",1
"Cansu Sahin",1
"Baris Efe Sepidzi",1
"Pierre Gruno",1
"Yoshi Sudarso",1
"Ted Levine",1
"Sohum Shah",1
"Manuel Tavares Almeida",1
Ventura,1
"Francisco Brito",1
"Yayu A.W. Unru",1
"Alvaro Maldini Siregar",1
"Wafda Saifan Lubis",1
"Vicente Catacora",1
"Batmend Baast",1
"Bazarragchaa Logo",1
"Zain Al Rafeea",1
"Hector Delgado",1
"Jorge Blanco Muñoz",1
"Omar Cruz Soto",1
"Blas Sien Diaz",1
"Ralf Beck",1
"Paresh Rawal",1
"Mohit Raina",1
"Vicky Kaushal",1
"Antonio Banderas",1
"Leonardo Sbaraglia",1
"Asier Etxeandia",1
"Mehmet Sabri Arafatoglu",1
"Selim Aygün",1
"Tahir Ulubayrak",1
"Beyza Metin",1
Vidharth,1
"Ilias Kanchan",1
Raanveer,1
"Paul Sambo",1
"Remilekun Reminisce Safaru",1
"Allari Naresh",1
"Jishu Sengupta",1
"Parambrata Chattopadhyay",1
"Rhys Stone",1
"Kris Hitchen",1
"Jimmy Gerovac",1
"Carl Bailey",1
"John Reign",1
"Paul Worley",1
"James Schultz",1
"Aj Santillo",1
"Aaron Mccrumb",1
"Scott Hoon",1
"Masood Akhtar",1
"Broto Banerjee",1
"Magnus Krepper",1
"Gustav Lindh",1
"Aiden Tetro",1
"Collin Dean",1
"Trey Harrison",1
"Nathan Bonk",1
"Sameer Dharmadhikari",1
"Astad Kale",1
"Michael Socha",1
"Anthony Hopkins",1
"Jonathan Pryce",1
"Sidney Cole",1
"Juan Minujín",1
"Dev Kharoud",1
"Jagjeet Sandhu",1
"Sukhdeep Sukh",1
"Sreenath Bhasi",1
"Soubin Shahir",1
"Roy Chiu",1
"Spark Chen",1
"Joseph Huang",1
"Andrew Hollingworth",1
"Robin Aubert",1
"Yener Gürsoy",1
"Naveen Andrews",1
"Toby Onwumere",1
"Jerry Riccardelli",1
"Michael Grandinetti",1
"Erskin Alysious Alexander",1
"Antwoine Steele",1
"Bobby Westrick",1
"John O Hara",1
"Sushanth Reddy",1
"Vishwaksen Naidu",1
"Venkatesh Kakumanu",1
"Sam Lee",1
"Anthony Chau-Sang Wong",1
"Tauquir Ahmed",1
"Dominic Gomez",1
"Rangga Azof",1
"Mani Haghighi",1
"Eddie Murphy",1
"Mike Epps",1
"Craig Robinson",1
"Keegan-Michael Key",1
Chanti,1
Bhadram,1
"Chammak Chandra",1
"Hyper Aadi",1
"Jason Skeen",1
"Alexander Kane",1
"James Eliya",1
Subbaraju,1
"Santosh Shoban",1
"Robert Capelli Jr.",1
"Clark Carmichael",1
"Johnny Calabro",1
"Daniel Hiu Tung Chan",1
"Andy Bian",1
"Kurt Chou",1
"Muji Hsu",1
"Gérard Rudolf",1
"Hannes Otto",1
"Germandt Geldenhuys",1
"Schalk Bezuidenhout",1
"Alvin Wong",1
"Remy Ishak",1
"Azrel Ismail",1
Mahendra,1
"Ramesh Bhat",1
"Lalit Prabhakar",1
"Kevin Alain",1
"Ryan Quinn Adams",1
"Havon Baraka",1
"Sarjano Khalid",1
"Arjun Asokan",1
"Bartosz Bielenia",1
"Satyadev Kancharana",1
"Bill Wise",1
"Kelvin Harrison Jr.",1
"Vincent Cassel",1
"Bryan Mialoundama",1
"Reda Kateb",1
"Golan Azulai",1
"Yaacov Cohen",1
"Shuli Rand",1
"Nagarjuna Akkineni",1
"Mandeep Mani",1
"Ramesh Adithya",1
Ramki,1
"Kartikeya Gummakonda",1
"Thai Hoa",1
Gowtham,1
"Shanthi Anand",1
"Sabumon Abdusamad",1
"Antony Varghese",1
"Atul Kulkarni",1
"Jacek Braciak",1
"Robert Wieckiewicz",1
"Sarabjit Cheema",1
Awie,1
"Arab Khalid",1
"Ropie Cecupak",1
"Emile Hirsch",1
"Rehan Jani",1
"Payal Rajput",1
"Adinda Azani",1
"Umay Shahab",1
"Arbani Yazis",1
"Taner Barlas",1
"Seçkin Özdemir",1
"Berat Efe Parlar",1
"Sefa Kindir",1
"Mami Emen",1
"Emre Gül",1
"Firat Kaymak",1
"Taner Cindoruk",1
"Martin Pierre",1
"Jabari Hollis",1
"Ryan J. Lewis",1
"Joem Bascon",1
"Ario Bayu",1
Isaac,1
"Phuong Minh",1
"Perlene Bhersaina",1
"Jackky Bhagnani",1
"Moh d Nagi",1
"Qassem Rashad",1
"Khaled Hamdan",1
"Om Ahire",1
"Rohit Aryan",1
"Parth Bhalerao",1
"Muhammad Khan",1
"Raditya Evandra",1
Rianto,1
"T. Rifnu Wikana",1
"Jue Zhang",1
"Yue Zhang",1
"Sen Yang",1
"Ran Zhang",1
"Oka Antara",1
"Verdi Solaiman",1
"Rio Dewanto",1
"Chicco Jerikho",1
"Levan Gelbakhiani",1
"Bachi Valishvili",1
"Giorgi Tsereteli",1
"Mahesh Bhatt",1
Avii,1
Irfanouzzaman,1
"Doskhan Zholzhaksynov",1
"Kayrat Kemalo",1
"Nopachai Jayanama",1
"Jared Lotz",1
"Brooks Ryan",1
"Ian McKellen",1
"Danny Webb",1
"Károly Hajduk",1
"Barnabás Horkay",1
"Andreas Wimberger",1
"Gaurav Kakkar",1
"Chandan Gill",1
"Anoop Karir",1
"Derrick Monasterio",1
"Juancho Trivino",1
"Vijay Antony",1
"Serban Pavlu",1
"Steve Blum",1
"Fikret Kuskan",1
"Ekin Koç",1
"Mikaal Zulfiqar",1
"Hassan Niazi",1
"Bartu Bedirhan",1
"Emrah Akyüz",1
"Armagan Baysal",1
"Emin Gümüskaya",1
"Vasay Chaudhry",1
"Adeel Hashmi",1
"Shafaat Ali",1
"Sai Dharam Tej",1
"Sanjay Kapoor",1
"Joy Badlani",1
"Nikhil Gowda",1
Ninja,1
"Sergey Lefor",1
"Oleg Oneshchak",1
"Yulia Chepurko",1
"Oleg Shulga",1
"Prasenjit Chatterjee",1
"Subhomoy Chatterjee",1
"Dulal Lahiri",1
"Subhasish Mukherjee",1
"Shaheizy Sam",1
"Eric Febrian",1
"Daniel Mananta",1
"Denny Sumargo",1
"Aram Arami",1
"Mehmet Atesci",1
"Raj Bhansali",1
"Jacob Tyler",1
"Thomas Carr",1
"Robert Annus",1
"Marvin Inno",1
Niranjan,1
"Ahmed Hashimi",1
"Habib Ghuloom",1
"Kaiji Tang",1
"Matthew Moy",1
"Vincent Rodriguez III",1
"Om Bhutkar",1
"Sunil Abhyankar",1
"Kshitish Date",1
"Dipti Dhotre",1
"R.J. Hemant",1
Raffi,1
"Adam Devine",1
"Ron Funches",1
"Vikram Bhatt",1
"Ameet Chana",1
"Shivam Bhaargava",1
"Aritra Sengupta",1
"Arindra Rai Chaudhuri",1
"Sukhwinder Chahal",1
"Nenad Nacev",1
"Andrey Chernyshov",1
"Oleg Fomin",1
"Vladimir Epifantsev",1
"Müfit Kayacan",1
"Javed Jaffrey",1
"Akhtem Seitablaev",1
"Remzi Bilyalov",1
"Viktor Zhdanov",1
"Jaffer Idukki",1
"Thomas Freeley",1
"Jacob Whiteshed",1
"Melih Selcuk",1
"Ari Irham",1
"Calvin Jeremy",1
"Bektas Erdogan",1
"Burçin Bildik",1
"Mevlut Acaroglu",1
"Siddharth Randeria",1
"Yash Soni",1
"Bhavik Bhojak",1
Anand,1
"Naveen Neni",1
Upendra,1
"Stanley Townsend",1
"Julian Ovenden",1
"Rhashan Stone",1
"Ankur Vikal",1
"Rangaraj Pandey",1
"Pratap Saurabh",1
"Preetyka Chauhan",1
"Pradeep Sharma",1
"Aloknath Pathak",1
"Aarav Mavi",1
"Tihomir Stanic",1
"Igor Djordjevic",1
"James Cosmo",1
"Eddie Izzard",1
"Kevin Guthrie",1
"Naphat Siangsomboon",1
"Jason Young",1
"Benjamin Joseph Varney",1
"Rahul Ramakrishna",1
"Buzz Aldrin",1
"Gaston Re",1
"Alfonso Barón",1
"Payman Maadi",1
"Mikey Averill",1
"Josh Bash",1
"Jordan Abbe",1
"Jim Averill",1
"Andrei Indreies",1
"Jean-Baptiste Heuet",1
"Cedric Henquez",1
"Cedric Maturana",1
"Jose Atuncar",1
"Claudine Bertin",1
"Mohd Amir Asyraf Bin Mohd Noor Rashid",1
"Irfan Fahim Bin Mohd Irman",1
"Ahmad Mawardi Bin Abdul Rahman",1
"Vimal Krishna",1
 */

/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

select production_company, total_votes as vote_count,rank() over (order by total_votes desc) as prod_comp_rank
from movie as m 
join ratings as r 
on m.id=r.movie_id
group by production_company
limit 3;

/* Answer_21
production_company,vote_count,prod_comp_rank
"Marvel Studios",551245,1
Syncopy,487517,2
"New Line Cinema",408221,3

 */

/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
with indian_actor_rank as
(
select n.name as actor_name,
		sum( total_votes) as total_votes, 
		count(r.movie_id) as movie_count, 	
        round(sum(avg_rating*total_votes)/sum(total_votes),2) as actor_avg_rating
from movie as  m
join ratings as r 
on m.id=r.movie_id
join role_mapping as rm 
on m.id=rm.movie_id
join names as n
on rm.name_id=n.id
where country like 'India' and category ='actor'
group by name
)
select * , 	rank() over (order by actor_avg_rating desc,total_votes desc) as actor_rank
from indian_actor_rank
where movie_count>=5;

/* Answer_22
name,total_votes,movie_count,actor_avg_rating,actor_rank
"Vijay Sethupathi",23114,5,8.42,1
"Fahadh Faasil",13557,5,7.99,2
"Yogi Babu",8500,11,7.83,3
"Joju George",3926,5,7.58,4
"Ammy Virk",2504,6,7.55,5
"Dileesh Pothan",6235,5,7.52,6
"Kunchacko Boban",5628,6,7.48,7
"Pankaj Tripathi",40728,5,7.44,8
"Rajkummar Rao",42560,6,7.37,9
"Dulquer Salmaan",17666,5,7.30,10
"Amit Sadh",13355,5,7.21,11
"Tovino Thomas",11596,8,7.15,12
Mammootty,12613,8,7.04,13
Nassar,4016,5,7.03,14
"Karamjit Anmol",1970,6,6.91,15
"Hareesh Kanaran",3196,5,6.58,16
"Naseeruddin Shah",12604,5,6.54,17
Anandraj,2750,6,6.54,18
Mohanlal,17244,6,6.51,19
Siddique,5953,7,6.43,20
"Aju Varghese",2237,5,6.43,21
"Prakash Raj",8548,6,6.37,22
"Jimmy Sheirgill",3826,6,6.29,23
"Mahesh Achanta",2716,6,6.21,24
"Biju Menon",1916,5,6.21,25
"Suraj Venjaramoodu",4284,6,6.19,26
"Abir Chatterjee",1413,5,5.80,27
"Sunny Deol",4594,5,5.71,28
"Radha Ravi",1483,5,5.70,29
"Prabhu Deva",2044,5,5.68,30

 */

-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
with hindi_actress_rank as
(
select n.name as actress_name,
		sum( total_votes) as total_votes, 
		count(r.movie_id) as movie_count, 	
        round(sum(avg_rating*total_votes)/sum(total_votes),2) as actress_avg_rating
from movie as  m
join ratings as r 
on m.id=r.movie_id
join role_mapping as rm 
on m.id=rm.movie_id
join names as n
on rm.name_id=n.id
where country like 'India' and category ='actress' and languages='hindi'
group by name
)
select * , 	rank() over (order by actress_avg_rating desc,total_votes desc) as actress_rank
from hindi_actress_rank
where movie_count>=3;

/* Answer_23
name,total_votes,movie_count,actress_avg_rating,actress_rank
"Taapsee Pannu",18061,3,7.74,1
"Divya Dutta",8579,3,6.88,2
"Kriti Kharbanda",2549,3,4.80,3
"Sonakshi Sinha",4025,4,4.18,4
 */


/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:
select title,
case when avg_rating>8 then 'superhit movie' 
when avg_rating>7 then 'hit movie'
when avg_rating >5 then 'one-time-watch movie' 
else 'flop movie'
end as movie_category
from movie as m 
join genre as g
on m.id=g.movie_id
join ratings as r 
on m.id=r.movie_id
where genre ='thriller';


/* 
title,movie_category
"Der müde Tod","hit movie"
"Fahrenheit 451","flop movie"
"Pet Sematary","one-time-watch movie"
Dukun,"one-time-watch movie"
"Back Roads","one-time-watch movie"
Countdown,"one-time-watch movie"
"Staged Killer","flop movie"
Vellaipookal,"hit movie"
"Uriyadi 2","hit movie"
Incitement,"hit movie"
Rakshasudu,"superhit movie"
"Trois jours et une vie","one-time-watch movie"
"Killer in Law","one-time-watch movie"
Kalki,"hit movie"
Milliard,"flop movie"
"Vinci Da","hit movie"
"Gunned Down","one-time-watch movie"
"Deviant Love","flop movie"
Storozh,"one-time-watch movie"
"Sivappu Manjal Pachai","hit movie"
Magamuni,"superhit movie"
"Hometown Killer","one-time-watch movie"
ECCO,"flop movie"
Baaji,"hit movie"
Kasablanka,"one-time-watch movie"
"Annabellum: The Curse of Salem","flop movie"
"Zuo jia de huang yan: Bi zhong you zui","one-time-watch movie"
Evaru,"superhit movie"
Saja,"one-time-watch movie"
Jiivi,"hit movie"
"Ai-naki Mori de Sakebe","one-time-watch movie"
"Ne Zha zhi mo tong jiang shi","hit movie"
"Bornoporichoy: A Grammar Of Death","one-time-watch movie"
"Ratu Ilmu Hitam","hit movie"
"Barot House","hit movie"
"La llorona","hit movie"
Tekst,"one-time-watch movie"
Byeonshin,"one-time-watch movie"
Fanxiao,"hit movie"
"The Belko Experiment","one-time-watch movie"
Safe,"superhit movie"
Chanakya,"one-time-watch movie"
"Raju Gari Gadhi 3","superhit movie"
Shapludu,"hit movie"
2:22,"one-time-watch movie"
"Rambo: Last Blood","one-time-watch movie"
Retina,"one-time-watch movie"
"Caller ID","flop movie"
"I See You","flop movie"
Venom,"one-time-watch movie"
"London Fields","flop movie"
"xXx: Return of Xander Cage","one-time-watch movie"
"Infection: The Invasion Begins","flop movie"
Truth,"hit movie"
Kidnap,"one-time-watch movie"
Mute,"one-time-watch movie"
Halloween,"one-time-watch movie"
"Voice from the Stone","one-time-watch movie"
"Simple Creature","flop movie"
"The Commuter","one-time-watch movie"
"The Foreigner","one-time-watch movie"
"Scary Story Slumber Party","flop movie"
Jasmine,"one-time-watch movie"
"The Entitled","one-time-watch movie"
"Message from the King","one-time-watch movie"
"59 Seconds","hit movie"
Trafficked,"one-time-watch movie"
Identical,"flop movie"
"Art of Deception","flop movie"
Mara,"one-time-watch movie"
"Teenage Cocktail","one-time-watch movie"
"Catskill Park","flop movie"
Seberg,"one-time-watch movie"
"An Ordinary Man","one-time-watch movie"
"Operation Ragnarök","flop movie"
Demonic,"one-time-watch movie"
"Hunter Killer","one-time-watch movie"
Insomnium,"one-time-watch movie"
"7 Splinters in Time","flop movie"
Brimstone,"hit movie"
"True Crimes","one-time-watch movie"
Overdrive,"one-time-watch movie"
"Amityville: The Awakening","flop movie"
"American Assassin","one-time-watch movie"
"City of Tiny Lights","one-time-watch movie"
"Beyond White Space","flop movie"
Geostorm,"one-time-watch movie"
Whispers,"flop movie"
"Would You Rather","one-time-watch movie"
"Nobel Chor","one-time-watch movie"
"The Outsider","one-time-watch movie"
Redcon-1,"flop movie"
"Never Here","flop movie"
"The Unseen","flop movie"
"Sanctuary; Quite a Conundrum","one-time-watch movie"
Delirium,"one-time-watch movie"
Sleepless,"one-time-watch movie"
"This Is Your Death","one-time-watch movie"
"Black Butterfly","one-time-watch movie"
"The Garlock Incident","flop movie"
Arizona,"one-time-watch movie"
Found,"one-time-watch movie"
"Nightmare Box","flop movie"
"I Still See You","one-time-watch movie"
"A Life Not to Follow","hit movie"
"A Patch of Fog","one-time-watch movie"
"The Elevator: Three Minutes Can Change Your Life","flop movie"
Bent,"one-time-watch movie"
"The Forgiven","one-time-watch movie"
"Dark Cove","one-time-watch movie"
"100 Ghost Street: The Return of Richard Speck","flop movie"
"Gali Guleiyan","hit movie"
Inspiration,"hit movie"
"Lost Angelas","superhit movie"
"Alien: Covenant","one-time-watch movie"
"Bottom of the World","one-time-watch movie"
"Gas Light","flop movie"
"Five Fingers for Marseilles","one-time-watch movie"
"Atomic Blonde","one-time-watch movie"
"The Forbidden Dimensions","flop movie"
"The Guest House","flop movie"
"The Ghost and The Whale","flop movie"
"Primrose Lane","flop movie"
"Deep Burial","flop movie"
"The Church","flop movie"
"The Answer","flop movie"
"Division 19","one-time-watch movie"
"Point Blank","one-time-watch movie"
Needlestick,"flop movie"
"Keep Watching","flop movie"
Blowtorch,"flop movie"
Skybound,"one-time-watch movie"
"Krampus: The Christmas Devil","flop movie"
"Sweet Virginia","one-time-watch movie"
Caretakers,"hit movie"
"The Big Take","one-time-watch movie"
Leatherface,"flop movie"
"The Ascent","one-time-watch movie"
Greta,"one-time-watch movie"
"Vishwaroopam 2","one-time-watch movie"
Displacement,"flop movie"
"The Harrowing","flop movie"
Angelica,"flop movie"
Dassehra,"flop movie"
"Circus of the Dead","one-time-watch movie"
"Message Man","one-time-watch movie"
"Ascent to Hell","flop movie"
"Mississippi Murder","flop movie"
"Strange But True","one-time-watch movie"
"Red Sparrow","one-time-watch movie"
"Higher Power","one-time-watch movie"
"The Snare","flop movie"
Money,"one-time-watch movie"
"The Circle","one-time-watch movie"
"Corbin Nash","one-time-watch movie"
"Wild for the Night","flop movie"
Alcoholist,"flop movie"
Voyoucratie,"one-time-watch movie"
"Cruel Summer","one-time-watch movie"
"The Man Who Was Thursday","flop movie"
"Two Down","hit movie"
"Where the Devil Dwells","flop movie"
Stockholm,"flop movie"
"Beacon Point","one-time-watch movie"
Delirium,"flop movie"
"The Perfect Host: A Southern Gothic Tale","flop movie"
Convergence,"flop movie"
"Capps Crossing","flop movie"
"Billy Boy","flop movie"
"The Birdcatcher","flop movie"
"5th Passenger","flop movie"
"A Violent Separation","one-time-watch movie"
"Be My Cat: A Film for Anne","one-time-watch movie"
Verónica,"one-time-watch movie"
"Call of the Wolf","one-time-watch movie"
Neckan,"one-time-watch movie"
"Bad Samaritan","one-time-watch movie"
"The Dinner","flop movie"
"Among Us","flop movie"
"Valley of the Sasquatch","flop movie"
"Anabolic Life","one-time-watch movie"
"As Worlds Collide","hit movie"
Domino,"flop movie"
Benzin,"one-time-watch movie"
"Asylum of Fear","flop movie"
"The Autopsy of Jane Doe","one-time-watch movie"
"Mientras el Lobo No Está","hit movie"
HHhH,"one-time-watch movie"
"Jekyll Island","flop movie"
"Den 12. mann","hit movie"
"The Hollow One","flop movie"
"Be Afraid","flop movie"
Accident,"flop movie"
"White Orchid","one-time-watch movie"
"Above Ground","flop movie"
"Burning Kiss","flop movie"
Slender,"flop movie"
Diverge,"flop movie"
"No Way to Live","one-time-watch movie"
Jigsaw,"one-time-watch movie"
"Bad Kids of Crestview Academy","one-time-watch movie"
"Bad Frank","flop movie"
"Scary Stories to Tell in the Dark","one-time-watch movie"
"Xian yi ren X de xian shen","one-time-watch movie"
"Puriyaadha Pudhir","one-time-watch movie"
"Adios Vaya Con Dios","superhit movie"
Painless,"one-time-watch movie"
Rabbit,"one-time-watch movie"
"A Place in Hell","flop movie"
"One Less God","one-time-watch movie"
"Land of Smiles","flop movie"
Havenhurst,"flop movie"
Grinder,"flop movie"
"Land of the Little People","one-time-watch movie"
"Investigation 13","flop movie"
"Deadly Sanctuary","flop movie"
Abduct,"flop movie"
"The Drownsman","flop movie"
"Damascus Cover","one-time-watch movie"
Unforgettable,"one-time-watch movie"
Inconceivable,"one-time-watch movie"
Relentless,"flop movie"
"Your Move","flop movie"
Security,"one-time-watch movie"
"Furthest Witness","flop movie"
"Welcome to Curiosity","one-time-watch movie"
"The Ballerina","flop movie"
"The Lighthouse","one-time-watch movie"
"The Tank","flop movie"
Haunted,"flop movie"
Retribution,"one-time-watch movie"
Submergence,"one-time-watch movie"
"Arise from Darkness","hit movie"
Stratton,"flop movie"
"She Who Must Burn","flop movie"
"The Dark Below","flop movie"
"Us and Them","one-time-watch movie"
"Bad Girl","one-time-watch movie"
"Bank Chor","one-time-watch movie"
"The Ghoul","one-time-watch movie"
"Tell Me Your Name","flop movie"
Candiland,"flop movie"
MindGamers,"flop movie"
"The Inherited","flop movie"
"Glass Jaw","hit movie"
"Body of Deceit","flop movie"
"Creep 2","one-time-watch movie"
Madtown,"one-time-watch movie"
"Beyond the Sky","one-time-watch movie"
Eloise,"flop movie"
"The Harvesting","flop movie"
"Vincent N Roxxy","one-time-watch movie"
"Face of Evil","flop movie"
Quarries,"flop movie"
"The Last Witness","one-time-watch movie"
Elle,"hit movie"
"The Wicked One","flop movie"
"Cuando los ángeles duermen","one-time-watch movie"
"I Before Thee","flop movie"
Besetment,"flop movie"
Recall,"flop movie"
Jungle,"one-time-watch movie"
"Blood Money","flop movie"
Ladyworld,"flop movie"
"The Evil Inside Her","flop movie"
"The Equalizer 2","one-time-watch movie"
"Body Keepers","flop movie"
"Dead Awake","flop movie"
"The Grinn","flop movie"
"House of Afflictions","flop movie"
Clowntergeist,"flop movie"
"Against the Clock","flop movie"
"Hank Boyd Is Dead","flop movie"
Slasher.com,"flop movie"
"Blood Stripe","one-time-watch movie"
"Infinity Chamber","one-time-watch movie"
Viktorville,"one-time-watch movie"
"Dangerous Company","flop movie"
"Strangers Within","flop movie"
"Dark Beacon","one-time-watch movie"
Seeds,"flop movie"
"Hounds of Love","one-time-watch movie"
Savageland,"one-time-watch movie"
"We Go On","one-time-watch movie"
"The Neighbor","one-time-watch movie"
"Deadly Crush","one-time-watch movie"
"Hell of a Night","flop movie"
"The Nth Ward","flop movie"
Ánimas,"flop movie"
Hebbuli,"hit movie"
"House by the Lake","flop movie"
Legionario,"one-time-watch movie"
"Level 16","one-time-watch movie"
"Lost Solace","flop movie"
"The Tale","hit movie"
Braxton,"flop movie"
Ah-ga-ssi,"superhit movie"
"The Honor Farm","flop movie"
"The Man in the Wall","one-time-watch movie"
Lycan,"one-time-watch movie"
"Cut to the Chase","flop movie"
"Ultimate Justice","flop movie"
"Blood Bound","flop movie"
"I Spit on Your Grave: Deja Vu","flop movie"
"The Nightingale","hit movie"
Monochrome,"flop movie"
"In Extremis","flop movie"
"Dark Sense","flop movie"
"O Rastro","one-time-watch movie"
Alterscape,"one-time-watch movie"
Darling,"one-time-watch movie"
"Demon House","one-time-watch movie"
"But Deliver Us from Evil","flop movie"
"The Tracker","flop movie"
Replicas,"one-time-watch movie"
Boar,"one-time-watch movie"
"Live Cargo","flop movie"
Restraint,"flop movie"
"The Redeeming","flop movie"
"A Room to Die For","flop movie"
"Valley of Bones","flop movie"
"The Crucifixion","one-time-watch movie"
Sleepwalker,"one-time-watch movie"
"Norman: The Moderate Rise and Tragic Fall of a New York Fixer","one-time-watch movie"
"Del Playa","flop movie"
"Chimera Strain","one-time-watch movie"
"We Are Monsters","flop movie"
Widows,"one-time-watch movie"
"The Wall","one-time-watch movie"
Inhumane,"flop movie"
"Virus of the Dead","flop movie"
Wrecker,"flop movie"
"Tangent Room","flop movie"
Bloodlands,"one-time-watch movie"
"La nuit a dévoré le monde","one-time-watch movie"
Sum1,"flop movie"
Terrifier,"one-time-watch movie"
"Broken Star","flop movie"
"The Circle","one-time-watch movie"
"Mirror Game","one-time-watch movie"
"The Evangelist","one-time-watch movie"
"Sugar Daddies","flop movie"
Fractured,"one-time-watch movie"
"Bonded by Blood 2","one-time-watch movie"
"My Birthday Song","one-time-watch movie"
"3 Lives","flop movie"
Tau,"one-time-watch movie"
Blackmark,"flop movie"
"The Man in the Shadows","flop movie"
"Ghost House","flop movie"
"Hide in the Light","flop movie"
"Blood Vow","one-time-watch movie"
Detour,"one-time-watch movie"
"Los Angeles Overnight","one-time-watch movie"
Enclosure,"flop movie"
"Rock, Paper, Scissors","flop movie"
"Lies We Tell","flop movie"
"7 Witches","flop movie"
"John Wick: Chapter 2","hit movie"
Innuendo,"one-time-watch movie"
Aux,"flop movie"
Desolation,"one-time-watch movie"
"The Playground","flop movie"
"The Marker","one-time-watch movie"
Terminal,"one-time-watch movie"
Bodysnatch,"flop movie"
"Fifty Shades Freed","flop movie"
"My Pure Land","one-time-watch movie"
"Cyber Case","flop movie"
"Gehenna: Where Death Lives","flop movie"
"Maze Runner: The Death Cure","one-time-watch movie"
"The Prodigy","one-time-watch movie"
"The Wasting","flop movie"
"Check Point","flop movie"
Defective,"flop movie"
"Robin Hood","one-time-watch movie"
"Zhui bu","one-time-watch movie"
"Miss Sloane","hit movie"
"Project Eden: Vol. I","flop movie"
"I Kill Giants","one-time-watch movie"
Altitude,"flop movie"
"Armed Response","flop movie"
"Mile 22","one-time-watch movie"
"The Haunted","flop movie"
"The Book of Henry","one-time-watch movie"
"Beneath the Leaves","flop movie"
"2036 Origin Unknown","flop movie"
Rupture,"flop movie"
"The Witch Files","flop movie"
Aftermath,"one-time-watch movie"
"The Body Tree","flop movie"
Darc,"one-time-watch movie"
Haze,"one-time-watch movie"
Paralytic,"flop movie"
"The Fate of the Furious","one-time-watch movie"
"Bloody Crayons","one-time-watch movie"
"Shot Caller","hit movie"
Braid,"one-time-watch movie"
"Night Pulse","flop movie"
"Razbudi menya","one-time-watch movie"
Drifter,"flop movie"
"The Broken Key","flop movie"
Beirut,"one-time-watch movie"
"The Sound","flop movie"
"Wolves at the Door","flop movie"
"American Fable","one-time-watch movie"
Woodshock,"flop movie"
"Dark Iris","flop movie"
Lavender,"one-time-watch movie"
Josie,"one-time-watch movie"
"1 Buck","one-time-watch movie"
Discarnate,"flop movie"
"In the Tall Grass","one-time-watch movie"
Parasites,"flop movie"
Shuddhi,"superhit movie"
Gurgaon,"one-time-watch movie"
"El Complot Mongol","one-time-watch movie"
"Mountain Fever","flop movie"
Monolith,"flop movie"
"Cold November","flop movie"
Money,"one-time-watch movie"
Curvature,"flop movie"
"Killing Ground","one-time-watch movie"
Fantasma,"flop movie"
"The Limehouse Golem","one-time-watch movie"
CTRL,"flop movie"
"Unfriended: Dark Web","one-time-watch movie"
"200 Degrees","flop movie"
"The Summoning","flop movie"
Negative,"flop movie"
"Fighting the Sky","flop movie"
"Central Park","flop movie"
Unhinged,"flop movie"
Larceny,"flop movie"
Countrycide,"flop movie"
"Rough Night","one-time-watch movie"
"Ruin Me","one-time-watch movie"
Lens,"one-time-watch movie"
"Bang jia zhe","one-time-watch movie"
Armed,"flop movie"
"The Parts You Lose","one-time-watch movie"
"Hush Money","one-time-watch movie"
"Together For Ever","one-time-watch movie"
"Black Wake","flop movie"
"Good Time","hit movie"
"Buckout Road","flop movie"
Contratiempo,"superhit movie"
"Rapid Eye Movement","flop movie"
"The Holly Kane Experiment","one-time-watch movie"
"Hollow in the Land","one-time-watch movie"
"Mind and Machine","flop movie"
"Most Beautiful Island","one-time-watch movie"
"Out of the Shadows","flop movie"
"Ridge Runners","flop movie"
"Die, My Dear","one-time-watch movie"
"The Spearhead Effect","flop movie"
"Strip Club Massacre","one-time-watch movie"
"Death Pool","flop movie"
Digbhayam,"superhit movie"
Baadshaho,"flop movie"
Lyst,"flop movie"
"Mission: Impossible - Fallout","hit movie"
"The Curse of La Llorona","one-time-watch movie"
9/11,"flop movie"
Parallel,"one-time-watch movie"
"El guardián invisible","one-time-watch movie"
"Tomato Red","one-time-watch movie"
"Las tinieblas","one-time-watch movie"
"The Worthy","one-time-watch movie"
"Demonios tus ojos","one-time-watch movie"
Fixeur,"one-time-watch movie"
"From a House on Willow Street","flop movie"
"Awaken the Shadowman","flop movie"
Rondo,"flop movie"
Axis,"flop movie"
Split,"hit movie"
"Zombies Have Fallen","one-time-watch movie"
"A martfüi rém","one-time-watch movie"
"Daas Dev","one-time-watch movie"
Unwritten,"flop movie"
"They Remain","flop movie"
"Life in the Hole","one-time-watch movie"
"Operation Brothers","one-time-watch movie"
Presumed,"flop movie"
Cage,"flop movie"
"Breakdown Forest - Reise in den Abgrund","hit movie"
Residue,"one-time-watch movie"
Prodigy,"one-time-watch movie"
Goodland,"one-time-watch movie"
"Kings Bay","one-time-watch movie"
"American Gothic","flop movie"
"Soul to Keep","flop movie"
Fare,"flop movie"
"Trench 11","one-time-watch movie"
Incontrol,"flop movie"
"The Assignment","flop movie"
Dismissed,"one-time-watch movie"
"Last Seen in Idaho","one-time-watch movie"
Muse,"one-time-watch movie"
Desolation,"flop movie"
Nereus,"flop movie"
"Get Out","hit movie"
"The Village in the Woods","one-time-watch movie"
"Body of Sin","flop movie"
"Easy Living","flop movie"
"Altered Hours","flop movie"
Transfert,"hit movie"
"The Butler","hit movie"
"The Isle","one-time-watch movie"
"Kundschafter des Friedens","one-time-watch movie"
"El ataúd de cristal","one-time-watch movie"
Luna,"one-time-watch movie"
"Jasper Jones","one-time-watch movie"
"O lyubvi","one-time-watch movie"
M.F.A.,"one-time-watch movie"
"Beneath Us","one-time-watch movie"
"Ghost Note","one-time-watch movie"
Noctem,"flop movie"
"Khaneye dokhtar","one-time-watch movie"
"Warning Shot","one-time-watch movie"
"Coyote Lake","flop movie"
"Perfect sãnãtos","flop movie"
"Red Christmas","flop movie"
"El bar","one-time-watch movie"
"O Animal Cordial","one-time-watch movie"
Ira,"one-time-watch movie"
Lover,"one-time-watch movie"
"Annabelle: Creation","one-time-watch movie"
"12 Feet Deep","one-time-watch movie"
Liebmann,"one-time-watch movie"
Illicit,"flop movie"
Shortwave,"flop movie"
Nightworld,"flop movie"
Nibunan,"one-time-watch movie"
"Escape Room","flop movie"
"Mean Dreams","one-time-watch movie"
"In Darkness","one-time-watch movie"
"Another Soul","flop movie"
"The Chamber","flop movie"
Inside,"one-time-watch movie"
"Billionaire Boys Club","one-time-watch movie"
Forushande,"hit movie"
"Beach House","one-time-watch movie"
"The Mason Brothers","one-time-watch movie"
Ravenswood,"one-time-watch movie"
Volt,"one-time-watch movie"
"Juzni vetar","superhit movie"
"Pray for Rain","one-time-watch movie"
Rosy,"flop movie"
"3 ting","one-time-watch movie"
"The Rake","flop movie"
"Intensive Care","flop movie"
Despair,"hit movie"
Assimilate,"one-time-watch movie"
"Final Score","one-time-watch movie"
B&B,"one-time-watch movie"
Enigma,"superhit movie"
Chappaquiddick,"one-time-watch movie"
"The Terrible Two","flop movie"
"Berlin Falling","one-time-watch movie"
"Immigration Game","flop movie"
Videomannen,"one-time-watch movie"
"Le serpent aux mille coupures","one-time-watch movie"
"The Standoff at Sparrow Creek","one-time-watch movie"
"Happy Death Day","one-time-watch movie"
"Is This Now","hit movie"
Close,"one-time-watch movie"
"Singam 3","one-time-watch movie"
"Hate Story IV","flop movie"
Pirmdzimtais,"one-time-watch movie"
Kaygi,"one-time-watch movie"
Ryde,"one-time-watch movie"
"The Wolf Hour","flop movie"
"The Child Remains","flop movie"
"A Young Man with High Potential","one-time-watch movie"
"The Hatton Garden Job","one-time-watch movie"
Drone,"one-time-watch movie"
"The Midnight Man","flop movie"
Magellan,"one-time-watch movie"
Callback,"one-time-watch movie"
"The Job","one-time-watch movie"
"The Martyr Maker","flop movie"
"Gatta Cenerentola","one-time-watch movie"
Tilt,"flop movie"
Life,"one-time-watch movie"
"24 Hours to Live","one-time-watch movie"
"American Satan","one-time-watch movie"
"The Men","one-time-watch movie"
Trendy,"one-time-watch movie"
"Zona hostil","one-time-watch movie"
"Blood Child","hit movie"
"Break-Up Nightmare","flop movie"
Kaabil,"hit movie"
Corporate,"one-time-watch movie"
"Hotel Mumbai","hit movie"
"Mom and Dad","one-time-watch movie"
"Kill Switch","flop movie"
"Havana Darkness","flop movie"
"Contract to Kill","flop movie"
Dagenham,"flop movie"
Vargur,"one-time-watch movie"
Shattered,"one-time-watch movie"
"The Samaritans","flop movie"
Apotheosis,"one-time-watch movie"
Lazarat,"one-time-watch movie"
"Two Pigeons","one-time-watch movie"
"Dhaka Attack","hit movie"
Raasta,"flop movie"
Maatr,"flop movie"
"The Music Box","one-time-watch movie"
Maanagaram,"superhit movie"
"The Good Liar","one-time-watch movie"
Replace,"flop movie"
Lucid,"one-time-watch movie"
Wetlands,"flop movie"
"Mu ji zhe","hit movie"
Clinical,"one-time-watch movie"
"The Mad Whale","one-time-watch movie"
Arsenal,"flop movie"
Harmony,"one-time-watch movie"
"Die Hölle","one-time-watch movie"
Extracurricular,"one-time-watch movie"
"The Beguiled","one-time-watch movie"
Driven,"one-time-watch movie"
Polaroid,"one-time-watch movie"
Eshtebak,"hit movie"
Ambition,"flop movie"
"Deadman Standing","flop movie"
Cabaret,"flop movie"
"Boyne Falls","one-time-watch movie"
"Spinning Man","one-time-watch movie"
Webcast,"one-time-watch movie"
3,"flop movie"
Cardinals,"one-time-watch movie"
"Black Water","flop movie"
Kaleidoscope,"one-time-watch movie"
Antisocial.app,"flop movie"
"The Second","flop movie"
Wraith,"flop movie"
"The Ritual","one-time-watch movie"
"BNB Hell","one-time-watch movie"
"8 Remains","flop movie"
Thoroughbreds,"one-time-watch movie"
"5 Frauen","flop movie"
"Camera Obscura","flop movie"
"Bad Day for the Cut","one-time-watch movie"
"Den enda vägen","one-time-watch movie"
Barracuda,"one-time-watch movie"
Fashionista,"one-time-watch movie"
"Cut Shoot Kill","flop movie"
Charmøren,"one-time-watch movie"
"The Recall","flop movie"
"Frazier Park Recut","one-time-watch movie"
Agent,"flop movie"
"Breaking Point","flop movie"
"Coffin 2","one-time-watch movie"
"La Misma Sangre","one-time-watch movie"
"The Corrupted","one-time-watch movie"
"Killing Gunther","flop movie"
Mom,"hit movie"
"Slender Man","flop movie"
ExPatriot,"flop movie"
"Darkness Visible","one-time-watch movie"
"American Criminal","hit movie"
"The Changeover","one-time-watch movie"
"Dark River","one-time-watch movie"
Everfall,"flop movie"
Heartthrob,"one-time-watch movie"
Madre,"one-time-watch movie"
"Carnivore: Werewolf of London","flop movie"
"The Killing of a Sacred Deer","one-time-watch movie"
Thumper,"one-time-watch movie"
"Small Crimes","one-time-watch movie"
"Never Hike Alone","one-time-watch movie"
"Aus dem Nichts","hit movie"
"Insidious: The Last Key","one-time-watch movie"
"The Stranger Inside","flop movie"
"Salinjaui gieokbeob","hit movie"
Involution,"flop movie"
"The Possession of Hannah Grace","one-time-watch movie"
"Sam Was Here","flop movie"
Midnighters,"one-time-watch movie"
"Red Room","flop movie"
"Il permesso - 48 ore fuori","one-time-watch movie"
"Small Town Crime","one-time-watch movie"
Skyscraper,"one-time-watch movie"
"Kung Fu Traveler","one-time-watch movie"
Freddy/Eddy,"one-time-watch movie"
Tiyaan,"one-time-watch movie"
"Bad Blood","flop movie"
Voidfinder,"one-time-watch movie"
"Tera Intezaar","flop movie"
"The Institute","flop movie"
"The Cutlass","flop movie"
"Running with the Devil","one-time-watch movie"
"Dementia 13","flop movie"
"The Archer","one-time-watch movie"
"Let Her Out","flop movie"
"Ji qi zhi xue","one-time-watch movie"
"Christmas Crime Story","flop movie"
"The Nun","one-time-watch movie"
"Close Calls","flop movie"
"Tout nous sépare","flop movie"
"Laissez bronzer les cadavres","one-time-watch movie"
"What Death Leaves Behind","superhit movie"
"Look Away","one-time-watch movie"
"Devil in the Dark","flop movie"
"River Runs Red","flop movie"
"Dark Meridian","flop movie"
"Chai dan zhuan jia","one-time-watch movie"
"American Violence","flop movie"
Lasso,"flop movie"
"The Atoning","flop movie"
"The Poison Rose","flop movie"
"The Capture","one-time-watch movie"
Silencer,"flop movie"
"Created Equal","one-time-watch movie"
"The Student","flop movie"
Serpent,"flop movie"
"22-nenme no kokuhaku: Watashi ga satsujinhan desu","one-time-watch movie"
"First Kill","flop movie"
"The Super","one-time-watch movie"
"Ghatel-e ahli","flop movie"
"Cain Hill","flop movie"
Ezra,"one-time-watch movie"
"Project Ghazi","one-time-watch movie"
"Avenge the Crows","one-time-watch movie"
"Dead on Arrival","one-time-watch movie"
"The Nursery","one-time-watch movie"
"Ana de día","one-time-watch movie"
"Thondimuthalum Dhriksakshiyum","superhit movie"
"Beyond the Night","one-time-watch movie"
Hongo,"one-time-watch movie"
"A Death in the Gunj","hit movie"
"A Crooked Somebody","one-time-watch movie"
"Marlina si Pembunuh dalam Empat Babak","one-time-watch movie"
"The Pale Man","flop movie"
Stay,"one-time-watch movie"
"Steel Country","one-time-watch movie"
BuyBust,"one-time-watch movie"
"We Have Always Lived in the Castle","one-time-watch movie"
"Commando 2","one-time-watch movie"
"Tiger Zinda Hai","one-time-watch movie"
Motorrad,"flop movie"
"The Cabin","flop movie"
Zavod,"one-time-watch movie"
"The Angel","one-time-watch movie"
"Captive State","one-time-watch movie"
"Lost Fare","flop movie"
"The Transcendents","hit movie"
"Bad Match","one-time-watch movie"
"La niebla y la doncella","one-time-watch movie"
"First Light","one-time-watch movie"
"The 13th Friday","flop movie"
"Roman J. Israel, Esq.","one-time-watch movie"
"What Lies Ahead","flop movie"
"Oru Mexican Aparatha","one-time-watch movie"
"Extracurricular Activities","one-time-watch movie"
"What Still Remains","flop movie"
"S.W.A.T.: Under Siege","flop movie"
"The Strange Ones","flop movie"
Sawoleuiggeut,"one-time-watch movie"
Obsession,"flop movie"
"All Light Will End","flop movie"
"The Wrong Mother","one-time-watch movie"
"Mal Nosso","one-time-watch movie"
"La Cordillera","one-time-watch movie"
"Welcome to Acapulco","flop movie"
"Die Vierhändige","one-time-watch movie"
"First Reformed","hit movie"
"The Toybox","flop movie"
Monos,"hit movie"
Acrimony,"one-time-watch movie"
[Cargo],"flop movie"
Bitch,"flop movie"
"The School","flop movie"
Possum,"one-time-watch movie"
"Looking Glass","flop movie"
Still/Born,"one-time-watch movie"
"Hitsuji no ki","one-time-watch movie"
M/M,"flop movie"
Romina,"flop movie"
Mona_Darling,"one-time-watch movie"
"Point of no Return","flop movie"
Khoj,"one-time-watch movie"
Radius,"one-time-watch movie"
Isabelle,"flop movie"
"A Thought of Ecstasy","flop movie"
Kaalakaandi,"one-time-watch movie"
Jackals,"one-time-watch movie"
Ramaleela,"hit movie"
Aadhi,"one-time-watch movie"
"The Young Cannibals","flop movie"
"The Night Comes for Us","one-time-watch movie"
"Jahr des Tigers","one-time-watch movie"
"Paradise Hills","one-time-watch movie"
"Blood Prism","flop movie"
Araña,"one-time-watch movie"
Asher,"one-time-watch movie"
"The Line","one-time-watch movie"
"Girl Followed","flop movie"
Downrange,"one-time-watch movie"
"Bullitt County","flop movie"
"The Black String","one-time-watch movie"
"Skin in the Game","flop movie"
Hex,"flop movie"
Distorted,"one-time-watch movie"
"John Wick: Chapter 3 - Parabellum","hit movie"
"Vikram Vedha","superhit movie"
K.O.,"one-time-watch movie"
"Best F(r)iends: Volume 1","one-time-watch movie"
Perdidos,"flop movie"
Astro,"flop movie"
"The Nanny","flop movie"
"A Violent Man","one-time-watch movie"
"Angamaly Diaries","hit movie"
"Naam Shabana","one-time-watch movie"
"Paint It Red","flop movie"
Feedback,"hit movie"
"Nur Gott kann mich richten","one-time-watch movie"
"St. Agatha","one-time-watch movie"
"Canal Street","flop movie"
Carbone,"one-time-watch movie"
"The Executioners","flop movie"
"Angel Has Fallen","one-time-watch movie"
X.,"one-time-watch movie"
Gremlin,"flop movie"
Berserk,"flop movie"
"Zero 3","one-time-watch movie"
"The Kill Team","one-time-watch movie"
Malicious,"flop movie"
Bairavaa,"one-time-watch movie"
"The Villain","one-time-watch movie"
Urvi,"one-time-watch movie"
"Bullet Head","one-time-watch movie"
"The Crossbreed","flop movie"
Trapped,"hit movie"
Funôhan,"one-time-watch movie"
"No Date, No Signature","hit movie"
Loverboy,"one-time-watch movie"
10x10,"flop movie"
"Öteki Taraf","one-time-watch movie"
"The Journey","one-time-watch movie"
"The Russian Bride","one-time-watch movie"
Allure,"flop movie"
Cereyan,"flop movie"
Calibre,"one-time-watch movie"
Pledge,"one-time-watch movie"
Occidental,"one-time-watch movie"
"Halt: The Motion Picture","flop movie"
Ride,"one-time-watch movie"
"Accident Man","one-time-watch movie"
Shelter,"one-time-watch movie"
Followers,"flop movie"
Sarvann,"one-time-watch movie"
#Selfi,"one-time-watch movie"
"Candy Corn","flop movie"
Konvert,"one-time-watch movie"
"In This Gray Place","one-time-watch movie"
"Door in the Woods","flop movie"
Abstruse,"superhit movie"
"Vodka Diaries","one-time-watch movie"
"Raju Gari Gadhi 2","one-time-watch movie"
"Love Me Not","one-time-watch movie"
"Kolaiyuthir Kaalam","flop movie"
Knuckleball,"one-time-watch movie"
"Acts of Vengeance","one-time-watch movie"
"Mon garçon","one-time-watch movie"
Witch-Hunt,"one-time-watch movie"
"Hong yi xiao nu hai 2","one-time-watch movie"
"The Ghazi Attack","hit movie"
"Broken Ghost","flop movie"
Matriarch,"one-time-watch movie"
"Perfect Skin","one-time-watch movie"
Yeo-gyo-sa,"one-time-watch movie"
"Game of Death","one-time-watch movie"
"Take Off","superhit movie"
"Empathy, Inc.","flop movie"
"Deadly Expose","flop movie"
Bogan,"one-time-watch movie"
Inuyashiki,"one-time-watch movie"
"Burn Out","one-time-watch movie"
Keshava,"one-time-watch movie"
"Where the Skin Lies","flop movie"
"Adhe Kangal","hit movie"
"Sniper: Ultimate Kill","one-time-watch movie"
"The Guardian Angel","one-time-watch movie"
"Last Ferry","hit movie"
"Edge of Isolation","flop movie"
"Una especie de familia","one-time-watch movie"
Aake,"one-time-watch movie"
Spell,"one-time-watch movie"
"Naa Panta Kano","flop movie"
Simran,"one-time-watch movie"
"Beautiful Manasugalu","hit movie"
"The Doll 2","one-time-watch movie"
"Anonymous 616","one-time-watch movie"
V.I.P.,"one-time-watch movie"
Ten,"flop movie"
"Fast Color","one-time-watch movie"
Konwój,"one-time-watch movie"
"Puthan Panam","one-time-watch movie"
Patser,"one-time-watch movie"
"Brothers in Arms","one-time-watch movie"
"Las grietas de Jara","one-time-watch movie"
"The Coldest Game","one-time-watch movie"
"The Hurt","flop movie"
"End Trip","hit movie"
Housewife,"flop movie"
Irada,"one-time-watch movie"
"Tempus Tormentum","flop movie"
"Polícia Federal: A Lei é para Todos","one-time-watch movie"
Serenity,"one-time-watch movie"
Mersal,"hit movie"
"Gol-deun seul-leom-beo","one-time-watch movie"
Kääntöpiste,"one-time-watch movie"
"Project Ithaca","flop movie"
Siberia,"flop movie"
Rideshare,"one-time-watch movie"
Armomurhaaja,"one-time-watch movie"
"Mata Batin","one-time-watch movie"
Tiere,"one-time-watch movie"
"Haseena Parkar","flop movie"
Baazaar,"one-time-watch movie"
Piercing,"one-time-watch movie"
Spyder,"one-time-watch movie"
"El otro hermano","one-time-watch movie"
Jagveld,"one-time-watch movie"
Skjelvet,"one-time-watch movie"
"The Wicked Gift","one-time-watch movie"
"Frères ennemis","one-time-watch movie"
Nomis,"one-time-watch movie"
Haunt,"one-time-watch movie"
#SquadGoals,"flop movie"
Reprisal,"flop movie"
"Life Like","one-time-watch movie"
"Siew Lup","one-time-watch movie"
"Monster Party","one-time-watch movie"
"American Pets","flop movie"
Sweetheart,"one-time-watch movie"
Cutterhead,"one-time-watch movie"
Yaman,"one-time-watch movie"
"Death Game","one-time-watch movie"
Tamaroz,"one-time-watch movie"
"Night Bus","hit movie"
"The Fast and the Fierce","flop movie"
"Adam Joan","one-time-watch movie"
Sathya,"flop movie"
"Strategy and Pursuit","hit movie"
Hesperia,"flop movie"
Drive,"flop movie"
"Kuttram 23","hit movie"
"Mai mee Samui samrab ter","one-time-watch movie"
Haebing,"one-time-watch movie"
"Rust Creek","one-time-watch movie"
Solo,"hit movie"
Manu,"hit movie"
Villain,"one-time-watch movie"
Lakshyam,"one-time-watch movie"
"Indu Sarkar","one-time-watch movie"
"The House of Violent Desire","flop movie"
"A Good Woman Is Hard to Find","one-time-watch movie"
"The Wrong Nanny","flop movie"
"Triple Threat","one-time-watch movie"
"Yuddham Sharanam","one-time-watch movie"
Maracaibo,"one-time-watch movie"
Carbon,"one-time-watch movie"
Fantasten,"one-time-watch movie"
"Every Time I Die","flop movie"
Nabab,"hit movie"
Amok,"one-time-watch movie"
"Two Graves","flop movie"
Incoming,"flop movie"
"Off the Rails","flop movie"
"Street Lights","one-time-watch movie"
"Rapurasu no majo","one-time-watch movie"
"Steig. Nicht. Aus!","one-time-watch movie"
Ittefaq,"hit movie"
"The Riot Act","flop movie"
"Babumoshai Bandookbaaz","one-time-watch movie"
Kavan,"hit movie"
"Dead Water","flop movie"
"Playing with Dolls: Havoc","flop movie"
Bhaagamathie,"one-time-watch movie"
Oxygen,"one-time-watch movie"
Revenge,"one-time-watch movie"
"Numéro une","one-time-watch movie"
"Den skyldige","hit movie"
"8 Thottakkal","hit movie"
"Room for Rent","one-time-watch movie"
"Saab Bahadar","hit movie"
"High Heel Homicide","flop movie"
Dogman,"hit movie"
"American Dreamer","one-time-watch movie"
"Escape Plan: The Extractors","flop movie"
"Truth or Dare","one-time-watch movie"
"Diwanji Moola Grand Prix","flop movie"
Aiyaary,"one-time-watch movie"
"Aala Kaf Ifrit","one-time-watch movie"
Totem,"flop movie"
"A Deadly View","flop movie"
"El crack cero","hit movie"
Verna,"hit movie"
Nighthawks,"flop movie"
"The 15:17 to Paris","one-time-watch movie"
"Une vie violente","one-time-watch movie"
Doe,"one-time-watch movie"
"Si-gan-wi-ui jib","one-time-watch movie"
Glass,"one-time-watch movie"
"The Field","flop movie"
"Mr. Jones","one-time-watch movie"
"Welcome Home","one-time-watch movie"
"Loosideu deurim","one-time-watch movie"
"Das Ende der Wahrheit","one-time-watch movie"
Saaho,"one-time-watch movie"
Vault,"one-time-watch movie"
"A Tale of Shadows","one-time-watch movie"
"Baaghi 2","flop movie"
"Til Death Do Us Part","flop movie"
Peppermint,"one-time-watch movie"
"Nigerian Prince","one-time-watch movie"
"Elizabeth Harvest","one-time-watch movie"
"Alien Domicile 2: Lot 24","hit movie"
#Captured,"one-time-watch movie"
"The Appearance","flop movie"
Us,"one-time-watch movie"
Roofied,"flop movie"
"The Hummingbird Project","one-time-watch movie"
Vivegam,"one-time-watch movie"
Perception,"one-time-watch movie"
"Hong hai xing dong","one-time-watch movie"
"The Follower","flop movie"
Ha-roo,"one-time-watch movie"
"Absurd Accident","one-time-watch movie"
"La ragazza nella nebbia","one-time-watch movie"
Tueurs,"one-time-watch movie"
Hyeob-sang,"one-time-watch movie"
"Al Asleyeen","one-time-watch movie"
"The Midnight Matinee","flop movie"
"Journal 64","hit movie"
"Deadly Exchange","flop movie"
Prodigy,"flop movie"
Prescience,"flop movie"
"Sarajin bam","one-time-watch movie"
One,"one-time-watch movie"
"The Fox","flop movie"
Hospitality,"flop movie"
"The Nightmare Gallery","flop movie"
Blackmail,"one-time-watch movie"
Clickbait,"one-time-watch movie"
"Nommer 37","one-time-watch movie"
Joel,"flop movie"
"Curse of the Nun","flop movie"
Uru,"one-time-watch movie"
"Paul Sanchez est revenu!","one-time-watch movie"
"The Wrong Son","one-time-watch movie"
Betrayed,"one-time-watch movie"
Velaikkaran,"hit movie"
"Tam jeong 2","one-time-watch movie"
El-Khaliyyah,"one-time-watch movie"
"Russkiy Bes","one-time-watch movie"
Balloon,"flop movie"
"Velvet Buzzsaw","one-time-watch movie"
"The Cleaning Lady","one-time-watch movie"
Jang-san-beom,"one-time-watch movie"
"The Pages","flop movie"
Fuga,"one-time-watch movie"
Dharmayuddhaya,"hit movie"
"Gi-eok-ui bam","hit movie"
"Angel of Mine","one-time-watch movie"
Ratsasan,"superhit movie"
"Theeran Adhigaaram Ondru","superhit movie"
"The Place","hit movie"
"What Keeps You Alive","one-time-watch movie"
"Inori no maku ga oriru toki","hit movie"
Carnivores,"one-time-watch movie"
Sathya,"one-time-watch movie"
"Nowhere Mind","flop movie"
"In un giorno la fine","one-time-watch movie"
Donnybrook,"one-time-watch movie"
Pandigai,"one-time-watch movie"
"Gemini Ganeshanum Suruli Raajanum","one-time-watch movie"
"Duverný neprítel","one-time-watch movie"
"The Chain","flop movie"
"El reino","hit movie"
Woosang,"one-time-watch movie"
Raazi,"hit movie"
"Rocky Mental","one-time-watch movie"
"La sombra de la ley","one-time-watch movie"
Kavaludaari,"superhit movie"
"Die in One Day","flop movie"
Ballon,"hit movie"
Stillwater,"one-time-watch movie"
"Bonehill Road","one-time-watch movie"
"Zhan lang II","one-time-watch movie"
"Ach spij kochanie","one-time-watch movie"
"Against the Night","flop movie"
Maradona,"one-time-watch movie"
"Edge of Fear","flop movie"
Kataka,"hit movie"
"Net I Die","flop movie"
"No dormirás","one-time-watch movie"
"Sequestro Relâmpago","flop movie"
"Night Zero","flop movie"
"The Perception","flop movie"
"Iravukku Aayiram Kangal","hit movie"
"Irumbu Thirai","hit movie"
Lifechanger,"one-time-watch movie"
Benzersiz,"flop movie"
Thupparivaalan,"hit movie"
"Twin Betrayal","one-time-watch movie"
"Real Cases of Shadow People The Sarah McCormick Story","one-time-watch movie"
"Pussy Kills","flop movie"
Jawaan,"flop movie"
Heilstätten,"flop movie"
"Operation Alamelamma","superhit movie"
"Kuang shou","one-time-watch movie"
Kaaviyyan,"one-time-watch movie"
"Puen Tee Raluek","one-time-watch movie"
"The System","flop movie"
"Heesaeng boohwalja","one-time-watch movie"
Artik,"flop movie"
"En affære","one-time-watch movie"
"Lucky Day","flop movie"
"Nene Raju Nene Mantri","one-time-watch movie"
LIE,"one-time-watch movie"
Botoks,"flop movie"
"Kala Viplavam Pranayam","flop movie"
"Orayiram Kinakkalal","one-time-watch movie"
"Kurangu Bommai","superhit movie"
Karuppan,"one-time-watch movie"
"A Lover Betrayed","one-time-watch movie"
#Followme,"flop movie"
"Kaashi in Search of Ganga","one-time-watch movie"
"Tik Tik Tik","one-time-watch movie"
"Long Lost","flop movie"
"Hell Is Where the Home Is","one-time-watch movie"
Joker,"superhit movie"
Pimped,"flop movie"
"Between Worlds","flop movie"
"The Lake Vampire","one-time-watch movie"
"Nothing Really Happens","one-time-watch movie"
"Svaha: The Sixth Finger","one-time-watch movie"
"Notes on an Appearance","one-time-watch movie"
"Them That Follow","one-time-watch movie"
"30 Miles from Nowhere","flop movie"
"Killer Kate!","flop movie"
Savovi,"hit movie"
Vals,"flop movie"
Hex,"flop movie"
"Direnis Karatay","one-time-watch movie"
"Abrahaminte Santhathikal","hit movie"
"Scars of Xavier","flop movie"
"The Lodge","one-time-watch movie"
"Head Count","one-time-watch movie"
"El desentierro","flop movie"
Eter,"one-time-watch movie"
"La hora final","one-time-watch movie"
"Ouija House","flop movie"
Duelles,"one-time-watch movie"
"Red Letter Day","flop movie"
"In the Cloud","flop movie"
Missing,"one-time-watch movie"
Removed,"one-time-watch movie"
Illusions,"hit movie"
"Cómprame un revolver","one-time-watch movie"
"The Wrong Daughter","one-time-watch movie"
War,"one-time-watch movie"
"Race 3","flop movie"
"Low Tide","one-time-watch movie"
"The Farm: En Veettu Thottathil","hit movie"
"Askin Gören Gözlere Ihtiyaci yok","one-time-watch movie"
"Bottle Girl","flop movie"
Like.Share.Follow.,"one-time-watch movie"
"Doll Cemetery","flop movie"
Anna,"one-time-watch movie"
"Le chant du loup","one-time-watch movie"
"Killers Within","one-time-watch movie"
"The Oath","one-time-watch movie"
"7 Hosil","one-time-watch movie"
"Yol kenari","one-time-watch movie"
"The Boat","one-time-watch movie"
"Seung joi nei jor yau","one-time-watch movie"
Silencio,"flop movie"
"The Gallows Act II","flop movie"
Nematoma,"hit movie"
"B. Tech","one-time-watch movie"
"The Tooth and the Nail","one-time-watch movie"
"Xue guan yin","hit movie"
"Semma Botha Aagatha","flop movie"
Eyewitness,"flop movie"
"The Burial Of Kojo","one-time-watch movie"
"Party Hard Die Young","one-time-watch movie"
"Thiruttu Payale 2","one-time-watch movie"
Kee,"one-time-watch movie"
"Yin bao zhe","one-time-watch movie"
"Paradise Beach","flop movie"
"The Dig","one-time-watch movie"
"Bez menya","one-time-watch movie"
Animal,"one-time-watch movie"
"It Kills","flop movie"
"Swathanthryam Ardharathriyil","hit movie"
Koxa,"flop movie"
Trickster,"flop movie"
F20,"one-time-watch movie"
Unda,"superhit movie"
"Wake Up","flop movie"
"Survival Box","flop movie"
Schoolhouse,"flop movie"
"The Legend of Halloween Jack","flop movie"
Ira,"one-time-watch movie"
"The Open House","flop movie"
"Daughter of the Wolf","one-time-watch movie"
"A Night to Regret","one-time-watch movie"
"Rewind: Die zweite Chance","one-time-watch movie"
"The Wedding Guest","one-time-watch movie"
"This Old Machine","flop movie"
"La quietud","one-time-watch movie"
"The Manson Family Massacre","flop movie"
Searching,"hit movie"
Thriller,"flop movie"
"Papa, sdokhni","one-time-watch movie"
Yazh,"superhit movie"
"Monsters and Men","one-time-watch movie"
Superfly,"one-time-watch movie"
"El pacto","one-time-watch movie"
"18am Padi","one-time-watch movie"
"Best F(r)iends: Volume 2","one-time-watch movie"
"According to Mathew","one-time-watch movie"
Diya,"one-time-watch movie"
Chanakyatanthram,"one-time-watch movie"
"To thávma tis thálassas ton Sargassón","one-time-watch movie"
"Alpha Wolf","flop movie"
"Silent Panic","flop movie"
Genius,"flop movie"
Nirdosh,"flop movie"
"Il testimone invisibile","one-time-watch movie"
"Blood Craft","flop movie"
Naachiyar,"one-time-watch movie"
"Until Midnight","hit movie"
"Çocuklar Sana Emanet","one-time-watch movie"
"Somewhere Beyond the Mist","one-time-watch movie"
"Apró mesék","hit movie"
Goodachari,"hit movie"
"Okka Kshanam","one-time-watch movie"
"Cola de Mono","one-time-watch movie"
"Varikkuzhiyile Kolapathakam","one-time-watch movie"
"The Perfection","one-time-watch movie"
Awe!,"hit movie"
Lukas,"one-time-watch movie"
"Odds Are","flop movie"
Thadam,"superhit movie"
Profile,"hit movie"
"Thuppaki Munai","one-time-watch movie"
"Loon Lake","one-time-watch movie"
Feedback,"one-time-watch movie"
Luz,"one-time-watch movie"
"Aapla Manus","hit movie"
122,"hit movie"
"The Fanatic","flop movie"
Mercury,"one-time-watch movie"
"Family Blood","flop movie"
Lottery,"one-time-watch movie"
"4 Rah Istanbul","one-time-watch movie"
"Be Vaghte Sham","one-time-watch movie"
"Maghzhaye Koochake Zang Zadeh","hit movie"
"Gogol. Viy","one-time-watch movie"
"Deception: Oo Pel Dan Myin","superhit movie"
E-Demon,"flop movie"
"Spider in the Web","flop movie"
"Body at Brighton Rock","flop movie"
Depraved,"flop movie"
Prospect,"one-time-watch movie"
"Bordo Bereliler Afrin","flop movie"
Acusada,"one-time-watch movie"
Ma,"one-time-watch movie"
"The Mule","one-time-watch movie"
"Utøya 22. juli","hit movie"
"The Farm","flop movie"
Vikadakumaran,"one-time-watch movie"
"Kargar sadeh niazmandim","one-time-watch movie"
"Quien a hierro mata","one-time-watch movie"
"70 Binladens","one-time-watch movie"
"The Haunting of Sharon Tate","flop movie"
Garbage,"flop movie"
Sabrina,"flop movie"
"Morto Não Fala","one-time-watch movie"
"Aschhe Abar Shabor","one-time-watch movie"
"The Operative","one-time-watch movie"
"Foto na pamyat","flop movie"
Burn,"one-time-watch movie"
Boomerang,"one-time-watch movie"
Rassvet,"flop movie"
"Shadow Wolves","flop movie"
Dressage,"one-time-watch movie"
Prowler,"flop movie"
"The Surrogate","flop movie"
Taxiwaala,"hit movie"
Manyak,"one-time-watch movie"
Kabir,"one-time-watch movie"
"7 Nyeon-eui bam","one-time-watch movie"
"The Watcher","one-time-watch movie"
Solum,"one-time-watch movie"
"The Row","flop movie"
"Shohrat the Trap","one-time-watch movie"
"Ban-deu-si jab-neun-da","one-time-watch movie"
"The Refuge","one-time-watch movie"
"His Perfect Obsession","one-time-watch movie"
"Judgementall Hai Kya","one-time-watch movie"
Andhadhun,"superhit movie"
"The Tashkent Files","hit movie"
Hattrick,"one-time-watch movie"
Bbaengban,"one-time-watch movie"
"Linhas de Sangue","flop movie"
"One Day: Justice Delivered","one-time-watch movie"
"Veera Bhoga Vasantha Rayalu","one-time-watch movie"
"El Hijo","one-time-watch movie"
Chase,"hit movie"
Varathan,"hit movie"
Cuck,"one-time-watch movie"
"Soul Hunters","one-time-watch movie"
Börü,"one-time-watch movie"
"Satyameva Jayate","one-time-watch movie"
"The Furies","one-time-watch movie"
"El Hoyo","hit movie"
"The Report","hit movie"
"Downward Twin","flop movie"
Khamoshi,"flop movie"
"Non sono un assassino","one-time-watch movie"
Lilli,"one-time-watch movie"
"The Huntress: Rune of the Dead","one-time-watch movie"
Fractured,"one-time-watch movie"
"Muere, monstruo, muere","one-time-watch movie"
"Memorias de lo que no fue","flop movie"
"Cucuy: The Boogeyman","flop movie"
Tone-Deaf,"flop movie"
Zoo-Head,"flop movie"
"The Burnt Orange Heresy","one-time-watch movie"
"Annabelle Comes Home","one-time-watch movie"
"Cradle Robber","flop movie"
"5 è il numero perfetto","one-time-watch movie"
"Witches in the Woods","flop movie"
"Deadly Switch","flop movie"
Cam,"one-time-watch movie"
Brokedown,"hit movie"
"Birbal Trilogy","superhit movie"
"Adanga Maru","hit movie"
"Mu hou wan jia","one-time-watch movie"
Swallow,"one-time-watch movie"
Instinct,"one-time-watch movie"
"El silencio de la ciudad blanca","one-time-watch movie"
Witnesses,"one-time-watch movie"
"Savita Damodar Paranjpe","one-time-watch movie"
Amavas,"flop movie"
"Sultan: The Saviour","one-time-watch movie"
Portal,"flop movie"
Tutsak,"one-time-watch movie"
"Ventajas de viajar en tren","hit movie"
"Rabbia furiosa","one-time-watch movie"
Kaappaan,"one-time-watch movie"
"We Belong Together","flop movie"
"Lie Low","flop movie"
"Running Out Of Time","flop movie"
Abrakadabra,"one-time-watch movie"
"Female Human Animal","one-time-watch movie"
Pihu,"one-time-watch movie"
Shéhérazade,"hit movie"
Somnium,"flop movie"
"Jai mat ze moon","one-time-watch movie"
"Creep Nation","flop movie"
Target,"flop movie"
"Les fauves","flop movie"
"Sumaho o otoshita dake na no ni","one-time-watch movie"
"Kill Chain","one-time-watch movie"
"Bundy and the Green River Killer","flop movie"
"Romeo Akbar Walter","one-time-watch movie"
"Killer in a Red Dress","flop movie"
Joseph,"superhit movie"
Crypto,"one-time-watch movie"
"Purity Falls","one-time-watch movie"
Karma,"one-time-watch movie"
"The Wrong Friend","flop movie"
"Il signor Diavolo","one-time-watch movie"
"Kidnapping Stella","flop movie"
"Plagi Breslau","one-time-watch movie"
"An Affair to Die For","flop movie"
"Amityville: Mt. Misery Rd.","one-time-watch movie"
"Bluff Master","one-time-watch movie"
Subrahmanyapuram,"one-time-watch movie"
"Nguoi Bât Tu","one-time-watch movie"
118,"one-time-watch movie"
"O Banquete","one-time-watch movie"
"Family Vanished","flop movie"
"Byomkesh Gotro","one-time-watch movie"
Mikhael,"flop movie"
Lupt,"hit movie"
Instakiller,"flop movie"
"Remélem legközelebb sikerül meghalnod:)","hit movie"
U-Turn,"one-time-watch movie"
"The Collini Case","hit movie"
"Gogol. Strashnaya mest","one-time-watch movie"
"Fear Bay","flop movie"
"Mercy Black","flop movie"
Freaks,"one-time-watch movie"
"The Dead Center","one-time-watch movie"
"Come to Daddy","one-time-watch movie"
Aurora,"flop movie"
Avengement,"one-time-watch movie"
"The Ex Next Door","one-time-watch movie"
Mok-gyeok-ja,"one-time-watch movie"
"Batla House","hit movie"
Bloodline,"one-time-watch movie"
Live,"flop movie"
"Mata Batin 2","one-time-watch movie"
Kavacha,"superhit movie"
Trezor,"hit movie"
"Room 37: The Mysterious Death of Johnny Thunders","flop movie"
"Game Over","hit movie"
Virus,"superhit movie"
Aadai,"one-time-watch movie"
Rojo,"one-time-watch movie"
"Mr. & Ms. Rowdy","flop movie"
Valhalla,"hit movie"
"O Paciente: O Caso Tancredo Neves","one-time-watch movie"
"American Hangman","one-time-watch movie"
Excursion,"hit movie"
"Cleavers: Killer Clowns","flop movie"
Boi,"flop movie"
Bumperkleef,"one-time-watch movie"
"Alpha: The Right to Kill","one-time-watch movie"
Homestay,"hit movie"
"The Husband","one-time-watch movie"
Blank,"one-time-watch movie"
"Cold Blood Legacy","flop movie"
"Home Is Where the Killer Is","flop movie"
Vera,"hit movie"
"The Pool","one-time-watch movie"
Rattlesnakes,"one-time-watch movie"
"Killer Under the Bed","one-time-watch movie"
Seven,"one-time-watch movie"
"The Villagers","one-time-watch movie"
"Pozivniy «Banderas»","hit movie"
Quick,"hit movie"
"Jûni-nin no shinitai kodomo-tachi","one-time-watch movie"
Madre,"one-time-watch movie"
Setters,"one-time-watch movie"
"Kadaram Kondan","one-time-watch movie"
Kavacham,"one-time-watch movie"
"Only Mine","flop movie"
"Scare BNB","flop movie"
"Halloween Horror Tales","flop movie"
"Laal Kabootar","hit movie"
Watchman,"one-time-watch movie"
Muse,"flop movie"
Ghost,"superhit movie"
"The Car: Road to Revenge","flop movie"
706,"one-time-watch movie"
"Dokyala Shot","superhit movie"
Do-eo-lak,"one-time-watch movie"
"Secret Obsession","flop movie"
Revenger,"one-time-watch movie"
"Bell Bottom","superhit movie"
Ishq,"hit movie"
"Bagh bandi khela","flop movie"
"Danmarks sønner","one-time-watch movie"
"Üç Harfliler: Adak","one-time-watch movie"
Sindhubaadh,"one-time-watch movie"
"Along Came the Devil 2","flop movie"
Night,"flop movie"
Trhlina,"one-time-watch movie"
"Gaddalakonda Ganesh","one-time-watch movie"
"Nerkonda Paarvai","superhit movie"
"Xue bao","one-time-watch movie"
Athiran,"one-time-watch movie"
"Falaknuma Das","one-time-watch movie"
Otryv,"flop movie"
"Majaray Nimrooz: Radde Khoon","one-time-watch movie"
"Metri Shesh Va Nim","hit movie"
"Misteri Dilaila","one-time-watch movie"
"Nightmare Tenant","one-time-watch movie"
"Paranormal Investigation","flop movie"
Sathru,"one-time-watch movie"
Kaithi,"superhit movie"
Jessie,"hit movie"

*/

/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
with rounding AS
(
select genre,
		round(avg(duration),2) as avg_duration,
        sum(avg(duration)) over (order by genre) as r_t,
        avg(avg(duration)) over (order by genre) as m_a
from movie as m
join genre as g
on g.movie_id=m.id
join ratings as r
on g.movie_id=r.movie_id
group by genre
)
SELECT genre,
		avg_duration,
		round(r_t,2) as running_total_duration,
        round(m_a,2) as moving_average_duration
from rounding;

/* Answer_25
genre,avg_duration,running_total_duration,moving_average_duration
Action,112.88,112.88,112.88
Adventure,101.87,214.75,107.38
Comedy,102.62,317.38,105.79
Crime,107.05,424.43,106.11
Drama,106.77,531.20,106.24
Family,100.97,632.17,105.36
Fantasy,105.14,737.31,105.33
Horror,92.72,830.03,103.75
Mystery,101.80,931.83,103.54
Others,100.16,1031.99,103.20
Romance,109.53,1141.53,103.78
Sci-Fi,97.94,1239.47,103.29
Thriller,101.58,1341.05,103.16
*/

-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies

SELECT genre,
	COUNT(movie_id) AS movie_count
FROM genre
GROUP BY genre
ORDER BY movie_count DESC
LIMIT 3;

-- The TOP 3 genre are 'Drama', 'Comedy' and 'Thriller'.

WITH Top AS (
	SELECT g.genre,
		m.year,
		m.title AS movie_name,
		m.worlwide_gross_income,
		DENSE_RANK () OVER ( PARTITION BY year
							 ORDER BY worlwide_gross_income DESC) AS movie_rank
	FROM movie m INNER JOIN genre g
		ON m.id = g.movie_id
	WHERE genre IN ('Drama', 'Comedy', 'Thriller') AND worlwide_gross_income IS NOT NULL)

SELECT *
FROM Top
WHERE movie_rank <= 5
GROUP BY (movie_name);

/* Answer_26
genre,year,movie_name,worlwide_gross_income,movie_rank
Drama,2017,"Shatamanam Bhavati","INR 530500000",1
Drama,2017,Winner,"INR 250000000",2
Drama,2017,"Thank You for Your Service","$ 9995692",3
Comedy,2017,"The Healer","$ 9979800",4
Thriller,2017,"Gi-eok-ui bam","$ 9968972",5
Thriller,2018,"The Villain","INR 1300000000",1
Drama,2018,"Antony & Cleopatra","$ 998079",2
Comedy,2018,"La fuitina sbagliata","$ 992070",3
Drama,2018,Zaba,"$ 991",4
Comedy,2018,Gung-hab,"$ 9899017",5
Thriller,2019,Prescience,"$ 9956",1
Drama,2019,Joker,"$ 995064593",2
Comedy,2019,"Eaten by Lions","$ 99276",3
Comedy,2019,"Friend Zone","$ 9894885",4
Drama,2019,"Nur eine Frau","$ 9884",5

*/



-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
select production_company , count(m.id) as movie_count, rank() over (order by count(id) desc) as prod_comp_rank
from movie as m
join ratings as r 
on m.id=r.movie_id
where r.median_rating>=8 and production_company is not null and position(',' in languages)>0
group by production_company 
limit 2;

/* Answer_27
production_company,movie_count,prod_comp_rank
"Star Cinema",7,1
"Twentieth Century Fox",4,2
*/
-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
select n.name as actress_name, 
		sum(total_votes) as total_votes, 
        count(r.movie_id) as movie_count, 
        avg_rating as actress_avg_rating,
		row_number() over (order by count(movie_id) desc) as actess_rank
from ratings as r
join movie as m
on r.movie_id=m.id
join role_mapping as rm
on m.id=rm.movie_id
join names as n
on rm.name_id=n.id
join genre as g
on m.id=g.movie_id
where category = 'actress' and avg_rating>8 and genre = 'drama'
group by name
limit 3;

/* Answer_28
actress_name,total_votes,movie_count,actress_avg_rating,actess_rank
"Parvathy Thiruvothu",4974,2,8.3,1
"Susan Brown",656,2,8.9,2
"Amanda Lawrence",656,2,8.9,3
*/


/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

select name,
count(movie_id) as movies
from director_mapping d inner join names n
on n.id = d.name_id
group by name
order by movies desc
limit 9;
-- Top 9 directors are 'A.L. Vijay', 'Andrew Jones', 'Chris Stokes', 'Justin Price', 'Jesse V. Johnson', 'Steven Soderbergh', 'Sion Sono', 'Özgür Bakar', 'Sam Liu


with a as(
SELECT name,
	date_published
from movie m inner join director_mapping d
on m.id = d.movie_id inner join names n
on n.id = d.name_id
where name in ('A.L. Vijay', 'Andrew Jones', 'Chris Stokes', 'Justin Price', 'Jesse V. Johnson', 
				'Steven Soderbergh', 'Sion Sono', 'Özgür Bakar', 'Sam Liu')),
-- ORDER BY name, date_published),

b as(
select *,
	lead (date_published, 1) over (partition by name
									order by date_published) as next_movie
from a)

SELECT *,
datediff(next_movie, date_published) as days
from b;



SELECT n.Name,
	COUNT(d.movie_id) AS Movie_Count
FROM names n INNER JOIN director_mapping d
	ON n.id = d.name_id
GROUP BY Name
ORDER BY Movie_Count DESC
LIMIT 9;
 /* Top 9 directors are 'A.L. Vijay', 'Andrew Jones', 'Chris Stokes', 'Justin Price', 
 'Jesse V. Johnson', 'Steven Soderbergh', 'Sion Sono', 'Özgür Bakar', 'Sam Liu' */
 
 -- Fetching the other required details.
 WITH Top AS (
	 SELECT d.name_id AS director_id,
		n.name AS director_name,
		m.id,
		m.date_published,
		r.avg_rating,
		r.total_votes,
		m.duration,
		LEAD (date_published, 1) OVER w1 AS next_movie,
		MIN(avg_rating) OVER w2 AS min_rating,
		MAX(avg_rating) OVER w3 AS max_rating
	FROM names n INNER JOIN director_mapping d
		ON n.id = d.name_id INNER JOIN movie m
			ON m.id = d.movie_id INNER JOIN ratings r
				ON m.id = r.movie_id
	WHERE name IN ('A.L. Vijay', 'Andrew Jones', 'Chris Stokes', 'Justin Price', 'Jesse V. Johnson',
					'Steven Soderbergh', 'Sion Sono', 'Özgür Bakar', 'Sam Liu')
	WINDOW w1 AS ( PARTITION BY name
				   ORDER BY  date_published),
			w2 AS (PARTITION BY name),
			w3 AS (PARTITION BY name)),

Nine AS (
	SELECT *,
		DATEDIFF(next_movie, date_published) AS Days
	FROM Top),

Directors AS (
	SELECT *,
		ROUND(AVG((Days)) OVER (PARTITION BY director_name
						ORDER BY date_published)) AS avg_inter_movie_days
	FROM Nine)

SELECT director_id,
	director_name,
    COUNT(id) AS number_of_movies,
    avg_inter_movie_days,
    avg_rating,
    SUM(total_votes) AS total_votes,
    min_rating,
    max_rating,
    SUM(duration) AS total_duration
FROM Directors
GROUP BY director_name;


/* Answer_29:
director_id,director_name,number_of_movies,avg_inter_movie_days,avg_rating,total_votes,min_rating,max_rating,total_duration
nm1777967,"A.L. Vijay",5,192,5.5,1754,3.7,6.9,613
nm2096009,"Andrew Jones",5,126,3.2,1989,2.7,3.2,432
nm0831321,"Chris Stokes",4,302,4.5,3664,4.0,4.6,352
nm0425364,"Jesse V. Johnson",4,215,4.2,14778,4.2,6.5,383
nm2691863,"Justin Price",4,301,3.0,5343,3.0,5.8,346
nm6356309,"Özgür Bakar",4,196,3.2,1092,3.1,4.9,374
nm0515005,"Sam Liu",4,161,5.9,28557,5.8,6.7,312
nm0814469,"Sion Sono",4,7,5.4,2972,5.4,6.4,502
nm0001752,"Steven Soderbergh",4,210,7.0,171684,6.2,7.0,401
*/