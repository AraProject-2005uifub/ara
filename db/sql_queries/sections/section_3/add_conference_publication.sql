-- add_conference_publication.sql

-- report_id, title

INSERT INTO publications (
	report_id,
	title,
	date,
	kind_of_publication_id
)
VALUES (
	"$",
	"$",
	"$",
	(SELECT id FROM kinds_of_publications WHERE name = "Conference")
);
--|
