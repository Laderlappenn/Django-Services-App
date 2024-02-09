BEGIN TRANSACTION;
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
CREATE TABLE IF NOT EXISTS "SpecialistApp_specialist" (
	"id"	integer NOT NULL,
	"specialization"	varchar(20) NOT NULL,
	"user_id"	bigint NOT NULL UNIQUE,
	FOREIGN KEY("user_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ServiceAdsApp_comment" (
	"id"	integer NOT NULL,
	"ad_fk_id"	bigint NOT NULL,
	"user_fk_id"	bigint NOT NULL,
	FOREIGN KEY("ad_fk_id") REFERENCES "ServiceAdsApp_ad"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_fk_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ServiceAdsApp_servicerequest" (
	"id"	integer NOT NULL,
	"status"	varchar(20) NOT NULL,
	"request_date"	datetime NOT NULL,
	"ad_fk_id"	bigint NOT NULL,
	"user_fk_id"	bigint NOT NULL,
	FOREIGN KEY("ad_fk_id") REFERENCES "ServiceAdsApp_ad"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_fk_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "SpecialistApp_rating" (
	"id"	integer NOT NULL,
	"created_at"	datetime NOT NULL,
	"changed_at"	datetime NOT NULL,
	"vote"	smallint NOT NULL,
	"specialist_id"	bigint NOT NULL,
	"user_id"	bigint NOT NULL,
	FOREIGN KEY("specialist_id") REFERENCES "SpecialistApp_specialist"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ServiceAdsApp_ad" (
	"id"	integer NOT NULL,
	"created_at"	datetime NOT NULL,
	"changed_at"	datetime NOT NULL,
	"specialist_fk_id"	bigint NOT NULL,
	"text"	text NOT NULL,
	"title"	varchar(255) NOT NULL,
	FOREIGN KEY("specialist_fk_id") REFERENCES "SpecialistApp_specialist"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "ProfileApp_profile" VALUES (1,'pbkdf2_sha256$720000$bDC2kGmJgz22XlpttzTFNS$3BZID5GNv+CSPY6jpcdl/BhJbEpVYmMS/tHucDX+az4=',NULL,'','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (2,'pbkdf2_sha256$720000$8gm7hMtkrWOw9LGuMdxYQ7$W5GN+nQwfdPdIKStZ4QoZU1yGT2+HmaHiaY6fAyeD3Q=',NULL,'ciphra5@mail.ru','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (3,'pbkdf2_sha256$720000$VLa17YU01F9F8ickBXJmJz$PuZ4f0uEGex+eMh5/RbFSLBcZfy0JtxdEyxKwFeECkY=','2024-02-07 11:32:51.878953','ciphra6@mail.ru','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (4,'pbkdf2_sha256$720000$HtKHoslFOl9GLk15FotfHX$Sx+TO+HJqlBxXLkcqc3FvQ9ROAz8pqc6/lDkeUcsePQ=','2024-02-06 13:19:40.267017','ciphra7@mail.ru','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (5,'pbkdf2_sha256$720000$Y5dduNPlJfx8UTMkKsefFZ$0s14xayV+7GxdmJwDYMOWmD8hJnPMth/m7MU94aFixQ=','2024-02-06 14:04:16.222864','ciphra1@mail.ru','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (6,'pbkdf2_sha256$720000$0Tmvuut0zNB4Zvq5AElYLi$iQfmo9XX6aAr00L3JwZ3hIsoUB48Kt5TBHJihdSfiQY=','2024-02-09 20:59:27.789045','ciphra10@mail.ru','',0,0,0,1);
INSERT INTO "ProfileApp_profile" VALUES (7,'pbkdf2_sha256$720000$RE4dB3ynXh5GwOnSxGjNIy$RBkMyDvyUuaEGn4NNwCt6EUEF8xWSXe15TfSwe5iFco=','2024-02-09 20:41:33.487546','ciphra11@mail.ru','',0,0,0,1);
INSERT INTO "SpecialistApp_specialist" VALUES (1,'ELECTRICIAN',4);
INSERT INTO "SpecialistApp_specialist" VALUES (2,'PLUMBER',5);
INSERT INTO "SpecialistApp_specialist" VALUES (3,'PLUMBER',6);
INSERT INTO "ServiceAdsApp_ad" VALUES (1,'2024-02-09 20:33:12.356505','2024-02-09 20:33:12.360505',3,'ewq','eqw');
INSERT INTO "ServiceAdsApp_ad" VALUES (2,'2024-02-09 20:41:01.473854','2024-02-09 20:41:01.477857',3,'ewq','ewq');
INSERT INTO "ServiceAdsApp_ad" VALUES (3,'2024-02-09 20:59:32.313790','2024-02-09 20:59:32.315790',3,'ewqewqewq','ewq');
INSERT INTO "ServiceAdsApp_ad" VALUES (4,'2024-02-09 21:01:26.998546','2024-02-09 21:01:26.999545',3,'ewq','ewq');
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
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_ad_specialist_fk_id_47ed70bf" ON "ServiceAdsApp_ad" (
	"specialist_fk_id"
);
COMMIT;
