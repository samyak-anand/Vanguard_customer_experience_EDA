USE vanguard;
CREATE VIEW customer_data_view  AS
SELECT 
    client_id, 
    clnt_age,
    gendr as gender,
    CAST(clnt_tenure_yr AS SIGNED) AS clnt_tenure_yr,
    CAST(clnt_tenure_mnth AS SIGNED) AS clnt_tenure_mnth,
    CAST(num_accts AS SIGNED) AS num_accts,
    CAST(calls_6_mnth AS SIGNED) AS calls_6_mnth,
    CAST(logons_6_mnth AS SIGNED) AS logons_6_mnth,
    bal as balance 
FROM customer_data;


CREATE TABLE customer_data_cleaned AS
SELECT * FROM customer_data_view;