-- get_all_publications_of_a_given_unit_during_several_years.sql

-- start_year, end_year, unit_name

SELECT 
	publications.title AS "Publication title",
	kinds_of_publications.name AS "Kind"
FROM
	((publications
		INNER JOIN kinds_of_publications 
			ON kinds_of_publications.id = publications.kind_of_publication_id)
				INNER JOIN reports 
					ON publications.report_id = reports.id
						AND (reports.start_of_period >= "$-01-01" 
							OR reports.end_of_period <= "$-12-31")
								AND (reports.unit_id in (SELECT id FROM units WHERE name = "$")));