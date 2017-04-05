note
	description: "Summary description for {COURSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COURSE
create
	make_with_data

feature -- INit
	make_with_data(l_course_name, l_semester, l_level, l_number_of_students: STRING)
	do
		course_name := l_course_name
		semester := l_semester
		level := l_level
		number_of_students := l_number_of_students
	end

feature -- Access
	course_name, semester, level, number_of_students: STRING
end
