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
	echo "Prometheus is already installed ✅"
else
	sleep 1
	echo "Installing prometheus now...."
	echo "Downloading Prometheus now...."
	sleep 1
	cd /opt && wget https://github.com/prometheus/prometheus/releases/download/v2.35.0/prometheus-2.35.0.linux-amd64.tar.gz
	echo "Extracting prometheus into /opt"
	sleep 2
	tar -xvzf prometheus-2.35.0.linux-amd64.tar.gz && mv prometheus-2.35.0.linux-amd64 prometheus
	cd prometheus
	sudo mv prometheus prometheus.sh
	sudo mkdir data
	sudo chmod +x prometheus.sh
	cd ..
	sleep 1
	sudo rm prometheus-2.35.0.linux-amd64.tar.gz
	echo "Prometheus directory was installed sucessfully"
	sleep 2
	echo "Installing prometheus Systemd service...."
fi
	if [ -f /etc/systemd/system/prometheus.service ]
	then 
	echo "Prometheus is already installed ✅"
	else
echo "Installing prometheus service file....."
		sleep 3
		cd /etc/systemd/system && wget https://raw.githubusercontent.com/HPDiddy/node_exporter-systemd/main/prometheus.service 
		sudo systemctl enable prometheus.service
		sudo systemctl daemon-reload
		sudo systemctl start prometheus.service
		echo "prometheus service has finished installing...."
		sudo systemctl status prometheus.service
fi
clear
echo "Checking Install..."
sleep 2
if [ -f /opt/prometheus/prometheus.yml ]
then
echo "Prometheus Config File ✅"
  else
echo "Prometheus Config File ❌"
	fi
if [ -d /opt/prometheus/data ]
then
echo "Prometheus Data Folder ✅"
  else
echo "Prometheus Data Folder ❌"
	fi
	sleep 2
	if [ -d /opt/prometheus/consoles/ ]
	then
		if [ -f /opt/prometheus/consoles/node.html ]
		then
			if [ -f /opt/prometheus/consoles/node-cpu.html ]
			then
				if [ -f /opt/prometheus/consoles/node-disk.html ]
				then
					if [ -f /opt/prometheus/consoles/node-overview.html ]
					then
						if [ -f /opt/prometheus/consoles/prometheus.html ]
						then
							if [ -f /opt/prometheus/consoles/prometheus-overview.html ]
							then
								sleep 1
							fi
						fi
					fi
				fi
			fi
		fi
	fi
if [ -f /etc/systemd/system/prometheus.service ]
then
echo "Prometheus Service File ✅"
  else
echo "Prometheus Service File ❌"
	fi
	#Check if prometheus is running
systemctl is-active --quiet prometheus && echo "The install is now complete and is accessible via http://*:9090 ✅" || echo "Missions Failed, We'll get em next time ❌"
echo "Exiting now...."
exit
