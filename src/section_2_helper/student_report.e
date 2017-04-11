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

	make_with_data (l_student_name, l_report_title, l_publication_plans: STRING)
		require
			student_name_not_void: l_student_name /= Void
			report_title_not_void: l_report_title /= Void
			publication_plans_not_void: l_publication_plans /= Void
		do
			student_name := l_student_name
			report_title := l_report_title
			publication_plans := l_publication_plans
		ensure
			student_name_set: student_name ~ l_student_name
			report_title_set: report_title ~ l_report_title
			publication_plans_set: publication_plans ~ l_publication_plans
		end

feature -- Access

	student_name, report_title, publication_plans: STRING

end
