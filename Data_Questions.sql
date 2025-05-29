-- Questions
SELECT *
FROM hr;

-- 1. What is the gender breakdown of employees in the company?

SELECT gender, COUNT(*) AS Gender_Count
FROM hr
WHERE age>=18 AND termdate is null
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT race, COUNT(*) AS Race_Count
FROM hr
WHERE age>=18 AND termdate is null
group by race
order by count(*) desc;

-- 3. What is the age distribution of employees in the company?

select 
  min(age) as youngest,
  max(age) as oldest
  from hr
where age>=18 and termdate is null;

select
	case
		when age>=18 and age<=24 then '18-24'
        when age>=25 and age<=34 then '25-34'
        when age>=35 and age<=44 then '35-44'
        when age>=45 and age<=54 then '45-54'
        when age>=55 and age<=64 then '56-64'
        else '65+'
	end as age_group,
    count(*) as count
from hr
where age>=18 and termdate is null
group by age_group
order by age_group;


-- 4. How many employees work at headquarters vs remote locations?

select location, count(*) as count 
from hr
where age>=18 AND termdate is null
group by location
order by location;

-- 5. What is the average length of employment for employees who have been terminated

select 
round(avg(datediff(termdate,hire_date))/365,0) as avg_emp_length
from hr
where termdate is not null and termdate<=curdate() and age>=18;

-- 6. How does gender distribution vary across dept and job titles?
select department, gender, count(*) as dept_gender_count
from hr
where age>=18 and termdate is null
group by gender, department
order by department;

select jobtitle, gender, count(*) as title_gender_count
from hr
where age>=18 and termdate is null
group by gender, jobtitle
order by jobtitle;

-- 7. What is the distribution of jobttile accross the company
select jobtitle, count(*) as job_title_count
from hr
where age>=18 and termdate is null
group by jobtitle;

-- 8. Which department has the highest turnover rate?
select department,
	total_count,
    terminated_count,
    terminated_count/total_count as termination_rate
from(
	select department,
    count(*) as total_count,
    sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminated_count
    from hr
    where age>=18
    group by department
    ) as subquery
order by termination_rate desc;


-- 9. What is the distribution of employees across location by state?
select location_state , count(*) as count
from hr 
where age>=18 and termdate is null
group by location_state
order by count desc;

-- 10. How has the company's employee count changed over time based on hire date and term date

select hire_year, 
	hire_count, 
    term_count, 
    hire_count - term_count as net_change,
    round((hire_count - term_count)/hire_count * 100,2) as net_change_percentage
	from(
	select year(hire_date) as hire_year , count(*) as hire_count,
	sum(case when termdate is not null and termdate<=curdate() then 1 else 0 end) as term_count
    from hr
    where age>=18
    group by hire_year
    ) as subquery
order by hire_year asc;

-- 11. What is the tenure distribution for each department?
select department, round(avg((datediff(termdate,hire_date)/365)),0) as avg_tenure
from hr
where age>=18 and termdate is not null and termdate <= curdate()
group by department;