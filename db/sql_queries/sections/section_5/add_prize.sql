-- add_prize.sql

-- recipient, report_id, report_id recipient,
-- title, granting_institution, date

INSERT OR IGNORE INTO unit_members (
	name,
	unit_id
)
VALUES (
	"$",
	(SELECT unit_id FROM reports WHERE id == "$")
);
--|
INSERT OR REPLACE INTO prizes (
	report_id,
	recipient_unit_member_id,
	title,
	granting_organization_name,
	a_date
)
VALUES (
	"$",
	(SELECT id FROM unit_members WHERE name = "$"),
	"$",
	"$",
	date("$")
);
--|