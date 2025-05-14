USE vanguard;

SELECT 
  v.client_id,
  v.process_step,
  v.num_visits,

  -- Completion only if confirm step exists
  CASE 
    WHEN v.process_step = 'confirm' AND c.confirm_visits > 0 THEN 1
    ELSE 0
  END AS completed,

  -- Total completions only on confirm row
  CASE 
    WHEN v.process_step = 'confirm' THEN c.confirm_visits
    ELSE 0
  END AS total_completions,

  -- Step-specific counts only on matching step row
  CASE WHEN v.process_step = 'start' THEN s.start_count ELSE 0 END AS start_count,
  CASE WHEN v.process_step = 'step_1' THEN s.step_1_count ELSE 0 END AS step_1_count,
  CASE WHEN v.process_step = 'step_2' THEN s.step_2_count ELSE 0 END AS step_2_count,
  CASE WHEN v.process_step = 'step_3' THEN s.step_3_count ELSE 0 END AS step_3_count,
  CASE WHEN v.process_step = 'confirm' THEN s.confirm_count ELSE 0 END AS confirm_count
FROM (
  -- Per-client, per-step visit counts
  SELECT 
    client_id,
    process_step,
    COUNT(DISTINCT visit_id) AS num_visits
  FROM digital_footprint
  GROUP BY client_id, process_step
) AS v

-- Confirm step count
LEFT JOIN (
  SELECT 
    client_id,
    COUNT(DISTINCT visit_id) AS confirm_visits
  FROM digital_footprint
  WHERE process_step = 'confirm'
  GROUP BY client_id
) AS c ON v.client_id = c.client_id

-- Per-step counts
LEFT JOIN (
  SELECT 
    client_id,
    SUM(process_step = 'start') AS start_count,
    SUM(process_step = 'step_1') AS step_1_count,
    SUM(process_step = 'step_2') AS step_2_count,
    SUM(process_step = 'step_3') AS step_3_count,
    SUM(process_step = 'confirm') AS confirm_count
  FROM digital_footprint
  GROUP BY client_id
) AS s ON v.client_id = s.client_id

-- Total visits per client
LEFT JOIN (
  SELECT 
    client_id,
    COUNT(DISTINCT visit_id) AS total_visits
  FROM digital_footprint
  GROUP BY client_id
) AS t ON v.client_id = t.client_id

ORDER BY v.client_id, FIELD(v.process_step, 'start', 'step_1', 'step_2', 'step_3', 'confirm');
