#!/bin/bash
# This script was created by https://github.com/hpdiddy
# we need to check if node_exporter is installed first.
if [ -d /opt/node_exporter/ ]
then
	echo "node_exporter is already installed... exiting now"
	exit
else
	#Download and install node_exporter 1.3.1
	echo "Installing node_exporter version 1.3.1"
	sudo mkdir /opt/node_exporter
	sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz -P /opt/node_exporter
	cd /opt/node_exporter
	touch config.yaml
	sudo tar -xvzf node_exporter-1.3.1.linux-amd64.tar.gz
	sudo rm node_exporter-1.3.1.linux-amd64.tar.gz
	sudo mv node_exporter-1.3.1.linux-amd64 node_exporter
	cd /opt/node_exporter/node_exporter-1.3.1-amd64
fi
# Now we need to create a systemd service for node_exporter so we can manage it.
if [ -d /etc/systemd/system ]
then
	#Install node_exporter service
	cd /etc/systemd/system
	sudo wget https://raw.githubusercontent.com/hpddidy/node_exporter-systemd/main/node_exporter.service
	#Enable the node_exporter service.
	sudo systemctl daemon-reload 
	sudo systemctl enable node_exporter.service 
	sudo systemctl start node_exporter.service
	echo "Install Complete...."
	sudo systemctl status node_exporter.service 
else
echo "SystemD was not found"
fi
