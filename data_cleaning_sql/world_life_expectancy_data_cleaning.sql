SELECT *
from world_life_expectancy;

SELECT Country,Year,count(*) as count1
from world_life_expectancy
group by 1,2
having count(*) > 1;

SELECT Country,Year,CONCAT(Country,Year) as combination,count(*) as count1
from world_life_expectancy
group by 1,2
having count(*) > 1;

with cte as (
SELECT CONCAT(Country,Year) as combination,
row_number() over (partition by CONCAT(Country,Year) order by CONCAT(Country,Year) ) as rn
from world_life_expectancy
)
select *
from cte 
where rn >1;

DELETE FROM world_life_expectancy
where row_id in (select row_id
				from (
						SELECT row_id,CONCAT(Country,Year) as combination,
						row_number() over (partition by CONCAT(Country,Year) order by CONCAT(Country,Year) ) as rn
						from world_life_expectancy
					)a
					where rn >1);

UPDATE world_life_expectancy w1
join world_life_expectancy w2
on w1.Country = w2.Country 
SET w1.status = 'Developing'
WHERE w1.status = '' and w2.status <>'' and w2.status = 'Developing';

SELECT *
FROM world_life_expectancy
where country like 'United States %';

UPDATE world_life_expectancy w1
join world_life_expectancy w2
on w1.Country = w2.Country 
SET w1.status = 'Developed'
WHERE w1.status = '' and w2.status <>'' and w2.status = 'Developed';

SELECT w1.Country,w1.Year,w1.`Life expectancy`,w2.Country,w2.Year,w2.`Life expectancy`,w3.Country,w3.Year,w3.`Life expectancy`
,round((w2.`Life expectancy`+ w3.`Life expectancy`)/2,2)
from world_life_expectancy w1
JOIN world_life_expectancy w2 on w1.Country = w2.Country and w1.year = w2.year-1
JOIN world_life_expectancy w3  on w2.Country= w3.Country and w1.year = w3.year+1
where w1.`Life expectancy` = '';

UPDATE world_life_expectancy w1
JOIN world_life_expectancy w2 on w1.Country = w2.Country and w1.year = w2.year-1
JOIN world_life_expectancy w3  on w2.Country= w3.Country and w1.year = w3.year+1
SET w1.`Life expectancy` = round((w2.`Life expectancy`+ w3.`Life expectancy`)/2,2)
where w1.`Life expectancy` = '';

SELECT *
FROM world_life_expectancy

