-- add_journal_publication.sql

-- report_id, title

INSERT INTO publications (
	report_id,
	title,
	kind_of_publication_id,
)
VALUES (
	"$",
	"$",
	(SELECT id FROM kind_of_publications WHERE name = "Journal")
);
y