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
	make_with_data(l_name, l_date: STRING)
		do
			name := l_name
			date := l_date
		end
feature -- Access
	name, date: STRING

end
