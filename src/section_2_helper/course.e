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

	make_with_data (l_course_name, l_semester, l_level, l_number_of_students: STRING)
		require
			course_name_not_void: l_course_name /= Void
			semester_not_void: l_semester /= Void
			level_not_void: l_level /= Void
			l_number_of_students: l_number_of_students /= Void
		do
			course_name := l_course_name
			semester := l_semester
			level := l_level
			number_of_students := l_number_of_students
		ensure
			course_name_set: course_name ~ l_course_name
			semester_set: semester ~ l_semester
			level_set: level ~ l_level
			number_of_students_set: number_of_students ~ l_number_of_students
		end

feature -- Access

	course_name, semester, level, number_of_students: STRING

end
