#!/bin/bash

#Create variables
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

# Check number of arguments is correct
if [ $# -ne 5 ]; then
        echo 'Please enter the host, port, database name, username, and password.'
        exit 1
fi

#Save machine statistics in MB and current machine hostname to variables
lscpu_out='lscpu'
hostname=$(hostname -f)
memory_total=$(cat /proc/meminfo)

#Retrieve hardware specification variables
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out"  | egrep "^Architecture" | awk '{print $2}' | xargs)
cpu_model=$(echo "$lscpu_out"  | egrep "^Model name" | cut -f 2 -d ":"  | awk '{$1=$1}1' | xargs)
cpu_mhz=$(echo "$lscpu_out"  | egrep "^CPU MHz" | awk '{print $3}' | xargs)
l2_cache=$(echo "$lscpu_out"  | egrep "^L2 cache" | awk '{print $3}' | xargs)
total_mem=$(echo "$memory_total"  | egrep "^MemTotal" | cut -f 2 -d ":"  | awk '{$1=$1}1' | xargs)

#Current time in UTC
timestamp=$(vmstat -t | awk '{print $18,$19}' | tail -n1 | xargs)

#PSQL command: Inserts usage data into host_usage table
insert_stmt="INSERT INTO host_info(hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, l2_cache, total_mem, timestamp)
                 VALUES ('$hostname', $cpu_number,'$cpu_architecture', $cpu_model, $cpu_mhz, $l2_cache, $total_mem, '$timestamp');"

#set up env var for pql cmd
export PGPASSWORD=$psql_password

#Insert data into a database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?
