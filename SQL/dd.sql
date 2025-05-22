USE vanguard;

SELECT 
    MAX(sp.date_time) AS date_time,
    sp.client_id,
    sp.visitor_id,
    sp.visit_id,
    MAX(
        CASE
            WHEN sp.process_step = 'start' THEN 0
            WHEN sp.process_step = 'step_1' THEN 1
            WHEN sp.process_step = 'step_2' THEN 2
            WHEN sp.process_step = 'step_3' THEN 3
            WHEN sp.process_step = 'confirm' THEN 4
            ELSE NULL
        END
    ) AS process_id,
    sp.Variation,
    MAX(ps.num_visits) AS num_visits,
    MAX(ps.confirm_count) AS confirm_count,
    MAX(ps.completed) AS completed,
    MAX(ci.time_spent_seconds) AS time_spent_seconds,
    MAX(sp.error) AS step_error
FROM sorted_process_step sp
JOIN process_steps ps 
    ON sp.visit_id = ps.visit_id
JOIN client_interactions ci 
    ON ps.client_id = ci.client_id
WHERE sp.date_time >= '2025-01-01'
GROUP BY sp.visit_id, sp.client_id, sp.visitor_id, sp.Variation
LIMIT 20000;
