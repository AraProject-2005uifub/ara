-- clear_section_2.sql

-- report_id * 5

DELETE FROM courses_taught
WHERE report_id = "$";
--|
DELETE FROM examinations
WHERE report_id = "$";
--|
DELETE FROM phd_theses
WHERE report_id = "$";
--|
DELETE FROM student_reports
WHERE report_id = "$";
--|
DELETE FROM students_supervised
WHERE report_id = "$";
--|