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

feature -- Execution

	execute
			-- Use `request' to get data for the incoming http request
			-- and `response' to send response back to the client
		local
				--	mesg: WSF_PAGE_RESPONSE
			html_page: WSF_FILE_RESPONSE
			answer: STRING
			data: ARRAY [STRING]
		do
				--| As example, you can use {WSF_PAGE_RESPONSE}
				--| To send back easily a simple plaintext message.
				-- create mesg.make_with_body ("Hello Eiffel Web")
				-- response.send (mesg)
			if request.is_get_request_method then
				if request.path_info.same_string ("/") then
					create html_page.make_html ("www\index.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/auth/") then
					create html_page.make_html ("www\auth.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/admin/") then
					create html_page.make_html ("www\admin.html")
					response.send (html_page)
				elseif request.path_info.same_string ("/report/") then
					create html_page.make_html ("www\report.html")
					response.send (html_page)
				end
			elseif request.is_post_request_method then
				if request.path_info.same_string ("/auth/") then
					create data.make_filled ("", 1, 2)
					if attached {WSF_STRING} request.form_parameter ("username") as username then
						data.put (username.string_representation, 1)
					end
					if attached {WSF_STRING} request.form_parameter ("password") as password then
						data.put (password.string_representation, 2)
					end
					if data.at (1) ~ "admin" and data.at (2) ~ "admin" then
						response.set_status_code ({HTTP_STATUS_CODE}.found)
						response.redirect_now ("/admin/")
					else
						if data.at (1) ~ "prof1" and data.at (2) ~ "password" then
							response.set_status_code ({HTTP_STATUS_CODE}.found)
							response.redirect_now ("/report/")

						else
							create answer.make_from_string ("Invalid username or password")
							response.put_header ({HTTP_STATUS_CODE}.ok, <<["Content-type", "text/html"], ["Content-lenght", answer.count.out]>>)
							response.put_string (answer)
						end
					end
				end
			end
		end

end
