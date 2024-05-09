-- 1. Write a SQL statement to create a table countries including columns country_id, country_name, and region_id, and make sure that the combination of columns country_id and region_id will be unique.
create table countries (
    country_id varchar(10) primary key,
    country_name varchar(40),
    region_id varchar(10) not null,
    unique (country_id, region_id)
);


-- 2. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.
create table jobs (
    job_id varchar(10) primary key,
    job_title varchar(35) default '',
    min_salary decimal(6, 0) default 150000,
    max_salary decimal(6, 0)
);


-- 3. Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id, and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column job_id contain only those values which exist in the jobs table.
create table job_history (
    employee_id int,
    start_date date,
    end_date date,
    job_id varchar(15) not null,
    department_id varchar(15) not null,
    constraint pk_job_history primary key (employee_id, start_date),
    constraint fk_job_history foreign key (job_id) references jobs(job_id),
    constraint chk_dates check (start_date < end_date)
);


-- 4. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id, and department_id and make sure that the employee_id column does not contain any duplicate value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain only those unique combination values, which combinations exist in the departments table.
create table departments (
    department_id varchar(10) not null primary key,
    department_name varchar(30) not null,
    manager_id int not null,
    location_id varchar(10)
);

create table employees (
    employee_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    phone_number varchar(20),
    hire_date date,
    job_id varchar(15),
    salary decimal(10, 2),
    commission decimal(10, 2),
    manager_id int,
    department_id varchar(10),
    constraint uk_email unique (email),
    constraint fk_job_id foreign key (job_id) references jobs(job_id)
);

alter table departments
add constraint fk_mgr_id foreign key (manager_id) references employees(employee_id);

alter table employees
add constraint fk_manager_department foreign key (manager_id, department_id) references departments(manager_id, department_id);


-- 5. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, email, phone_number hire_date, job_id, salary, commission, manager_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column department_id, reference by the column department_id of departments table, can contain only those values which are exists in the departments table and another foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables.
create table employees (
    employee_id int not null primary key,
    first_name varchar(50) not null,
    last_name varchar(50),
    email varchar(100) not null unique,
    phone_number varchar(20),
    hire_date date,
    job_id varchar(10) references jobs(job_id),
    salary decimal(10, 2),
    commission decimal(10, 2),
    manager_id int,
    department_id varchar(10),
    constraint fk_manager_department foreign key (manager_id, department_id) references departments(manager_id, department_id)
) engine=innodb;


-- 6. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE CASCADE that lets you allow to delete records in the employees(child) table that refer to a record in the jobs(parent) table when the record in the parent table is deleted and the ON UPDATE RESTRICT actions reject any updates.
create table employees (
    employee_id int not null primary key,
    first_name varchar(50) not null,
    last_name varchar(50),
    job_id varchar(10) references jobs(job_id) on delete cascade on update restrict,
    salary decimal(10, 2)
) engine=innodb;


-- 7. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE SET NULL action will set the foreign key column values in the child table(employees) to NULL when the record in the parent table(jobs) is deleted, with a condition that the foreign key column in the child table must accept NULL values and the ON UPDATE SET NULL action resets the values in the rows in the child table(employees) to NULL values when the rows in the parent table(jobs) are updated.
create table employees (
    employee_id int not null primary key,
    first_name varchar(50) not null,
    last_name varchar(50),
    job_id varchar(10) references jobs(job_id) on delete set null on update set null,
    salary decimal(10, 2)
) engine=innodb;


-- 8. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name, job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is that, The ON DELETE NO ACTION and the ON UPDATE NO ACTION actions will reject the deletion and any updates.
create table employees (
    employee_id int not null primary key,
    first_name varchar(50) not null,
    last_name varchar(50),
    job_id varchar(10) references jobs(job_id) on delete no action on update no action,
    salary decimal(10, 2)
) engine=innodb;
