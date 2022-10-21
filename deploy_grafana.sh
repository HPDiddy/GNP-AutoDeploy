#!/bin/bash
#This script was created by https://github.com/hpdiddy
#Check if grafana is installed
if [ $EUID -ne 0 ]
then
	echo '🔨 Please run this script with root privileges'
fi
function DeployGrafana() {
#Check if grafana is already installed
if [ -d /etc/grafana ]
then
	echo '😕 Grafana is already installed'
else
	echo 'Grafana could not be found, Would you like to install it now [y/n]'
	read answer
	if [ $answer == 'y' ]
	then
echo '🔨 Installing Grafana now...'
echo '🔒 Downlading Grafana GPG key'
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
	sleep 1
echo '📦 Adding Grafana repo'
sudo add-apt-repository 'deb https://packages.grafana.com/oss/deb stable main'
	sleep 1
sudo apt update
#Install grafana
echo '🔨 Installing grafana....'
	sleep 3
sudo apt install grafana -y
	sleep 1
echo '😎 Enabling grafana...'
sudo systemctl enable grafana-server
echo '🔔 Starting Grafana'
	sleep 1
sudo systemctl start grafana-server
sleep 3
fi
fi
clear
}
DeployGrafana
function checkInstall() {
echo '🔨 Checking install....'
if [ -d /etc/grafana ]
then
	if [ -f /etc/grafana/grafana.ini ]
	then
		echo '✅ Grafana install complete, You can browse grafana via http://*:3000'
	else
		echo '❌ Failed to install grafana'
	fi
fi
}
checkInstall
echo 'Script Execution finished, Exiting now. Bye bye 👋🏽'
