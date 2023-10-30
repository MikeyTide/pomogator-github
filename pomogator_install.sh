#!/bin/bash
if dpkg -s git  &>/dev/null; then
   if dpkg -s curl  &>/dev/null; then
    $(zenity --info --text "Вас приветствует программа установки приложения Помогатор Astra Linux! В следующем окошке введите пароль от администратора!" --height=150 --width=300)
    passwd=$(zenity --forms --title="Пароль для администратора" \
            --text="Введите пароль администратора" \
            --add-password="Пароль")
    echo "$passwd" | sudo -Sv >/dev/null 2>&1
        if [ $? -eq 0 ]; then
        echo $passwd | sudo -S git clone https://gitflic.ru/project/gabidullin-aleks/pomogator.git /opt/helper
        echo $passwd | sudo -S chmod +x -R /opt/helper
        echo $passwd | sudo -S cp /opt/helper/pomogator.desktop -P /usr/share/applications/flydesktop/
        echo $passwd | sudo -S cp /opt/helper/pomogator_icon.png -P /usr/share/pixmaps/
        else
        $(zenity --info --text "Неверный пароль администратора! Или у вас не хватает прав!" --height=150 --width=300)
        exit 0
        fi
    else
    $(zenity --info --text=" У вас не установлена утилита curl" --height=150 --width=300)
        $(zenity --question --text "Хотите установить программу curl?" --ok-label="Установить" --cancel-label="Отмена" --height=150 --width=300)
        if [[ $? -eq 0 ]]; then
        passwd=$(zenity --forms --title="Пароль для администратора" \
            --text="Введите пароль администратора" \
            --add-password="Пароль")
        echo "$passwd" | sudo -Sv >/dev/null 2>&1
            if [ $? -eq 0 ]; then
            echo $passwd | sudo -S apt install curl -y
            else
            $(zenity --info --text "Неверный пароль администратора! Или у вас не хватает прав!" --height=150 --width=300)
            fi
        else
            exit 0
        fi
    fi
else
    $(zenity --info --text=" У вас не установлена утилита git" --height=150 --width=300)
    $(zenity --question --text "Хотите установить программу git?" --ok-label="Установить" --cancel-label="Отмена" --height=150 --width=300)
        if [[ $? -eq 0 ]]; then
        passwd=$(zenity --forms --title="Пароль для администратора" \
            --text="Введите пароль администратора" \
            --add-password="Пароль")
        echo "$passwd" | sudo -Sv >/dev/null 2>&1
            if [ $? -eq 0 ]; then
            echo $passwd | sudo -S apt install git -y
            else
            $(zenity --info --text "Неверный пароль администратора! Или у вас не хватает прав!" --height=150 --width=300)
            fi
        else
            exit 0
        fi
fi







