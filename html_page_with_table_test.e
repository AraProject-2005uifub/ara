note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HTML_PAGE_WITH_TABLE_TEST

inherit

	EQA_TEST_SET

feature

	page: HTML_PAGE_WITH_TABLE

feature -- Test routines

	html_page_with_table_make
			-- New test routine
		local
			array: ARRAY2 [STRING]
		do
			create array.make_filled ("s", 1, 1)
			create page.make (array)
		end

--	html_page_with_table_make_invalid
--			-- New test routine
--		local
--			array: ARRAY2 [STRING]
--		do
--			create page.make (array)
--		end

	html_page_make_from_several_arrays
		local
			array1: ARRAY2 [STRING]
			array2: ARRAY2 [STRING]
			array: ARRAY [ARRAY2 [STRING]]
		do
			create array1.make_filled ("s", 1, 1)
			create array2.make_filled ("s", 1, 1)
			create array.make (1, 2)
			array [1] := array1
			array [2] := array2
			create page.make_from_several_arrays (array)
		end

--	html_page_make_from_several_arrays_invalid
--		local
--			array1: ARRAY2 [STRING]
--			array2: ARRAY2 [STRING]
--			array: ARRAY [ARRAY2 [STRING]]
--		do
--			create page.make_from_several_arrays (array)
--		end

	html_page_creation
		local
			array1: ARRAY2 [STRING]
			array2: ARRAY2 [STRING]
			array: ARRAY [ARRAY2 [STRING]]
			s: STRING
		do
			create array1.make_filled ("s", 1, 1)
			create array2.make_filled ("s", 1, 1)
			create array.make (1, 2)
			array [1] := array1
			array [2] := array2
			create page.make_from_several_arrays (array)
			s := page.create_html_from_local_table
		end

end
