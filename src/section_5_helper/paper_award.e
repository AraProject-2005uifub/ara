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

	make_with_data (l_author, l_title, l_conference, l_wording, l_date: STRING)
		require
			author_not_void: l_author /= Void
			title_not_void: l_title /= Void
			conference_not_void: l_conference /= Void
			wording_not_void: l_wording /= Void
			date_not_void: l_date /= Void
		do
			author := l_author
			title := l_title
			conference := l_conference
			wording := l_wording
			date := l_date
		ensure
			author_set: author ~ l_author
			title_set: title ~ l_title
			conference_set: conference ~ l_conference
			wording_set: wording ~ l_wording
			date_set: date ~ l_date
		end

feature -- Access

	author, title, conference, wording, date: STRING

end
