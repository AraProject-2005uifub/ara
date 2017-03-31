note
	description: "[
		application execution
	]"
	date: "$Date: 2016-10-21 09:45:18 -0800 (Fri, 21 Oct 2016) $"
	revision: "$Revision: 99331 $"

class
	ARAPROJECT_EXECUTION

inherit

	WSF_EXECUTION

create
	make

feature {NONE} -- Initialization

	db: DB_ADAPTER
		once ("OBJECT")
			create Result.open
				--	Result.add_admin ("Admin Adminich", "admin", "admin", "111")
		end

feature -- Execution

	execute
			-- Use `request' to get data for the incoming http request
			-- and `response' to send response back to the client
		local
				--	mesg: WSF_PAGE_RESPONSE
			header: HTTP_HEADER
			html_page: WSF_FILE_RESPONSE
			answer, role_db: STRING
			user: USER
			report_iterator: ITERATION_CURSOR [WSF_VALUE]
		do
				--| As example, you can use {WSF_PAGE_RESPONSE}
				--| To send back easily a simple plaintext message.
				-- create mesg.make_with_body ("Hello Eiffel Web")
				-- response.send (mesg)
			if request.is_get_request_method then
				if request.path_info.same_string ("/") then
					create html_page.make_html ("www/index.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/auth/") then
					create html_page.make_html ("www/auth.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/admin/") then
					create html_page.make_html ("www/admin.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/report/") then
					create html_page.make_html ("www/report.html")
					response.send (html_page)
				end
			elseif request.is_post_request_method then
				if request.path_info.same_string ("/auth/") then
					create user.make
					if attached {WSF_STRING} request.form_parameter ("username") as username then
						user.set_username (username.string_representation)
					end
					if attached {WSF_STRING} request.form_parameter ("password") as password then
						user.set_password (password.string_representation)
					end
					role_db := db.check_password (user.username, user.password)
					if role_db ~ "admin" then
						if attached {WSF_STRING} request.cookie ("session_id") as session then
							db.update_cookie (user.username, session.string_representation)
						end
						response.set_status_code ({HTTP_STATUS_CODE}.found)
						response.redirect_now ("/admin/")
					else
						create html_page.make_html ("www/auth_bad.html/")
						response.send (html_page)
					end
						--					if user.username ~ "admin" and user.password ~ "admin" then
						--						response.set_status_code ({HTTP_STATUS_CODE}.found)
						--						response.redirect_now ("/admin/")
						--					else
						--						if user.username ~ "prof1" and user.password ~ "password" then
						--							response.set_status_code ({HTTP_STATUS_CODE}.found)
						--							response.redirect_now ("/report/")
						--						else
						--							create html_page.make_html ("www/auth_bad.html")
						--							response.send(html_page)
						--						end
						--					end
				elseif request.path_info.same_string ("/add_user/") then
					create user.make
					if attached {WSF_STRING} request.form_parameter ("full_name") as full_name then
						user.set_full_name (full_name.string_representation)
					end
					if attached {WSF_STRING} request.form_parameter ("username") as username then
						user.set_username (username.string_representation)
					end
					if attached {WSF_STRING} request.form_parameter ("password") as password then
						user.set_password (password.string_representation)
					end
					if attached {WSF_STRING} request.form_parameter ("role") as role then
						user.set_role (role.string_representation)
					end
					if user.role ~ "sysadmin" then
						db.add_admin (user.full_name, user.username, user.password, "bruh")
					elseif user.role ~ "uadministrator" then
						db.add_univerity_admin (user.full_name, user.username, user.password, "bruh")
					end
					response.set_status_code ({HTTP_STATUS_CODE}.found)
					response.redirect_now ("/admin/")
				elseif request.path_info.same_string ("/report_submit/") then
					create user.make
					from
						report_iterator := request.form_parameters.new_cursor
					until
						report_iterator.after
					loop
						user.add_data (report_iterator.item)
					end
				end
			end
		end

end
