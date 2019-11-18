#!/bin/bash
# Shell Script Template
#/ Usage: update-Ubuntu-budgie.sh 
#/ Description:updae my offline system (ubunut-budgie) 

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
      
function usage() { grep '^#/' update-Ubuntu-budgie.sh | cut -c4- ; exit 0 ; }

# Logging Functions to log what happend in the script [It's recommended]

readonly LOG_FILE="/tmp/$(basename "$0").log"

    info()    { echo -e "$light_cyan[INFO]$white  $*$normal" | tee -a "$LOG_FILE" >&2 ; }
    warning() { echo -e "$yellow[WARNING]$white $*$normal" | tee -a "$LOG_FILE" >&2 ; }
    error()   { echo -e "$red[ERROR]$white $*$normal" | tee -a "$LOG_FILE" >&2 ; }
    fatal()   { echo -e "$orange[FATAL]$white $*$normal" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }
      
      
# Stops execution if any command fails.
set -eo pipefail

function cleanup() {
    info Restoring Defualt Network Settings
    sleep 2
    echo ""
    if [[ -e "$LFS/etc/resolv.conf" && -L "$LFS/etc/resolv.conf.bak.bak" ]]
      then
        chroot $LFS  mv -f  /etc/resolv.conf /etc/resolv.conf.bak > /dev/null 2>&1
        chroot $LFS  mv -f  /etc/resolv.conf.bak.bak /etc/resolv.conf > /dev/null 2>&1
      else
        sleep 2
        info "it\'s seems that $LFS/etc/resolv.conf and $LFS/etc/resolv.conf.bak.bak not generated in the main funtion"
        info Moving on
        true
      fi
    info Unmounting File System 
    sleep 2
    echo ""
    umount  $LFS/dev/pts > /dev/null 2>&1
    umount  $LFS/dev > /dev/null 2>&1
    umount  $LFS/proc > /dev/null 2>&1
    umount  $LFS/sys > /dev/null 2>&1
    umount  $LFS/run > /dev/null 2>&1
    umount $LFS > /dev/null 2>&1
    sleep 2
    info Done ...
    echo ""

}

function main() {
  chk_root
  if [[ $1 = "--help" ]]
    then
      expr "$*" : ".*--help" > /dev/null && usage
    else
      info Mounting $1
      sleep 2
      echo ""
      if [[ ! -d $1 && -e $1 ]]
        then
          mount $1 /media/mohamedelsiddig/ > /dev/null 2>&1
          if [[ $? = 0 ]]
            then
              info Exporting LFS variable
              sleep 2
              echo ""
              export LFS="/media/mohamedelsiddig"
              if [[ -d $LFS/boot ]]
                then
                  info Mounting Virtual Kernel File System
                  sleep 2
                  echo ""
                  mount -v --bind /dev $LFS/dev > /dev/null 2>&1
                  mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620 > /dev/null 2>&1
                  mount -vt proc proc $LFS/proc > /dev/null 2>&1
                  mount -vt sysfs sysfs $LFS/sys > /dev/null 2>&1
                  mount -vt tmpfs tmpfs $LFS/run > /dev/null 2>&1
                else
                sleep 2
                echo ""
                error Error on Detecting Offline system
                fatal Exiting the script due the previous Error
                cleanup
              fi
            info Preparing Internet Settings
            sleep 2
            echo ""

            # check if the sympolic link is found 

            if [[ -L "$LFS/etc/resolv.conf" && -e "$LFS/etc/resolv.conf.bak" ]]
              then
                chroot /media/mohamedelsiddig  mv -f /etc/resolv.conf /etc/resolv.conf.bak.bak 
                chroot /media/mohamedelsiddig  mv -f /etc/resolv.conf.bak /etc/resolv.conf 
              else
                error Couldn\'t find $LFS/etc/resolv.conf or $LFS/etc/resolv.conf.bak
                fatal Exiting the script due the previous Error
                info rolling back 
                cleanup
              fi
            info Running System Updates
            sleep 2
            echo ""
            (
            chroot $LFS apt update -y && chroot $LFS apt upgrade -y 
            )
          else 
            sleep 2
            echo ""
            fatal Failed to mount $1
          fi
        else
          if [[ -z $1 ]]
            then
                sleep 2
                echo ""
                fatal Failed to mount Partition You didn\'t Enter any thing
            else
              sleep 2
              echo ""
              fatal Failed to mount $1 becuase it\'s not a valid Partition 
          fi
      fi
  fi

#trap command make sure the cleanup function run to clean any miss created by the script

trap cleanup EXIT

}
function chk_root()
{
    if [ $(id -u) != 0 ]
        then
        fatal $red [ x ]$cyan::[$red You are not root $cyan]: You need to be [$red root $cyan] to run this script.$normal
        echo ""
        sleep 3
        
    fi
}
#This test is used to execute the main code only when the script is executed directly, not sourced

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    # Main code of the script
main "$@"
fi
