CREATE TABLE "egt_user" (
	"egt_id" serial(10) NOT NULL,
	"user_name" character varying(10) NOT NULL,
	"user_email" character varying(10) NOT NULL,
	"user_contact" character varying(10) NOT NULL,
	"user_credits" int4(5),
	"primary_category_id" int4(5) NOT NULL,
	"total_wins" int4(5),
	"user_xp" int4,
	"user_level" int4 NOT NULL DEFAULT '1',
	"user_medals" int4,
	CONSTRAINT egt_user_pk PRIMARY KEY ("egt_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "level_ref" (
	"level_id" int4 NOT NULL,
	"level_desc" character varying(10) NOT NULL,
	"min_requirement" int4 NOT NULL,
	CONSTRAINT level_ref_pk PRIMARY KEY ("level_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "category_ref" (
	"category_id" serial NOT NULL,
	"category_name" character varying(10) NOT NULL,
	"parent_category" int4,
	"start_date" TIMESTAMP NOT NULL,
	"end_date" TIMESTAMP,
	"category_user_count" int4 NOT NULL DEFAULT '0',
	CONSTRAINT category_ref_pk PRIMARY KEY ("category_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "user_medals" (
	"egt_user_id" int4(10) NOT NULL,
	"current_value" int4(10) NOT NULL,
	"change_type" int2(1) NOT NULL,
	"change_value" int4(10) NOT NULL,
	"battle_id" int4(10) NOT NULL,
	"start_date" TIMESTAMP NOT NULL,
	"end_date" TIMESTAMP
) WITH (
  OIDS=FALSE
);



CREATE TABLE "egt_user_follow" (
	"following_id" int4 NOT NULL,
	"follower_id" int4 NOT NULL,
	"start_date" TIMESTAMP NOT NULL,
	"end_date" TIMESTAMP,
	CONSTRAINT egt_user_follow_pk PRIMARY KEY ("following_id","follower_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "egt_battles" (
	"battle_id" serial NOT NULL,
	"first_participant_id" int4 NOT NULL,
	"second_participant_id" int4 NOT NULL,
	"category_id" int4 NOT NULL,
	"battle_mode" character varying(10) NOT NULL,
	"start_date" TIMESTAMP NOT NULL,
	"end_date" TIMESTAMP,
	"winner_id" int4 NOT NULL,
	"winning_percentage" int4,
	"audience_count" int4,
	"content_id" int4 NOT NULL,
	CONSTRAINT egt_battles_pk PRIMARY KEY ("battle_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "user_upload_content" (
	"battle_id" int4 NOT NULL,
	"egt_user_id" int4 NOT NULL,
	"upload_path" character varying NOT NULL,
	CONSTRAINT user_upload_content_pk PRIMARY KEY ("battle_id","egt_user_id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "egt_user" ADD CONSTRAINT "egt_user_fk0" FOREIGN KEY ("primary_category_id") REFERENCES "category_ref"("category_id");
ALTER TABLE "egt_user" ADD CONSTRAINT "egt_user_fk1" FOREIGN KEY ("user_level") REFERENCES "level_ref"("level_id");


ALTER TABLE "category_ref" ADD CONSTRAINT "category_ref_fk0" FOREIGN KEY ("parent_category") REFERENCES "category_ref"("category_id");

ALTER TABLE "user_medals" ADD CONSTRAINT "user_medals_fk0" FOREIGN KEY ("egt_user_id") REFERENCES "egt_user"("egt_id");
ALTER TABLE "user_medals" ADD CONSTRAINT "user_medals_fk1" FOREIGN KEY ("battle_id") REFERENCES "egt_battles"("battle_id");

ALTER TABLE "egt_user_follow" ADD CONSTRAINT "egt_user_follow_fk0" FOREIGN KEY ("following_id") REFERENCES "egt_user"("egt_id");
ALTER TABLE "egt_user_follow" ADD CONSTRAINT "egt_user_follow_fk1" FOREIGN KEY ("follower_id") REFERENCES "egt_user"("egt_id");

ALTER TABLE "egt_battles" ADD CONSTRAINT "egt_battles_fk0" FOREIGN KEY ("first_participant_id") REFERENCES "egt_user"("egt_id");
ALTER TABLE "egt_battles" ADD CONSTRAINT "egt_battles_fk1" FOREIGN KEY ("second_participant_id") REFERENCES "egt_user"("egt_id");
ALTER TABLE "egt_battles" ADD CONSTRAINT "egt_battles_fk2" FOREIGN KEY ("winner_id") REFERENCES "egt_user"("egt_id");

ALTER TABLE "user_upload_content" ADD CONSTRAINT "user_upload_content_fk0" FOREIGN KEY ("battle_id") REFERENCES "egt_battles"("battle_id");
ALTER TABLE "user_upload_content" ADD CONSTRAINT "user_upload_content_fk1" FOREIGN KEY ("egt_user_id") REFERENCES "egt_user"("egt_id");

