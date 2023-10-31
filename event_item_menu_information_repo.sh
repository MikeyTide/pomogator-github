#!/bin/bash
#---------------init event for event_item_menu_information_repo.sh="Сетевые репозитории" menu-------------------------------
declare -A event_menu
event_menu["$item_menu_information_repo"]="run_menu ${item_menu_information_repo_all[@]}"
event_menu["$item_menu_information_repo_stable"]="repo_stable"
event_menu["$item_menu_information_repo_frozen"]="repo_frozen"
event_menu["$item_menu_information_repo_debian"]="repo_debian"
event_menu["$item_menu_information_repo_stable_debian"]="repo_stable_debian"
event_menu["$item_menu_information_repo_info"]="repo_info"
