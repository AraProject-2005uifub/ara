note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SECTION_5_HELPER_TEST

inherit
	EQA_TEST_SET

feature
	membership:MEMBERSHIP
	paper_award:PAPER_AWARD
	prize:PRIZE

feature -- Test routines

	membership_create_test
		do
			create membership.make_with_data ("a", "2016-12-12")
		end

	paper_award_create_test
		do
			create paper_award.make_with_data ("a", "b", "c", "d", "2016-12-12")
		end

	prize_create_test
		do
			create prize.make_with_data ("a", "b", "c", "2016-12-12")
		end

end


