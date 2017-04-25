-- add_best_paper_award.sql

-- report_id, author, article_title,
-- wording, awarding_organization, date

INSERT OR REPLACE INTO best_paper_awards (
	report_id,
	author,
	article_title,
	wording,
	awarding_organization,
	a_date
)
VALUES (
	"$",
	"$",
	"$",
	"$",
	"$",
	"$"
);
--|