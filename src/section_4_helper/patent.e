note
	description: "Summary description for {PATIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PATENT

create
	make_with_data

feature -- Init

	make_with_data (l_country, l_description: STRING)
		require
			country_not_void: l_country /= Void
			description_not_void: l_description /= Void
		do
			country := l_country
			description := l_description
		ensure
			country_set: country ~ l_country
			description_set: description ~ l_description
		end

feature -- Access

	country, description: STRING;

end
