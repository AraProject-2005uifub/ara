-- add_prize.sql

-- recipient, report_id, recipient,
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
INSERT OR RELPACE INTO prizes (
	recipient_unit_member_id,
	title,
	granting_organization_id,
	a_date
)
VALUES (
	(SELECT id FROM unit_members WHERE name = "$"),
	"$",
	(SELECT id FROM organizations WHERE name = "$"),
	date("$")
);
--|