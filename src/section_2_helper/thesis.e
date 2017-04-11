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

	make_with_data (l_student_name, l_degree, l_supervisor_name, l_other, l_institute, l_title: STRING)
		require
			student_name_not_void: l_student_name /= Void
			degree_not_void: l_degree /= Void
			supervisor_name_not_void: l_supervisor_name /= Void
			other_not_void: l_other /= Void
			institute_not_void: l_institute /= Void
			title_not_void: l_title /= Void
		do
			student_name := l_student_name
			degree := l_degree
			supervisor_name := l_supervisor_name
			other := l_other
			institute := l_institute
			title := l_title
		ensure
			student_name_set: student_name ~ l_student_name
			degree_set: degree ~ l_degree
			supervisor_name_set: supervisor_name ~ l_supervisor_name
			other_set: other ~ l_other
			institute_set: institute ~ l_institute
			title_set: title ~ l_title
		end

feature -- Access

	student_name, degree, supervisor_name, other, institute, title: STRING

end
