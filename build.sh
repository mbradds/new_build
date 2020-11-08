#!/bin/bash
# A script to install my software on a clean ubuntu install

function askUserToInstall(){
    message=$1
    pkg=$2
    read -p "${message}" -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sh ./install_modules/${pkg}.sh
        echo $(date -u) $pkg >> 'install_logs/installed.txt'
        sudo apt-get update
    else
        echo $(date -u) $pkg >> 'install_logs/skipped_install.txt'
    fi
}

function askUserToUninstall(){
    message=$1
    pkg=$2
    read -p "${message}" -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sh ./uninstall_modules/${pkg}.sh
        echo $(date -u) $pkg >> 'install_logs/uninstalled.txt'
        sudo apt-get update
    else
        echo $(date -u) $pkg >> 'install_logs/skipped_uninstall.txt'
    fi
}

declare -a packages=("nodejs" "nmp" "qgis" "code" "mssql-server" "sqlite3")
#force remove any content in the log files
rm -f ./install_logs/already_installed.txt 
rm -f ./install_logs/installed.txt 
rm -f ./install_logs/skipped_install.txt 
rm -f ./install_logs/uninstalled.txt 
rm -f ./install_logs/skipped_uninstall.txt 

for package in "${packages[@]}"; do
    if [ $(dpkg-query -W -f='${Status}' ${package} 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        askUserToInstall "$package is not installed. Start install? (y/n)" "${package}"
    else
        askUserToUninstall "$package is already installed. Uninstall? (y/n)" "${package}"
    fi
done

#"Anaconda doesnt appear in default list of packages"
askUserToUninstall "Cant verify if Anaconda is installed. Uninstall? (y/n)" "Anaconda"
askUserToInstall "Install Anaconda? (y/n)" "Anaconda"