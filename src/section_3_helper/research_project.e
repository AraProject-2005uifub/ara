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

	make_with_data (l_project_title, l_inno_personnel_involved, l_external_personnel, l_start_date, l_end_date, l_source_of_financing: STRING)
		require
			project_title_not_void: project_title /= Void
			inno_personnel_involved_not_void: inno_personnel_involved /= Void
			external_personnel_not_void: external_personnel /= Void
			start_date_not_void: start_date /= Void
			end_date_not_void: end_date /= Void
			source_of_financing_not_void: source_of_financing /= Void
		do
			project_title := l_project_title
			inno_personnel_involved := l_inno_personnel_involved
			external_personnel := l_external_personnel
			start_date := l_start_date
			end_date := l_end_date
			source_of_financing := l_source_of_financing
		ensure
			project_title_set: project_title ~ l_project_title
			inno_personnel_involved_set: inno_personnel_involved ~ l_inno_personnel_involved
			external_personnel_set: external_personnel ~ l_external_personnel
			start_date_set: start_date ~ l_start_date
			end_date_set: end_date ~ l_end_date
			source_of_financing_set: source_of_financing ~ l_source_of_financing
		end

feature -- Access

	project_title, inno_personnel_involved, external_personnel, start_date, end_date, source_of_financing: STRING

end
