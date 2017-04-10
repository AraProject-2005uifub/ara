note
	description: "Class for database. For clients: use DB class instead."
	date: "17.03.2017"
	revision: "1"

class
	DB_ADAPTER

create
	db_first_init, open, init_if_need_or_open

feature -- Constant statements

	frozen db_file_name: STRING = "db/main.db"

	frozen new_db_creation_query: STRING = "db/new_db.sql"

	frozen default_insertions_statement: STRING = "db/first_inserts.sql"

	frozen sql_queries_path: STRING = "db/sql_queries/"

	frozen admin_alias_string: STRING = "admin"

	frozen head_of_unit_alias_string: STRING = "head_of_unit"

	frozen ui_admin_alias_string: STRING = "ui_admin"

feature {NONE} -- Secret constant elements

	frozen password_salt: STRING = "sdmv12 3k e"

feature -- Initialization

	db_first_init
			-- Initializes a new main database.
			--s
			-- WARNING! If db exists, it will be dropped and recreated!
		require
			db_file_name_correct: is_normal_string (db_file_name)
		do
			log ("creating new DB file")
			if db_file_exist then
				(create {RAW_FILE}.make_with_name (db_file_name)).delete
				log ("old DB deleted")
			end
			create db.make_create_read_write (db_file_name)
			execute_insertion_query_from_file (new_db_creation_query)
			log (db_file_name + " is created successfully!")
			execute_insertion_query_from_file (default_insertions_statement)
			log (db_file_name + " is filled with default values.")
		end

	open
			-- Opens existing database with such name.
		require
			db_file_exist
		do
			log ("opening existing DB file")
			create db.make_open_read_write (db_file_name)
			log (db_file_name + " is opened successfully!")
		end

	init_if_need_or_open
			-- Inits db if the file is not found,
			-- opens if possible.
		do
			log ("trying to open or create DB, according to its existence")
			if db_file_exist then
				open
			else
				db_first_init
			end
		end

feature {NONE} -- Implementation

	db: SQLITE_DATABASE
			-- Main database variable. Should be opened for the whole time of using database.

	execute_insertion_query (a_query: STRING)
			-- Executes a query with gaining no data.
		require
		local
			db_insert_statement: SQLITE_INSERT_STATEMENT
		do
			log ("attempt to execute_insertion_query: query = " + a_query)
			create db_insert_statement.make (a_query, db)
			db_insert_statement.execute
		end

	execute_insertion_query_from_file (a_file_name: STRING)
			-- Executes query from sql files
		require
			db_opened: not db.is_closed
			a_file_name_not_empty: is_normal_string (a_file_name)
		local
			query: STRING
			sql_file: PLAIN_TEXT_FILE
		do
			create sql_file.make_open_read (a_file_name)
			sql_file.read_stream (sql_file.count)
			query := sql_file.last_string
			sql_file.close
			execute_insertion_query (query)
		end

	execute_selection_query_from_file_with_args (a_file_name: STRING; args: ARRAY [STRING]): ARRAY2 [STRING]
		require
			a_file_name_not_empty: is_normal_string (a_file_name)
			args_not_empty: True -- TODO FIX
			-- TODO check bounds of the array
		local
			query: STRING
			i, r: INTEGER
		do
			query := read_whole_file (a_file_name)
			from
				i := args.lower
			until
				i > args.upper or query.index_of ('$', 1) = 0
			loop
				r := query.index_of ('$', 1)
				query.remove (r)
				query.insert_string (args.at (i), r)
				i := i + 1
			end
			Result := execute_selection_query (query)
		end

	execute_inertion_query_from_file_with_args (a_file_name: STRING; args: ARRAY [STRING])
		require
			a_file_name_not_empty: is_normal_string (a_file_name)
			args_not_empty: True -- TODO FIX
			-- TODO check bounds of the array
		local
			query: STRING
			i, r: INTEGER
		do
			query := read_whole_file (a_file_name)
			from
				i := args.lower
			until
				i > args.upper or query.index_of ('$', 1) = 0
			loop
				r := query.index_of ('$', 1)
				query.remove (r)
				query.insert_string (args.at (i), r)
				i := i + 1
			end
			separate_and_execute_insertion_query (query)
		end

	execute_selection_query (a_query: STRING): ARRAY2 [STRING]
		local
			db_query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			col, row: INTEGER
		do
			log ("atempt to execute_selection_query: query = " + a_query)
			create Result.make_filled ("", 1, 1)
			create db_query_statement.make (a_query, db)
			cursor := db_query_statement.execute_new
			from
				cursor.start
				row := 1
			until
				cursor.after
			loop
				from
					col := 1
				until
					col > cursor.item.count.as_integer_32
				loop
					Result.resize_with_default ("", row, col)
					Result.put (cursor.item.string_value (col.as_natural_32), row, col)
					col := col + 1
				end
				cursor.forth
				row := row + 1
			end
			log ("execute_selection_query: finished successfully")
		end

	separate_and_execute_insertion_query (query: STRING)
		require
			query_not_empty_and_attached: is_normal_string (query)
		local
			prev_delim_ind, curr_delim_ind: INTEGER
			subquery: STRING
		do
			from
				prev_delim_ind := 0
				subquery := ""
			until
				prev_delim_ind >= query.count or query.index_of ('|', prev_delim_ind + 1) = 0
			loop
				curr_delim_ind := query.index_of ('|', prev_delim_ind + 1)
				subquery := query.substring (prev_delim_ind + 1, curr_delim_ind - 3)
				prev_delim_ind := curr_delim_ind
				execute_insertion_query (subquery)
			end
		end

	read_whole_file (a_file_name: STRING): STRING
		require
			a_file_name_not_empty: is_normal_string (a_file_name)
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make_open_read (a_file_name)
			file.read_stream (file.count)
			Result := file.last_string
		end

	hash_password (password: STRING): STRING
		local
			query: STRING
			hash: STRING
		do
			hash := password + password_salt
			Result := hash.hash_code.to_hex_string
		end

	log (log_string: STRING)
			-- Logs
		do
			io.put_string ("DB: " + log_string + "%N")
		end

