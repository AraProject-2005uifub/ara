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
	make_with_data(l_course_name, l_semester, l_kind_of_exam, l_number_of_students: STRING)
	do
		course_name := l_course_name
		semester := l_semester
		kind_of_exam := l_kind_of_exam
		number_of_students := l_number_of_students
	end

feature -- Access
	course_name, semester, kind_of_exam, number_of_students: STRING
end
