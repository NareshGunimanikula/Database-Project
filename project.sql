DROP TABLE EMPLOYEESS;
CREATE TABLE EMPLOYEESS (
        EMPLOYEE_ID FOR COLUMN EMPLO00001 NUMERIC(6 , 0) DEFAULT , 
        FIRST_NAME VARCHAR(30) CCSID 37 NOT NULL, 
        LAST_NAME VARCHAR(30) CCSID 37 NOT NULL, 
        BIRTH_DATE DATE NOT NULL, 
        GENDER VARCHAR(1) CCSID 37 NOT NULL, 
        HIRE_DATE DATE NOT NULL, 
        EMPLOYEE_TYPE FOR COLUMN EMPLO00002 VARCHAR(1) CCSID 37 NOT NULL, 
        STOCK_OPTION FOR COLUMN STOCK00001 VARCHAR(1) CCSID 37 DEFAULT , 
        PROFIT_SHARING FOR COLUMN PROFI00001 VARCHAR(1) CCSID 37 DEFAULT , 
        YEARLY_BONUS FOR COLUMN YEARL00001 VARCHAR(1) CCSID 37 DEFAULT , 
        CONTRACT_NO FOR COLUMN CONTR00001 NUMERIC(6 , 0) DEFAULT , 
        MANAGER_ID NUMERIC(6 , 0) DEFAULT
    );

DROP TABLE AGENCIES;
CREATE TABLE AGENCIES (
        AGENCY_ID NUMERIC(6 , 0) NOT NULL, 
        AGENCY_NAME FOR COLUMN AGENC00001 VARCHAR(40) CCSID 37 NOT NULL, 
        CONTACT_NAME FOR COLUMN CONTA00001 VARCHAR(30) CCSID 37 DEFAULT , 
        PHONE_NUMBER FOR COLUMN PHONE00001 VARCHAR(15) CCSID 37 NOT NULL
    );

DROP TABLE CONTRACTS;
CREATE TABLE CONTRACTS (
        CONTRACT_NO FOR COLUMN CONTR00001 NUMERIC(6 , 0) NOT NULL, 
        HOURLY_RATE FOR COLUMN HOURL00001 DECIMAL(5 , 2) NOT NULL, 
        AGENCY_ID NUMERIC(6 , 0) NOT NULL
    );

DROP TABLE CUSTOMERS;
CREATE TABLE CUSTOMERS (
        CUSTOMER_ID FOR COLUMN CUSTO00001 NUMERIC(6 , 0) GENERATED AS IDENTITY (
            START WITH 1
            INCREMENT BY 1
            MINVALUE 1
            MAXVALUE 999999
            NO CYCLE
            CACHE 20
            NO ORDER ), 
        FIRST_NAME VARCHAR(30) CCSID 37 NOT NULL, 
        LAST_NAME VARCHAR(30) CCSID 37 NOT NULL, 
        ADDRESS VARCHAR(30) CCSID 37 NOT NULL, 
        CITY VARCHAR(30) CCSID 37 NOT NULL, 
        STATE VARCHAR(30) CCSID 37 NOT NULL, 
        COUNTRY VARCHAR(30) CCSID 37 DEFAULT
    );
  
  DROP TABLE PROJECTS;  
CREATE TABLE PROJECTS (
        PROJECT_ID NUMERIC(6 , 0) NOT NULL, 
        PROJECT_TITLE  VARCHAR(30) CCSID 37 NOT NULL, 
        START_DATE DATE DEFAULT , 
        END_DATE DATE DEFAULT , 
        QUOTED_PRICE DECIMAL(9 , 2) DEFAULT , 
        CUSTOMER_ID  NUMERIC(6 , 0) DEFAULT 
    );


  DROP TABLE EMPLOYEE_HOURS;
CREATE TABLE EMPLOYEE_HOURS (
        EMPLOYEE_ID  NUMERIC(6 , 0) NOT NULL, 
        PROJECT_ID NUMERIC(6 , 0) NOT NULL, 
        EMPLOYEE_HOURS FOR COLUMN EMPLO00002 DECIMAL(7 , 2) DEFAULT 
    );

RENAME TABLE EMPLOYEE_HOURS TO SYSTEM NAME EMPLO00002;

DROP TABLE JOBS;
CREATE TABLE JOBS (
        JOB_ID VARCHAR(10) CCSID 37 NOT NULL, 
        JOB_TITLE VARCHAR(35) CCSID 37 NOT NULL, 
        MIN_SALARY NUMERIC(6 , 0) DEFAULT , 
        MAX_SALARY NUMERIC(6 , 0) DEFAULT 
    );


