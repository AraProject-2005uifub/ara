note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SECTION_2_HELPER_TEST

inherit
	EQA_TEST_SET

feature
	course: COURSE
	exam:EXAMINATION
	student:STUDENT
	student_report:STUDENT_REPORT
	thesis:THESIS

feature -- Test routines

	course_create_test
		do
			create course.make_with_data("a", "b", "c", "1")
		end

	exam_create_test
		do
			create exam.make_with_data ("a", "b", "c", "1")
		end

	student_create_test
		do
			create student.make_with_data ("a", "a")
		end

	student_report_create_test
		do
			create student_report.make_with_data ("a", "b", "c")
		end

	thesis_create_test
		do
			create thesis.make_with_data ("a", "b", "c", "d", "e", "f")
		end

end


