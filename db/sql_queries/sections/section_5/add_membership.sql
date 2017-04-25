-- add_membership.sql

-- report_id, name, date

INSERT OR REPLACE INTO memberships (
	report_id,
	name,
	a_date
)
VALUES (
	"$",
	"$",
	date("$")
);
--|