-- get_all_publications_of_a_given_year.sql

-- year_s, year_f

SELECT 
	publications.title AS "Publication title",
	kinds_of_publications.name AS "Kind"
FROM
	publications
		INNER JOIN kinds_of_publications 
			ON kinds_of_publications.id = publications.kind_of_publication_id
WHERE 
	date(publications.date) >= "$-01-01" AND date(publications.date) <= "$-12-31";