/*
1. Select the last names of unemployed end-users.
2. Select the count of HRRs that also have an end-user profile.
3. Select the company (or companies) that listed the highest paying job’s posting.
4. Select the end-user that has been working at the same company for the longest period.
5. Select the first name and last name of the HRRs that posted a job listing for company C.
6. Select the number of end-users that applied to job listing J.
7. Select the number of applications by end-user E.
8. Select the username of the end-user(s) that has the maximum experience. 
Experience is measured by the duration of employment and does not include current employment.
9. Select the highest paying job listing.
10. For each end-user, list the number of applications to job listings. Order the result set by count in descending order.
11. Find the jobs those are suitable for an end user E, who is looking for a part-time job to work during the summer in Disney Studios.
12. Find the highest paying manager job with department size<50 for an end user E.
13. List the open internships positions of a particular company C which allows more than 20 days.
*/

SELECT lname AS "Last Name"
FROM end_user
WHERE end_user.lname NOT in (SELECT lname FROM END_USER e
RIGHT OUTER JOIN employement_history h ON e.username = h.username
ORDER BY h.username != 'null');

SELECT COUNT(*) as "Quantity of End-Users Who Are Also HRR's"
FROM hrr
WHERE end_user_username != 'null';

SELECT c.cid as "Company ID", c.name as "Company Name", salary AS "Salary"
FROM job_posting jp
LEFT OUTER JOIN company c ON c.cid = jp.cid
WHERE salary = (SELECT MAX(salary) FROM job_posting);

SELECT username as "Username", cid as "Company ID", position as "Position", duration as "Maximum Duration"
FROM employement_history
WHERE duration = (SELECT MAX(duration) FROM employement_history);

SELECT fname as "First Name", lname as "Late Name", cid as "Company ID" FROM hrr h
LEFT OUTER JOIN job_posting jp ON h.username = jp.HRR_username
WHERE cid = 1;

SELECT COUNT(*) AS "Quantity of Applicants to Job Posting ID = 4"
FROM application
WHERE jid = 4;

SELECT username as "Username", COUNT(*) AS "Quantity of Applications"
FROM application
WHERE username = "Captain America";

SELECT username as "Username", duration AS "Maximum Employment Duration"
FROM employement_history
WHERE duration = (SELECT MAX(duration) FROM employement_history);

SELECT jid as "Job ID", salary as "Maximum Salary"
FROM job_posting
WHERE salary = (SELECT MAX(salary) FROM job_posting);

SELECT username as "Username", COUNT(jid) as "Quantity of Applications"
FROM application 
GROUP BY username 
ORDER BY COUNT(jid) desc;

SELECT * FROM job_posting jp
LEFT OUTER JOIN company c ON c.cid = jp.cid
WHERE contract_type = "part time" AND (opening_date >= "2020-06-01" AND opening_date <= "2020-09-01"/*for summer parttime jobs*/) 
AND address = "disney studios";


SELECT department_name as "Department Name", department_size as "Department Size", MAX(salary) as "Maximum Salary", jp.* FROM manager_job_posting mjp
LEFT OUTER JOIN job_posting jp ON mjp.jid = jp.jid
WHERE department_size < 50;


SELECT cid as "Company ID",jp.* FROM internship_job_posting ijp
LEFT OUTER JOIN job_posting jp ON ijp.jid = jp.jid
WHERE minimum_days >= 20 AND cid = 5;
