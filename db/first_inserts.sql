INSERT INTO kinds_of_users (name) VALUES ("Technical administrator");
INSERT INTO kinds_of_users (name) VALUES ("Head of Unit");
INSERT INTO kinds_of_users (name) VALUES ("University administrator");

INSERT INTO kinds_of_publications (name) VALUES ("Conference");
INSERT INTO kinds_of_publications (name) VALUES ("Journal");

INSERT INTO degrees (name) VALUES ("PhD");
INSERT INTO degrees (name) VALUES ("Dr. Sc.");

INSERT INTO organization_types (name) VALUES ("University");
INSERT INTO organization_types (name) VALUES ("Granting agency");
INSERT INTO organization_types (name) VALUES ("Institution");

INSERT INTO countries (name) VALUES ("Russia");
INSERT INTO countries (name) VALUES ("USA");

INSERT INTO users (name, username, password, kind_of_user_id) 
VALUES ( "Admin", "admin", "1CD29B65", 1);