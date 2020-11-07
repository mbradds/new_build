#!/bin/bash
sudo apt install gnupg software-properties-common
wget -qO - https://qgis.org/downloads/qgis-2020.gpg.key | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import sudo chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg
sudo add-apt-repository "deb https://qgis.org/debian `lsb_release -c -s` main"
sudo apt update
sudo apt install qgis qgis-plugin-grass