#!/bin/bash
declare -A event_menu
event_menu["$item_menu_information_resources_of_SSEU"]="run_menu ${items_resources_of_SSEU[@]}"
event_menu["$item_menu_sseu_ru"]="firefox -new-tab https://www.sseu.ru &"
event_menu["$item_menu_phones"]="firefox -new-tab https://lms2.sseu.ru/phones/ &"
event_menu["$item_menu_ios"]="firefox -new-tab https://lms2.sseu.ru/ &"
event_menu["$item_menu_schedule_board"]="firefox -new-tab https://lms3.sseu.ru/schedule-board/schedule-all &"
event_menu["$item_menu_cloud"]="firefox -new-tab https://cloud.sseu.ru &"
event_menu["$item_menu_helpdesk"]="firefox -new-tab https://t.me/helpLinuxsseu_bot &"
event_menu["$item_menu_schedule_bot"]="firefox -new-tab https://t.me/SseuScheduleBot &"
event_menu["$item_menu_glpi"]="firefox -new-tab http://mail.sseu.ru/glpi/ &"