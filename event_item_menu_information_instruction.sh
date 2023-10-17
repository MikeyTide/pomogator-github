#!/bin/bash
#-------------init event for item_menu_information_instructions="Инструкции СГЭУ"-----------------------
declare -A event_menu
event_menu["$item_menu_information_instructions"]="run_menu ${item_menu_instructions_all[@]}"
event_menu["$item_menu_instruction_google"]="firefox -new-tab https://cloud.sseu.ru/s/xXsQms2QyLZfEND &"
event_menu["$item_menu_instruction_yandex"]="firefox -new-tab https://cloud.sseu.ru/s/a45cAH7ZE7ZWcG3 &"
event_menu["$item_menu_instruction_astra_adm1"]="firefox -new-tab https://cloud.sseu.ru/s/b6ETt9g7M8ocF9S &"
event_menu["$item_menu_instruction_astra_adm2"]="firefox -new-tab https://cloud.sseu.ru/s/LgtwqsSWaM5Xfcp &"
event_menu["$item_menu_instruction_astra_user"]="firefox -new-tab https://cloud.sseu.ru/s/8QE9L5kxeDM7tX9 &"