#!/bin/bash
#This is a simple script that will deploy the latest version of grafana as a docker container!
#With the option of watch tower also included.
#Script written by: https://github.com/hpdiddy
if [ $EUID -ne 0 ]
then
	echo "🔨 This script requires sudo privileges"
fi
function dependencyCheck() {
	#Check if docker is installed
	echo '🔨 Checking that docker is already installed, If not docker will be installed:'
		sleep 1
	if [ -d /var/lib/docker ]; then
		BUILD_NUMBER=$(docker version)
		echo $BUILD_NUMBER
	else
		echo 'Could not find docker, Do you want to install it now? [Y/n]'
		read answer
		if [ $answer == 'y' ]
		then
			#We need to check docker has been installed!
			echo '🐋 Installing Docker...'
			sudo apt update && sudo apt install docker.io docker-compose;
			echo '🔨 Checking that docker is installed...'
	sleep 1
	if [ -d /var/lib/docker ]; then
		BUILD_NUMBER=$(echo 'Your docker version: ' && docker version)
		echo $BUILD_NUMBER
		echo '✅ Docker is installed. Attempting to deploy grafana!'
		else
			echo '❌ Aborting install'
			exit 0
		fi
	fi
fi
}
dependencyCheck
#Now we can deploy grafana
function deployGrafana() {
	#Check if grafana is running
	IS_GRAFANA_RUNNING=$(sudo docker container ls --all --quiet --filter "name=grafana")
if [ -z $IS_GRAFANA_RUNNING ]
then
      echo "✅ Grafana container is not running, Attempting to deploy grafana now..."
      docker run -d --name=grafana -p 3000:3000 grafana/grafana
      echo 'Waiting for grafana to start...'
      sleep 20
      	echo '✅ Grafana container is running and active on http://*:3000'
else
      echo '❌ Failed: Grafana is running with the container ID: ' $IS_GRAFANA_RUNNING
fi
}
deployGrafana
#Deploy watchtower
function watchtower() {
	echo 'Do you want to install Watchtower [y/n]'
	read answer
	if [ $answer == 'y' ]
	then
		echo '🔨 Checking watchtower is already installed'
		IS_WATCHTOWER_ACTIVE=$(sudo docker container ls --all --quiet --filter "name=watchtower")
		if [ -z $IS_WATCHTOWER_ACTIVE ]
		then
			echo 'Watchtower is not active, Deploying now...'
			docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock -e WATCHTOWER_CLEANUP="true" -e WATCHTOWER_DEBUG="true" -e WATCHTOWER_SCHEDULE="0 00 00 * * *" containrrr/watchtower
				IS_WATCHTOWER_ACTIVE=$(sudo docker container ls --all --quiet --filter "name=watchtower")
		else
			echo '❌ Failed: Watchtower is already active.'
			exit 0
		fi
	fi
}
watchtower
echo 'Script finished executing, Bye bye 👋🏽'
