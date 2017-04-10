-- add_student_supervised.sql

-- student_name, report_id, 
-- student_name, nature_of_work

INSERT OR IGNORE INTO students (
	name
)
VALUES (
	"$"
);
--|
INSERT INTO students_supervised (
	report_id, 
	student_id, 
	nature_of_work
)
VALUES(
	"$",
	(SELECT id FROM students WHERE name = "$"),
	"$"
);
--|
