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
	make_with_data(l_student_name, l_nature_of_work: STRING)
	do
		student_name := l_student_name
		nature_of_work := l_nature_of_work
	end
feature -- Access
	student_name, nature_of_work: STRING
end
