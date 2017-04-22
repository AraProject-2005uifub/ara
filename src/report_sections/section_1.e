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
		require
			cursor_not_void: cursor /= Void
			cookie_not_void: cookie /= Void
			cookie_not_empty: not (cookie ~ "")
		local
			start_year, end_year: INTEGER
		do
			head_of_unit_cookie := cookie
			name_of_unit := cursor.item.string_representation
			cursor.forth
			name_of_head_of_unit := cursor.item.string_representation
			cursor.forth

			-- Start of period is assuming from YYYY-08-15, as it is a date
			-- of starting of the student's year in Innopolis university.
			-- End of period is 1 year ahead, minus 1 day, to avoid overlapping.
			start_year := cursor.item.string_representation.to_integer
			end_year := start_year + 1
			start_of_period := start_year.out + "-08-15"
			end_of_period := end_year.out + "-08-14"
		ensure
			cookie_set: head_of_unit_cookie = cookie
			name_of_unit_set: name_of_unit /= old name_of_unit
			start_of_period_set: start_of_period /= old start_of_period
			end_of_period_set: end_of_period /= old end_of_period
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
