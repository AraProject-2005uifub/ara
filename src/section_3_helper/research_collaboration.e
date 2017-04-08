note
	description: "Summary description for {RESEARCH_COLLABORATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESEARCH_COLLABORATION
create
	make_with_data

feature -- Init
	make_with_data(l_country, l_institution_name, l_contacts, l_nature: STRING)
	do
		country := l_country
		institution_name := l_institution_name
		contacts := l_contacts
		nature := l_nature
	end
feature -- Access
	country, institution_name, contacts, nature: STRING

end
