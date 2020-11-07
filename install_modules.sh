#!/bin/bash
# A script to install my software on a clean ubuntu install

#get user input
read -p "sudo apt-get update? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "run update"
    sudo apt-get update
fi


declare -a packages=("nodejs" "nmp" "qgis" "code" "mssql-server" "azuredatastudio")
rm -f ./install_logs/already_installed.txt #force remove anything in the already installed file
rm -f ./install_logs/installed.txt #force remove anything in the already installed file


for package in "${packages[@]}"; do
    if [ $(dpkg-query -W -f='${Status}' ${package} 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo "$package is not installed. Starting install...";
        sh ./${package}.sh
        echo $(date -u) $package >> 'install_logs/installed.txt'
    else
        install_status="$package already installed"
        echo $install_status
        echo $(date -u) $install_status >> 'install_logs/already_installed.txt'
    fi
done



#write to a file
# status='to file'
# rm -f ./log.txt #force remove the file
# echo $status >> 'log.txt'

#concatenate lists:
#bothLists=("${list1[@]}" "${list2[@]}")

#get length of list echo "${#list[@]}""