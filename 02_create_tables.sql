USE cfpb_complaints_db;

CREATE TABLE complaints (
    complaint_id BIGINT NOT NULL PRIMARY KEY,
    date_received DATETIME,
    product VARCHAR(100),
    sub_product VARCHAR(150),
    issue VARCHAR(255),
    sub_issue VARCHAR(255),
    consumer_complaint_narrative LONGTEXT,
    company_public_response TEXT,
    company VARCHAR(255),
    state CHAR(2),
    zip_code VARCHAR(10),
    tags VARCHAR(255),
    submitted_via VARCHAR(50),
    date_sent_to_company DATETIME,
    company_response_to_consumer VARCHAR(255),
    timely_response VARCHAR(10)
);


SHOW VARIABLES LIKE 'secure_file_priv';

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Projects/Enterprise AI Analytics Platform for Customer Complaints/data/processed/complaints_mysql_ready.csv'
INTO TABLE complaints
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    date_received,
    product,
    sub_product,
    issue,
    sub_issue,
    consumer_complaint_narrative,
    company_public_response,
    company,
    state,
    zip_code,
    tags,
    submitted_via,
    date_sent_to_company,
    company_response_to_consumer,
    timely_response,
    complaint_id
);


SELECT COUNT(*) AS total_rows
FROM complaints;

SHOW COUNT(*) WARNINGS;