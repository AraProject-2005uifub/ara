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
			-- New test routine
		do
			create user.make
		end

	user_make_valid
		do
			create user.make_with_username_password("name", "login", "Password")
		end
--	user_make_invalid
--		do
--			create user.make_with_username_password (Void, Void, Void)
--		end
	set_fields_valid
		do
			create user.make
			user.set_full_name("name")
			user.set_username("username")
			user.set_password("password")
			user.set_role("role")
			user.set_cookie_session("cookie")
		end

--	set_fields_invalid
--		do
--			create user.make
--			user.set_full_name(Void)
--			user.set_username(Void)
--			user.set_password(Void)
--			user.set_role(Void)
--			user.set_cookie_session(Void)
--		end

end


