SELECT 
  v.client_id,
  v.process_step,
  v.num_visits,
  v.visit_id,

  -- Mark as completed only for confirm steps
  CASE 
    WHEN v.process_step = 'confirm' THEN 1 
    ELSE 0 
  END AS completed,

  -- Total completions shown only on confirm rows
  CASE 
    WHEN v.process_step = 'confirm' THEN c.total_confirm 
    ELSE 0 
  END AS total_completions,

  -- Individual step counts shown only for matching rows
  CASE WHEN v.process_step = 'start' THEN v.step_count ELSE 0 END AS start_count,
  CASE WHEN v.process_step = 'step_1' THEN v.step_count ELSE 0 END AS step_1_count,
  CASE WHEN v.process_step = 'step_2' THEN v.step_count ELSE 0 END AS step_2_count,
  CASE WHEN v.process_step = 'step_3' THEN v.step_count ELSE 0 END AS step_3_count,
  CASE WHEN v.process_step = 'confirm' THEN v.step_count ELSE 0 END AS confirm_count

FROM (
  SELECT 
    df.client_id,
    df.process_step,
    df.visit_id,
    COUNT(*) AS num_visits,
    COUNT(*) AS step_count
  FROM digital_footprint df
  GROUP BY df.client_id, df.process_step, df.visit_id
) v

LEFT JOIN (
  SELECT 
    client_id,
    COUNT(*) AS total_confirm
  FROM digital_footprint
  WHERE process_step = 'confirm'
  GROUP BY client_id
) c ON v.client_id = c.client_id

ORDER BY v.client_id, FIELD(v.process_step, 'start', 'step_1', 'step_2', 'step_3', 'confirm');
