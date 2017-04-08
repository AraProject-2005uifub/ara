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
	make_with_data(l_project_title, l_granting_agency, l_grant_period_start, l_grant_period_end, l_grant_continuation, l_grant_amount: STRING)
	do
		project_title := l_project_title
		granting_agency := l_granting_agency
		grant_period_start := l_grant_period_start
		grant_period_end := l_grant_period_end
		grant_continuation := l_grant_continuation
		grant_amount := l_grant_amount
	end
feature -- Access
	project_title, granting_agency, grant_period_start, grant_period_end, grant_continuation, grant_amount: STRING

end
