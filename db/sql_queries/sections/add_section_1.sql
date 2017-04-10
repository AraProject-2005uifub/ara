-- add_section_1.sql

-- name_of_unit, head_of_unit_cookie, 
-- name_of_unit, start_of_period, 
-- end_of_period, head_of_unit_cookie

INSERT or IGNORE INTO units (
	name, 
	head_of_unit_username
)
VALUES (
	"$", 
	(SELECT username FROM users WHERE cookie == "$")
);

INSERT INTO reports (
	unit_id, 
	start_of_period, 
	end_of_period, 
	head_of_unit_cookie
)
VALUES (
	(SELECT id FROM units WHERE name == "$"), 
	"$", 
	"$", 
	(SELECT username FROM users WHERE cookie == "$")
);
