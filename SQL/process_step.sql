
SELECT 
    base.client_id,
    base.visit_id,
    base.process_step,
    base.num_visits,
    CASE WHEN base.process_step = 'confirm' THEN 1 ELSE 0 END AS completed,
    -- COALESCE(comp.total_completions, 0) AS total_completions,
    CASE WHEN base.process_step = 'start' THEN base.num_visits ELSE 0 END AS start_count,
    CASE WHEN base.process_step = 'step_1' THEN base.num_visits ELSE 0 END AS step_1_count,
    CASE WHEN base.process_step = 'step_2' THEN base.num_visits ELSE 0 END AS step_2_count,
    CASE WHEN base.process_step = 'step_3' THEN base.num_visits ELSE 0 END AS step_3_count,
    CASE WHEN base.process_step = 'confirm' THEN base.num_visits ELSE 0 END AS confirm_count
FROM (
    SELECT client_id, visit_id, process_step, COUNT(*) AS num_visits
    FROM digital_footprint
    GROUP BY client_id, visit_id, process_step
) AS base
LEFT JOIN (
    SELECT client_id, COUNT(*) AS total_completions
    FROM digital_footprint
    WHERE process_step = 'confirm'
    GROUP BY client_id
) AS comp ON base.client_id = comp.client_id;
