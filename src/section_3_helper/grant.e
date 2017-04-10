note
	description: "Summary description for {GRANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRANT

create
	make_with_data

feature -- Init

	make_with_data (l_project_title, l_granting_agency, l_grant_period_start, l_grant_period_end, l_grant_continuation, l_grant_amount: STRING)
		require
			project_title_not_void: project_title /= Void
			granting_agency_not_void: granting_agency /= Void
			grant_period_start_not_void: grant_period_start /= Void
			grant_period_end_not_void: grant_period_end /= Void
			grant_continuation_not_void: grant_continuation /= Void
			grant_amount_not_void: grant_amount /= Void
		do
			project_title := l_project_title
			granting_agency := l_granting_agency
			grant_period_start := l_grant_period_start
			grant_period_end := l_grant_period_end
			grant_continuation := l_grant_continuation
			grant_amount := l_grant_amount
		ensure
			project_title_set: project_title ~ l_project_title
			granting_agency_set: granting_agency ~ l_granting_agency
			grant_period_start_set: grant_period_start ~ l_grant_period_start
			grant_period_end_set: grant_period_end ~ l_grant_period_end
			grant_continuation_set: grant_continuation ~ l_grant_continuation
			grant_amount_set: grant_amount ~ l_grant_amount
		end

feature -- Access

	project_title, granting_agency, grant_period_start, grant_period_end, grant_continuation, grant_amount: STRING

end
