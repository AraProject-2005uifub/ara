note
	description: "Summary description for {PUBLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PUBLICATION

create
	make_with_data

feature -- Init

	make_with_data (l_publication, l_date: STRING)
		require
			publication_not_void: l_publication /= Void
			date_not_void: l_date /= Void
		do
			publication := l_publication
			date := l_date
		ensure
			publication_set: publication ~ l_publication
			date_set: date ~ l_date 
		end

feature -- Access

	publication, date: STRING

end
