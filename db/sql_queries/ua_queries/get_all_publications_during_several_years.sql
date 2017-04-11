-- get_all_publications_of_a_given_year.sql

-- year_s, year_f

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
);

