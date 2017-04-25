-- get_patents_got_by_all_units_during_given_period.sql

-- start_year, end_year

SELECT 
	patents.description AS "Patent description",
	countries.name AS "Office country"
FROM
	patents
			INNER JOIN countries
					ON patents.patent_office_country_id = countries.id
						INNER JOIN reports 
							ON patents.report_id = reports.id
WHERE
	((date(reports.start_of_period) >= date("$")) AND 
		(date(reports.end_of_period) <= date("$")));