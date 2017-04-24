note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SECTION_4_HELPER_TEST

inherit
	EQA_TEST_SET

feature
	patent :PATENT

feature -- Test routines

	patent_create_test
			-- New test routine
		do
			create patent.make_with_data ("a", "b")
		end

end


