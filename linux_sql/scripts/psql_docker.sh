#! /bin/bash

cmd=$1
db_username=$2
db_password=$3

#checks the status of the docker, if it is running continuo. If not, start docker
sudo systemctl status docker || sudo systemctl start docker

#check container status (try the following cmds on terminal)
docker container inspect jrvs-psql

#returns the exit value of the last executed command
container_status=$?

#User switch case to handle create|stop|start opetions
case $cmd in
        create)

        # Check if the container is already created
        if [ $container_status -eq 0 ]; then
                echo "Container already exists"
                exit 1
        fi

        #Check number of CLI arguments
        if [ $# -ne 3 ]; then
                echo "Create require username and password"
                exit 1
        fi

        #create a new volume if not exist
        docker volume create pgdata

        #psql docker docs https://hub.docker.com/_/postgres
        #set password for default user `postgres`
        export PGPASSWORD='tarek'

        #create a container using psql image with name=jrvs-psql
        docker run --name jrvs-psql -e POSTGRES_PASSWORD=$db_password -e POSTGRES_USER=$db_username -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
        exit $?
        ;;

        # if comand is start or stop
        start|stop)
        #check instance status; exit 1 if container has not been created
        if [ $container_status -ne 0 ]; then
                echo "Container has not been created"
                exit 1
        fi

        #start or stop the container
        docker container $cmd jrvs-psql
        exit $?
        ;;

        # Anything else
        *)
                echo "Illegal command"
                echo "Acceptable comands are: start|stop|create"
                exit 1
                ;;
esac


