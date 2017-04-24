-- add_patent.sql

-- report_id, title,
-- description, country_name

INSERT OR UPDATE INTO patents (
	report_id,
	title,
	description,
	patent_office_country_id
)
VALUES (
	"$",
	"$",
	"$",
	(SELECT id FROM countries WHERE name = "$")
);
--|