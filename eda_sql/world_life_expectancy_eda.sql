## world_life_expectancy_eda

SELECT *
FROM world_life_expectancy;

SELECT Country,MIN(`Life expectancy`),MAX(`Life expectancy`)
, ROUND(MAX(`Life expectancy`) -MIN(`Life expectancy`) ,2) AS life_increase_over
FROM world_life_expectancy
group by 1
having MIN(`Life expectancy`) <> 0 and MAX(`Life expectancy`) <>0
ORDER BY 1 desc ;


SELECT year ,round(AVG(`Life expectancy`),2) AS average
FROM world_life_expectancy
where `Life expectancy` <> 0 
group by 1
order by 1
;
select country , round(avg(`Life expectancy`),2) as average , avg(GDP) as GDP_average
FROM world_life_expectancy
GROUP BY 1
HAVING average <> 0 
order by GDP_average DESC;

SELECT 
SUM(CASE WHEN GDP >=1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >=1500 THEN `Life expectancy` ELSE 0 END) High_GDP_Life_expectancy,
SUM(CASE WHEN GDP <=1500 THEN 1 ELSE 0 END) lOW_GDP_Count,
AVG (CASE WHEN GDP <=1500 THEN `Life expectancy` ELSE 0 END) low_GDP_Count_Life_expectancy
from world_life_expectancy;


SELECT status ,COUNT(DISTINCT Country),ROUND (AVG(`Life expectancy`),1)
from world_life_expectancy
group by 1 ;

select country , round(avg(`Life expectancy`),2) as average , avg(BMI) as BMI_average
FROM world_life_expectancy
GROUP BY 1
HAVING average <> 0 
order by BMI_average DESC;

SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
sum(`Adult Mortality`) over (partition by Country order by year)
from world_life_expectancy
where country like 'United%'