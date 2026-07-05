use world_layoff;

select * 
from layoffs_staging2;

select max(total_laid_off),min(total_laid_off)
from layoffs_staging2;

select max(percentage_laid_off),min(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off
order by total_laid_off desc;

select company , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by company
order by company;

select company , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select industry , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by industry
order by industry;

select industry , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select country , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by country
order by country;

select country , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select location , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by location
order by location;

select location , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by location
order by 2 desc;

select stage , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by stage
order by stage;

select stage , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select min(`date`),max(`date`)
from layoffs_staging2;

select year(`date`) , sum(total_laid_off),avg(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by `month`asc;

with Rolling_total as
(
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by `month`asc
)
select `month`,total_off,sum(total_off) over(order by `month`)as rolling_total
from Rolling_total;

select company ,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 1 asc;

select company ,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 3 desc;


with company_year(company,years,total_laid_off)  as
(
select company ,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
)
select *, dense_rank() over(partition  by years order by total_laid_off desc) as ranking
from company_year
where years is not null
order by ranking asc;

with company_year(company,years,total_laid_off)  as
(
select company ,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
),
company_year_rank as
(
select *, dense_rank() over(partition  by years order by total_laid_off desc) as ranking
from company_year
where years is not null
)
select * 
from company_year_rank
where ranking <= 5;

-- From the analysis, it is clear that layoffs increased dramatically during 2022 and 2023 compared to 
-- previous years. The data shows that both startups and large multinational companies were affected,
--  indicating that layoffs were not limited to a specific type of business. The United States recorded the
-- highest number of layoffs, while industries such as Technology, Retail, and Consumer Services experienced
-- the greatest impact. Monthly trends reveal that layoffs surged sharply in late 2022 and early 2023,
-- suggesting a period of economic uncertainty and cost-cutting across organizations. Overall, the findings
-- indicate that companies shifted their focus from rapid expansion to profitability and operational
-- efficiency, leading to widespread workforce reductions across different sectors and countries.








