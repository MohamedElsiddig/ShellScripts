#!/bin/bash
# Shell Script Template
#/ Usage: bash-sh.sh 
#/ Description: 
#/ Options: 
# 
#Colors

normal='\e[0m'
cyan='\e[0;36m'
green='\e[0;32m'
light_green='\e[1;32m'
white='\e[0;37m'
yellow='\e[1;49;93m'
blue='\e[0;34m'
light_blue='\e[1;34m'
orange='\e[38;5;166m'
light_cyan='\e[1;36m'
red='\e[1;31m' 
      
function usage() { grep '^#/' bash-sh.sh | cut -c4- ; exit 0 ; }

# Logging Functions to log what happend in the script [It's recommended]

readonly LOG_FILE="/tmp/$(basename "$0").log"

    info()    { echo -e "$light_cyan[INFO]$white    $*$normal" | tee -a "$LOG_FILE" >&2 ; }
    warning() { echo -e "$yellow[WARNING]$white $*$normal" | tee -a "$LOG_FILE" >&2 ; }
    error()   { echo -e "$red[ERROR]$white   $*$normal" | tee -a "$LOG_FILE" >&2 ; }
    fatal()   { echo -e "$orange[FATAL]$white   $*$normal" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }
      
      
# Stops execution if any command fails.
set -eo pipefail

function cleanup() {
  # Remove temporary files
    # Restart services
    # ...
  echo ""
}

function main() {
  if [[ $1 = "--help" ]]
	then
    expr "$*" : ".*--help" > /dev/null && usage
	else
    # Some Code Here
    echo "some code here"
  fi

#trap command make sure the cleanup function run to clean any miss created by the script

trap cleanup EXIT

}

#This test is used to execute the main code only when the script is executed directly, not sourced

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    # Main code of the script
      
main "$@"

      info  this is information
      warning  this is warning
      error  this is Error
      fatal  this is Fatal
      
fi


