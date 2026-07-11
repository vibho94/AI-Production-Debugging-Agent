INSERT INTO orders
(order_id, customer_name, order_status, payment_status, warehouse_id, created_date)
VALUES
(1001,'Rahul Sharma','Packed','Paid',1,'2026-06-01 10:15:00'),
(1002,'Priya Verma','Created','Paid',1,'2026-06-02 11:20:00'),
(1003,'Amit Singh','Cancelled','Refunded',2,'2026-06-03 09:40:00'),
(1004,'Sneha Kapoor','Shipped','Paid',2,'2026-06-04 15:10:00'),
(1005,'Rohit Gupta','Processing','Paid',3,'2026-06-05 13:30:00');



INSERT INTO shipment
(shipment_id, order_id, shipment_status, awb, carrier, created_date)
VALUES
(501,1001,'In Transit','AWB5081','BlueDart','2026-06-02 08:30:00'),
(502,1002,'Packed','AWB5082','Delhivery','2026-06-03 10:00:00'),
(503,1004,'Delivered','AWB5083','Ecom Express','2026-06-05 14:00:00'),
(504,1005,'Pending','AWB5084','XpressBees','2026-06-06 16:45:00');


INSERT INTO api_log
(id, order_id, api_name, response_code, error_message, created_date)
VALUES
(1,1001,'Order Push',200,NULL,'2026-06-01 10:20:00'),
(2,1002,'Shipment Push',200,NULL,'2026-06-03 10:05:00'),
(3,1003,'Order Cancel',500,'Cancellation API Failed','2026-06-03 11:10:00'),
(4,1004,'Shipment Update',200,NULL,'2026-06-05 14:05:00'),
(5,1005,'Inventory Sync',503,'Service Unavailable','2026-06-06 17:00:00');



INSERT INTO inventory
(sku, available_qty, reserved_qty)
VALUES
('SKU1001',120,15),
('SKU1002',85,10),
('SKU1003',0,0),
('SKU1004',250,35),
('SKU1005',40,5);


INSERT INTO orderdetail
(order_id, sku, order_qty, order_status, created_date)
VALUES
(1001,'SKU1001',2,'Packed','2026-06-01 10:16:00'),
(1002,'SKU1002',1,'Created','2026-06-02 11:22:00'),
(1003,'SKU1003',3,'Cancelled','2026-06-03 09:42:00'),
(1004,'SKU1004',2,'Shipped','2026-06-04 15:12:00'),
(1005,'SKU1005',5,'Processing','2026-06-05 13:35:00');


INSERT INTO scheduler_log
(id, job_name, status, error_message, created_date)
VALUES
(1,'Inventory Sync','SUCCESS',NULL,'2026-06-06 01:00:00'),
(2,'Shipment Sync','SUCCESS',NULL,'2026-06-06 02:00:00'),
(3,'Order Push','FAILED','Timeout while connecting to API','2026-06-06 03:00:00');


INSERT INTO table_metadata
(table_name, description, primary_key, purpose)
VALUES
('orders','Stores customer order information','order_id','Primary order details'),
('shipment','Stores shipment and AWB information','shipment_id','Shipment tracking'),
('inventory','Stores SKU inventory information','sku','Inventory availability'),
('api_log','Stores API request and response logs','id','API troubleshooting'),
('scheduler_log','Stores scheduler execution logs','id','Scheduler monitoring'),
('orderdetail','Stores SKU level order details','id','Product level order investigation');


INSERT INTO column_metadata
(table_name,column_name,data_type,description,searchable)
VALUES
('orders','order_id','INT','Unique Order Identifier',1),
('orders','customer_name','VARCHAR','Customer Name',0),
('orders','order_status','VARCHAR','Current Order Status',1),
('orders','payment_status','VARCHAR','Payment Status',1),
('orders','warehouse_id','INT','Warehouse Identifier',0),

('shipment','shipment_id','INT','Shipment Identifier',0),
('shipment','order_id','INT','Order Reference',1),
('shipment','awb','VARCHAR','Airway Bill Number',1),
('shipment','shipment_status','VARCHAR','Shipment Status',1),
('shipment','carrier','VARCHAR','Courier Partner',0),

('inventory','sku','VARCHAR','Product SKU',1),
('inventory','available_qty','INT','Available Quantity',0),
('inventory','reserved_qty','INT','Reserved Quantity',0),

('api_log','id','INT','Log Identifier',0),
('api_log','order_id','INT','Order Reference',1),
('api_log','api_name','VARCHAR','API Name',0),
('api_log','response_code','INT','HTTP Response Code',1),
('api_log','error_message','VARCHAR','API Error',1),

('scheduler_log','job_name','VARCHAR','Scheduler Job Name',1),
('scheduler_log','status','VARCHAR','Scheduler Status',1),
('scheduler_log','error_message','VARCHAR','Scheduler Error',1),

('orderdetail','order_id','INT','Order Reference',1),
('orderdetail','sku','VARCHAR','Product SKU',1),
('orderdetail','order_qty','INT','Ordered Quantity',0),
('orderdetail','order_status','VARCHAR','Order Status',1);



INSERT INTO business_rules
(issue_type,rule_name,rule_description,priority)
VALUES
('order_issue',
'Order Investigation',
'Verify order details before checking downstream systems.',
1),

('shipment_issue',
'Shipment Investigation',
'Check shipment table using order_id. If AWB is provided, search by awb.',
1),

('inventory_issue',
'Inventory Investigation',
'Verify inventory availability using SKU.',
1),

('api_failure',
'API Failure Investigation',
'Review API logs using order_id and response_code.',
2),

('scheduler_issue',
'Scheduler Investigation',
'Verify scheduler execution logs for failed jobs.',
2),

('sku_issue',
'SKU Investigation',
'Validate SKU details from orderdetail and inventory tables.',
1);


INSERT INTO investigation_steps
(issue_type,sequence_no,table_name,lookup_column,description)
VALUES

('order_issue',1,'orders','order_id','Fetch order details'),
('order_issue',2,'orderdetail','order_id','Fetch SKU details'),
('order_issue',3,'shipment','order_id','Fetch shipment information'),

('shipment_issue',1,'shipment','order_id','Fetch shipment details'),
('shipment_issue',2,'orders','order_id','Validate order'),
('shipment_issue',3,'api_log','order_id','Verify shipment API'),

('inventory_issue',1,'inventory','sku','Fetch inventory'),
('inventory_issue',2,'orderdetail','sku','Fetch SKU order details'),

('api_failure',1,'api_log','order_id','Fetch API logs'),
('api_failure',2,'orders','order_id','Validate order'),

('scheduler_issue',1,'scheduler_log','job_name','Check scheduler status'),

('sku_issue',1,'orderdetail','sku','Fetch SKU details'),
('sku_issue',2,'inventory','sku','Check inventory');