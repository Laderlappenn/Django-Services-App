BEGIN TRANSACTION;
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
CREATE TABLE IF NOT EXISTS "SpecialistApp_specialist" (
	"id"	integer NOT NULL,
	"specialization"	varchar(20) NOT NULL,
	"user_id"	bigint NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "ServiceAdsApp_comment" (
	"id"	integer NOT NULL,
	"ad_fk_id"	bigint NOT NULL,
	"user_fk_id"	bigint NOT NULL,
	"text"	text NOT NULL,
	"created_at"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_fk_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("ad_fk_id") REFERENCES "ServiceAdsApp_ad"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "ServiceAdsApp_ad" (
	"id"	integer NOT NULL,
	"title"	varchar(255) NOT NULL,
	"created_at"	datetime NOT NULL,
	"changed_at"	datetime NOT NULL,
	"specialist_fk_id"	bigint NOT NULL,
	"text"	text NOT NULL,
	"image"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("specialist_fk_id") REFERENCES "SpecialistApp_specialist"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "ProfileApp_profile" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"email"	varchar(254) NOT NULL UNIQUE,
	"phone_number"	varchar(17) NOT NULL,
	"is_active"	bool NOT NULL,
	"is_admin"	bool NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_superuser"	bool NOT NULL,
	"image"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "StatisticApp_visits" (
	"id"	integer NOT NULL,
	"path"	varchar(255) NOT NULL UNIQUE,
	"count"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "VoteApp_votes" (
	"id"	integer NOT NULL,
	"created_at"	datetime NOT NULL,
	"changed_at"	datetime NOT NULL,
	"vote"	bool NOT NULL,
	"ad_id"	bigint NOT NULL,
	"user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("ad_id") REFERENCES "ServiceAdsApp_ad"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "ProfileApp_profile"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (1,'pending','2024-02-11 09:24:53.762665',1,2);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (2,'completed','2024-02-11 09:25:21.749616',1,3);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (3,'completed','2024-02-11 09:47:22.923392',2,3);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (4,'pending','2024-02-11 11:25:28.441619',3,3);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (5,'completed','2024-02-11 20:31:08.503997',1,4);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (6,'pending','2024-02-11 20:35:36.440500',3,5);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (7,'pending','2024-02-27 18:38:20.203921',1,1);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (8,'pending','2024-02-28 12:42:16.277310',2,1);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (9,'pending','2024-02-28 13:17:35.053722',3,1);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (10,'pending','2024-02-28 13:17:41.091726',5,1);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (11,'in_progress','2024-02-28 13:17:45.772965',7,1);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (12,'pending','2024-02-28 13:17:48.627045',11,1);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (13,'pending','2024-02-28 13:18:59.477755',23,2);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (14,'completed','2024-02-28 14:26:16.870251',17,2);
INSERT INTO "ServiceAdsApp_servicerequest" VALUES (15,'completed','2024-02-28 14:26:19.702202',18,2);
INSERT INTO "SpecialistApp_specialist" VALUES (1,'PLUMBER',2);
INSERT INTO "SpecialistApp_specialist" VALUES (2,'PLUMBER',4);
INSERT INTO "SpecialistApp_specialist" VALUES (3,'ELECTRICIAN',1);
INSERT INTO "ServiceAdsApp_comment" VALUES (31,3,2,'ewq','2024-02-13 22:10:16.476081');
INSERT INTO "ServiceAdsApp_comment" VALUES (32,1,3,'ihu9','2024-02-14 13:19:10.668753');
INSERT INTO "ServiceAdsApp_comment" VALUES (33,1,3,'ihu9
ewq','2024-02-14 13:19:16.838665');
INSERT INTO "ServiceAdsApp_comment" VALUES (34,9,2,'уцйуй','2024-02-21 18:36:29.062119');
INSERT INTO "ServiceAdsApp_comment" VALUES (35,12,2,'eqw','2024-02-21 18:36:50.545619');
INSERT INTO "ServiceAdsApp_comment" VALUES (36,12,2,'eqewqw','2024-02-21 18:36:51.991942');
INSERT INTO "ServiceAdsApp_comment" VALUES (37,12,2,'eqewqwewq','2024-02-21 18:36:54.661109');
INSERT INTO "ServiceAdsApp_comment" VALUES (38,12,2,'eqewqwewq','2024-02-21 18:36:55.451286');
INSERT INTO "ServiceAdsApp_comment" VALUES (39,12,2,'eqewqwewq','2024-02-21 18:36:57.713793');
INSERT INTO "ServiceAdsApp_comment" VALUES (40,12,2,'eqewqwewq','2024-02-21 18:36:59.468735');
INSERT INTO "ServiceAdsApp_comment" VALUES (41,12,2,'eqewqwewq','2024-02-21 18:37:00.815545');
INSERT INTO "ServiceAdsApp_comment" VALUES (42,12,2,'eqewqwewq','2024-02-21 18:37:02.218860');
INSERT INTO "ServiceAdsApp_comment" VALUES (43,12,2,'eqewqwewq','2024-02-21 18:37:03.065779');
INSERT INTO "ServiceAdsApp_comment" VALUES (44,12,2,'eqewqwewq','2024-02-21 18:37:05.092233');
INSERT INTO "ServiceAdsApp_comment" VALUES (45,10,2,'ewq','2024-02-21 18:37:47.235400');
INSERT INTO "ServiceAdsApp_comment" VALUES (46,10,2,'ewqewq','2024-02-21 18:37:49.981527');
INSERT INTO "ServiceAdsApp_comment" VALUES (47,1,1,'eqwe <script>alert("xss")</script>','2024-02-26 16:09:06.758414');
INSERT INTO "ServiceAdsApp_comment" VALUES (48,1,1,'wqeqweq','2024-02-27 18:38:26.266991');
INSERT INTO "ServiceAdsApp_comment" VALUES (49,2,1,'ewqeqweq','2024-02-27 18:39:53.638166');
INSERT INTO "ServiceAdsApp_comment" VALUES (50,24,1,'ewqewq','2024-03-03 20:24:06.987585');
INSERT INTO "ServiceAdsApp_comment" VALUES (51,24,1,'ewqewq
eqwewq','2024-03-03 20:24:08.633167');
INSERT INTO "ServiceAdsApp_comment" VALUES (52,1,2,'eqwewqeqwew','2024-03-03 20:45:31.303523');
INSERT INTO "ServiceAdsApp_ad" VALUES (1,'123','2024-02-11 09:24:51','2024-02-23 11:58:28.631523',1,'123','ad_images/bFpTbzVsDHo_P4PBGE3.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (2,'1234','2024-02-11 09:47:03','2024-02-23 11:58:40.456340',1,'1234','ad_images/bFpTbzVsDHo_EEVH4tW.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (3,'ciphra3','2024-02-11 11:24:58','2024-02-23 11:58:45.754530',2,'ciphra3','ad_images/bFpTbzVsDHo_TiAX2rA.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (4,'21312','2024-02-13 19:59:34','2024-02-23 11:58:54.565597',1,'3213213123','ad_images/bFpTbzVsDHo_moKIQFK.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (5,'eqw','2024-02-20 17:55:58.027865','2024-02-20 17:55:58.204905',1,'ewq','ad_images/bFpTbzVsDHo.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (6,'ewq','2024-02-20 18:11:21.166593','2024-02-20 18:11:21.171594',1,'ewq','ad_images/HL1yiHxfZQ4.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (7,'eqwewq','2024-02-20 18:11:32.981331','2024-02-20 18:11:32.986331',1,'ewqe','ad_images/HL1yiHxfZQ4_dVDmyeb.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (8,'qweqwewqewq','2024-02-20 18:12:02.179295','2024-02-20 18:12:02.186300',1,'eqeewqewq','ad_images/I0AtKOiii_I.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (9,'ewqewq','2024-02-20 18:13:03.483241','2024-02-20 18:13:03.489244',1,'ewq','ad_images/I0AtKOiii_I_CRBGtFX.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (10,'ewqewq','2024-02-20 18:14:16.957499','2024-02-20 18:14:16.962500',1,'ewqewqewq','ad_images/I0AtKOiii_I_gESwbfk.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (11,'ewq','2024-02-20 18:15:57.351564','2024-02-20 18:15:57.471591',1,'ewqeq','ad_images/I0AtKOiii_I_9OnQI9f.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (12,'ewqe','2024-02-20 19:01:41.445476','2024-02-20 19:01:41.558504',1,'wqewq','ad_images/test_img.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (13,'ewq','2024-02-25 13:47:06.550251','2024-02-25 13:47:06.758296',3,'ewqe','ad_images/bFpTbzVsDHo_JkdqygR.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (14,'qewqe','2024-02-25 13:47:26.113382','2024-02-25 13:47:26.118385',3,'eqwew','ad_images/I0AtKOiii_I_IcHK4sg.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (15,'test1','2024-02-27 15:59:12.581469','2024-02-27 15:59:12.790669',3,'eqwewq','ad_images/RqV2pSOEiYk.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (16,'tewwtqwt','2024-02-27 15:59:31.398294','2024-02-27 15:59:31.403297',3,'eqweqw','ad_images/bFpTbzVsDHo_2LUa2mD.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (17,'tewwtqwt','2024-02-27 15:59:35.867644','2024-02-27 15:59:35.959665',3,'eqweqw','ad_images/bFpTbzVsDHo_S2zxmKV.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (18,'ewq','2024-02-27 16:27:59.607342','2024-02-27 16:27:59.720368',3,'eqw','ad_images/RqV2pSOEiYk_8h0cybn.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (19,'ewqe','2024-02-27 16:42:50.086453','2024-02-27 16:42:50.090455',3,'ewq','ad_images/bFpTbzVsDHo_q7kgG0q.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (20,'eqewq','2024-02-27 16:42:58.627458','2024-02-27 16:42:58.632459',3,'ewqeq','ad_images/bFpTbzVsDHo_kmhWKxG.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (21,'qw','2024-02-27 16:46:43.669628','2024-02-27 16:46:43.674631',3,'wq','ad_images/bFpTbzVsDHo_BJbKFYP.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (22,'eq','2024-02-27 16:46:47.923526','2024-02-27 16:46:47.927527',3,'eq','ad_images/I0AtKOiii_I_VbuQp2M.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (23,'eqw','2024-02-27 18:38:37.656631','2024-02-27 18:38:37.960758',3,'eqwe','ad_images/RqV2pSOEiYk_J1TFMwS.jpg');
INSERT INTO "ServiceAdsApp_ad" VALUES (24,'3r32r23','2024-03-03 20:23:53.536546','2024-03-03 20:23:53.781911',3,'r23r23r32','ad_images/cpX_7CN8hYg.jpg');
INSERT INTO "ProfileApp_profile" VALUES (1,'pbkdf2_sha256$720000$rB8pXrFWdNV7naElo021hc$t2ex3l15/jEgRWRiqNJCiNsP0HoQymoU2/n1dY+JknI=','2024-03-03 20:23:32.299780','admin@mail.ru','',1,1,1,1,'1');
INSERT INTO "ProfileApp_profile" VALUES (2,'pbkdf2_sha256$720000$Fl3FLakPiFSRVkkJtnVD5V$SORrCbeAbV4KGFJ4Lt6N4Grvs6z4T9qYXh2FayQIqwE=','2024-03-03 20:28:02.878886','ciphra1@mail.ru','',1,0,0,0,'profile_images/profile_pic_DqTyDlf.jpeg');
INSERT INTO "ProfileApp_profile" VALUES (3,'pbkdf2_sha256$720000$ogBq82ZHk9bvAWlcX2xQGi$VEgtoOurEP0ZzA3UDoM1QZuZJvCtBYrhHcWlysh7D3w=','2024-02-23 12:36:52.201327','ciphra2@mail.ru','',1,0,0,0,'profile_images/HL1yiHxfZQ4.jpg');
INSERT INTO "ProfileApp_profile" VALUES (4,'pbkdf2_sha256$720000$1HHMrZxJkU5drDKiShw66p$4zUelA7oEZ7wOJ20T5wqCbuWSVbxuhqcqcdc61AJm2k=','2024-02-11 11:25:37.995014','ciphra3@mail.ru','',1,0,0,0,'1');
INSERT INTO "ProfileApp_profile" VALUES (5,'pbkdf2_sha256$720000$k0c7A4q4PapIgAZFblGDlQ$CvYxVAT94MHO1UBrnpb9DpTyPX9bwAzlTCAgiNMSZEc=','2024-02-11 20:35:09','ciphra11@mail.ru','',1,0,0,0,'1');
INSERT INTO "ProfileApp_profile" VALUES (6,'',NULL,'','',1,0,0,0,'profile_images/profile_pic.jpeg');
INSERT INTO "StatisticApp_visits" VALUES (1,'/ad/',153);
INSERT INTO "StatisticApp_visits" VALUES (6,'/ad/1/',79);
INSERT INTO "StatisticApp_visits" VALUES (7,'/',121);
INSERT INTO "StatisticApp_visits" VALUES (8,'/favicon.ico',13);
INSERT INTO "StatisticApp_visits" VALUES (12,'/ad/create-ad/',66);
INSERT INTO "StatisticApp_visits" VALUES (21,'/ad/service-requests/',75);
INSERT INTO "StatisticApp_visits" VALUES (22,'/ad/service-request/1/',11);
INSERT INTO "StatisticApp_visits" VALUES (23,'/ad/2/',21);
INSERT INTO "StatisticApp_visits" VALUES (24,'/ad/7/',7);
INSERT INTO "StatisticApp_visits" VALUES (27,'/profile/',19);
INSERT INTO "StatisticApp_visits" VALUES (28,'/media/profile_images/profile_pic_DqTyDlf.jpeg',1);
INSERT INTO "StatisticApp_visits" VALUES (29,'/profile/logout/',4);
INSERT INTO "StatisticApp_visits" VALUES (30,'/profile/login/',11);
INSERT INTO "StatisticApp_visits" VALUES (31,'/ad/13/',13);
INSERT INTO "StatisticApp_visits" VALUES (32,'/media/ad_images/bFpTbzVsDHo_JkdqygR.jpg',12);
INSERT INTO "StatisticApp_visits" VALUES (33,'/ad/14/',30);
INSERT INTO "StatisticApp_visits" VALUES (34,'/media/ad_images/I0AtKOiii_I_IcHK4sg.jpg',12);
INSERT INTO "StatisticApp_visits" VALUES (35,'/__debug__/render_panel/',37);
INSERT INTO "StatisticApp_visits" VALUES (36,'/statistic/ads/',93);
INSERT INTO "StatisticApp_visits" VALUES (37,'/media/ad_images/bFpTbzVsDHo_P4PBGE3.jpg',12);
INSERT INTO "StatisticApp_visits" VALUES (38,'/media/ad_images/bFpTbzVsDHo_EEVH4tW.jpg',11);
INSERT INTO "StatisticApp_visits" VALUES (39,'/media/ad_images/bFpTbzVsDHo_TiAX2rA.jpg',11);
INSERT INTO "StatisticApp_visits" VALUES (40,'/media/ad_images/bFpTbzVsDHo_moKIQFK.jpg',11);
INSERT INTO "StatisticApp_visits" VALUES (41,'/media/ad_images/HL1yiHxfZQ4_dVDmyeb.jpg',11);
INSERT INTO "StatisticApp_visits" VALUES (42,'/media/ad_images/HL1yiHxfZQ4.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (43,'/media/ad_images/I0AtKOiii_I.jpg',11);
INSERT INTO "StatisticApp_visits" VALUES (44,'/media/ad_images/bFpTbzVsDHo.jpg',11);
INSERT INTO "StatisticApp_visits" VALUES (45,'/media/ad_images/I0AtKOiii_I_CRBGtFX.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (46,'/media/ad_images/I0AtKOiii_I_gESwbfk.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (47,'/media/ad_images/I0AtKOiii_I_9OnQI9f.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (48,'/media/ad_images/test_img.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (49,'/ad/create-comment/1',3);
INSERT INTO "StatisticApp_visits" VALUES (50,'/__debug__/history_sidebar/',181);
INSERT INTO "StatisticApp_visits" VALUES (51,'/statistic/ads/path/to/chartjs/dist/chart.umd.js',2);
INSERT INTO "StatisticApp_visits" VALUES (52,'/ad/15/',15);
INSERT INTO "StatisticApp_visits" VALUES (53,'/media/ad_images/RqV2pSOEiYk.jpg',21);
INSERT INTO "StatisticApp_visits" VALUES (54,'/ad/17/',2);
INSERT INTO "StatisticApp_visits" VALUES (55,'/media/ad_images/bFpTbzVsDHo_S2zxmKV.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (56,'/ad/18/',2);
INSERT INTO "StatisticApp_visits" VALUES (57,'/media/ad_images/RqV2pSOEiYk_8h0cybn.jpg',9);
INSERT INTO "StatisticApp_visits" VALUES (58,'/ad/19/',1);
INSERT INTO "StatisticApp_visits" VALUES (59,'/media/ad_images/bFpTbzVsDHo_q7kgG0q.jpg',9);
INSERT INTO "StatisticApp_visits" VALUES (60,'/ad/20/',1);
INSERT INTO "StatisticApp_visits" VALUES (61,'/media/ad_images/bFpTbzVsDHo_kmhWKxG.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (62,'/ad/21/',1);
INSERT INTO "StatisticApp_visits" VALUES (63,'/media/ad_images/bFpTbzVsDHo_BJbKFYP.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (64,'/ad/22/',2);
INSERT INTO "StatisticApp_visits" VALUES (65,'/media/ad_images/I0AtKOiii_I_VbuQp2M.jpg',10);
INSERT INTO "StatisticApp_visits" VALUES (66,'/media/ad_images/bFpTbzVsDHo_2LUa2mD.jpg',9);
INSERT INTO "StatisticApp_visits" VALUES (67,'/ad/check-service-requests/',41);
INSERT INTO "StatisticApp_visits" VALUES (68,'/statistic/ads/search/',3);
INSERT INTO "StatisticApp_visits" VALUES (69,'/ad/create-request/1',3);
INSERT INTO "StatisticApp_visits" VALUES (70,'/ad/23/',10);
INSERT INTO "StatisticApp_visits" VALUES (71,'/media/ad_images/RqV2pSOEiYk_J1TFMwS.jpg',13);
INSERT INTO "StatisticApp_visits" VALUES (72,'/ad/create-comment/2',1);
INSERT INTO "StatisticApp_visits" VALUES (73,'/admin',1);
INSERT INTO "StatisticApp_visits" VALUES (74,'/admin/',1);
INSERT INTO "StatisticApp_visits" VALUES (75,'/ad/service-request/7/',14);
INSERT INTO "StatisticApp_visits" VALUES (76,'/ad/create-request/2',4);
INSERT INTO "StatisticApp_visits" VALUES (77,'/ad/service-request/8/',4);
INSERT INTO "StatisticApp_visits" VALUES (78,'/ad/3/',1);
INSERT INTO "StatisticApp_visits" VALUES (79,'/ad/create-request/3',1);
INSERT INTO "StatisticApp_visits" VALUES (80,'/ad/5/',1);
INSERT INTO "StatisticApp_visits" VALUES (81,'/ad/create-request/5',1);
INSERT INTO "StatisticApp_visits" VALUES (82,'/ad/create-request/7',1);
INSERT INTO "StatisticApp_visits" VALUES (83,'/ad/11/',1);
INSERT INTO "StatisticApp_visits" VALUES (84,'/ad/create-request/11',1);
INSERT INTO "StatisticApp_visits" VALUES (85,'/ad/create-request/14',1);
INSERT INTO "StatisticApp_visits" VALUES (86,'/ad/create-request/23',3);
INSERT INTO "StatisticApp_visits" VALUES (87,'/ad/create-request/22',1);
INSERT INTO "StatisticApp_visits" VALUES (88,'/ad/service-request/2/',4);
INSERT INTO "StatisticApp_visits" VALUES (89,'/ad/service-request/13/',19);
INSERT INTO "StatisticApp_visits" VALUES (90,'/ad/service-request/12/',1);
INSERT INTO "StatisticApp_visits" VALUES (91,'/ad/service-request/11/',2);
INSERT INTO "StatisticApp_visits" VALUES (92,'/ad/service-request/5/',10);
INSERT INTO "StatisticApp_visits" VALUES (93,'/ad/change-service-request-status/5',8);
INSERT INTO "StatisticApp_visits" VALUES (94,'/ad/change-service-request-status/11',1);
INSERT INTO "StatisticApp_visits" VALUES (95,'/ad/create-request/17',1);
INSERT INTO "StatisticApp_visits" VALUES (96,'/ad/create-request/18',1);
INSERT INTO "StatisticApp_visits" VALUES (97,'/ad/service-request/15/',3);
INSERT INTO "StatisticApp_visits" VALUES (98,'/ad/service-request/14/',8);
INSERT INTO "StatisticApp_visits" VALUES (99,'/ad/search/',5);
INSERT INTO "StatisticApp_visits" VALUES (100,'/ad/search',1);
INSERT INTO "StatisticApp_visits" VALUES (101,'/ad',1);
INSERT INTO "StatisticApp_visits" VALUES (102,'/search/ads/',45);
INSERT INTO "StatisticApp_visits" VALUES (103,'/ads',1);
INSERT INTO "StatisticApp_visits" VALUES (104,'/search',3);
INSERT INTO "StatisticApp_visits" VALUES (105,'/search/',186);
INSERT INTO "StatisticApp_visits" VALUES (106,'/profile/register/',1);
INSERT INTO "StatisticApp_visits" VALUES (107,'/ad/24/',3);
INSERT INTO "StatisticApp_visits" VALUES (108,'/media/ad_images/cpX_7CN8hYg.jpg',12);
INSERT INTO "StatisticApp_visits" VALUES (109,'/ad/create-comment/24',2);
INSERT INTO "StatisticApp_visits" VALUES (110,'/ad/create-request/24',1);
INSERT INTO "StatisticApp_visits" VALUES (111,'/ad/change-service-request-status/14',1);
INSERT INTO "StatisticApp_visits" VALUES (112,'/ad/change-service-request-status/15',1);
INSERT INTO "StatisticApp_visits" VALUES (113,'/search/search-result/',63);
INSERT INTO "StatisticApp_visits" VALUES (114,'/vote/',91);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_servicerequest_ad_fk_id_5cad3347" ON "ServiceAdsApp_servicerequest" (
	"ad_fk_id"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_servicerequest_user_fk_id_ac969bad" ON "ServiceAdsApp_servicerequest" (
	"user_fk_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "ServiceAdsApp_servicerequest_ad_fk_id_user_fk_id_2d532ef0_uniq" ON "ServiceAdsApp_servicerequest" (
	"ad_fk_id",
	"user_fk_id"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_comment_ad_fk_id_b889714f" ON "ServiceAdsApp_comment" (
	"ad_fk_id"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_comment_user_fk_id_25e219b3" ON "ServiceAdsApp_comment" (
	"user_fk_id"
);
CREATE INDEX IF NOT EXISTS "ServiceAdsApp_ad_specialist_fk_id_47ed70bf" ON "ServiceAdsApp_ad" (
	"specialist_fk_id"
);
CREATE INDEX IF NOT EXISTS "VoteApp_votes_ad_id_6544b718" ON "VoteApp_votes" (
	"ad_id"
);
CREATE INDEX IF NOT EXISTS "VoteApp_votes_user_id_e3f8373d" ON "VoteApp_votes" (
	"user_id"
);
COMMIT;
