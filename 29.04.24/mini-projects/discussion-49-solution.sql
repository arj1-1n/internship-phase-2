-- 1. Task: Query the country table to select the Name, Continent, and Population
select name, continent, population from country;
-- 2. Task: Use aliases to rename the Name column to Country Name and the country table as c in your queries
select name as 'country name' from country as c;
-- 3. Task: Find all countries in the 'Europe' continent with a population greater than 10 million
select name, population from country where continent = 'Europe' and population > 10000000;
-- 4. Task: Retrieve all cities in 'Poland' or 'Belgium'
select name, countrycode from city where countrycode = 'POL' or countrycode = 'BEL';
-- 5. Task: List all countries in 'South America' by their LifeExpectancy in descending order
select name, lifeexpectancy from country where continent = 'South America' order by lifeexpectancy desc;
-- 6. Task: Get the top 5 largest cities by population in the database.
select name, population from city order by population desc limit 5;