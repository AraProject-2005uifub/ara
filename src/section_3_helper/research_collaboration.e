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

	make_with_data (l_country, l_institution_name, l_contacts, l_nature: STRING)
		require
			country_not_void: l_country /= Void
			institution_name_not_void: l_institution_name /= Void
			contacts_not_void: l_contacts /= Void
			nature_not_void: l_nature /= Void
		do
			country := l_country
			institution_name := l_institution_name
			contacts := l_contacts
			nature := l_nature
		ensure
			country_set: country ~ l_country
			institution_name_set: institution_name ~ l_institution_name
			contacts_set: contacts ~ l_contacts
			nature_set: nature ~ l_nature
		end

feature -- Access

	country, institution_name, contacts, nature: STRING

end
