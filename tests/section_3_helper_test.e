note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SECTION_3_HELPER_TEST

inherit
	EQA_TEST_SET

feature
	grant: GRANT
	publications: PUBLICATION
	research_collaboration:RESEARCH_COLLABORATION
	research_project:RESEARCH_PROJECT

feature -- Test routines

	grant_create_test
		do
			create grant.make_with_data ("a,", "b", "2016-12-12", "2016-12-12", "e", "1")
		end

	publications_create_test
		do
			create publications.make_with_data ("a", "2016-12-12")
		end

	research_collaboration_create_test
		do
			create research_collaboration.make_with_data ("a", "b", "c", "d")
		end

	research_project_create_test
		do
			create research_project.make_with_data ("a", "b", "c", "2016-12-12", "2016-12-12", "f")
		end

end


