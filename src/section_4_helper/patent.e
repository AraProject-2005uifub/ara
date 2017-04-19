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
	make_with_data(l_country, l_description: STRING)
	do
		country := l_country
		description := l_description
	end

feature -- Access
	country, description: STRING;

end
