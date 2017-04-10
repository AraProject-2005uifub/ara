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
			-- To get access to admin panel: admin:admin
			-- To get access to head of unit page: prof:prof
			-- To get access to uadmin page: uadmin:uadmin
		local
			header: HTTP_HEADER
			html_page: WSF_FILE_RESPONSE
			answer, role_db: STRING
			user: USER
			report_iterator: ITERATION_CURSOR [WSF_VALUE]
			report_general: SECTION_1
			report_teaching: SECTION_2
			report_research: SECTION_3
		do
			if request.is_get_request_method then
				if request.path_info.same_string ("/") then
					create html_page.make_html ("www/index.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/auth/") or request.path_info.same_string ("/auth") then
					create html_page.make_html ("www/auth.html")
					if attached {WSF_VALUE}request.cookie ("session_id") as session then
						io.put_string ("Eiffel Web Server: New user connection with cookie '"+session.string_representation+"'")
						io.new_line
					end
					response.send (html_page)
				elseif request.path_info.same_string ("/admin/") or request.path_info.same_string ("/admin") then
					create html_page.make_html ("www/admin.html")
					if attached {WSF_VALUE}request.cookie ("session_id") as session then
						io.put_string ("Eiffel Web Server: System Administrator with cookie '"+session.string_representation+"' accessed admin page")
						io.new_line
					end
					response.send (html_page)
				elseif request.path_info.same_string("/report_general/") or request.path_info.same_string ("/report_general") then
					create html_page.make_html ("www/report_general.html")
					if attached {WSF_VALUE}request.cookie ("session_id") as session then
						io.put_string ("Eiffel Web Server: Head of Unit with cookie '"+session.string_representation+"' accessed report page")
						io.new_line
					end
					response.send (html_page)
				elseif request.path_info.same_string ("/report_teaching/") or request.path_info.same_string ("/report_teaching") then
					create html_page.make_html ("www/report_teaching.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/report_research/") or request.path_info.same_string ("/report_research") then
					create html_page.make_html ("www/report_research.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/report_successful/") or request.path_info.same_string ("/report_successful") then
					create html_page.make_html ("www/report_successful.html/")
					response.send (html_page)
				elseif request.path_info.same_string ("/ua_main/") or request.path_info.same_string ("/ua_main") then
					create html_page.make_html ("www/ua_main.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/ua_courses/") or request.path_info.same_string ("/ua_courses") then
					create html_page.make_html ("www/ua_courses.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/ua_information/") or request.path_info.same_string ("/ua_information") then
					create html_page.make_html ("www/ua_information.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/ua_publications/") or request.path_info.same_string ("/ua_publications") then
					create html_page.make_html ("www/ua_publications.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/404/") then
					create html_page.make_html ("www/404.html")
					response.send (html_page)
				else
					response.set_status_code ({HTTP_STATUS_CODE}.found)
					response.redirect_now ("/404/")
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
					elseif role_db ~ "head_of_unit" then
						if attached {WSF_STRING} request.cookie ("session_id") as session then
							db.update_cookie (user.username, session.string_representation)
						end
						response.set_status_code ({HTTP_STATUS_CODE}.found)
						response.redirect_now ("/report_teaching/")
					elseif role_db ~ "ui_admin" then
						if attached {WSF_STRING} request.cookie ("session_id") as session then
							db.update_cookie (user.username, session.string_representation)
						end
						response.set_status_code ({HTTP_STATUS_CODE}.found)
						response.redirect_now ("/ua_main/")
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
						db.add_admin (user.full_name, user.username, user.password)
					elseif user.role ~ "uadministrator" then
						db.add_university_admin (user.full_name, user.username, user.password)
					elseif user.role ~ "headofunit" then
						db.add_head_of_unit (user.full_name, user.username, user.password)
					end
					response.set_status_code ({HTTP_STATUS_CODE}.found)
					response.redirect_now ("/admin/")
				elseif request.path_info.same_string ("/report_general/") then
					report_iterator := request.form_parameters.new_cursor
					if attached {WSF_VALUE}request.cookie ("session_id") as session then
						create report_general.make (report_iterator, session.string_representation)
					end
					response.set_status_code ({HTTP_STATUS_CODE}.found)
					response.redirect_now ("/report_teaching/")
				elseif request.path_info.same_string ("/report_teaching/") then
					if attached {WSF_VALUE}request.cookie ("session_id") as session then
						create report_teaching.make (request.form_parameters.new_cursor, session.string_representation)
					end
					response.set_status_code ({HTTP_STATUS_CODE}.found)
					response.redirect_now ("/report_research/")
				elseif request.path_info.same_string ("/report_research/") then
					if attached {WSF_VALUE}request.cookie ("session_id") as session then
						create report_research.make (request.form_parameters.new_cursor, session.string_representation)
					end
					response.set_status_code ({HTTP_STATUS_CODE}.found)
					response.redirect_now ("/report_successful/")
				elseif request.path_info.same_string ("/admin_choose/") then
					if attached {WSF_VALUE}request.form_parameter ("query") as query then
						response.set_status_code ({HTTP_STATUS_CODE}.found)
						if query.string_representation ~ "All publications of the university in a given year" then
							response.redirect_now ("/ua_publications/")
						elseif query.string_representation ~ "Information of a given unit over several years" then
							response.redirect_now ("/ua_information/")
						elseif query.string_representation ~ "Courses taught by a Laboratory between initial and final date" then
							response.redirect_now ("/ua_courses/")
						end
					end

				end
			end
		end

end
