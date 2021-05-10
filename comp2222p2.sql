
CREATE TABLE END_USER (
username CHAR(30) PRIMARY KEY,
password CHAR(20) NOT NULL,
fname CHAR(30) NOT NULL,
lname CHAR(30) NOT NULL,
military_service_status CHAR(20)
);

CREATE TABLE END_USER_EMAIL (
username CHAR(30),
email CHAR(50),
FOREIGN KEY (username) REFERENCES END_USER(username) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(username,email)
);

CREATE TABLE HRR (
end_user_username CHAR(30),
fname CHAR(30)NOT NULL,
lname CHAR(30) NOT NULL,
password CHAR(20) NOT NULL,
username CHAR(30) PRIMARY KEY
);

CREATE TABLE COMPANY (
cid INTEGER(20) PRIMARY KEY,
name CHAR(50) NOT NULL,
address CHAR(100) NOT NULL,
phone INTEGER(15) NOT NULL
);

CREATE TABLE EMPLOYEMENT_HISTORY (
username CHAR(20) NOT NULL,
cid INTEGER(20) NOT NULL,
end_date date NOT NULL,
position CHAR(20) NOT NULL,
start_date date NOT NULL PRIMARY KEY,
duration INTEGER(20) GENERATED ALWAYS AS (start_date-end_date) VIRTUAL,
FOREIGN KEY (username) REFERENCES END_USER(username) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (cid) REFERENCES COMPANY(cid) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE JOB_POSTING (
jid INTEGER(20) PRIMARY KEY,
description CHAR(100) NOT NULL,
salary INTEGER(20) NOT NULL,
phone INTEGER(20) NOT NULL,
manager_or_intern CHAR(20) NOT NULL,
contract_type CHAR(20) NOT NULL,
opening_date date NOT NULL,
duration INTEGER(20) NOT NULL ,
cid INTEGER(20) NOT NULL,
HRR_username CHAR(20) NOT NULL,
FOREIGN KEY (cid) REFERENCES COMPANY(cid) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (HRR_username) REFERENCES HRR(username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE APPLICATION (
jid INTEGER(20),
username CHAR(20),
date_applied date NOT NULL,
applicant_resume CHAR(100) NOT NULL,
university CHAR(100) NOT NULL,
program CHAR(100) NOT NULL,
gpa REAL NOT NULL,
standing CHAR(50) NOT NULL,
number_of_days INTEGER(20) NOT NULL,
PRIMARY KEY(jid,username),
FOREIGN KEY (jid) REFERENCES JOB_POSTING(jid) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (username) REFERENCES END_USER(username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MANAGER_JOB_POSTING (
jid INTEGER(20) NOT NULL,
department_name CHAR(20) NOT NULL,
department_size INTEGER(20) NOT NULL,
PRIMARY KEY (jid),
FOREIGN KEY (jid) REFERENCES JOB_POSTING(jid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE INTERNSHIP_JOB_POSTING (
jid INTEGER(20) NOT NULL,
minimum_days INTEGER(20) NOT NULL,
PRIMARY KEY (jid),
FOREIGN KEY (jid) REFERENCES JOB_POSTING(jid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE END_USER_EMPLOYER (
cid INTEGER(20) NOT NULL,
username CHAR(20) NOT NULL,
start_date DATE NOT NULL,
PRIMARY KEY(cid,username),
FOREIGN KEY (cid) REFERENCES COMPANY(cid) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (username) REFERENCES END_USER(username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE COURSES_FOR_INTERNSHIP_APPLICATIONS (
ciaid INTEGER(20)  PRIMARY KEY,
jid INTEGER(20) NOT NULL,
username CHAR(20) NOT NULL,
course CHAR(20) NOT NULL,
FOREIGN KEY (jid) REFERENCES JOB_POSTING(jid) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (username) REFERENCES END_USER(username) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO END_USER(username,password,fname,lname,military_service_status) VALUES 
("Ironman","GstVdKGn","Robert","Downey Jr.","Completed"),
("Captain America","IzLdAsXd","Chris","Evans","Completed"),
("Hulk","YfNhybjQ","Mark","Ruffalo","Completed"),
("Thor","lkiAtaKw","Chris","Hemsworth","Delayed"),
("Black Widow","dEzrbSXk","Scarlett","Johansson",null),
("Loki","HfKoabCs","Tom","Hiddleston","completed"),
("Scarlet Witch","NGfKGqVp","Elizabeth","Olsen",null),
("Black Panther","svdCdgXn","Chadwick","Boseman","Completed"),
("Winter Soldier","fQPaKuue","Sebastian","Stan","Completed"),
("Spiderman","gRtaMbpJ","Tom","Holland","Exempt")
;
INSERT INTO END_USER_EMAIL (username,email) VALUES 
((SELECT username FROM END_USER WHERE username = "Ironman"),"ironman@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Captain America"),"captainamerica@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Hulk"),"hulk@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Thor"),"thor@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Black Widow"),"blackwidow@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Loki"),"loki@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Scarlet Witch"),"scarletwitch@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Black Panther"),"blackpanther@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Winter Soldier"),"wintersoldier@hotmail.com"),
((SELECT username FROM END_USER WHERE username = "Spiderman"),"spiderman@hotmail.com")
;
INSERT INTO HRR (end_user_username,fname,lname,password,username) VALUES 
((SELECT username FROM END_USER WHERE username = "Ironman"),(SELECT fname FROM END_USER WHERE username = "Ironman"),(SELECT lname FROM END_USER WHERE username = "Ironman"),"VkgtcbuW","Ironman"),
(null,"Ivan","Vanko","PLqAlzdt","Whiplash"),
(null,"Emil","Blonsky","CvnWCZey","Abomination"),
((SELECT username FROM END_USER WHERE username = "Thor"),(SELECT fname FROM END_USER WHERE username = "Thor"),(SELECT lname FROM END_USER WHERE username = "Thor"),"vklVXfMy","Thor"),
(null,"Frost Giant","Laufey","WAvPGTRV","Laufey"),
((SELECT username FROM END_USER WHERE username = "Scarlet Witch"),(SELECT fname FROM END_USER WHERE username = "Scarlet Witch"),(SELECT lname FROM END_USER WHERE username = "Scarlet Witch"),"lSvwvVCL","Scarlet Witch"),
(null,"Darren","Cross","LRgzMfmj","Yellow Jacket")
;
INSERT INTO COMPANY (cid,name,address,phone) VALUES 
(0,"Avengers","Disney Studios","123456789"),
(1,"X-men","Disney Studios","930732235"),
(2,"Fantastic Four","Disney Studios","202392222"),
(3,"Runaways","Disney Studios","494151507"),
(4,"Guardians Of The Galaxy","Disney Studios","723438354"),
(5,"Starforce","Disney Studios","216977360"),
(6,"Defenders","Disney Studios","274254362"),
(7,"HYDRA","Disney Studios","118589724"),
(8,"Eternals","Disney Studios","201026402"),
(9,"Inhumans","Disney Studios","416061279")
;

INSERT INTO EMPLOYEMENT_HISTORY (username,cid,end_date,position,start_date) VALUES 
((SELECT username FROM END_USER WHERE username ="Ironman"),(SELECT cid FROM company WHERE cid = 0),"2008-05-02","Founder","2019-04-25"),
((SELECT username FROM END_USER WHERE username ="Captain America"),(SELECT cid FROM company WHERE cid = 7),"2011-09-02","Employee","2019-05-25"),
((SELECT username FROM END_USER WHERE username ="Thor"),(SELECT cid FROM company WHERE cid = 5),"2011-04-29","Employee","2019-06-25"),
((SELECT username FROM END_USER WHERE username ="Black Widow"),(SELECT cid FROM company WHERE cid = 6),"2010-07-05","Employee","2019-07-25"),
((SELECT username FROM END_USER WHERE username ="Spiderman"),(SELECT cid FROM company WHERE cid = 0),"2016-05-06","Employee","2019-08-25")
;
INSERT INTO JOB_POSTING (jid,description,salary,phone,manager_or_intern,contract_type,opening_date,duration,cid,HRR_username) VALUES 
(0,"Now Hiring",74365,(SELECT phone FROM company WHERE cid = 0),"Manager","Full Time","2020-07-02",5,(SELECT cid FROM company WHERE cid = 0),(SELECT username FROM HRR WHERE username = "Ironman")),
(1,"Now Hiring",30394,(SELECT phone FROM company WHERE cid = 1),"Intern","Internship","2020-05-02",5,(SELECT cid FROM company WHERE cid = 1),(SELECT username FROM HRR WHERE username = "Ironman")),
(2,"Now Hiring",53074,(SELECT phone FROM company WHERE cid = 1),"Intern","Internship","2020-03-02",5,(SELECT cid FROM company WHERE cid = 1),(SELECT username FROM HRR WHERE username = "Whiplash")),
(3,"Now Hiring",26943,(SELECT phone FROM company WHERE cid = 3),"Intern","Internship","2020-04-02",5,(SELECT cid FROM company WHERE cid = 3),(SELECT username FROM HRR WHERE username = "Thor")),
(4,"Now Hiring",63649,(SELECT phone FROM company WHERE cid = 1),"Manager","Part Time","2020-08-02",5,(SELECT cid FROM company WHERE cid = 1),(SELECT username FROM HRR WHERE username = "Thor")),
(5,"Now Hiring",88540,(SELECT phone FROM company WHERE cid = 5),"Intern","Internship","2020-06-02",5,(SELECT cid FROM company WHERE cid = 5),(SELECT username FROM HRR WHERE username = "Scarlet Witch")),
(6,"Now Hiring",70333,(SELECT phone FROM company WHERE cid = 6),"Intern","Internship","2020-06-02",5,(SELECT cid FROM company WHERE cid = 6),(SELECT username FROM HRR WHERE username = "Scarlet Witch")),
(7,"Now Hiring",75401,(SELECT phone FROM company WHERE cid = 7),"Manager","Full Time","2020-01-02",5,(SELECT cid FROM company WHERE cid = 7),(SELECT username FROM HRR WHERE username = "Scarlet Witch")),
(8,"Now Hiring",63063,(SELECT phone FROM company WHERE cid = 8),"Manager","Part Time","2020-05-02",5,(SELECT cid FROM company WHERE cid = 8),(SELECT username FROM HRR WHERE username = "Ironman")),
(9,"Now Hiring",20000,(SELECT phone FROM company WHERE cid = 9),"Intern","Internship","2020-03-02",5,(SELECT cid FROM company WHERE cid = 9),(SELECT username FROM HRR WHERE username = "Thor"))
;
INSERT INTO APPLICATION (jid,username,date_applied,applicant_resume,university,program,gpa,standing,number_of_days) VALUES 
((SELECT jid FROM job_posting WHERE jid = 0),(SELECT username FROM END_USER WHERE username ="Ironman"),"2020-02-03","I am iron man","Isik University","Hero",3.20,"Senior",5),
((SELECT jid FROM job_posting WHERE jid = 1),(SELECT username FROM END_USER WHERE username ="Captain America"),"2020-02-03","I can do this all day","Isik University","Hero",2.03,"Junior",5),
((SELECT jid FROM job_posting WHERE jid = 2),(SELECT username FROM END_USER WHERE username ="Captain America"),"2020-02-03","I can do this all day","Isik University","Hero",2.03,"Senior",5),
((SELECT jid FROM job_posting WHERE jid = 3),(SELECT username FROM END_USER WHERE username ="Thor"),"2020-02-03","You people are so petty and tiny","Isik University","Hero",2.89,"Senior",5),
((SELECT jid FROM job_posting WHERE jid = 4),(SELECT username FROM END_USER WHERE username ="Black Widow"),"2020-02-03","Did i step on your moment","Isik University","Hero",1.72,"Junior",5),
((SELECT jid FROM job_posting WHERE jid = 4),(SELECT username FROM END_USER WHERE username ="Loki"),"2020-02-03","I assure you brother the sun will shine on us again","Isik University","Hero",2.11,"Senior",5),
((SELECT jid FROM job_posting WHERE jid = 6),(SELECT username FROM END_USER WHERE username ="Scarlet Witch"),"2020-02-03","You guys know i can move thing with my mind right","Isik University","Hero",3.02,"Senior",5),
((SELECT jid FROM job_posting WHERE jid = 7),(SELECT username FROM END_USER WHERE username ="Black Panther"),"2020-02-03","Wakanda forever","Isik University","hero",2.25,"Freshman",5),
((SELECT jid FROM job_posting WHERE jid = 8),(SELECT username FROM END_USER WHERE username ="Winter Soldier"),"2020-02-03","I am no longer the winter soldier","Isik University","Hero",3.21,"Freshman",5),
((SELECT jid FROM job_posting WHERE jid = 9),(SELECT username FROM END_USER WHERE username ="Spiderman"),"2020-02-03","Your friendly neighbourhood","Isik University","Hero",3.00,"Freshman",5)
;
INSERT INTO MANAGER_JOB_POSTING (jid,department_name,department_size) VALUES 
((SELECT jid FROM job_posting WHERE jid = 0),"Special Effects",7),
((SELECT jid FROM job_posting WHERE jid = 1),"Music",10),
((SELECT jid FROM job_posting WHERE jid = 2),"Visual",5),
((SELECT jid FROM job_posting WHERE jid = 3),"Casting",2),
((SELECT jid FROM job_posting WHERE jid = 4),"Directing",55)
;
INSERT INTO INTERNSHIP_JOB_POSTING (jid,minimum_days) VALUES 
((SELECT jid FROM job_posting WHERE jid = 5),25),
((SELECT jid FROM job_posting WHERE jid = 6),30),
((SELECT jid FROM job_posting WHERE jid = 7),12),
((SELECT jid FROM job_posting WHERE jid = 8),14),
((SELECT jid FROM job_posting WHERE jid = 9),6)
;
INSERT INTO END_USER_EMPLOYER (cid,username,start_date) VALUES
((SELECT cid FROM company WHERE cid = 0),(SELECT username FROM END_USER WHERE username ="Ironman"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 1),(SELECT username FROM END_USER WHERE username ="Captain America"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 2),(SELECT username FROM END_USER WHERE username ="Hulk"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 3),(SELECT username FROM END_USER WHERE username ="Thor"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 4),(SELECT username FROM END_USER WHERE username ="Black Widow"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 5),(SELECT username FROM END_USER WHERE username ="Loki"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 6),(SELECT username FROM END_USER WHERE username ="Scarlet Witch"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 7),(SELECT username FROM END_USER WHERE username ="Black Panther"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 8),(SELECT username FROM END_USER WHERE username ="Winter Soldier"),"2021-05-08"),
((SELECT cid FROM company WHERE cid = 9),(SELECT username FROM END_USER WHERE username ="Spiderman"),"2021-05-08")
;
INSERT INTO COURSES_FOR_INTERNSHIP_APPLICATIONS (ciaid,jid,username,course) VALUES 
(1,(SELECT jid FROM job_posting WHERE jid = 5),(SELECT username FROM END_USER WHERE username ="Spiderman"),"Web Throwing"),
(2,(SELECT jid FROM job_posting WHERE jid = 6),(SELECT username FROM END_USER WHERE username ="Winter Soldier"),"Fighting"),
(3,(SELECT jid FROM job_posting WHERE jid = 7),(SELECT username FROM END_USER WHERE username ="Scarlet Witch"),"Spell"),
(4,(SELECT jid FROM job_posting WHERE jid = 8),(SELECT username FROM END_USER WHERE username ="Black Panther"),"Technology"),
(5,(SELECT jid FROM job_posting WHERE jid = 9),(SELECT username FROM END_USER WHERE username ="Thor"),"History")
;
;




