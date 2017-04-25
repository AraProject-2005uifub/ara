-- add_patent.sql

-- country_name, report_id,
-- description, country_name

INSERT OR IGNORE INTO countries (
	name
)
VALUES(
	"$"
);
--|
INSERT OR REPLACE INTO patents (
	report_id,
	description,
	patent_office_country_id
)
VALUES (
	"$",
	"$",
	(SELECT id FROM countries WHERE name = "$")
);
--|