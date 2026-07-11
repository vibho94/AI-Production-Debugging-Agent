CREATE TABLE "orders" (
  "order_id" int NOT NULL,
  "customer_name" varchar(100) DEFAULT NULL,
  "order_status" varchar(50) DEFAULT NULL,
  "payment_status" varchar(50) DEFAULT NULL,
  "warehouse_id" int DEFAULT NULL,
  "created_date" datetime DEFAULT NULL,
  PRIMARY KEY ("order_id")
);


CREATE TABLE "shipment" (
  "shipment_id" int NOT NULL,
  "order_id" int DEFAULT NULL,
  "shipment_status" varchar(50) DEFAULT NULL,
  "awb" varchar(100) DEFAULT NULL,
  "carrier" varchar(50) DEFAULT NULL,
  "created_date" datetime DEFAULT NULL,
  PRIMARY KEY ("shipment_id")
);

CREATE TABLE "api_log" (
  "id" int NOT NULL,
  "order_id" int DEFAULT NULL,
  "api_name" varchar(100) DEFAULT NULL,
  "response_code" int DEFAULT NULL,
  "error_message" varchar(255) DEFAULT NULL,
  "created_date" datetime DEFAULT NULL,
  PRIMARY KEY ("id")
);


CREATE TABLE "inventory" (
  "sku" varchar(30) NOT NULL,
  "available_qty" int DEFAULT NULL,
  "reserved_qty" int DEFAULT NULL,
  PRIMARY KEY ("sku")
);



CREATE TABLE "orderdetail" (
  "id" int NOT NULL AUTO_INCREMENT,
  "order_id" int NOT NULL,
  "sku" varchar(50) DEFAULT NULL,
  "order_qty" int DEFAULT NULL,
  "order_status" varchar(50) DEFAULT NULL,
  "created_date" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  KEY "fk_order" ("order_id"),
  CONSTRAINT "fk_order" FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id")
);



CREATE TABLE "scheduler_log" (
  "id" int NOT NULL,
  "job_name" varchar(100) DEFAULT NULL,
  "status" varchar(50) DEFAULT NULL,
  "error_message" varchar(255) DEFAULT NULL,
  "created_date" datetime DEFAULT NULL,
  PRIMARY KEY ("id")
);







