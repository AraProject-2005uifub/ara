note
	description: "Summary description for {COLLABORATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COLLABORATION

create
	make_with_data

feature -- Init

	make_with_data (l_company, l_nature: STRING)
		require
			company_not_void: l_company /= Void
			nature_not_void: l_nature /= Void
		do
			company := l_company
			nature := l_nature
		ensure
			company_set: company ~ l_company
			nature_set: nature ~ l_nature
		end

feature -- Access

	company, nature: STRING

end
