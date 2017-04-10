-- add_or_change_password_university_admin.sql

-- name, username, password

INSERT OR REPLACE INTO users (
	name, 
	username, 
	password, 
	kind_of_user_id
) 
VALUES ( 
	"$", 
	"$", 
	"$", 
	2
);
