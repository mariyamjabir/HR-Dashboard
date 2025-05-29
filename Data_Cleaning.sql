USE projects;

SELECT * FROM hr;

SET SQL_SAFE_UPDATES = 0;


ALTER table hr
Modify column birthdate date;

UPDATE hr
SET birthdate = CASE
 WHEN birthdate like '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
 WHEN birthdate like '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
 ELSE null
END
WHERE birthdate LIKE '%/%' OR birthdate LIKE '%-%';

UPDATE hr
SET hire_date = CASE
 WHEN hire_date like '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
 WHEN hire_date like '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
 ELSE null
END
WHERE hire_date LIKE '%/%' OR hire_date LIKE '%-%';

ALTER table hr
Modify column hire_date date;

SELECT hire_date FROM hr;

describe hr;

SELECT termdate FROM hr;

update hr
set termdate=date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
where termdate IS NOT NULL and termdate!=' ';

UPDATE hr
SET termdate = NULL
WHERE termdate IS NULL OR termdate = '';

ALTER table hr
modify column termdate date;

ALTER TABLE hr 
ADD COLUMN age INT;

SELECT * FROM hr;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate,CURDATE());

SELECT birthdate,age FROM hr;

SELECT gender, COUNT(*) AS gender_count
FROM hr
WHERE age>=18 and termdate IS NULL
GROUP BY gender;