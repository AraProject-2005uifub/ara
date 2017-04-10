-- add_student_report.sql

-- student_name, report_id, 
-- student_name, title, publication_plans

INSERT OR IGNORE INTO students (
	name
)
VALUES (
	"$"
);

INSERT INTO student_reports (
	report_id, 
	student_id, 
	title, 
	publication_plans
)
VALUES(
	"$",
	(SELECT id FROM students WHERE name = "$"),
	"$",
	"$"
);
