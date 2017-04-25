-- clear_section_3.sql

-- report_id * 4

DELETE FROM publications
WHERE report_id = "$";
--|
DELETE FROM grants
WHERE report_id = "$";
--|
DELETE FROM research_collaborations
WHERE report_id = "$";
--|
DELETE FROM research_projects
WHERE report_id = "$";
--|
