note
	description: "Summary description for {EXAMINATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMINATION

create
	make_with_data

feature -- Init

	make_with_data (l_course_name, l_semester, l_kind_of_exam, l_number_of_students: STRING)
		require
			course_name_not_void: l_course_name /= Void
			semester_not_void: l_semester /= Void
			kind_of_exam_not_void: l_kind_of_exam /= Void
			number_of_students_not_void: l_number_of_students /= Void
		do
			course_name := l_course_name
			semester := l_semester
			kind_of_exam := l_kind_of_exam
			number_of_students := l_number_of_students
		ensure
			course_name_set: course_name ~ l_course_name
			semester_set: semester ~ l_semester
			kind_of_exam_set: kind_of_exam ~ l_kind_of_exam
			number_of_students_set: number_of_students ~ l_number_of_students
		end

feature -- Access

	course_name, semester, kind_of_exam, number_of_students: STRING

end
