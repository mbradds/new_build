#!/bin/bash
# A script to install my software on a clean ubuntu install

function askUserAboutPackage(){
    message=$1
    pkg=$2
    install=$3
    read -p "${message}" -n 1 -r
    echo    # (optional) move to a new line
    if [[ $install =~ ^[Yy]$ ]]
    then
        cmdpath="sh ./install_modules/${pkg}.sh"
        logpath="install_logs/installed.txt"
        logpathno="install_logs/skipped_install.txt"
    else
        cmdpath="sh ./uninstall_modules/${pkg}.sh"
        logpath="install_logs/skipped_install.txt"
        logpathno="install_logs/skipped_uninstall.txt"
    fi

    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        $cmdpath
        echo $(date -u) $pkg >> $logpath
        apt-get update
    else
        echo $(date -u) $pkg >> $logpathno
    fi
}

declare -a packages=("nodejs" "npm" "git" "qgis" "code" "mssql-server" "sqlite3")
declare -a log_files=("already_installed" "installed" "skipped_install" "uninstalled" "skipped_uninstall")
mkdir -p install_logs 

for log in "${log_files[@]}"; do #force remove any content in the log files
    rm -f ./install_logs/${log}.txt
done

apt-get update && apt-get dist-upgrade
for package in "${packages[@]}"; do
    if [ $(dpkg-query -W -f='${Status}' ${package} 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        askUserAboutPackage "$package is not installed. Start install? (y/n)" "${package}" "y"
    else
        askUserAboutPackage "$package is already installed. Uninstall? (y/n)" "${package}" "n"
    fi
done

#Anaconda doesnt appear in default list of packages
askUserAboutPackage "Cant verify if Anaconda is installed. Uninstall? (y/n)" "Anaconda" "y"
askUserAboutPackage "Install Anaconda? (y/n)" "Anaconda" "n"
apt-get dist-upgrade