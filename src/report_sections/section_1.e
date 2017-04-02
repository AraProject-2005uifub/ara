note
	description: "Class for section 1 of the report."
	date: "02.04.2017"

class
	SECTION_1

create
	make

feature {NONE} -- Initialization

	make (cursor: ITERATION_CURSOR [WSF_VALUE])
			-- Iterates through a given cursor to get and fill
			-- some fields of the class.
		do
			-- TODO: for Timur
			create head_of_unit_cookie.make_empty
			create name_of_unit.make_empty
			create start_of_period.make_empty
			create end_of_period.make_empty
		end


feature -- Fields

	head_of_unit_cookie: STRING
			-- To identify user and his report.

	name_of_unit: STRING

	start_of_period: STRING
			-- Please, keep it in format YYYY-MM-DD

	end_of_period: STRING
			-- Please, keep it in format YYYY-MM-DD
end
