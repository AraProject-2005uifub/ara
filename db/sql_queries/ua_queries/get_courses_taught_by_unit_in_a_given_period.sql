-- get_courses_taught_by_unit_in_a_given_period.sql

-- start_year, end_year, unit_name

SELECT 
	courses_taught.name AS "Course name", 
	courses_taught.semester AS "Semester",
	levels.name AS "Level"
FROM
	(courses_taught
		INNER JOIN levels ON levels.id = courses_taught.level_id)
			INNER JOIN reports ON courses_taught.report_id = reports.id
				AND (reports.start_of_period >= "$" 
							OR reports.end_of_period <= "$")
					AND reports.unit_id in (SELECT id FROM units WHERE name == "$");