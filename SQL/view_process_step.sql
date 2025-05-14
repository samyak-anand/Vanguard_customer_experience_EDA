USE vanguard;
create view  process_step_fact as
SELECT 
  v.client_id,
  v.process_step,
  v.num_visits,
  -- 1 if this row is for 'confirm' and client has at least one confirm, else 0
  CASE 
    WHEN v.process_step = 'confirm' AND c.confirm_count > 0 THEN 1
    ELSE 0
  END AS completed,
  -- only show confirm_count when it's the confirm step, else 0
  CASE 
    WHEN v.process_step = 'confirm' THEN c.confirm_count
    ELSE 0
  END AS total_completions
FROM (
  -- Subquery to count visits by process step
  SELECT 
    df.client_id,
    df.process_step,
    COUNT(DISTINCT df.visit_id) AS num_visits
  FROM digital_footprint df
  GROUP BY df.client_id, df.process_step
) AS v
LEFT JOIN (
  -- Subquery to count how many times each client reached 'confirm'
  SELECT 
    client_id,
    COUNT(*) AS confirm_count
  FROM digital_footprint
  WHERE process_step = 'confirm'
  GROUP BY client_id
) AS c
ON v.client_id = c.client_id
ORDER BY v.client_id, FIELD(v.process_step, 'start', 'step_1', 'step_2', 'step_3', 'confirm');


CREATE TABLE process_steps AS
SELECT * FROM process_step_fact;
