note
	description: "Summary description for {RESEARCH_PROJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESEARCH_PROJECT
create
	make_with_data

feature -- Init
	make_with_data(l_project_title, l_inno_personnel_involved, l_external_personnel, l_start_date, l_end_date, l_source_of_financing: STRING)
	do
		project_title := l_project_title
		inno_personnel_involved := l_inno_personnel_involved
		external_personnel := l_external_personnel
		start_date := l_start_date
		end_date := l_end_date
		source_of_financing := l_source_of_financing
	end
feature -- Access
	project_title, inno_personnel_involved, external_personnel, start_date, end_date, source_of_financing: STRING

end
