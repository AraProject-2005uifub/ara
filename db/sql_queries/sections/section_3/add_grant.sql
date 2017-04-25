-- add_grant.sql

-- granting_agency_name,
-- report_id, title, 
-- granting_agency_name,
-- start_of_period, end_of_period,
-- prev_grant_name, amount

INSERT OR IGNORE INTO organizations (
	name,
	type_id
)
VALUES (
	"$",
	(SELECT id FROM organization_types WHERE name = "Granting agency")
);
--|
INSERT INTO grants (
	report_id, 
	title, 
	granting_agency_id, 
	start_of_period,
	end_of_period,
	previous_grant_name,
	amount
)
VALUES(
	"$",
	"$",
	(SELECT id FROM organizations WHERE name = "$"),
	date("$"),
	date("$"),
	"$",
	"$"
);
--|
