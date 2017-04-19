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
	make_with_data(l_company, l_nature: STRING)
		do
			company := l_company
			nature := l_nature
		end
feature -- Access
	company, nature: STRING

end
