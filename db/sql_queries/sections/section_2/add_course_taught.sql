-- add_course_taught.sql

-- report_id, name_of_course, 
-- semester, level, num_of_students

INSERT INTO courses_taught (
	report_id, 
	name, 
	semester, 
	level_id, 
	num_of_students
)
VALUES(
	"$",
	"$",
	"$",
	(SELECT id FROM levels WHERE name = "$"),
	"$"
);
--|