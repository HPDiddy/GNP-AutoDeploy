#!/bin/bash
#This script was created by https://github.com/hpdiddy
#Check if grafana is installed
if [ $EUID -ne 0 ]
then
	echo "Please run this script with root privileges"
fi
if [ -d /etc/grafana ]
then
	echo "Grafana is already installed"
else
echo "Installing grafana now..."
echo "Downlading grafana GPG key"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
	sleep 1
echo "Adding Grafana repo"
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
	sleep 1
sudo apt update
#Install grafana
echo "Installing grafana...."
	sleep 3
sudo apt install grafana -y
	sleep 1
echo "Enabling grafana..."
sudo systemctl enable grafana-server
echo "Starting Grafana"
	sleep 1
sudo systemctl start grafana-server
sleep 3
fi
clear
echo "Checking install...."
if [ -d /etc/grafana ]
then
	if [ -f /etc/grafana/grafana.ini ]
	then
		echo "Grafana install complete, You can browse grafana via http://*:3000"
	else
		echo "install failed"
	fi
fi
