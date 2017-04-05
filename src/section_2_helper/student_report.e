note
	description: "Summary description for {STUDENT_REPORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_REPORT
create
	make_with_data

feature -- Init
	make_with_data(l_student_name, l_report_title, l_publication_plans: STRING)
	do
		student_name := l_student_name
		report_title := l_report_title
		publication_plans := l_publication_plans
	end
feature -- Access
	student_name, report_title, publication_plans: STRING
end
