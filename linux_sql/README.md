# Linux Cluster Monitoring Agent
# Introduction
This project will allow Jarvis Linux Cluster Administration (LCA) team to track hardware information and recourse usage of each node in real-time, which are running on CentOS 7. This is done by gathering server usage data suchas: Available memory, Disk space, CPU idle, and CPU kernel and so on. These data are collected and saved in a PostgreSQL database automatically every minute in the background. On the other hand, the hardware specifications data like System hostname, Number of CPU, CPU architecture and so on. They are assumed to be static, which means that they will be collected once only. <br/> 
<br/>
Technolgies that been used:
  * IntelliJ IDEA
  * Bash
  * Docker
  * PostgreSQL
  * SQL
  * Git
  * GitHub

# Quick Start
* Start psql instance using psql_docker.sh:
    * Start psql instance: 
     ```
     ./scripts/psql_docker.sh start
     ```
* Create tables using ddl.sql in the host_agent database:
```
psql -h localhost -p 5432 -U postgres -d host_agent -f sql/ddl.sql
```
* Insert hardware specs data into the DB using host_info.sh:
```
./scripts/host_info.sh localhost 5432 host_agent postgres psql_password
```
* Insert hardware specs data into the DB using host_usage.sh:
```
./scripts/host_usage.sh localhost 5432 host_agent postgres psql_password
```
* Crontab setup (Collects and saves data in a PostgreSQL database automaticaly):
```
#edit crontab by typing this on the command-line:
crontab -e

#add this to crontab:
* * * * * bash (The whole path to host_usage.sh file) localhost 5432 host_agent postgres psql_password > /tmp/host_usage.log
```
# Implemenation
1. Setup GitHub using Git.
2. Install Docker and Provision a PSQL instance.
3. Create a ddl.sql script that will create two tables: a table for host hardware specification data and the second table for resource usage data.
4. Create host_info.sh and host_usage.sh scripts for extracting hardware specification data and resource usage data respectively and then store them in the PostgreSQL database tables.
5. Continuously collect usage data by using Crontab to execute the host_usage.sh script every minute.
6. Write SQL Queries that group hosts by CPU number and memory size (GROUP BY), calculate the percentage average used memory over 5 minute intervals where used memory = total memory - free memory (Aggregate functions and create round function), and detect host failures (Aggregate functions).

# Architecture
![host_agent-db](https://user-images.githubusercontent.com/97988554/173858848-6f9ce3e8-19d7-4734-acdd-e10af25cba5e.jpg)

# Scripts
* psql_docker.sh:
    * This script can create, start, or stop a PSQL docker container that contains the PSQL database: 
     ```
     # Create PSQL docker container:
     ./scripts/psql_docker.sh create db_username db_password

     # Start PSQL docker container:
     ./scripts/psql_docker.sh start

     # Stop PSQL docker container:
     ./scripts/psql_docker.sh stop
     ```
* host_info.sh: 
    * This script collects hardware specifications data such as:
      * hostname
      * cpu_number
      * cpu_architecture
      * cpu_model
      * cpu_mhz (CPU clock rate)
      * L2_cache (CPU cache memory)
      * total_mem (total memory)
      * timestamp (current time in UTC) 
    * Usage:
      * ``` ./scripts/host_info.sh localhost 5432 host_agent postgres psql_password ```
* host_usage.sh:
    * This script collects resource usage data such as:
      * timestamp
      * host_id
      * memory_free
      * cpu_idle (percentage of CPU when there is no program running)
      * cpu_kernel (percentage of CPU kernel)
      * disk_io (measures active disk I/O time)
      * disk_available (disk space)
    * Usage:
      * ``` ./scripts/host_usage.sh localhost 5432 host_agent postgres psql_password ```
* crontab:
     * This script allows the continuous execution (every minute) of host_usage.sh script: 
       1. Edit crontab: ``` crontab -e ```
       2. Add this line to the crontab editor to excute the file every minute: ``` * * * * * bash [The whole path to host_usage.sh file] localhost 5432 host_agent postgres psql_password > /tmp/host_usage.log ```
* queries.sql:
    * This scripts resolves three business problems:
      1. Group hosts by CPU number and sort by their memory size in descending order (largest memory size will be displayed at the first entry or row).
      2. Average used memory in percentage over 5 mins interval for each host.
      3. Detect host failures whenever it inserts less than three data points within a 5-min interval.
# Database Modeling
### ``` host_info ``` table:
Columns | Data Type | Constraint
| :--- | ---: | :---:
id | SERIAL | PRIMARY KEY
hostname | VARCHAR | NOT NULL <br/> UNIQUE
cpu_number | INTEGER | NOT NULL
cpu_architecture | VARCHAR | NOT NULL
cpu_model | VARCHAR | NOT NULL
cpu_mhz | DECIMAL(7,3) | NOT NULL
L2_cache | INTEGER | NOT NULL
total_mem | INTEGER | NOT NULL
timestamp | TIMESTAMP | NOT NULL

### ``` host_usage ``` table:
Columns | Data Type | Constraint
| :--- | ---: | :---:
timestamp | TIMESTAMP | NOT NULL
host_id | SERIAL | FOREIGN KEY <br/> refrences host_info(id)
memory_free | INTEGER | NOT NULL
cpu_idle | DECIMAL | NOT NULL
cpu_kernel | DECIMAL | NOT NULL
disk_io | INTEGER | NOT NULL
disk_available | INTEGER | NOT NULL
# Test
* __psql_docker.sh:__ was tested by using ``` docker container ls -a -f name=jrvs-psql ``` which gives us information about jrvs-psql container like when it was created and if it's running or not.
* __host_info.sh & host_usage.sh:__ were tested by using Data Manipulation Language (DML) statments in PSQL, for example: (SELECT * FROM host_usage;) and see if the new data has been added to the table since host_usage.sh should be executed every minute. host_usage.sh can also be tested by typing ``` bash [the whole path of host_info.sh] localhost 5432 host_agent postgres password > /tmp/host_usage.log ``` and see if it executed successfully.  
* __ddl.sql & queries.sql:__ were tested by excuting their statments in PSQL.
# Deployment
Docker is installed to allow us to manage PostgreSQL database. Crontab is used to execute host_usage.sh every minute and store recourse usage data in a host_usage table in the PostgreSQL database to monitor the usage data. Git was used for uploading files into the GitHub repository based on the GitFlow process. 
# Improvements
1. I would say maybe increasing the execution time of the host_usage.sh script because it's running every minute which will give us many entries in host_usage table or maybe delete some old data when the entries reach 50 0r 100 for example.
2.  Adding more sample data to the host_info table and adding more SQL business problems.
