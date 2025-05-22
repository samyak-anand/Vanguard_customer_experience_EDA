SELECT 
    sp.date_time,
    sp.client_id,
    sp.visitor_id,
    sp.visit_id,
    CASE
        WHEN sp.process_step = 'start' THEN 0
        WHEN sp.process_step = 'step_1' THEN 1
        WHEN sp.process_step = 'step_2' THEN 2
        WHEN sp.process_step = 'step_3' THEN 3
        WHEN sp.process_step = 'confirm' THEN 4
        ELSE NULL
    END AS process_id,
    sp.Variation,
    sp.process_step,
    ps.num_visits,
    ps.confirm_count,
    ps.completed,
    ci.time_spent_seconds,
    sp.error AS step_error
FROM sorted_process_step sp
JOIN process_steps ps 
    ON sp.visit_id = ps.visit_id AND sp.process_step = ps.process_step
JOIN client_interactions ci 
    ON ps.client_id = ci.client_id AND ps.process_step = ci.process_step;
