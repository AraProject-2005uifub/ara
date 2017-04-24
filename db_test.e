note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	DB_TEST

inherit
	EQA_TEST_SET

feature
	db: DB_ADAPTER

feature -- Test routines

	db_first_init_test
			-- New test routine
		do
			create db.db_first_init
		end

	db_open_test
		do
			create db.open
		end

	db_init_if_need_or_open
		do
			create db.init_if_need_or_open
		end

	db_add_admin_test
		do
			create db.init_if_need_or_open
			db.add_admin ("dsaffsd", "dsaffsd", "dsaffsd")
		end

	db_add_university_admin_test
		do
			create db.init_if_need_or_open
			db.add_university_admin ("dasda", "dsaffsd", "dsaffsd")
		end

	db_add_head_of_unit_test
		do
			create db.init_if_need_or_open
			db.add_head_of_unit ("dsaasdfffsd", "dsaffsd", "dsaffsd")
		end

	update_cookie_test
		do
			create db.init_if_need_or_open
			db.update_cookie ("adminf", "asdads")
		end

	check_user_role_by_cookie_test
		local
			s:STRING
		do
			create db.init_if_need_or_open
			s:=db.check_user_role_by_cookie ("asdas")
		end

	check_password_test
		local
			s:STRING
		do
			create db.init_if_need_or_open
			s := db.check_password ("asd", "sad")
		end

	get_all_publications_during_several_years_test
		local
			a :ARRAY2[STRING]
		do
			create db.init_if_need_or_open
			a := db.get_all_publications_during_several_years ("2000", "2099")
		end

	get_all_publications_of_a_given_unit_during_several_years_test
		local
			a :ARRAY2[STRING]
		do
			create db.init_if_need_or_open
			a := db.get_all_publications_of_a_given_unit_during_several_years("2000", "2099", "saad")
		end

	get_courses_taught_by_unit_in_a_given_period_test
		local
			a:ARRAY2[STRING]
		do
			create db.init_if_need_or_open
			a := db.get_courses_taught_by_unit_in_a_given_period("2000", "2099", "asqwe")
		end


end

