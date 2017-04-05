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
	make(cursor: ITERATION_CURSOR[WSF_VALUE]; cookie: STRING)
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
		create courses.make_empty
		from
			i := 1
		until
			 cursor.after or not (cursor.item.name ~ "course_name"+i.out)
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
			io.put_string (courses.at (i).course_name+" "+courses.at (i).semester+" "+courses.at (i).level+" "+courses.at (i).number_of_students)
			io.new_line
			i := i+1
		end
		create examinations.make_empty
		from
			i := 1
		until
			 cursor.after or not (cursor.item.name ~ "e_course_name"+i.out)
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
			io.put_string (examinations.at (i).course_name+" "+examinations.at (i).semester+" "+examinations.at (i).kind_of_exam+" "+examinations.at (i).number_of_students)
			io.new_line
			i := i+1
		end
		create students.make_empty
		from
			i := 1
		until
			cursor.after or not (cursor.item.name ~ "student_name"+i.out)
		loop
			student_name := cursor.item.string_representation
			cursor.forth
			nature_of_work := cursor.item.string_representation
			cursor.forth
			create student.make_with_data (student_name, nature_of_work)
			students.force (student, i)
			io.put_string (students.at (i).student_name + " " + students.at (i).nature_of_work)
			io.new_line
			i := i+1
		end
		create students_reports.make_empty
		from
			i := 1
		until
			cursor.after or not (cursor.item.name ~ "r_student_name"+i.out)
		loop
			student_name := cursor.item.string_representation
			cursor.forth
			report_title := cursor.item.string_representation
			cursor.forth
			publication_plans := cursor.item.string_representation
			cursor.forth
			create student_report.make_with_data (student_name, report_title, publication_plans)
			students_reports.force (student_report, i)
			io.put_string (students_reports.at (i).student_name + " " + students_reports.at (i).report_title + " " + students_reports.at(i).publication_plans)
			io.new_line
			i := i+1
		end
		create theses.make_empty
		from
			i := 1
		until
			cursor.after or not (cursor.item.name ~ "t_student_name"+i.out)
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
			io.put_string (theses.at (i).student_name + " " + theses.at (i).degree + " " + theses.at(i).supervisor_name + " " + theses.at (i).other + " " + theses.at (i).institute + " " + theses.at (i).title)
			io.new_line
			i := i+1
		end
	end

feature -- Access
	courses: ARRAY[COURSE]
	examinations: ARRAY[EXAMINATION]
	students: ARRAY[STUDENT]
	students_reports: ARRAY[STUDENT_REPORT]
	theses: ARRAY[THESIS]
end
