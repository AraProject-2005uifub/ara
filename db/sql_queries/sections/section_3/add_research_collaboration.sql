-- add_research_collaboration.sql

-- country_of_institution_name, 
-- institution_name, report_id,
-- country_of_institution_name,
-- institution_name,
-- contact_with_institution

INSERT OR IGNORE INTO countries (
	name
)
VALUES(
	"$"
);
--|
INSERT OR IGNORE INTO organizations (
	name,
	type_id
)
VALUES(
	"$",
	(SELECT id FROM organization_types WHERE name = "Institution")
);
--|
INSERT INTO research_collaborations (
	report_id,
	country_of_institution_id,
	institution_id,
	contact_with_institution
)
VALUES (
	"$",
	(SELECT id FROM countries WHERE name = "$"),
	"$",
	"$"
);
--|
