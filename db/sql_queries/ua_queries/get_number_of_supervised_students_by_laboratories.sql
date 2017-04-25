-- get_number_of_supervised_students_by_laboratories.sql

SELECT 
	COUNT(*) AS "Total number of supervised students by all the laboratories"
FROM 
	students_supervised;