#!/bin/bash

usea=$(whoami)
hos=$(hostname)
dt=$(date "+%Y-%m-%d %H:%M:%S")
os=$(uname -s)
curr=$(pwd)
home=$HOME
usr=$(who | wc -l)
upp=$(uptime -p)
disk=$(df -h / | awk 'NR==2 {print $3 "/" $2}')
mem=$(free -h | awk 'NR==2 {print $3 "/" $2}')

echo -e "${CYAN}=======================================${RESET}"
echo -e "${GREEN}       System Information Display=${RESET}"
echo -e "${CYAN}========================================${RESET}"
echo -e "${YELLO}Username         :${RESET} $usea"
echo -e "${YELLO}"Hostname         :${RESET} $hos"
echo -e "${YELLO}"date and time    :${RESET} $dt"
echo -e "${YELLO}"OS               :${RESET} $os"
echo -e "${YELLO}"Current Diectory :${RESET} $curr"
echo -e "${YELLO}"home directory   :${RESET} $home"
echo -e "${YELLO}"online user      :${RESET} $usr"
echo -e "${YELLO}"UP time          :${RESET} $upp"
echo -e "${YELLO}"Disk Usage       :${RESET} $disk"
echo -e "${YELLO}"Memory Usage     :${RESET} $mem"
echo -e "${CYAN}=======================================${RESET}"

