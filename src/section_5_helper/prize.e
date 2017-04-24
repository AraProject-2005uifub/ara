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

	make_with_data (l_recepient, l_name, l_granting_institution, l_date: STRING)
		require
			recepient_not_void: l_recepient /= Void
			name_not_void: l_name /= Void
			granting_institution_not_void: l_granting_institution /= Void
			date_not_void: l_date /= Void
		do
			recepient := l_recepient
			name := l_name
			granting_institution := l_granting_institution
			date := l_date
		ensure
			recepient_set: recepient ~ l_recepient
			name_set: name ~ l_name
			granting_institution_set: granting_institution ~ l_granting_institution
			date_set: date ~ l_date
		end

feature -- Access

	recepient, name, granting_institution, date: STRING

end
