note
	description: "Summary description for {THESIS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	THESIS
create
	make_with_data

feature -- Init
	make_with_data(l_student_name, l_degree, l_supervisor_name, l_other, l_institute, l_title: STRING)
	do
		student_name := l_student_name
		degree := l_degree
		supervisor_name := l_supervisor_name
		other := l_other
		institute := l_institute
		title := l_title
	end
feature -- Access
	student_name, degree, supervisor_name, other, institute, title: STRING

end
