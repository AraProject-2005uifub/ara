note
	description: "Summary description for {PRIZE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRIZE
create
	make_with_data

feature -- Init
	make_with_data(l_recepient, l_name, l_granting_institution, l_date: STRING)
		do
			recepient := l_recepient
			name := l_name
			granting_institution := l_granting_institution
			date := l_date
		end

feature -- Access
	recepient, name, granting_institution, date: STRING
end
