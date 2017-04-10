-- add_phd_thesis.sql

-- student_name, supervisor_name,report_id, 
-- degree_granting_organization_name,
-- degree, report_id,
-- student_name, title, degree, 
-- supervisor_name, degree_granting_organization_name

INSERT OR IGNORE INTO students (
	name
)
VALUES (
	"$"
);
--|
INSERT OR IGNORE INTO unit_members (
	name,
	unit_id
)
VALUES (
	"$",
	(SELECT unit_id FROM reports WHERE id == "$")
);
--|
INSERT INTO organizations (
	name,
	type_id
)
VALUES (
	"$",
	(SELECT id FROM organization_types WHERE name = "University")
);
--|
INSERT INTO degrees (
	name
)
VALUES (
	"$"
);
--|
INSERT INTO phd_theses (
	report_id, 
	student_id, 
	title, 
	degree_id, 
	supervisor_id, 
	degree_granting_organization_id
)
VALUES(
	"$",
	(SELECT id FROM students WHERE name = "$"),
	"$",
	(SELECT id FROM degrees WHERE name = "$"),
	(SELECT id FROM unit_members WHERE name = "$"),
	(SELECT id FROM organizations WHERE name = "$")
);
--|
