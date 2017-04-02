note
	description: "Class for database. For clients: use DB class instead."
	date: "17.03.2017"
	revision: "1"

class
	DB_ADAPTER

create
	db_first_init, open

feature -- Constant statements

	frozen db_file_name: STRING = "db/main.db"

	frozen new_db_creation_query: STRING = "db/new_db.sql"

	frozen default_insertions_statement: STRING = "db/first_inserts.sql"

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
			create db.make_create_read_write (db_file_name)
			execute_insertion_query_from_file (new_db_creation_query)
			log ("DB: " + db_file_name + " is created successfully!")
			execute_insertion_query_from_file (default_insertions_statement)
			log ("DB: " + db_file_name + " is filled with default values.")
		end

	open
			-- Opens existing database with such name.
		require
			db_file_exist (db_file_name)
		do
			create db.make_open_read_write (db_file_name)
			log ("DB: " + db_file_name + " is opened successfully!")
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
			log ("DB: attempt to execute_insertion_query: query = " + a_query)
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
			i: INTEGER
		do
			query := read_whole_file (a_file_name)
			from
				i := args.lower
			until
				i > args.upper
			loop
					-- TODO finish
					-- query.index_of ('$', 1)
				i := i + 1
			end
			Result := execute_selection_query (query)
		end

	execute_selection_query (a_query: STRING): ARRAY2 [STRING]
		local
			db_query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			col, row: INTEGER
		do
			log ("DB: atempt to execute_selection_query: query = " + a_query)
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
			log ("DB: execute_selection_query: finished successfully")
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

	log (log_string: STRING)
			-- Logs
		do
			io.put_string (log_string + "%N")
		end

feature -- Insertion queries

	add_admin (name: STRING; username: STRING; password: STRING)
		local
			query: STRING
			hash: STRING
		do
			hash := password + password_salt
			hash := hash.hash_code.to_hex_string
			query := "INSERT INTO users (name, username, password, kind_of_user_id) VALUES (%"" + name + "%", %"" + username + "%", %"" + hash + "%", 1);"
			execute_insertion_query (query)
		end

	add_university_admin (name: STRING; username: STRING; password: STRING)
		local
			query: STRING
			hash: STRING
		do
			hash := password + password_salt
			hash := hash.hash_code.to_hex_string
			query := "INSERT INTO users (name, username, password, kind_of_user_id) VALUES (%"" + name + "%", %"" + username + "%", %"" + hash + "%", 3);"
			execute_insertion_query (query)
		end

	add_head_of_unit (name, username, password: STRING)
			-- Adds user in the table
		local
			query: STRING
			unit_member_id: STRING
			hash: STRING
		do
			hash := password + password_salt
			hash := hash.hash_code.to_hex_string
			query := "INSERT INTO unit_members (unit_id, name) VALUES ( -1, %"" + name + "%");"
			execute_insertion_query (query)
			query := "SELECT id FROM unit_members WHERE name == %"" + name + "%");"
			unit_member_id := execute_selection_query (query).at (1)
			query := "INSERT INTO users (username, password, name, unit_memeber_id, kind_of_user_id) VALUES (%"" + name + "%", %"" + username + "%", %"" + hash + ", %"" + name + "%", %"" + unit_member_id + "%", 2);"
			execute_insertion_query (query)
		end

	add_section_1 (a_section_1: SECTION_1)
			-- Writes info from the argument into the database.
		require
			a_section_1_not_void: a_section_1 /= Void
		do
				--a_section_1.head_of_unit_cookie
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
				Result := "admin"
			elseif reply [1] ~ "2" then
				Result := "head_of_unit"
			elseif reply [1] ~ "3" then
				Result := "ui_admin"
			end
		end

feature -- Contract checkers

	db_file_exist (a_file_name: STRING): BOOLEAN
			-- Checks if db file with such name exists.
			-- FIXME! ! ! -- doesn't work at all
		require
			a_file_name_correct: is_normal_string (a_file_name)
		do
				-- TODO: Check if works as validator for file existence: and (create {RAW_FILE}.make_with_name (a_file_name)).exists
			Result := True
		end

	is_normal_string (a_string: STRING): BOOLEAN
			-- Returns if string is not void and not empty.
		do
			Result := a_string /= Void and not a_string.is_empty
		end

invariant
	db_opened: not db.is_closed

end
