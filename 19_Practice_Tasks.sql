CREATE TABLE demo.web_logs (
  session_id INT64,
  event_data JSON
);


INSERT INTO demo.web_logs (session_id, event_data)
VALUES
(1, JSON '{"user":{"id":201,"name":"Alice"},"page":"home","actions":[{"type":"click","element":"banner"},{"type":"scroll","depth":70}],"duration_sec":45,"timestamp":"2025-11-01T09:15:00Z"}'),
(2, JSON '{"user":{"id":202,"name":"Bob"},"page":"product","actions":[{"type":"click","element":"add_to_cart"}],"duration_sec":120,"timestamp":"2025-11-02T10:05:10Z"}'),
(3, JSON '{"user":{"id":203,"name":"Clara"},"page":"checkout","actions":[{"type":"click","element":"pay_button"},{"type":"input","element":"email_field"}],"duration_sec":80,"timestamp":"2025-11-03T18:45:20Z"}'),
(4, JSON '{"user":{"id":204,"name":"Dan"},"page":"home","actions":[{"type":"scroll","depth":90}],"duration_sec":60,"timestamp":"2025-11-04T08:30:00Z"}'),
(5, JSON '{"user":{"id":205,"name":"Eve"},"page":"product","actions":[{"type":"click","element":"image"},{"type":"click","element":"description_tab"}],"duration_sec":150,"timestamp":"2025-11-04T13:00:00Z"}'),
(6, JSON '{"user":{"id":206,"name":"Frank"},"page":"home","actions":[{"type":"click","element":"menu"}],"duration_sec":30,"timestamp":"2025-11-05T11:20:10Z"}'),
(7, JSON '{"user":{"id":207,"name":"Gina"},"page":"checkout","actions":[{"type":"click","element":"apply_coupon"}],"duration_sec":110,"timestamp":"2025-11-02T14:40:00Z"}'),
(8, JSON '{"user":{"id":208,"name":"Hank"},"page":"product","actions":[{"type":"scroll","depth":50},{"type":"click","element":"review_tab"}],"duration_sec":95,"timestamp":"2025-11-03T19:30:45Z"}'),
(9, JSON '{"user":{"id":209,"name":"Ivy"},"page":"home","actions":[{"type":"scroll","depth":100}],"duration_sec":40,"timestamp":"2025-11-05T09:10:30Z"}'),
(10, JSON '{"user":{"id":210,"name":"Jake"},"page":"checkout","actions":[{"type":"click","element":"cancel_button"}],"duration_sec":20,"timestamp":"2025-11-01T22:22:00Z"}')
;

select * from demo.web_logs;

/*
Task 1, 0.5

Stakeholder request: “We need to evaluate website engagement by page type, but the event logs are stored as JSON. Avoid flattening arrays.”

Write one SQL query (no UNNEST) that outputs, for each page type:
- Average session duration (duration_sec)
- Count of unique users (user.id)
- Timestamp of the latest session
*/


/*
Task 2, 0.5

Stakeholder wants deeper insight into how users interact with specific elements.

 Write a query that returns, for each page and action type:
- Total number of actions
- Number of unique users who performed them
- Most recent timestamp of such action

*/
