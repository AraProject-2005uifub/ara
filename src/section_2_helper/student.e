note
	description: "Summary description for {STUDENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT

create
	make_with_data

feature -- Init

	make_with_data (l_student_name, l_nature_of_work: STRING)
		require
			student_name_not_void: l_student_name /= Void
			nature_of_work_not_void: l_nature_of_work /= Void
		do
			student_name := l_student_name
			nature_of_work := l_nature_of_work
		ensure
			student_name_set: student_name ~ l_student_name
			nature_of_work_set: nature_of_work ~ l_nature_of_work
		end

feature -- Access

	student_name, nature_of_work: STRING

end
