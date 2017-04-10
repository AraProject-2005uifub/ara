note
	description: "Summary description for {SECTION_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECTION_2

create
	make

feature -- Init

	make (cursor: ITERATION_CURSOR [WSF_VALUE]; cookie: STRING)
		require
			cursor_not_void: cursor /= Void
			cookie_not_void: cookie /= Void
			cookie_not_empty: cookie /= ""
		local
			i: INTEGER
			course_name, semester, level, number_of_students, kind_of_exam, student_name, nature_of_work: STRING
			report_title, publication_plans, degree, supervisor_name, other, institute, title: STRING
			course: COURSE
			examination: EXAMINATION
			student: STUDENT
			student_report: STUDENT_REPORT
			thesis: THESIS
		do
			head_of_unit_cookie := cookie
			create courses.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "course_name" + i.out)
			loop
				course_name := cursor.item.string_representation
				cursor.forth
				semester := cursor.item.string_representation
				cursor.forth
				level := cursor.item.string_representation
				cursor.forth
				number_of_students := cursor.item.string_representation
				cursor.forth
				create course.make_with_data (course_name, semester, level, number_of_students)
				courses.force (course, i)
				i := i + 1
			end
			create examinations.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "e_course_name" + i.out)
			loop
				course_name := cursor.item.string_representation
				cursor.forth
				semester := cursor.item.string_representation
				cursor.forth
				kind_of_exam := cursor.item.string_representation
				cursor.forth
				number_of_students := cursor.item.string_representation
				cursor.forth
				create examination.make_with_data (course_name, semester, kind_of_exam, number_of_students)
				examinations.force (examination, i)
				i := i + 1
			end
			create students.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "student_name" + i.out)
			loop
				student_name := cursor.item.string_representation
				cursor.forth
				nature_of_work := cursor.item.string_representation
				cursor.forth
				create student.make_with_data (student_name, nature_of_work)
				students.force (student, i)
				i := i + 1
			end
			create students_reports.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "r_student_name" + i.out)
			loop
				student_name := cursor.item.string_representation
				cursor.forth
				report_title := cursor.item.string_representation
				cursor.forth
				publication_plans := cursor.item.string_representation
				cursor.forth
				create student_report.make_with_data (student_name, report_title, publication_plans)
				students_reports.force (student_report, i)
				i := i + 1
			end
			create theses.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "t_student_name" + i.out)
			loop
				student_name := cursor.item.string_representation
				cursor.forth
				degree := cursor.item.string_representation
				cursor.forth
				supervisor_name := cursor.item.string_representation
				cursor.forth
				other := cursor.item.string_representation
				cursor.forth
				institute := cursor.item.string_representation
				cursor.forth
				title := cursor.item.string_representation
				cursor.forth
				create thesis.make_with_data (student_name, degree, supervisor_name, other, institute, title)
				theses.force (thesis, i)
				i := i + 1
			end
		ensure
			courses_not_empty: not courses.is_empty
			examinations_not_empty: not examinations.is_empty
		end

feature -- Fields

	head_of_unit_cookie: STRING
			-- To identify user and his report.

	courses: ARRAY [COURSE]

	examinations: ARRAY [EXAMINATION]

	students: ARRAY [STUDENT]

	students_reports: ARRAY [STUDENT_REPORT]

	theses: ARRAY [THESIS]

end
