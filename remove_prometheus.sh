#!/bin/bash
#This script was created by https://github.com/hpdiddy
	#Remove prometheus install directory
function rm_prom_dir {
if [ -d /opt/prometheus ]
then
	echo "Removing prometheus install directory...."
sudo rm -rf /opt/prometheus
else 
	echo "Could not remove /opt/prometheus"
fi
}
rm_prom_dir
	#Remove prometheus service
function rm_prom_service {
	sudo systemctl stop prometheus.service
	sudo systemctl disable prometheus.service
	sudo systemctl daemon-reload
}
rm_prom_service