feature -- Insertion queries

	add_admin (name: STRING; username: STRING; password: STRING)
		local
			query_file_name: STRING
			unit_member_id: STRING
			hash: STRING
			args: ARRAY [STRING]
		do
			query_file_name := sql_queries_path + "add_or_change_password_admin.sql"
			create args.make_from_array (<<name, username, hash_password (password)>>)
			execute_inertion_query_from_file_with_args (query_file_name, args)
		end

	add_university_admin (name: STRING; username: STRING; password: STRING)
		local
			query_file_name: STRING
			unit_member_id: STRING
			hash: STRING
			args: ARRAY [STRING]
		do
			query_file_name := sql_queries_path + "add_or_change_password_university_admin.sql"
			create args.make_from_array (<<name, username, hash_password (password)>>)
			execute_inertion_query_from_file_with_args (query_file_name, args)
		end

	add_head_of_unit (name, username, password: STRING)
			-- Adds user in the table
		local
			query_file_name: STRING
			unit_member_id: STRING
			hash: STRING
			args: ARRAY [STRING]
		do
			query_file_name := sql_queries_path + "add_or_change_password_head_of_unit.sql"
			create args.make_from_array (<<name, name, username, hash_password (password), name>>)
			execute_inertion_query_from_file_with_args (query_file_name, args)
		end

	update_cookie (username, cookie: STRING)
		require
			username_not_empty: is_normal_string (username)
			cookie_not_empty: is_normal_string (cookie)
		local
			query: STRING
		do
			query := "UPDATE users SET cookie = %"" + cookie + "%" WHERE username = %"" + username + "%";"
			execute_insertion_query (query)
		end

	check_user_role_by_cookie (cookie: STRING): STRING
		require
			username_not_empty: is_normal_string (cookie)
		local
			reply: ARRAY [STRING]
		do
			reply := execute_selection_query ("SELECT kind_of_user_id FROM users WHERE cookie == %"" + cookie + "%";")
			if reply.is_empty then
				Result := ""
			elseif reply [1] ~ "1" then
				Result := admin_alias_string
			elseif reply [1] ~ "2" then
				Result := head_of_unit_alias_string
			elseif reply [1] ~ "3" then
				Result := ui_admin_alias_string
			end
		end

