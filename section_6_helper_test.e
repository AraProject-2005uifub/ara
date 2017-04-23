note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SECTION_6_HELPER_TEST

inherit
	EQA_TEST_SET

feature
	collaboration: COLLABORATION

feature -- Test routines

	collaboration_create_test
		do
			create collaboration.make_with_data ("a", "b")
		end

end


