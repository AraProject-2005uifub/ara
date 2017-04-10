note
	description: "Summary description for {SECTION_3}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECTION_3

create
	make

feature -- Init

	make (cursor: ITERATION_CURSOR [WSF_VALUE]; cookie: STRING)
		local
			i: INTEGER
			project_title, granting_agency, grant_period_start, grant_period_end, grant_continuation, grant_amount: STRING
			inno_personnel_involved, external_personnel, start_date, end_date, source_of_financing, country, institution_name: STRING
			contacts, nature: STRING
			grant: GRANT
			research_project: RESEARCH_PROJECT
			research_collaboration: RESEARCH_COLLABORATION
		do
			head_of_unit_cookie := cookie

			create grants.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "project_title" + i.out)
			loop
				project_title := cursor.item.string_representation
				cursor.forth
				granting_agency := cursor.item.string_representation
				cursor.forth
				grant_period_start := cursor.item.string_representation
				cursor.forth
				grant_period_end := cursor.item.string_representation
				cursor.forth
				grant_continuation := cursor.item.string_representation
				cursor.forth
				grant_amount := cursor.item.string_representation
				cursor.forth
				create grant.make_with_data (project_title, granting_agency, grant_period_start, grant_period_end, grant_continuation, grant_amount)
				grants.force (grant, i)
				i := i + 1
			end
			create research_projects.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "r_project_title" + i.out)
			loop
				project_title := cursor.item.string_representation
				cursor.forth
				inno_personnel_involved := cursor.item.string_representation
				cursor.forth
				external_personnel := cursor.item.string_representation
				cursor.forth
				start_date := cursor.item.string_representation
				cursor.forth
				end_date := cursor.item.string_representation
				cursor.forth
				source_of_financing := cursor.item.string_representation
				cursor.forth
				create research_project.make_with_data (project_title, inno_personnel_involved, external_personnel, start_date, end_date, source_of_financing)
				research_projects.force (research_project, i)
				i := i + 1
			end
			create research_collaborations.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "country" + i.out)
			loop
				country := cursor.item.string_representation
				cursor.forth
				institution_name := cursor.item.string_representation
				cursor.forth
				contacts := cursor.item.string_representation
				cursor.forth
				nature := cursor.item.string_representation
				cursor.forth
				create research_collaboration.make_with_data (country, institution_name, contacts, nature)
				research_collaborations.force (research_collaboration, i)
				i := i + 1
			end
			create conference_publications.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "con_publication" + i.out)
			loop
				conference_publications.force (cursor.item.string_representation, i)
				cursor.forth
				i := i + 1
			end
			create journal_publications.make_empty
			from
				i := 1
			until
				cursor.after or not (cursor.item.name ~ "jou_publication" + i.out)
			loop
				journal_publications.force (cursor.item.string_representation, i)
				cursor.forth
				i := i + 1
			end
		end

feature -- Access

	grants: ARRAY [GRANT]

	research_collaborations: ARRAY [RESEARCH_COLLABORATION]

	research_projects: ARRAY [RESEARCH_PROJECT]

	conference_publications, journal_publications: ARRAY [STRING]

	head_of_unit_cookie: STRING

end
