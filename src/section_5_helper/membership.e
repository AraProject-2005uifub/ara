note
	description: "Summary description for {MEMBERSHIP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEMBERSHIP

create
	make_with_data

feature -- Init

	make_with_data (l_name, l_date: STRING)
		require
			name_not_void: l_name /= Void
			date_not_void: l_date /= Void
		do
			name := l_name
			date := l_date
		ensure
			name_set: name ~ l_name
			date_set: date ~ l_date
		end

feature -- Access

	name, date: STRING

end
