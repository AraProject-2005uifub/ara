note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_USER

inherit
	EQA_TEST_SET

feature -- Variables
	user:USER

feature -- Test routines

	user_make_empty
		do
			create user.make
		end

	user_make
		do
			create user.make_with_username_password("name", "login", "Password")
		end

	set_fields
		do
			create user.make
			user.set_full_name("name")
			user.set_username("username")
			user.set_password("password")
			user.set_role("role")
			user.set_cookie_session("cookie")
		end
end


