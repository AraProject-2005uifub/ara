-- clear_section_4.sql

-- report_id * 2

DELETE FROM ip_licensies
WHERE report_id = "$";
--|
DELETE FROM patents
WHERE report_id = "$";
--|
