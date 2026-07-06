ANALYZE TABLE complaints;

CREATE INDEX idx_date_received ON complaints(date_received);

CREATE INDEX idx_date_sent_to_company ON complaints(date_sent_to_company);

CREATE INDEX idx_product ON complaints(product);

CREATE INDEX idx_sub_product ON complaints(sub_product);

CREATE INDEX idx_issue ON complaints(issue);

CREATE INDEX idx_sub_issue ON complaints(sub_issue);

CREATE INDEX idx_company ON complaints(company);

CREATE INDEX idx_company_public_response ON complaints(company_public_response);

CREATE INDEX idx_zip_code ON complaints(zip_code);

CREATE INDEX idx_tags ON complaints(tags);

CREATE INDEX idx_state ON complaints(state);

CREATE INDEX idx_submitted_via ON complaints(submitted_via);

CREATE INDEX idx_timely_response ON complaints(timely_response);

CREATE INDEX idx_company_response ON complaints(company_response_to_consumer);

 