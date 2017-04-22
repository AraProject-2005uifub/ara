note
	description: "Summary description for {SECTION_7}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECTION_7
create
	make

feature -- Init
	make(cursor: ITERATION_CURSOR[WSF_VALUE]; cookie: STRING)
		local
			head_of_unit_cookie: STRING
		do
			head_of_unit_cookie := cookie
			other := cursor.item.string_representation
		end

feature -- Access
	other: STRING

end
