note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SECTION_1_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	section1_create_and_addition_to_db_test
			-- New test routine
		local
			section1: SECTION_1

			it_cursor:ITERATION_CURSOR[WSF_VALUE]

			head_of_unit_cookie: STRING
			-- To identify user and his report.

			name_of_unit: STRING

			name_of_head_of_unit: STRING

			start_of_period: STRING
					-- Please, keep it in format YYYY-MM-DD

			end_of_period: STRING
					-- Please, keep it in format YYYY-MM-DD
		do
			
		end

end


