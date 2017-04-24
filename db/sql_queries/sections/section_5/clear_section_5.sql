-- clear_section_5.sql

-- report_id * 3

DELETE FROM best_paper_awards
WHERE report_id = "$";
--|
DELETE FROM memberships
WHERE report_id = "$";
--|
DELETE FROM prizes
WHERE report_id = "$";
--|
