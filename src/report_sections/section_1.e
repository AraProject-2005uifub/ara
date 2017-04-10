note
	description: "Class for section 1 of the report."
	date: "02.04.2017"

class
	SECTION_1

create
	make

feature {NONE} -- Initialization

	make (cursor: ITERATION_CURSOR [WSF_VALUE]; cookie: STRING)
			-- Iterates through a given cursor to get and fill
			-- some fields of the class.
		do
			head_of_unit_cookie := cookie
			name_of_unit := cursor.item.string_representation
			cursor.forth
			name_of_head_of_unit := cursor.item.string_representation
			cursor.forth
			start_of_period := cursor.item.string_representation
			cursor.forth
			end_of_period := cursor.item.string_representation
		end


feature -- Fields

	head_of_unit_cookie: STRING
			-- To identify user and his report.

	name_of_unit: STRING

	name_of_head_of_unit: STRING

	start_of_period: STRING
			-- Please, keep it in format YYYY-MM-DD

	end_of_period: STRING
			-- Please, keep it in format YYYY-MM-DD

end
