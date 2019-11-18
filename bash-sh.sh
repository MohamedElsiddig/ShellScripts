#!/bin/bash
clear
echo "==========================="
echo "Tool for theme"
echo "==========================="

function check_update {
echo "checking theme update"
}

function reinstall_theme {
echo "Reinstalling"
echo "==========================="
}

function font {
    echo ""
    
echo "Installing font"
}

function wall {
echo "Installing wallpaper"
}

function check_update_tool {
echo "Checking tool update"
}

all_done=0
while (( !all_done )); do
options=("Check theme update" "Reinstall theme" "Install font" "Install wallpaper" "Check tool update" "Quit")

echo "Choose an option: "
select opt in "${options[@]}"; do
case $REPLY in
1) check_update; break ;;
2) reinstall_theme; break ;;
3) font; break ;;
4) wall; break ;;
5) check_update_tool; break ;;
6) all_done=1; break ;;
*) echo "Invalid option" ;;
esac
done
done

echo "Exiting"
sleep 2
