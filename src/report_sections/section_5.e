note
	description: "Summary description for {SECTION_5}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECTION_5

create
	make

feature -- Init
	make(cursor: ITERATION_CURSOR[WSF_VALUE]; cookie: STRING)
		require
			cursor_not_void: cursor /= Void
			cookie_not_void: cookie /= Void
			cookie_not_empty: not (cookie ~ "")
		local
			paper_award: PAPER_AWARD
			membership: MEMBERSHIP
			prize: PRIZE
			head_of_unit_cookie, author, title, conference, wording, date, name, recepient, granting_institution: STRING
			i: INTEGER
		do
			head_of_unit_cookie := cookie
			create paper_awards.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "author"+i.out)
			loop
				author := cursor.item.string_representation
				cursor.forth
				title := cursor.item.string_representation
				cursor.forth
				conference := cursor.item.string_representation
				cursor.forth
				wording := cursor.item.string_representation
				cursor.forth
				date := cursor.item.string_representation
				cursor.forth
				create paper_award.make_with_data (author, title, conference, wording, date)
				paper_awards.force (paper_award, i)
				i := i + 1
			end
			create memberships.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "member_name"+i.out)
			loop
				name := cursor.item.string_representation
				cursor.forth
				date := cursor.item.string_representation
				cursor.forth
				create membership.make_with_data (name, date)
				memberships.force (membership, i)
				i := i + 1
			end
			create prizes.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "recepient"+i.out)
			loop
				recepient := cursor.item.string_representation
				cursor.forth
				name := cursor.item.string_representation
				cursor.forth
				granting_institution := cursor.item.string_representation
				cursor.forth
				date := cursor.item.string_representation
				cursor.forth
				create prize.make_with_data (recepient, name, granting_institution, date)
				prizes.force (prize, i)
				i := i+1
			end
		ensure
			paper_awards_not_empty: not paper_awards.is_empty
			memberships_not_empty: not memberships.is_empty
			prizes_not_empty:  not prizes.is_empty
		end

feature -- Access
	paper_awards: ARRAY[PAPER_AWARD]
	memberships: ARRAY[MEMBERSHIP]
	prizes: ARRAY[PRIZE]
end
