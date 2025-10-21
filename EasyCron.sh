#!/bin/bash

#--------------------------------------------------------------
# EasyCron : Linux TaskScheduler                             |
# Author    : Redinit (A.K.A Viswajith)                       |
#--------------------------------------------------------------


RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[34m"
YELLOW_BG="\033[43m"
CYAN_BG="\033[46m"
BOLD="\033[1m"
RESET="\033[0m"


#---------------------------
# Functions
#---------------------------

print_banner() {

	echo -e "============================================================================"
	echo -e "                          ${YELLOW_BG}${BOLD}Welcome To EasyCron!${RESET}   "
	echo -e "            EasyCron: Easy Way To Make Scheduled Tasks In Linux             "
	echo -e "============================================================================"
}


# User input validation/check
Path_Validation() {
	if [[ ! -e ${1} ]];
	then
		echo -e "${RED}ERROR: There is No ${1}  Script/Command Existed!"
		echo -e "Provide Correct Script/Command!${RESET}"
		exit 1
	elif [[ ! -x ${1} ]];
	then
		echo -e "${YELLOW_BG}File Existed But Not Executable!"
		echo -e "Make Scripts Executable: chmod +x ${1} ${RESET}"

	fi
}

# User input cront entry validation/check
cron_entry_validation() {
	for value in "${minute}" "${hour}" "${days}" "${month}" "${weekdays}"; do
		if [[ -z ${value} ]]; then
			echo -e "${RED}ERROR : One Of The Time Fields is Empty!${RESET}"
			exit 1
		fi
		if [[ ${value} == "-" ]]; then
			echo -e "${RED}ERROR : '-' Is Not Valid In Cron Fields. ${RESET}"
			exit 1
		fi
	done
}

# Asking User choose
schedule() {
	echo -e "${CYAN_BG}${BOLD} When Should This Task Runs? ${RESET}"
	echo -e "1) Every Day: "
	echo -e "2) Every Week: "
	echo -e "3) Every Month: "
	echo -e "4) Custom Time: "

	read -p "Choose(1-4): " choice

	case ${choice} in
		1) 
			minute="0"; hour="8"; days="*"; month="*"; weekdays="*" 
			;;
		2) 
			minute="0"; hour="5"; days="*"; month="*"; weekdays="1" 
			;;
		3) 
			minute="0"; hour="7"; days="1"; month="*"; weekdays="*" 
			;;
		4) 
			read -p "Minute(0-59): " minute
			read -p "Hour(0-23): " hour
			read -p "Days(1-31 or * ): " days
			read -p "Months(1-12 or * ): " month
			read -p "Day of Week(0-6 or * ): " weekdays
			;;
		*)
			echo -e "${RED} Invalid Choice. Exiting! ${RESET}"
			exit 1
			;;
	esac
}

#--------------------
# Main Script
#--------------------

# calling print_banner function to execute
print_banner

# Asking user input for Command/script full path
read -p "Enter full Path(command/script): " Task

# calling path_validation function to be executed
Path_Validation "${Task}"

# calling schedule function to be executed
schedule

# calling cron_entry_validation function to be executed
cron_entry_validation

# adding entry to cron entry var 
cron_entry="${minute} ${hour} ${days} ${month} ${weekdays} ${Task}"

# showing preview 
echo -e "${BLUE}${BOLD}Cron Entry Preview: ${RESET}${cron_entry}"


tempfile=$(mktemp) # make temporary file
crontab -l 2>/dev/null > ${tempfile} # list existing jobs and save to tempfile
echo -e "${cron_entry}" >> ${tempfile} # add cron entry to tempfile
crontab "${tempfile}" # tempfile value(entry) to crontab
rm "${tempfile}" # removes tempfile after adding entry to cron

echo -e "${BLUE}Task Successfully Added"
echo -e "Cron Entry: ${cron_entry}\n"
echo -e "You Can Verify Using: ${BOLD}crontab -l${RESET}"