DROP TABLE EMPLOYEE_JOB_HISTORYS;
CREATE TABLE EMPLOYEE_JOB_HISTORYS (
        EMPLOYEE_ID  NUMERIC(6 , 0) NOT NULL, 
        START_DATE DATE NOT NULL, 
        END_DATE DATE DEFAULT , 
        SALARY DECIMAL(9 , 2) DEFAULT , 
        JOB_ID NUMERIC(6 , 0) NOT NULL
    );

RENAME TABLE EMPLOYEE_JOB_HISTORYS TO SYSTEM NAME EMPLO00001;

DROP TABLE PAYMENTS;
CREATE TABLE PAYMENTS (
        PAYMENT_NO NUMERIC(6 , 0) NOT NULL, 
        PAYMENT_DATE  DATE NOT NULL, 
        PAYMENT_AMOUNT  DECIMAL(9 , 2) NOT NULL, 
        PROJECT_ID NUMERIC(6 , 0) NOT NULL
    );

 
 
-- Requirement 10
-- Constraints -- Primary Key

Alter table employeess  
Constraint employeess_employee_id_pk  Primary Key (employee_id);

Alter table contracts  
Constraint contracts_contract_no_pk  Primary Key (contract_no);

Alter table agencies  
Constraint agencies_agency_id_pk  Primary Key (agency_id);

Alter table employee_job_historys  
Constraint employees_job_historys_employee_id_pk  Primary Key (employee_id, start_date);

Alter table employee_hours  
Constraint employee_hours_employee_id_pk  Primary Key (employee_id, project_id);

Alter table projects  
Constraint projects_project_id_pk  Primary Key (project_id);

Alter table customers  
Constraint customers_customer_id_pk  Primary Key (customer_id);

Alter table payments  
Constraint payments_payment_no_pk  Primary Key (payment_no);

Alter table jobs
Constraint jobs_job_id_pk  Primary Key (job_id);

-- Requirement 10
-- Constraints -- Foreign Key
Alter table employeess 
Constraint employeess_manager_id_fk Foreign Key (manager_id) References employeess(employee_id);

Alter table employeess 
Constraint employeess_contract_no_fk Foreign Key (contract_no) References contracts(contract_no);


Alter table contracts 
Constraint agencies_agency_id_fk Foreign Key (agency_id) References agencies(agency_id);

ALTER TABLE agencies
ADD CONSTRAINT agencies_agencies_name_uk UNIQUE(agency_name);

Alter table employee_job_historys 
Constraint employee_job_historys_employee_id_fk Foreign Key (employee_id) References employeess(employee_id);

Alter table employee_job_historys 
Constraint employee_job_id_fk Foreign Key (job_id) References jobs(job_id);


Alter table employee_hours
constraint employee_hours_employee_id_fk Foreign Key (employee_id) References employeess(employee_id);

Alter table employee_hours
constraint employee_hours_project_id_fk Foreign Key (project_id) References projects(project_id);

ALTER TABLE projects
ADD CONSTRAINT projects_project_title_uk UNIQUE(project_title);

ALTER TABLE projects
ADD CONSTRAINT projects_customer_id_fk Foreign Key (customer_id) References customers(customer_id);

alter table payments 
add constraint payments_project_id_fk Foreign Key (project_id) References projects(project_id);

ALTER TABLE jobs
ADD CONSTRAINT jobss_job_title_uk UNIQUE(job_title);

-- Requirement 10

alter table employeess
add constraint p1_check check( (stock_option is not null and profit_sharing is null and yearly_bonus is null ) or 
(stock_option is null and profit_sharing is not null and yearly_bonus is null) or 
(stock_option is null and profit_sharing is null and yearly_bonus is not null ) or 
(stock_option is  null and profit_sharing is null and yearly_bonus is null ));


-- Requirement 10
-- Insert Statements 
insert into agencies values (1, 'Oracle Agency', 'Kishan', '9898989898' ),
(2, 'SQL Agency', 'God', '9898989891' ),
(3, 'MSSQL Agency', 'Avani', '9898989892' ),
(4, 'PLSQL Agency', 'Ashley', '9898989893' ),
(5, 'DB2 Agency', 'Jim', '9898989828' );


insert into contracts values (1, 23, 1),
(2, 30, 2),
(3, 35, 3),
(4, 40, 4),
(5, 45, 5);

insert into jobs values (1, 'Software Analyst' , 12000,50000 ),
(2, 'Business Analyst' , 12000,60000 ),
(3, 'Software Developer' , 12000,75000 ),
(4, 'Test engineer' , 12000,90000 ),
(5, 'DevOps Engineer ' , 12000,150000 );

