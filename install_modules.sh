#!/bin/bash
# A script to install my software on a clean ubuntu install

#get user input
#echo 'Ask for confirmation for each module? (y/n)'
#read eachModule
#echo $eachModule

declare -a anaconda=("Anaconda" "module1 command1 && module1 command2")
declare -a nodejs=("nodejs" "module2 command1 && module2 command2")
declare -a packages=("anaconda" "nodejs")

for package in "${packages[@]}"; do
    declare -n lst=$package
    package_name=${lst[0]}
    if [ $(dpkg-query -W -f='${Status}' ${package_name} 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo "$package_name is not installed. Starting install";
    else
        echo "$package_name is already installed"
    fi
    # cmd="${lst[1]} &> ${package_name}.log"
    # echo "Starting ${package_name}..."
    # echo ${cmd}
    # echo "Completed ${package_name}..."

done


#write to a file
# status='to file'
# rm -f ./log.txt #force remove the file
# echo $status >> 'log.txt'

#concatenate lists:
#bothLists=("${list1[@]}" "${list2[@]}")

#get length of list echo "${#list[@]}""