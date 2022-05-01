INSERT INTO movie VALUES
('tt0012494','Der müde Tod',2017,'2017-06-09',97,'Germany','$ 12156','German','Decla-Bioscop AG'),
('tt0038733','A Matter of Life and Death',2017,'2017-12-08',104,'UK','$ 124241','English, French, Russian','The Archers'),
('tt0361953','The Nest of the Cuckoo Birds',2017,'2017-10-16',81,'USA',null,'English','Bert Williams Motion Pictures and Distributor'),
('tt0235166','Against All Hope',2017,'2017-10-20',90,'USA',null,'English',null),
('tt0337383','Vaikai is Amerikos viesbucio',2017,'2017-03-09',88,'Soviet Union',null,'Lithuanian, Russian','Lietuvos Kinostudija');


INSERT INTO genre VALUES
('tt0012494','Thriller'),
('tt0012494','Fantasy'),
('tt0012494','Drama'),
('tt0038733','Fantasy'),
('tt0038733','Drama');



INSERT INTO director_mapping VALUES
('tt0038733','nm0003836'),
('tt0038733','nm0696247'),
('tt0060908','nm0003606'),
('tt0069049','nm0000080'),
('tt0082620','nm0716460');



INSERT INTO role_mapping VALUES
('tt0038733','nm0000057','actor'),
('tt0038733','nm0001375','actress'),
('tt0038733','nm0178509','actor'),
('tt0038733','nm0126402','actress'),
('tt0060908','nm0000869','actor');


INSERT INTO names VALUES
('nm0000002','Lauren Bacall','174','1924-09-16',null),
('nm0000110','Kenneth Branagh','177','1960-12-10','tt3402236'),
('nm0000009','Richard Burton','175','1925-11-10',null),
('nm0000114','Steve Buscemi','175','1957-12-13','tt4686844'),
('nm0000014','Olivia de Havilland','163','1916-07-01',null);



INSERT INTO ratings VALUES
('tt0012494',7.7,4695,8),
('tt0038733',8.1,17693,8),
('tt0060908',7.5,3392,8),
('tt0069049',6.9,5014,7),
('tt0071145',8.2,789,8);




-- Testing tables for inserted Values:

Select * from Movie
;
Select * from Genre
;
Select * from Director_Mapping
;
Select * from Role_Mapping
;
Select * from Names
;
Select * from Ratings
;

TRUNCATE movie
;
TRUNCATE Movie;
TRUNCATE  Genre;
TRUNCATE  Director_Mapping;
TRUNCATE Role_Mapping;
TRUNCATE Names;
TRUNCATE Ratings;
