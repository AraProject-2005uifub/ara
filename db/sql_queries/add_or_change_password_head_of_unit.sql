-- add_or_change_password_head_of_unit.sql

-- name, name, username,
-- password, name

INSERT OR IGNORE INTO unit_members (
	unit_id, 
	name
)
VALUES (
	-1,
	"$"
);

INSERT OR REPLACE INTO users (
	name, 
	username, 
	password, 
	kind_of_user_id, 
	unit_member_id
)
VALUES (
	"$", 
	"$", 
	"$", 
	"3", 
	(SELECT id FROM unit_members WHERE name == "$")
);