insert into projects values (1, 'NS5', '01/01/2015' , '01/04/2016', 25000, 1),
(2, 'ABS', '02/01/2015' , '01/04/2016', 25000, 2),
(3, 'VVS', '03/01/2015' , '01/04/2016', 25000, 3),
(4, 'KXM', '04/01/2015' , '01/04/2016', 25000, 4),
(5, 'NPM', '05/01/2015' , '01/04/2016', 25000, 5),
(6, 'ASG', '06/01/2015' , '01/04/2016', 25000, 6);


insert into payments values (1, '02/01/2015', 250, 1),
(2, '02/01/2015', 250, 1),
(3, '02/11/2015', 2500, 2),
(4, '03/01/2015', 1250, 3),
(5, '02/04/2015', 2250, 3),
(6, '01/01/2015', 2510, 4),
(7, '01/01/2015', 2450, 2),
(8, '12/01/2015', 2550, 2),
(9, '10/01/2015', 2530, 3),
(10, '02/10/2015', 2250,2),
(11, '02/07/2015', 7250, 1);

insert into employeess values (1,'kishan', 'patel', '01/01/1992', 'M', '01/01/2015', 'E', 'Y' , null, null,1, null);
insert into employeess values (2,'avani', 'patel', '01/01/1992', 'F', '01/01/2015', 'E', 'Y' , null, null,1, 1);
insert into employeess values (3,'smith', 'patel', '01/01/1992', 'M', '01/01/2015', 'E', 'Y' , null, null,1, 1);

insert into employeess values (4,'mark', 'roy', '01/01/1992', 'M', '01/01/2015', 'P', null , 'Y', null,1, 1);
insert into employeess values (5,'jason', 'roy', '01/01/1992', 'F', '01/01/2015', 'P', null , 'Y', null,1, 4);
insert into employeess values (6,'chris', 'gayle', '01/01/1992', 'M', '01/01/2015', 'P', null , 'Y', null,1, 4);

insert into employeess values (7,'andre', 'russel', '01/01/1992', 'M', '01/01/2015', 'C', null , 'Y', null,1, 1);
insert into employeess values (8,'mark', 'peter', '01/01/1992', 'F', '01/01/2015', 'C', null , 'Y', null,1, 7);
insert into employeess values (9,'man', 'gayle', '01/01/1992', 'M', '01/01/2015', 'C', null , 'Y', null,1, 7);

insert into employeess values (10,'james', 'roy', '01/01/1992', 'M', '01/01/2015', 'R', null , null, 'Y',1, 1);
insert into employeess values (11,'klassn', 'beach', '01/01/1992', 'F', '01/01/2015', 'R', null , null, 'Y',1, 10);
insert into employeess values (12,'jon', 'key', '01/01/1992', 'M', '01/01/2015', 'R', null , null, 'Y',1, 10);

insert into employeess values (13,'Peter', 'roy', '01/01/1992', 'M', '01/01/2015', 'S', null , null, null,2, 1);
insert into employeess values (14,'Smith', 'beach', '01/01/1992', 'F', '01/01/2015', 'S', null , null, null,3, 10);
insert into employeess values (15,'Jason', 'key', '01/01/1992', 'M', '01/01/2015', 'S', null , null, null,2, 10);



insert into employee_job_historys values (1, '01/01/2015', '05/01/2015' , 25000 , 1),
(1, '05/02/2015', '10/01/2015' , 25000 , 1),
(2, '01/01/2015', '05/01/2015' , 25000 , 2),
(2, '05/02/2015', '10/01/2015' , 25000 , 2),
(3, '01/01/2015', '05/01/2015' , 50000 , 3),
(3, '05/02/2015', '10/01/2015' , 25000 , 3),
(4, '01/01/2015', '05/01/2015' , 75000 , 4),
(4, '05/02/2015', '10/01/2015' , 25000 , 4),
(5, '01/01/2015', '05/01/2015' , 95000 , 5),
(5, '05/02/2015', '10/01/2015' , 25000 , 5),
(6, '01/01/2015', '05/01/2015' , 95000 , 1),
(6, '05/02/2015', '10/01/2015' , 25000 , 1),
(7, '01/01/2015', '05/01/2015' , 95000 , 2),
(7, '05/02/2015', '10/01/2015' , 25000 , 2),
(8, '01/01/2015', '05/01/2015' , 95000 , 3),
(8, '05/02/2015', '10/01/2015' , 25000 , 3),
(9, '01/01/2015', '05/01/2015' , 95000 , 4),
(9, '05/02/2015', '10/01/2015' , 25000 , 4),
(10, '01/01/2015', '05/01/2015' , 95000 , 5),
(10, '05/02/2015', '10/01/2015' , 25000 , 5);