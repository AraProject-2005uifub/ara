-- get_information_about_industrial_collaboration.sql

SELECT
	industry_collaborations.company_name as "Organization name",
	industry_collaborations.nature_of_collaboration as "Nature of collaboration"
FROM 
	industry_collaborations;