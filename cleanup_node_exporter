#!/bin/bash
#This script was made by https://github.com/hpdiddy
if [ -d /opt/node_exporter ]
then
	echo "Disabling node_exporter"
	sudo systemctl stop node_exporter 
	sudo systemctl disable node_exporter
	echo "Deleting node_exporter"
sudo rm -rf /opt/node_exporter && sudo rm /etc/systemd/system/node_exporter.service
	sudo systemctl daemon-reload
	echo "Cleanup Complete...."
else
	echo "Cleanup Failed...."
	exit
fi
