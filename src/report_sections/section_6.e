note
	description: "Summary description for {SECTION_6}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECTION_6
create
	make

feature -- Init
	make(cursor: ITERATION_CURSOR[WSF_VALUE]; cookie: STRING)
		require
			cursor_not_void: cursor /= Void
			cookie_not_void: cookie /= Void
			cookie_not_empty: not (cookie ~ "")
		local
			company, nature: STRING
			collaboration: COLLABORATION
			i: INTEGER
		do
			head_of_unit_cookie := cookie
			create collaborations.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "company"+i.out)
			loop
				company := cursor.item.string_representation
				cursor.forth
				nature := cursor.item.string_representation
				cursor.forth
				create collaboration.make_with_data (company, nature)
				collaborations.force (collaboration, i)
				i := i + 1
			end
		ensure
			collaborations_not_empty: not collaborations.is_empty
		end

feature -- Access
	collaborations: ARRAY[COLLABORATION]
	head_of_unit_cookie: STRING
end
