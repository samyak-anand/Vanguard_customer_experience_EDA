use vanguard;

select * from customer_data;


SELECT 
    client_id, 
    clnt_age,gendr,
    CAST(clnt_tenure_yr AS SIGNED) AS clnt_tenure_yr,
    CAST(clnt_tenure_mnth AS SIGNED) AS clnt_tenure_mnth,
    CAST(num_accts AS SIGNED) AS num_accts,
    CAST(calls_6_mnth AS SIGNED) AS calls_6_mnth,
    CAST(logons_6_mnth AS SIGNED) AS logons_6_mnth,
    bal
FROM customer_data;

/*
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
*/
select *  from customer_data_cleaned cc
inner join digital_footprint df on cc.client_id= df.client_id;

/*
calculating the number of visit on every steps 
*/
SELECT 
  cc.client_id,
  df.process_step,
  COUNT(DISTINCT df.visit_id) AS num_visits
FROM customer_data_cleaned cc
INNER JOIN digital_footprint df 
  ON cc.client_id = df.client_id
GROUP BY cc.client_id, df.process_step
ORDER BY cc.client_id, FIELD(df.process_step, 'start', 'step_1', 'step_2', 'step_3', 'confirm');


select *  from customer_data_cleaned cc
inner join digital_footprint df on cc.client_id= df.client_id
where cc.client_id=1643;

SELECT 
  COUNT(DISTINCT CASE WHEN df.process_step = 'confirm' THEN cc.client_id END) 
    / COUNT(DISTINCT cc.client_id) AS completion_rate
FROM customer_data_cleaned cc
INNER JOIN digital_footprint df 
  ON cc.client_id = df.client_id;
/*
CComplted visit by customers 
*/

SELECT 
  cc.client_id,
  CASE 
    WHEN MAX(CASE WHEN df.process_step = 'confirm' THEN 1 ELSE 0 END) = 1 THEN 1
    ELSE 0
  END AS completed
FROM customer_data_cleaned cc
INNER JOIN digital_footprint df 
  ON cc.client_id = df.client_id
GROUP BY cc.client_id;
/*
SELECT 
  COUNT(DISTINCT CASE 
                   WHEN MAX(CASE WHEN df.process_step = 'confirm' THEN 1 ELSE 0 END) = 1 THEN cc.client_id 
                 END) 
  / COUNT(DISTINCT cc.client_id) AS overall_completion_rate
FROM customer_data_cleaned cc
INNER JOIN digital_footprint df 
  ON cc.client_id = df.client_id;
*/

select * from customer_data_cleaned;
/* 
completion rate 
*/

SELECT 
  cc.client_id,
  COUNT(DISTINCT df.process_step) /4 AS completion_rate -- Assuming there are 5 steps in total
FROM customer_data_cleaned cc
INNER JOIN digital_footprint df 
  ON cc.client_id = df.client_id
WHERE df.process_step IN ( 'step_1', 'step_2', 'step_3', 'confirm')
GROUP BY cc.client_id;



