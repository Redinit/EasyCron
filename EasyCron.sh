#!/bin/bash

#=============================================================
# EasyCron  : Linux TaskScheduler                             
# Author    : Redinit (A.K.A Viswajith)                      
#=============================================================

#=============================
# Color & Style Variables
#=============================
# These are ANSI escape codes for colorful terminal output.
RED="\033[31m"                # Red text
GREEN="\033[32m"              # Green text
BLUE="\033[34m"               # Blue text
YELLOW_BG="\033[43m"          # Yellow background
CYAN_BG="\033[46m"            # Cyan text
BOLD="\033[1m"                # Bold text
RESET="\033[0m"               # Reset to normal text


#==============================================================
#  Function: print_banner
#  Purpose : Display program banner
#==============================================================
print_banner() {

	echo -e "============================================================================"
	echo -e "                          ${YELLOW_BG}${BOLD}Welcome To EasyCron!${RESET}   "
	echo -e "            EasyCron: Easy Way To Make Scheduled Tasks In Linux             "
	echo -e "============================================================================"
}


#==============================================================
#  Function: path_validation
#  Purpose : Verify if file/command exists
#==============================================================
Path_Validation() {

        local cmd_to_check=$(echo ${1} | awk '{print $1}')

        if ! command -v "$cmd_to_check" &> /dev/null && [ ! -e "$cmd_to_check" ] ;
        then
                echo -e "${RED}ERROR: There is No ${1}  Script/Command found!"
                echo -e "Provide Correct Script/Command path!${RESET}"
                exit 1
        fi
}

#==============================================================
#  Function: cron_entry_validation 
#  Purpose : Validates the time fields provided for the cron job.
#            Ensures none of the fields are empty or invalid ('-').
#==============================================================
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

#==============================================================================================
#  Function: schedule
#  Purpose : Displaying scheduling options and collects timing info from user for the cron job
#               
#==============================================================================================
schedule() {
	echo -e "${CYAN_BG}${BOLD} When Should This Task Runs? ${RESET}"
	echo -e "1) Every Day: "
	echo -e "2) Every Week: "
	echo -e "3) Every Month: "
	echo -e "4) Custom Time: "

	# prompt user to choose a scheduling option
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
		    # Custom time input from the user
			read -p "Minute(0-59): " minute
			read -p "Hour(0-23): " hour
			read -p "Days(1-31 or * ): " days
			read -p "Months(1-12 or * ): " month
			read -p "Day of Week(0-6 or * ): " weekdays
			;;
		*)
		    # Invalid input
			echo -e "${RED} Invalid Choice. Exiting! ${RESET}"
			exit 1
			;;
	esac
}

#===================
# Main Script
#===================

# Print the banner first
print_banner

# Ask the user for the full path of the Command/script to run
read -p "Enter full Path(command/script): " Task

# Validate if the provided path is correct and executable
Path_Validation "${Task}"

# Ask the user for schdeuling time
schedule

# Validate all entered cron time fields
cron_entry_validation

# Build the cron entry line
cron_entry="${minute} ${hour} ${days} ${month} ${weekdays} ${Task}"

#================================
# Add Cron Job to System
#================================
tempfile=$(mktemp) # Create a temporary file to hold cron entries
crontab -l 2>/dev/null > ${tempfile} # Export existing cron jobs to the temp file (if any)
echo -e "${cron_entry}" >> ${tempfile} # Append the new cron entry
crontab "${tempfile}" # Load the updated cron list from the temp file
rm "${tempfile}" # Remove the temporary file after updating crontab

# Confirm success to the user
echo -e "${BLUE}Task Successfully Added"
echo -e "Cron Entry: ${cron_entry}\n"
echo -e "You Can Verify Using: ${BOLD}crontab -l${RESET}"
