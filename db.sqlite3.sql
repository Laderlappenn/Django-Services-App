BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ProfileApp_profile_groups" (
	"id"	integer NOT NULL,
	"profile_id"	bigint NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("profile_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "ProfileApp_profile_user_permissions" (
	"id"	integer NOT NULL,
	"profile_id"	bigint NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("profile_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "ProfileApp_profile" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"email"	varchar(254) NOT NULL UNIQUE,
	"phone_number"	varchar(17) NOT NULL,
	"is_admin"	bool NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_superuser"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ServiceAdsApp_ad" (
	"id"	integer NOT NULL,
	"title"	varchar(255) NOT NULL,
	"slug"	varchar(255) NOT NULL UNIQUE,
	"created_at"	datetime NOT NULL,
	"changed_at"	datetime NOT NULL,
	"text"	text NOT NULL,
	"specialist_fk_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("specialist_fk_id") REFERENCES "SpecialistApp_specialist"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "SpecialistApp_specialist" (
	"id"	integer NOT NULL,
	"specialization"	varchar(20) NOT NULL,
	"user_id"	bigint NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	bigint NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "ServiceAdsApp_comment" (
	"id"	integer NOT NULL,
	"ad_fk_id"	bigint NOT NULL,
	"user_fk_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("ad_fk_id") REFERENCES "ServiceAdsApp_ad"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_fk_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "ServiceAdsApp_servicerequest" (
	"id"	integer NOT NULL,
	"status"	varchar(20) NOT NULL,
	"request_date"	datetime NOT NULL,
	"ad_fk_id"	bigint NOT NULL,
	"user_fk_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("ad_fk_id") REFERENCES "ServiceAdsApp_ad"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_fk_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "SpecialistApp_rating" (
	"id"	integer NOT NULL,
	"created_at"	datetime NOT NULL,
	"changed_at"	datetime NOT NULL,
	"vote"	smallint NOT NULL,
	"specialist_id"	bigint NOT NULL,
	"user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("specialist_id") REFERENCES "SpecialistApp_specialist"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-02-02 06:55:07.641785');
INSERT INTO "django_migrations" VALUES (2,'contenttypes','0002_remove_content_type_name','2024-02-02 06:55:07.655788');
INSERT INTO "django_migrations" VALUES (3,'auth','0001_initial','2024-02-02 06:55:07.677794');
INSERT INTO "django_migrations" VALUES (4,'auth','0002_alter_permission_name_max_length','2024-02-02 06:55:07.691796');
INSERT INTO "django_migrations" VALUES (5,'auth','0003_alter_user_email_max_length','2024-02-02 06:55:07.702798');
INSERT INTO "django_migrations" VALUES (6,'auth','0004_alter_user_username_opts','2024-02-02 06:55:07.714801');
INSERT INTO "django_migrations" VALUES (7,'auth','0005_alter_user_last_login_null','2024-02-02 06:55:07.725806');
INSERT INTO "django_migrations" VALUES (8,'auth','0006_require_contenttypes_0002','2024-02-02 06:55:07.731805');
INSERT INTO "django_migrations" VALUES (9,'auth','0007_alter_validators_add_error_messages','2024-02-02 06:55:07.740809');
INSERT INTO "django_migrations" VALUES (10,'auth','0008_alter_user_username_max_length','2024-02-02 06:55:07.752810');
INSERT INTO "django_migrations" VALUES (11,'auth','0009_alter_user_last_name_max_length','2024-02-02 06:55:07.763813');
INSERT INTO "django_migrations" VALUES (12,'auth','0010_alter_group_name_max_length','2024-02-02 06:55:07.776456');
INSERT INTO "django_migrations" VALUES (13,'auth','0011_update_proxy_permissions','2024-02-02 06:55:07.786112');
INSERT INTO "django_migrations" VALUES (14,'auth','0012_alter_user_first_name_max_length','2024-02-02 06:55:07.796240');
INSERT INTO "django_migrations" VALUES (15,'ProfileApp','0001_initial','2024-02-02 06:55:07.804282');
INSERT INTO "django_migrations" VALUES (16,'ProfileApp','0002_alter_profile_managers_profile_is_active_and_more','2024-02-02 06:55:07.822980');
INSERT INTO "django_migrations" VALUES (17,'ProfileApp','0003_profile_groups_profile_is_superuser_and_more','2024-02-02 06:55:07.862990');
INSERT INTO "django_migrations" VALUES (18,'ProfileApp','0004_alter_profile_phone_number','2024-02-02 06:55:07.874992');
INSERT INTO "django_migrations" VALUES (19,'SpecialistApp','0001_initial','2024-02-02 06:55:07.894953');
INSERT INTO "django_migrations" VALUES (20,'ServiceAdsApp','0001_initial','2024-02-02 06:55:07.915960');
INSERT INTO "django_migrations" VALUES (21,'ServiceAdsApp','0002_rename_ad_text_ad_text','2024-02-02 06:55:07.932962');
INSERT INTO "django_migrations" VALUES (22,'ServiceAdsApp','0003_alter_ad_specialist_fk_servicerequest','2024-02-02 06:55:07.966969');
INSERT INTO "django_migrations" VALUES (23,'ServiceAdsApp','0004_comment','2024-02-02 06:55:07.989974');
INSERT INTO "django_migrations" VALUES (24,'SpecialistApp','0002_remove_specialist_last_login_and_more','2024-02-02 06:55:08.021988');
INSERT INTO "django_migrations" VALUES (25,'admin','0001_initial','2024-02-02 06:55:08.072044');
INSERT INTO "django_migrations" VALUES (26,'admin','0002_logentry_remove_auto_add','2024-02-02 06:55:08.111304');
INSERT INTO "django_migrations" VALUES (27,'admin','0003_logentry_add_action_flag_choices','2024-02-02 06:55:08.160340');
INSERT INTO "django_migrations" VALUES (28,'sessions','0001_initial','2024-02-02 06:55:08.206909');
INSERT INTO "django_migrations" VALUES (29,'ServiceAdsApp','0005_rename_user_id_fk_comment_user_fk_and_more','2024-02-02 10:01:31.657456');
INSERT INTO "django_migrations" VALUES (30,'SpecialistApp','0003_rename_specialist_id_rating_specialist_and_more','2024-02-02 10:01:31.695469');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (5,'sessions','session');
INSERT INTO "django_content_type" VALUES (6,'SpecialistApp','specialist');
INSERT INTO "django_content_type" VALUES (7,'SpecialistApp','rating');
INSERT INTO "django_content_type" VALUES (8,'ProfileApp','profile');
INSERT INTO "django_content_type" VALUES (9,'ServiceAdsApp','ad');
INSERT INTO "django_content_type" VALUES (10,'ServiceAdsApp','servicerequest');
INSERT INTO "django_content_type" VALUES (11,'ServiceAdsApp','comment');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (14,4,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (15,4,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (16,4,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (17,5,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (18,5,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (19,5,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (20,5,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (21,6,'add_specialist','Can add specialist');
INSERT INTO "auth_permission" VALUES (22,6,'change_specialist','Can change specialist');
INSERT INTO "auth_permission" VALUES (23,6,'delete_specialist','Can delete specialist');
INSERT INTO "auth_permission" VALUES (24,6,'view_specialist','Can view specialist');
INSERT INTO "auth_permission" VALUES (25,7,'add_rating','Can add rating');
INSERT INTO "auth_permission" VALUES (26,7,'change_rating','Can change rating');
INSERT INTO "auth_permission" VALUES (27,7,'delete_rating','Can delete rating');
INSERT INTO "auth_permission" VALUES (28,7,'view_rating','Can view rating');
INSERT INTO "auth_permission" VALUES (29,8,'add_profile','Can add profile');
INSERT INTO "auth_permission" VALUES (30,8,'change_profile','Can change profile');
INSERT INTO "auth_permission" VALUES (31,8,'delete_profile','Can delete profile');
INSERT INTO "auth_permission" VALUES (32,8,'view_profile','Can view profile');
INSERT INTO "auth_permission" VALUES (33,9,'add_ad','Can add ad');
INSERT INTO "auth_permission" VALUES (34,9,'change_ad','Can change ad');
INSERT INTO "auth_permission" VALUES (35,9,'delete_ad','Can delete ad');
INSERT INTO "auth_permission" VALUES (36,9,'view_ad','Can view ad');
INSERT INTO "auth_permission" VALUES (37,10,'add_servicerequest','Can add service request');
INSERT INTO "auth_permission" VALUES (38,10,'change_servicerequest','Can change service request');
INSERT INTO "auth_permission" VALUES (39,10,'delete_servicerequest','Can delete service request');
INSERT INTO "auth_permission" VALUES (40,10,'view_servicerequest','Can view service request');
INSERT INTO "auth_permission" VALUES (41,11,'add_comment','Can add comment');
INSERT INTO "auth_permission" VALUES (42,11,'change_comment','Can change comment');
INSERT INTO "auth_permission" VALUES (43,11,'delete_comment','Can delete comment');
INSERT INTO "auth_permission" VALUES (44,11,'view_comment','Can view comment');
INSERT INTO "ProfileApp_profile" VALUES (1,'pbkdf2_sha256$720000$bDC2kGmJgz22XlpttzTFNS$3BZID5GNv+CSPY6jpcdl/BhJbEpVYmMS/tHucDX+az4=',NULL,'','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (2,'pbkdf2_sha256$720000$8gm7hMtkrWOw9LGuMdxYQ7$W5GN+nQwfdPdIKStZ4QoZU1yGT2+HmaHiaY6fAyeD3Q=',NULL,'ciphra5@mail.ru','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (3,'pbkdf2_sha256$720000$VLa17YU01F9F8ickBXJmJz$PuZ4f0uEGex+eMh5/RbFSLBcZfy0JtxdEyxKwFeECkY=',NULL,'ciphra6@mail.ru','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (4,'pbkdf2_sha256$720000$HtKHoslFOl9GLk15FotfHX$Sx+TO+HJqlBxXLkcqc3FvQ9ROAz8pqc6/lDkeUcsePQ=',NULL,'ciphra7@mail.ru','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (5,'pbkdf2_sha256$720000$Y5dduNPlJfx8UTMkKsefFZ$0s14xayV+7GxdmJwDYMOWmD8hJnPMth/m7MU94aFixQ=',NULL,'ciphra1@mail.ru','',0,0,0,1);
INSERT INTO "SpecialistApp_specialist" VALUES (1,'ELECTRICIAN',4);
INSERT INTO "SpecialistApp_specialist" VALUES (2,'PLUMBER',5);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "ProfileApp_profile_groups_profile_id_group_id_8d3936da_uniq" ON "ProfileApp_profile_groups" (
	"profile_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "ProfileApp_profile_groups_profile_id_4f4557a3" ON "ProfileApp_profile_groups" (
	"profile_id"
);
CREATE INDEX IF NOT EXISTS "ProfileApp_profile_groups_group_id_9449ff11" ON "ProfileApp_profile_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "ProfileApp_profile_user_permissions_profile_id_permission_id_c365b71f_uniq" ON "ProfileApp_profile_user_permissions" (
	"profile_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "ProfileApp_profile_user_permissions_profile_id_a7d01328" ON "ProfileApp_profile_user_permissions" (
	"profile_id"
);
CREATE INDEX IF NOT EXISTS "ProfileApp_profile_user_permissions_permission_id_00325259" ON "ProfileApp_profile_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_ad_specialist_fk_id_47ed70bf" ON "ServiceAdsApp_ad" (
	"specialist_fk_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_comment_ad_fk_id_b889714f" ON "ServiceAdsApp_comment" (
	"ad_fk_id"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_comment_user_fk_id_25e219b3" ON "ServiceAdsApp_comment" (
	"user_fk_id"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_servicerequest_ad_fk_id_5cad3347" ON "ServiceAdsApp_servicerequest" (
	"ad_fk_id"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_servicerequest_user_fk_id_ac969bad" ON "ServiceAdsApp_servicerequest" (
	"user_fk_id"
);
CREATE INDEX IF NOT EXISTS "SpecialistApp_rating_specialist_id_aaab08fa" ON "SpecialistApp_rating" (
	"specialist_id"
);
CREATE INDEX IF NOT EXISTS "SpecialistApp_rating_user_id_7e10477f" ON "SpecialistApp_rating" (
	"user_id"
);
COMMIT;
