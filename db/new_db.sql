CREATE TABLE "best_paper_awards" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"article_title" TEXT NOT NULL,

"wording" TEXT NOT NULL,

"awarding_organization" TEXT NOT NULL,

"date" TEXT NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_best_paper_awards_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id")

);


CREATE TABLE "countries" (

"id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

PRIMARY KEY ("id") 

);



CREATE TABLE "courses_taught" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

"semester" TEXT NOT NULL,

"level_id" INTEGER NOT NULL,

"num_of_students" INTEGER NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_courses_taught_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id"),

CONSTRAINT "fk_courses_taught_levels_1" FOREIGN KEY ("level_id") REFERENCES "levels" ("id")

);


CREATE TABLE "degrees" (

"id" INTEGER NOT NULL,

"name" TEXT UNIQUE NOT NULL,

PRIMARY KEY ("id") 

);



CREATE TABLE "examinations" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"course_name" TEXT NOT NULL,

"semester" TEXT NOT NULL,

"kind_of_exam_id" INTEGER NOT NULL,

"num_of_students" INTEGER NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_examinations_kinds_of_exams_1" FOREIGN KEY ("kind_of_exam_id") REFERENCES "kinds_of_exams" ("id"),

CONSTRAINT "fk_examinations_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id")

);



CREATE TABLE "grants" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"title" TEXT NOT NULL,

"granting_agency_id" INTEGER NOT NULL,

"start_of_period" TEXT NOT NULL,

"end_of_period" TEXT NOT NULL,

"previous_grant_name" TEXT,

"amount" REAL NOT NULL,

PRIMARY KEY ("id"),

CONSTRAINT "fk_grants_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id"),

CONSTRAINT "fk_grants_organizations_1" FOREIGN KEY ("granting_agency_id") REFERENCES "organizations" ("id")

);



CREATE TABLE "industry_collaboration" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"company_id" INTEGER NOT NULL,

"nature_of_collaboration" TEXT NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_industry_collaboration_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id"),

CONSTRAINT "fk_industry_collaboration_organizations_1" FOREIGN KEY ("company_id") REFERENCES "organizations" ("id")

);



CREATE TABLE "ip_licensies" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"license" TEXT NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_ip_licensies_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id")

);



CREATE TABLE "kinds_of_exams" (

"id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

PRIMARY KEY ("id") 

);



CREATE TABLE "kinds_of_publications" (

"id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

PRIMARY KEY ("id") 

);



CREATE TABLE "levels" (

"id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

PRIMARY KEY ("id") 

);


CREATE TABLE "memberships" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"organization_id" INTEGER NOT NULL,

"start_of_period" TEXT NOT NULL,

"end_of_period" TEXT NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_memberships_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id"),

CONSTRAINT "fk_memberships_organizations_1" FOREIGN KEY ("organization_id") REFERENCES "organizations" ("id")

);


CREATE TABLE "organization_types" (

"id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

PRIMARY KEY ("id") 

);


CREATE TABLE "organizations" (

"id" INTEGER NOT NULL,

"name" TEXT UNIQUE NOT NULL,

"type_id" INTEGER NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_organizations_organization_types_1" FOREIGN KEY ("type_id") REFERENCES "organization_types" ("id")

);


CREATE TABLE "patents" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"title" TEXT NOT NULL,

"description" TEXT NOT NULL,

"patent_office_country_id" TEXT NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_patents_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id"),

CONSTRAINT "fk_patents_countries_1" FOREIGN KEY ("patent_office_country_id") REFERENCES "countries" ("id")

);


CREATE TABLE "phd_theses" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"student_id" INTEGER NOT NULL,

"title" TEXT UNIQUE NOT NULL,

"degree_id" INTEGER NOT NULL,

"supervisor_id" INTEGER NOT NULL,

"committe_members" TEXT,

"degree_granting_organization_id" INTEGER NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_phd_theses_students_1" FOREIGN KEY ("student_id") REFERENCES "students" ("id"),

CONSTRAINT "fk_phd_theses_unit_members_1" FOREIGN KEY ("supervisor_id") REFERENCES "unit_members" ("id"),

CONSTRAINT "fk_phd_theses_degrees_1" FOREIGN KEY ("degree_id") REFERENCES "degrees" ("id"),

CONSTRAINT "fk_phd_theses_granting_agencies_1" FOREIGN KEY ("degree_granting_organization_id") REFERENCES "organizations" ("id"),

CONSTRAINT "fk_phd_theses_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id")

);


