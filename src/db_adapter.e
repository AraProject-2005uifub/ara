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

feature -- Initialization

	db_first_init
			-- Initializes a new main database.
			--
			-- WARNING! If db exists, it will be dropped and recreated!
		require
			file_name_correct (db_file_name)
		do
			create db.make_create_read_write (db_file_name)
			execute_insertion_query_from_file (new_db_creation_query)
			io.put_string ("DB " + db_file_name + " is created successfully!")
			execute_insertion_query_from_file (default_insertions_statement)
			io.put_string ("DB " + db_file_name + " is filled with default values.")
		end

	open
			-- Opens existing database with such name.
		require
			db_file_exist (db_file_name)
		do
			create db.make_open_read_write (db_file_name)
			io.put_string ("DB " + db_file_name + " is opened successfully!")
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
			create db_insert_statement.make (a_query, db)
			db_insert_statement.execute
		end

	execute_insertion_query_from_file (file_name: STRING)
			-- Executes query from sql files
		require
			db_opened: not db.is_closed
		local
			query: STRING
			sql_file: PLAIN_TEXT_FILE
		do
			create sql_file.make_open_read (file_name)
			sql_file.read_stream (sql_file.count)
			query := sql_file.last_string
			sql_file.close
			execute_insertion_query (query)
		end

	execute_selection_query (query: STRING): ARRAY [STRING]
		local
			db_query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			i: NATURAL
			reply: ARRAY [STRING]
		do
			create reply.make_empty
			create db_query_statement.make (query, db)
			cursor := db_query_statement.execute_new
			from
				cursor.start
				i := 1
			until
				cursor.after
			loop
				reply.force (cursor.item.string_value (i), i.as_integer_32)
					-- reply.put (cursor.item.string_value (i), i.as_integer_32)
				cursor.forth
				i := i + 1
			end
			Result := reply
		end

feature -- Queries running

	add_admin (name: STRING; username: STRING; password: STRING; cookie: STRING)
		local
			query: STRING
			hash: STRING
		do
			hash := password + "sdmv12 3k e"
			hash := hash.hash_code.to_hex_string
			query := "INSERT INTO users (name, username, password, cookie, kind_of_user_id) VALUES (%"" + name + "%", %"" + username + "%", %"" + hash + "%", %"" + cookie + "%", 1);"
			execute_insertion_query (query)
		end

	add_univerity_admin (name: STRING; username: STRING; password: STRING; cookie: STRING)
		local
			query: STRING
			hash: STRING
		do
			hash := password + "sdmv12 3k e"
			hash := hash.hash_code.to_hex_string
			query := "INSERT INTO users (name, username, password, cookie, kind_of_user_id) VALUES (%"" + name + "%", %"" + username + "%", %"" + hash + "%", %"" + cookie + "%", 3);"
			execute_insertion_query (query)
		end

	check_password (username, password: STRING): STRING
		local
			hash: STRING
			reply: ARRAY [STRING]
		do
			create reply.make_filled ("", 1, 1)
			Result := ""
			hash := password + "sdmv12 3k e"
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

		--	add_head_of_unit(name: STRING; unit_name: STRING; username: STRING; password: STRING; cookie: STRING)
		--			-- Adds user in the table
		--		local
		--			query: STRING
		--		do
		--		--	query := "INSERT INTO unit_members  VALUES

		--		end

	update_cookie (username, cookie: STRING)
		local
			query: STRING
		do
			query := "UPDATE users SET cookie = %"" + cookie + "%" WHERE username = %"" + username + "%";"
			execute_insertion_query (query)
		end

feature -- Precondition checkers

	db_file_exist (a_file_name: STRING): BOOLEAN
			-- Checks if db file with such name exists.
			-- FIXME! ! ! -- doesn't work at all
		require
			file_name_correct (a_file_name)
		do
				-- TODO: Check if works as validator for file existence: and (create {RAW_FILE}.make_with_name (a_file_name)).exists
			Result := True
		end

	file_name_correct (a_file_name: STRING): BOOLEAN
			-- Returns if filename is not void and not empty.
		do
			Result := a_file_name /= Void and not a_file_name.is_empty
		end

invariant
	db_opened: not db.is_closed

end