feature -- Report fill

	add_section_1 (a_section_1: SECTION_1)
			-- Writes info from the argument into the database.
		require
			a_section_1_not_void: a_section_1 /= Void
		local
			query_file_name: STRING
			args: ARRAY [STRING]
		do
			query_file_name := sql_queries_path + "sections/add_section_1.sql"
				-- Query args sequence:
				-- name_of_unit, head_of_unit_cookie,
				-- name_of_unit, start_of_period,
				-- end_of_period, head_of_unit_cookie
			create args.make_from_array (<<a_section_1.name_of_unit, a_section_1.head_of_unit_cookie, a_section_1.name_of_unit, a_section_1.start_of_period, a_section_1.end_of_period, a_section_1.head_of_unit_cookie>>)
			execute_inertion_query_from_file_with_args (query_file_name, args)
		end

	add_section_2 (a_section_2: SECTION_2)
			-- Writes info from the argument into the database.
		require
			a_section_2_not_void: a_section_2 /= Void
		local
			query_file_name, report_id: STRING
			args: ARRAY [STRING]
			i: INTEGER
		do
			query_file_name := "db/sql_queries/get_report_id.sql"
				-- head_of_unit_cookie
			create args.make_from_array (<<a_section_2.head_of_unit_cookie>>)
			report_id := execute_selection_query_from_file_with_args (query_file_name, args).item (1, 1)
			query_file_name := "db/sql_queries/sections/section_2/add_course_taught.sql"
				-- report_id, name_of_course,
				-- semester, level, num_of_students
			from
				i := a_section_2.courses.lower
			until
				i > a_section_2.courses.upper
			loop
				create args.make_from_array (<<report_id, a_section_2.courses.at (i).course_name, a_section_2.courses.at (i).semester, a_section_2.courses.at (i).level, a_section_2.courses.at (i).number_of_students>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
			query_file_name := "db/sql_queries/sections/section_2/add_examination.sql"
				-- report_id, name_of_course,
				-- semester, kind_of_exam, num_of_students
			from
				i := a_section_2.examinations.lower
			until
				i > a_section_2.examinations.upper
			loop
				create args.make_from_array (<<report_id, a_section_2.examinations.at (i).course_name, a_section_2.examinations.at (i).semester, a_section_2.examinations.at (i).kind_of_exam, a_section_2.examinations.at (i).number_of_students>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
			query_file_name := "db/sql_queries/sections/section_2/add_phd_thesis.sql"
				-- student_name, supervisor_name,report_id,
				-- degree_granting_organization_name,
				-- degree, report_id,
				-- student_name, title, degree,
				-- supervisor_name, degree_granting_organization_name
			from
				i := a_section_2.theses.lower
			until
				i > a_section_2.theses.upper
			loop
				create args.make_from_array (<<a_section_2.theses.at (i).student_name, a_section_2.theses.at (i).supervisor_name, report_id, a_section_2.theses.at (i).institute, a_section_2.theses.at (i).degree, report_id, a_section_2.theses.at (i).student_name, a_section_2.theses.at (i).title, a_section_2.theses.at (i).degree, a_section_2.theses.at (i).supervisor_name, a_section_2.theses.at (i).institute>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
			query_file_name := "db/sql_queries/sections/section_2/add_student_report.sql"
				-- student_name, report_id,
				-- student_name, title, publication_plans
			from
				i := a_section_2.students_reports.lower
			until
				i > a_section_2.students_reports.upper
			loop
				create args.make_from_array (<<a_section_2.students_reports.at (i).student_name, report_id, a_section_2.students_reports.at (i).student_name, a_section_2.students_reports.at (i).report_title, a_section_2.students_reports.at (i).publication_plans>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
			query_file_name := "db/sql_queries/sections/section_2/add_student_supervised.sql"
				-- student_name, report_id,
				-- student_name, nature_of_work
			from
				i := a_section_2.students.lower
			until
				i > a_section_2.students.upper
			loop
				create args.make_from_array (<<a_section_2.students.at (i).student_name, report_id, a_section_2.students.at (i).student_name, a_section_2.students.at (i).nature_of_work>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
		end

	add_section_3 (a_section_3: SECTION_3)
			-- Writes info from the argument into the database.
		require
			a_section_3_not_void: a_section_3 /= Void
		local
			query_file_name, report_id: STRING
			args: ARRAY [STRING]
			i: INTEGER
		do
			query_file_name := "db/sql_queries/get_report_id.sql"
				-- head_of_unit_cookie
			create args.make_from_array (<<a_section_3.head_of_unit_cookie>>)
			report_id := execute_selection_query_from_file_with_args (query_file_name, args).item (1, 1)
			query_file_name := "db/sql_queries/sections/section_3/add_conference_publication.sql"
				-- report_id, title
			from
				i := a_section_3.conference_publications.lower
			until
				i > a_section_3.conference_publications.upper
			loop
				create args.make_from_array (<<report_id, a_section_3.conference_publications.at (i)>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
			query_file_name := "db/sql_queries/sections/section_3/add_journal_publication.sql"
				-- report_id, title
			from
				i := a_section_3.journal_publications.lower
			until
				i > a_section_3.journal_publications.upper
			loop
				create args.make_from_array (<<report_id, a_section_3.journal_publications.at (i)>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
			query_file_name := "db/sql_queries/sections/section_3/add_grant.sql"
				-- granting_agency_name,
				-- report_id, title,
				-- granting_agency_name,
				-- start_of_period, end_of_period,
				-- prev_grant_name, amount
				-- report_id, title
			from
				i := a_section_3.grants.lower
			until
				i > a_section_3.grants.upper
			loop
				create args.make_from_array (<<a_section_3.grants.at (i).granting_agency, report_id, a_section_3.grants.at (i).project_title, a_section_3.grants.at (i).granting_agency, a_section_3.grants.at (i).grant_period_start, a_section_3.grants.at (i).grant_period_end, a_section_3.grants.at (i).grant_continuation, a_section_3.grants.at (i).grant_amount, report_id, a_section_3.grants.at (i).project_title>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
			query_file_name := "db/sql_queries/sections/section_3/add_research_collaboration.sql"
				-- country_of_institution_name,
				-- institution_name, report_id,
				-- country_of_institution_name,
				-- institution_name,
				-- contact_with_institution
			from
				i := a_section_3.research_collaborations.lower
			until
				i > a_section_3.research_collaborations.upper
			loop
				create args.make_from_array (<<a_section_3.research_collaborations.at (i).country, a_section_3.research_collaborations.at (i).institution_name, report_id, a_section_3.research_collaborations.at (i).country, a_section_3.research_collaborations.at (i).institution_name, a_section_3.research_collaborations.at (i).contacts>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
			query_file_name := "db/sql_queries/sections/section_3/add_research_project.sql"
				-- report_id, title, inno_personnel_involved,
				-- external_personnel_involved,
				-- start_of_period, end_of_period,
				-- sources_of_financing
			from
				i := a_section_3.research_projects.lower
			until
				i > a_section_3.research_projects.upper
			loop
				create args.make_from_array (<<report_id, a_section_3.research_projects.at (i).project_title, a_section_3.research_projects.at (i).inno_personnel_involved, a_section_3.research_projects.at (i).external_personnel, a_section_3.research_projects.at (i).start_date, a_section_3.research_projects.at (i).end_date, a_section_3.research_projects.at (i).source_of_financing>>)
				execute_inertion_query_from_file_with_args (query_file_name, args)
				i := i + 1
			end
		end

feature -- Selection queries

	check_password (username, password: STRING): STRING
		require
			username_not_empty: is_normal_string (username)
			password_not_empty: is_normal_string (password)
		local
			hash: STRING
			reply: ARRAY [STRING]
		do
			create reply.make_filled ("", 1, 1)
			Result := ""
			hash := password + password_salt
			hash := hash.hash_code.to_hex_string
			reply := execute_selection_query ("SELECT kind_of_user_id FROM users WHERE username == %"" + username + "%" AND password == %"" + hash + "%";")
			if reply.is_empty then
				Result := ""
			elseif reply [1] ~ "1" then
				Result := admin_alias_string
			elseif reply [1] ~ "2" then
				Result := head_of_unit_alias_string
			elseif reply [1] ~ "3" then
				Result := ui_admin_alias_string
			end
		end

feature -- Contract checkers

	db_file_exist: BOOLEAN
		require
			a_file_name_correct: is_normal_string (db_file_name)
		do
			Result := (create {RAW_FILE}.make_with_name (db_file_name)).exists
		end

	is_normal_string (a_string: STRING): BOOLEAN
			-- Returns if string is not void and not empty.
		do
			Result := a_string /= Void and not a_string.is_empty
		end

feature -- Data retrieval for university administrators

	get_all_publications_of_a_given_year (year: STRING): ARRAY2[STRING]
		do
		end

	information_of_a_unit_over_several_years (unit_name: STRING; start_year: STRING; end_year: STRING): ARRAY2[STRING]
		do
		end

	courses_taught_by_unit_between_dates (unit_name: STRING; start_date: STRING; end_date: STRING): ARRAY2[STRING]
		do
		end

invariant
	db_opened: not db.is_closed

end