CREATE TABLE "prizes" (

"id" INTEGER NOT NULL,

"recipient_unit_member_id" INTEGER NOT NULL,

"title" TEXT NOT NULL,

"granting_organization_id" INTEGER NOT NULL,

"date" TEXT NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_prizes_granting_agencies_1" FOREIGN KEY ("granting_organization_id") REFERENCES "organizations" ("id"),

CONSTRAINT "fk_prizes_unit_members_1" FOREIGN KEY ("recipient_unit_member_id") REFERENCES "unit_members" ("id")

);


CREATE TABLE "publications" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"title" TEXT NOT NULL,

"date" TEXT NOT NULL,

"kind_of_publication_id" INTEGER NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_publications_kinds_of_publications_1" FOREIGN KEY ("kind_of_publication_id") REFERENCES "kinds_of_publications" ("id"),

CONSTRAINT "fk_publications_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id")

);


CREATE TABLE "reports" (

"id" INTEGER NOT NULL,

"unit_id" INTEGER NOT NULL,

"start_of_period" TEXT NOT NULL,

"end_of_period" TEXT NOT NULL,

"head_of_unit_cookie" TEXT UNIQUE NOT NULL,

"other_information" TEXT,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_reports_units_1" FOREIGN KEY ("unit_id") REFERENCES "units" ("id")

);


CREATE TABLE "research_collaborations" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"country_of_institution_id" INTEGER NOT NULL,

"institution_id" INTEGER NOT NULL,

"contact_with_institution" INTEGER NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_research_collaborations_countries_1" FOREIGN KEY ("country_of_institution_id") REFERENCES "countries" ("id"),

CONSTRAINT "fk_research_collaborations_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id"),

CONSTRAINT "fk_research_collaborations_organizations_1" FOREIGN KEY ("institution_id") REFERENCES "organizations" ("id")

);


CREATE TABLE "research_projects" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"title" TEXT NOT NULL,

"inno_personnel_involved" TEXT NOT NULL,

"external_personnel_involved" TEXT NOT NULL,

"start_of_period" TEXT NOT NULL,

"end_of_period" TEXT NOT NULL,

"sources_of_financing" TEXT,

PRIMARY KEY ("id"),

CONSTRAINT "fk_research_projects_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id")

);


CREATE TABLE "student_reports" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"student_id" INTEGER NOT NULL,

"title" TEXT NOT NULL,

"publication_plans" TEXT,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_student_reports_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id"),

CONSTRAINT "fk_student_reports_students_1" FOREIGN KEY ("student_id") REFERENCES "students" ("id")

);


CREATE TABLE "students" (

"id" INTEGER NOT NULL,

"name" TEXT UNIQUE NOT NULL,

"ui_student_id" TEXT,

PRIMARY KEY ("id") 

);


CREATE TABLE "students_supervised" (

"id" INTEGER NOT NULL,

"report_id" INTEGER NOT NULL,

"student_id" INTEGER NOT NULL,

"nature_of_work" TEXT NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_students_supervised_reports_1" FOREIGN KEY ("report_id") REFERENCES "reports" ("id"),

CONSTRAINT "fk_students_supervised_students_1" FOREIGN KEY ("student_id") REFERENCES "students" ("id")

);


CREATE TABLE "unit_members" (

"id" INTEGER NOT NULL,

"unit_id" INTEGER NOT NULL,

"name" TEXT UNIQUE NOT NULL,

"ui_employee_id" INTEGER,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_unit_members_units_1" FOREIGN KEY ("unit_id") REFERENCES "units" ("id")

);


CREATE TABLE "units" (

"id" INTEGER NOT NULL,

"name" TEXT UNIQUE NOT NULL,

"head_of_unit_username" INTEGER NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_units_users_1" FOREIGN KEY ("head_of_unit_username") REFERENCES "users" ("id")

);


CREATE TABLE "users" (

"id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

"username" TEXT UNIQUE NOT NULL,

"password" TEXT NOT NULL,

"cookie" BLOB,

"unit_member_id" INTEGER,

"kind_of_user_id" INTEGER NOT NULL,

PRIMARY KEY ("id") ,

CONSTRAINT "fk_users_unit_members_1" FOREIGN KEY ("unit_member_id") REFERENCES "unit_members" ("id"),

CONSTRAINT "fk_users_kinds_of_users_1" FOREIGN KEY ("kind_of_user_id") REFERENCES "kinds_of_users" ("id")

);


CREATE TABLE "kinds_of_users" (

"id" INTEGER NOT NULL,

"name" TEXT NOT NULL,

PRIMARY KEY ("id")

);

