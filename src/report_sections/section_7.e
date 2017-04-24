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
		require
			cursor_not_void: cursor /= Void
			cookie_not_void: cookie /= Void
			cookie_not_empty: not (cookie ~ "")
		local
			head_of_unit_cookie: STRING
		do
			head_of_unit_cookie := cookie
			other := cursor.item.string_representation
		ensure
			other_not_empty: not other.is_empty
		end

feature -- Access
	other: STRING

end
