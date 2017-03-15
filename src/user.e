note
	description: "Summary description for {USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USER

create
	make,
	make_with_username_password

feature -- Initialization
	make
		do
			create username.make_empty
			create password.make_empty
			create cookie_session.make_empty
		end

	make_with_username_password(l_username, l_password: STRING)
		require
			username_not_void: l_username /= Void
			password_not_void: l_password /= Void
		do
			username := l_username
			password := l_password
			create cookie_session.make_empty
		ensure
			username_is_set: l_username = username
			password_is_set: l_password = password
		end
feature -- Setters and getters
	set_username(l_username: STRING)
		require
			username_not_void: l_username /= Void
		do
			username := l_username
		ensure
			username_is_set: l_username = username
		end

	set_password(l_password: STRING)
		require
			password_not_void: l_password /= Void
		do
			password := l_password
		ensure
			password_is_set: l_password = password
		end

	set_cookie_session(l_cookie_session: STRING)
		require
			cookie_session_not_void: l_cookie_session /= Void
		do
			cookie_session := l_cookie_session
		ensure
			cookie_session_is_set: l_cookie_session = cookie_session
		end
		
feature -- Access
	username, password, cookie_session: STRING;
end
