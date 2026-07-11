CREATE TABLE "table_metadata" (
  "table_name" varchar(100) NOT NULL,
  "description" varchar(500) DEFAULT NULL,
  "primary_key" varchar(100) DEFAULT NULL,
  "purpose" varchar(500) DEFAULT NULL,
  PRIMARY KEY ("table_name")
);



CREATE TABLE "column_metadata" (
  "id" int NOT NULL AUTO_INCREMENT,
  "table_name" varchar(100) DEFAULT NULL,
  "column_name" varchar(100) DEFAULT NULL,
  "data_type" varchar(50) DEFAULT NULL,
  "description" varchar(500) DEFAULT NULL,
  "searchable" tinyint(1) DEFAULT NULL,
  PRIMARY KEY ("id")
);




CREATE TABLE "business_rules" (
  "rule_id" int NOT NULL AUTO_INCREMENT,
  "issue_type" varchar(100) DEFAULT NULL,
  "rule_name" varchar(200) DEFAULT NULL,
  "rule_description" text,
  "priority" int DEFAULT NULL,
  PRIMARY KEY ("rule_id")
);




CREATE TABLE "investigation_steps" (
  "step_id" int NOT NULL AUTO_INCREMENT,
  "issue_type" varchar(100) DEFAULT NULL,
  "sequence_no" int DEFAULT NULL,
  "table_name" varchar(100) DEFAULT NULL,
  "lookup_column" varchar(100) DEFAULT NULL,
  "description" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("step_id")
);


