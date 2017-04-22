note
	description: "Summary description for {PAPER_AWARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAPER_AWARD

create
	make_with_data

feature -- Init

	make_with_data(l_author, l_title, l_conference, l_wording, l_date: STRING)
		do
			author := l_author
			title := l_title
			conference := l_conference
			wording := l_wording
			date := l_date
		end

feature -- Access
	author, title, conference, wording, date: STRING

end
