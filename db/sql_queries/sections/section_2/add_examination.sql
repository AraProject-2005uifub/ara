-- add_examination.sql

-- report_id, name_of_course, 
-- semester, level, num_of_students

INSERT INTO examinations (
	report_id, 
	course_name, 
	kind_of_exam_id, 
	num_of_students
)
VALUES(
	"$",
	"$",
	(SELECT id FROM kinds_of_exams WHERE name = "$"),
	"$"
);
