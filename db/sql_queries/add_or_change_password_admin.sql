-- add_or_change_password_admin.sql

-- name, username, password

INSERT or REPLACE INTO users (
	name, 
	username, 
	password, 
	kind_of_user_id
) 
VALUES ( 
	"$", 
	"$", 
	"$", 
	1
);