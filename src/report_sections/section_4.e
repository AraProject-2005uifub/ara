note
	description: "Summary description for {SECTION_4}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECTION_4

create
	make

feature -- INit

	make (cursor: ITERATION_CURSOR [WSF_VALUE]; cookie: STRING)
		require
			cursor_not_void: cursor /= Void
			cookie_not_void: cookie /= Void
			cookie_not_empty: not (cookie ~ "")
		local
			head_of_unit_cookie, patent_country, patent_description: STRING
			patent: PATENT
			i: INTEGER
		do
			head_of_unit_cookie := cookie
			create patents.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "patient_country" + i.out)
			loop
				patent_country := cursor.item.string_representation
				cursor.forth
				patent_description := cursor.item.string_representation
				cursor.forth
				create patent.make_with_data (patent_country, patent_description)
				patents.force (patent, i)
				i := i + 1
			end
			create licenses.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "license_info"+i.out)
			loop
				licenses.force (cursor.item.string_representation, i)
				cursor.forth
				i := i + 1
			end
		ensure
			patents_not_empty: not patents.is_empty
			licenses_not_empty: not licenses.is_empty
		end

feature -- Access

	patents: ARRAY [PATENT]

	licenses: ARRAY [STRING]

end
