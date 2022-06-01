# Linux Cluster Monitoring Agent
# Introduction
This project will allow Jarvis Linux Cluster Administration (LCA) team to track hardware information and recourse usage of each node in real-time, which are running on CentOS 7. This is done by gathering server usage data such as: available memory, disk space, cpu idle, and cpu kernel, ..etc. These information are collected and saved in a PostgreSQL database automatically evey minute in the background. On the other hand, the hardware specifications data like: system hostname, number of CPU, CPU architecture, ... etc. They are assumed to be static, which means that they will be collected once only. <br/> 
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
4. Create host_info.sh and host_usage.sh scripts for extracting hardware specification data and resource usages data respectively and then store them is the PostgreSQL database tables.
5. Continuously collect usage data by using Crontab to excute the host_usage.sh script every minute.
6. Write SQL Queries that group hosts by CPU number and memory size (GROUP BY), calculate the percentage average used memory over 5 minute intervals where used memory = total memory - free memory (Aggregate functions and create round function), and detect host failures (Aggregate functions).

## Architecture
![host_agent_db](https://user-images.githubusercontent.com/97988554/171469271-e3958e5d-ffc7-49c5-ae41-2b19ef4e34cc.jpg)

## Scripts
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
      * cpu_mhz (cpu clock rate)
      * L2_cache (cpu cache memory)
      * total_mem (total memory)
      * timestamp (current time in UTC) 
    * Usage:
      * ``` ./scripts/host_info.sh localhost 5432 host_agent postgres psql_password ```
* host_usage.sh:
    * This script collects resource usage data such as:
      * timestamp
      * host_id
      * memory_free
      * cpu_idle (Percentage of cpu when there is no program running)
      * cpu_kernel (Percentage of cpu kernel)
      * disk_io (measures active disk I/O time)
      * disk_available (disk space)
    * Usage:
      * ``` ./scripts/host_usage.sh localhost 5432 host_agent postgres psql_password ```
* crontab:
     * This script allows the continuous execution (every minute) of host_usage.sh script: 
       1. Edit crontab: ``` crontab -e ```
       2. Add the below code to the crontab editor:
          *``` * * * * * bash (The whole path to host_usage.sh file) localhost 5432 host_agent postgres psql_password > /tmp/host_usage.log ```
