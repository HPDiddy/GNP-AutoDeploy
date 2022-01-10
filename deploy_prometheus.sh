#!/bin/bash
#This script was created by http://github.com/hpDiddy/
#We need to run as root first because we will be accessing the /opt directory
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
#Install prometheus monitoring service
if [ -d /opt/prometheus ]
then
	echo "prometheus is already installed..."
else
	echo "installing prometheus now...."
	cd /opt && mkdir prometheus
	sleep 1
	cd prometheus && wget https://github.com/prometheus/prometheus/releases/download/v2.32.1/prometheus-2.32.1.linux-amd64.tar.gz
	sleep 2
	tar -xvzf prometheus-2.32.1.linux-amd64.tar.gz && mv prometheus-2.32.1.linux-amd64 promethus
	echo "Installing prometheus Systemd service"
	if [ -f /etc/systemd/system/prometheus.service ]
	then 
		echo "prometheus service is already installed"
	else
		echo "Installing prometheus service file....."
		sleep 3
		cd /etc/systemd/system && wget https://raw.githubusercontent.com/HPDiddy/node_exporter-systemd/main/prometheus.service 
		sudo systemctl daemon-reload
		sudo systemctl enable prometheus.service
		sudo systemctl start prometheus.service
		echo "prometheus service has finished installing...."
	fi
fi
