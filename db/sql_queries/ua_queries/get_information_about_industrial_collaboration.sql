-- get_information_about_industrial_collaboration.sql

SELECT (
	organizations.name as "Organization name",
	industry_collaboration.nature_of_collaboration as "Nature of collaboration"
) 
FROM 
	industry_collaboration
INNER JOIN
	organizations
		ON
			organizations.id = industry_collaboration.company_id;

