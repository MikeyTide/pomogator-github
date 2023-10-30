#!/bin/bash
#---------------init core config-------------------------------------
url=license.sseu.ru
path=/opt/helper
source $path/version.sh
exit_app="Выход"
exit_menu="Назад"
selected_item_menu=""
app_info="Программа помощник: Помогатор\nВерсия: "$version_now"\nРазработчик: Габидуллин А.\nВкладки установка удаление программ могут быть использованны только под локальным или доменным администратором\n © 2023"
crypto="Для работы с сайтами использующими ЭЦП для подтверждения входа необходимо устанвить яндекс браузер!" 
papki="1.Необходимо перезайти в сессию.\n2. Перезагрузить ПК.\n3. Зайти в учетную запись имяпользователя@sseu.ru и пароль от windows прошлый ( если пароль устарел сменить его на новый)"
#---------------init items_main_menu-------------------------------
source $path/items_main_menu.sh

#---------------init for item_menu_information_resources_of_SSEU="Информационные ресурсы СГЭУ"-------------------------------
source $path/item_menu_information_resources_of_SSEU.sh

#---------------init item_menu_information_instructions="Инструкции СГЭУ"-------------------------------
source $path/item_menu_information_instructions.sh

#---------------item_menu_information_help="Что делать, если не работает?"-------------------------------
source $path/item_menu_information_help.sh

#---------------init for item_menu_network_folders="Сетевые папки" menu-------------------------------
source $path/item_menu_network_folders.sh

#---------------init for item_menu_information_install="Установка программ" menu-------------------------------
source $path/item_menu_information_install.sh

#---------------init for item_menu_information_remove="Удаление программ" menu-------------------------------
source $path/item_menu_remove_apps.sh

#---------------init for item_menu_information_printers="Драйвера для принтеров" menu-------------------------------
source $path/item_menu_information_printers.sh

#---------------init for item_menu_firma_samsung_models menu-------------------------------
item_driver_Samsung_ML_2851ND="Samsung-ML-2851ND"
item_menu_govno_printer="printer"
item_menu_firma_Samsung_models=("\"$item_driver_Samsung_ML_2851ND\"" "\"$item_menu_govno_printer\"" "\"$item_menu_govno_printer\"" "\"$item_menu_govno_printer\"" "\"$item_menu_govno_printer\"" "\"$exit_menu\"" "\"$exit_app\"")

#---------------init for item_menu_firma_Kyocera_models menu-------------------------------
source $path/item_menu_firma_Kyocera_models.sh

#---------------init item_menu_information_fonts="Установить шрифты" menu-------------------------------
source $path/item_menu_information_fonts.sh

#---------------init for item_menu_information_author="Связь с автором и пожелания" menu-------------------------------
source $path/item_menu_information_author.sh

#---------------init for item_menu_information_pomogator="Обновление и нововведения" menu-------------------------------
source $path/item_menu_information_pomogator.sh

#-------------init menu event-----------------------
declare -A event_menu
event_menu["$exit_app"]="exit 1"

#-------------init event for item_menu_information_resources_of_SSEU="Информационные ресурсы СГЭУ"-----------------------
source $path/event_item_menu_information_resources_of_SSEU.sh

#-------------init event for item_menu_information_instructions="Инструкции СГЭУ"-----------------------
source $path/event_item_menu_information_instruction.sh

#---------------init event for item_menu_information_help="Что делать, если не работает?"-------------------------------
event_menu["$item_menu_information_help"]="run_menu ${item_menu_help_all[@]}"
event_menu["$item_menu_help_papki"]="info_shared_papki"
event_menu["$item_menu_help_printer"]="info_install_printer"

#---------------init event for item_menu_network_folders="Сетевые папки" menu-------------------------------
source $path/event_item_menu_network_folders.sh

#---------------init event for item_menu_information_install="Установка программ" menu-------------------------------
source $path/event_item_menu_information_install.sh

#---------------init event for item_menu_information_remove="Удаление программ" menu-------------------------------
source $path/event_item_menu_information_remove.sh

#---------------init for item_menu_information_printers="Драйвера для принтеров" menu-------------------------------
event_menu["$item_menu_information_printers"]="run_menu ${item_menu_firmi_printers[@]}"

#-------------init menu event for item_menu_firmi_printers Фирмы принтеров-----------------------
event_menu["$item_menu_firma_Samsung"]="run_menu ${item_menu_firma_Samsung_models[@]}"
event_menu["$item_menu_firma_Kyocera"]="run_menu ${item_menu_firma_Kyocera_models[@]}"

#-------------init menu event for item_menu_firma_Samsung_models Фирма=Самсунг-----------------------
event_menu["$item_driver_Samsung_ML_2851ND"]="get_drivers"

#-------------init menu event for item_menu_firma_Kyocera_models Фирма=Киосера-----------------------
source $path/event_item_menu_firma_Kyocera_models.sh

#---------------init event for item_menu_information_freeipa="Домен" menu-------------------------------
source $path/event_item_menu_information_freeipa.sh

#---------------init event for item_menu_information_fonts = шрифты menu-------------------------------
source $path/event_item_menu_information_fonts.sh

#---------------init event for item_menu_information_update Обновление системы-------------------------------
event_menu["$item_menu_information_update"]="system_update"

#---------------init event for item_menu_information_pomogator обновление помогатора-------------------------------
source $path/event_item_menu_information_pomogator.sh

#---------------init menu event for item_menu_information_author="Связь с автором и пожелания" menu------------------
source $path/event_item_menu_information_author.sh


#---------------init menu event for item_menu_information_help="Что делать, если не работает?" menu------------------
info_install_printer(){
    $(zenity --info --text="Чтобы добавить принтер необходимо перейти от имени пользователя, которому добавляем принтер:\n Пуск -> Панель управления -> Оборудование -> Принтеры -> Нажать правой кнопкой мышки на принтер -> добавить принтер и ищем нужный принтер.\n Скачать необходимые драйвера можно во вкладке 'Драйвера для принтера' в данном приложение." --height=250 --width=350)
}

info_shared_papki() {
    $(zenity --info --text="$papki" --height=200 --width=300)
}

check_head_shared(){
    check_head=$(grep "Archives" "/home/$USER/.config/rusbitech/fly-fm-vfs.conf")
        if [[ "$check_head" == "" ]]; then
            echo "[Archives]
            Extensions=.zip,.rar~,.7z,.tar,.tgz,.tar.gz,.tar.bz2,.tar.xz,.iso~
            [General]
            AutoDetectBadPaths=true" > /home/$USER/.config/rusbitech/fly-fm-vfs.conf
        fi
}

filecore(){
    #для того чтобы добавить заранее готовые пути до сетевых папок чтобы добавлять их по нажатию 1 кнопки необходимо:
    #1. в файле event_item_menu_network_folders.sh добавить event_menu["$item_menu_share_folder"]="filecore"
    #2. item_menu_share_folder можно заменить на ваше значени в файле item_menu_network_folders.sh
    #3. filecore нужно заменить на функцию которую вы указали в main.sh
    check_head_shared
    #Вы можете самостоятельно здесь указать путь до вашего сервера с общими папками
    server=server.domain.ru/shared_folder
    local n=1
    while true; do
        number=$(grep "$n" "/home/$USER/.config/rusbitech/fly-fm-vfs.conf")
        if [[ "$number" == "" ]]; then
            break;
        fi
        n=$(($n+1))
    done
    #тут проверяется существует ли папка выбранная из меню уже у пользователя. 

    local check=$(grep "$selected_item_menu" "/home/$USER/.config/rusbitech/fly-fm-vfs.conf")
    echo $check
    if [[ "$check" == "" ]]; then
        echo "[Network Place $n]
        Name=$selected_item_menu
        Url=smb://$server/$selected_item_menu" >> /home/$USER/.config/rusbitech/fly-fm-vfs.conf
    fi
    killall fly-vfs-service fly-fops-service fly-open-service fly-fm-service
}

share_folder(){
    check_head_shared
    name_folder=$(zenity zenity --entry --text "Введите имя для сетевой папки на английском языке" --height=150 --width=300)
    folder=$(zenity zenity --entry --text "Введите полный путь до сетевой папки. smb://server/share/folder" --height=250 --width=400)
    local n=1
    while true; do
        number=$(grep "$n" "/home/$USER/.config/rusbitech/fly-fm-vfs.conf")
        echo $number
        if [[ "$number" == "" ]]; then
            break;
        fi
        n=$(($n+1))
    done
    local check=$(grep "$selected_item_menu" "/home/$USER/.config/rusbitech/fly-fm-vfs.conf")
    echo $check
    if [[ "$check" == "" ]]; then
        echo "[Network Place $n]
        Name=$name_folder
        Url=$folder" >> /home/$USER/.config/rusbitech/fly-fm-vfs.conf
    fi
    killall fly-vfs-service fly-fops-service fly-open-service fly-fm-service   
}

remove_share_folder(){
    remove_name_folder=$(zenity zenity --entry --text "Введите имя для сетевой папки, которую хотите удалить. Имя указано в пункте 'Добавить сетевую папку' " --height=150 --width=300)
    sed "/$remove_name_folder/d" /home/$USER/.config/rusbitech/fly-fm-vfs.conf > /home/$USER/.config/test
    mv /home/$USER/.config/test /home/$USER/.config/rusbitech/fly-fm-vfs.conf
    killall fly-vfs-service fly-fops-service fly-open-service fly-fm-service      
}

get_drivers() {
    mod_selected_item_menu=$(echo "$selected_item_menu" | sed 's/ /+/g')
    wget -O /home/$USER/Desktop/"$selected_item_menu".PPD https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=printer%2F"$mod_selected_item_menu".PPD

}

install_apps() {
    wget https://easyastra.ru/TEST/store/"$selected_item_menu".deb -P /home/$USER/Desktop/
    passwd=$(zenity --password)
    file="/home/$USER/Desktop/"$selected_item_menu".deb"
    # Установка пакета с указанием прогресса
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S apt install -f "$file" -y
    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
    rm /home/$USER/Desktop/"$selected_item_menu".deb
}

install_app_repo() {
    passwd=$(zenity --password)
    # Установка пакета с указанием прогресса
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S apt install "$selected_item_menu" -y
    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
}

remove_app(){
    local passwd=$(zenity --password)
    echo $passwd | sudo -S apt remove "$1" -y
}

anaconda(){
    passwd=$(zenity --password)
    # Установка пакета с указанием прогресса
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S wget --no-check-certificate https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Linux-x86_64.sh  -P /opt/
    echo $passwd | sudo -S chmod +x /opt/Anaconda3-2023.07-1-Linux-x86_64.sh
    $(zenity --info --text="ПОСЛЕ УСТАНОВКИ НЕОБХОДИМО ПЕРЕЗАГРУЗИТЬ ПК.Сейчас откроется меню установки в консоли. Нажимаем enter, когда увидите сообщение о лицензионном соглашение нажимаем q, видим внизу окошко вводим yes - жмем enter - yes" --height=300 --width=400)
    echo $passwd | sudo -S fly-term -e "/opt/Anaconda3-2023.07-1-Linux-x86_64.sh -p /opt/anaconda3/"
    echo $passwd | sudo -S chmod -R 777 /opt/anaconda3
    echo $passwd | sudo -S rm /opt/Anaconda3-2023.07-1-Linux-x86_64.sh
    filename="/etc/profile"
    echo $passwd | sudo -S sed -i 's@PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"@PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/anaconda3/bin"@' ${filename}
    echo $passwd | sudo -S sed -i 's@PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"@PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/opt/anaconda3/bin"@' ${filename}
    echo $passwd | sudo -S wget -O /usr/share/applications/flydesktop/anaconda3.desktop https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Fanaconda3.desktop
    echo $passwd | sudo -S wget -O /usr/share/pixmaps/anaconda3.png https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Fanaconda3.png

    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
    rm /home/$USER/Desktop/"$selected_item_menu".deb
}

xampp(){
    $(zenity --info --text="ПОСЛЕ УСТАНОВКИ НЕОБХОДИМО ПЕРЕЗАГРУЗИТЬ ПК"  --height=300 --width=400)
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S wget https://deac-fra.dl.sourceforge.net/project/xampp/XAMPP%20Linux/8.2.4/xampp-linux-x64-8.2.4-0-installer.run -P /opt/
    echo $passwd | sudo -S chmod 755 /opt/xampp-linux-x64-8.2.4-0-installer.run
    echo $passwd | sudo -S /opt/xampp-linux-x64-8.2.4-0-installer.run
    echo $passwd | sudo -S rm /opt/xampp-linux-x64-8.2.4-0-installer.run
    echo $passwd | sudo -S wget -O /usr/share/pixmaps/xampp.png https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Fxampp.png  
    echo $passwd | sudo -S wget -O /usr/share/applications/flydesktop/xampp.desktop https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Fxampp.desktop
    echo $passwd | sudo -S wget -O /opt/xampp.sh https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Fxampp.sh
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
}

workbench(){
    $(zenity --info --text="ПОСЛЕ УСТАНОВКИ НЕОБХОДИМО ПЕРЕЗАГРУЗИТЬ ПК"  --height=300 --width=400)
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S wget -O /home/$USER/Desktop/debian.deb https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=repo%2Fdebian.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/debian.deb
    echo $passwd | sudo -S wget -O /etc/apt/sources.list.d/debian.list https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=repo%2Fdebian.list
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/debian.deb
    echo $passwd | sudo -S apt update
    echo $passwd | sudo -S apt install snapd -y
    echo $passwd | sudo -S apt install snap -y
    echo $passwd | sudo -S snap install core
    echo $passwd | sudo -S snap install mysql-workbench-community --devmode    
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
}

freeipa(){
    $(zenity --info --text="Перед продолжением необходимо в dns указать первым, dns адрес вашего контроллера домена")
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S apt install astra-freeipa-client -y
    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
    domain_freeipa=$(zenity --entry --text="Введите ваш домен FreeIpa типа: astra.domain")
    user_freeipa=$(zenity --entry --text="Введите логин администратора домена astra.domain")
    pass_freeipa=$(zenity --forms --title="Пароль для админа домена" \
    --text="Введите пароль админа домена" \
    --add-password="Пароль")
    echo $passwd | sudo -S astra-freeipa-client -d "$domain_freeipa" -u "$user_freeipa" -p "$pass_freeipa" -y --par "--force --enable-dns-updates"
    echo $passwd | sudo -S sed -i 's/dns_lookup_realm = false/dns_lookup_realm = true/g'  /etc/krb5.conf
    echo $passwd | sudo -S sed -i 's/dns_lookup_kdc = false/dns_lookup_kdc = true/g'  /etc/krb5.conf
    # запоминать последний удачный вход в систему
    echo $passwd | sudo -S sed -i 's/PreselectUser=None/PreselectUser=Previous/g'  /etc/X11/fly-dm/fly-dmrc
    # убрать выбор доменов доверительных отношений, но воможность через user@domain останется
    # echo $passwd | sudo -S chmod -x /etc/domains.list.d/astra-freeipa-domains-ctl
}

aldpro(){
    echo 1
}

crypto1145(){
    if ! dpkg -s yandex-browser-stable &>/dev/null; then
    $(zenity --info --text="$crypto" --height=300 --width=400)
    else
    passwd=$(zenity --password)
    wget -O /home/$USER/Desktop/crypto1145.tgz https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=crypto%2Fcrypto1145.tgz
    tar -zxf /home/$USER/Desktop/crypto1145.tgz -C /home/$USER/Desktop/
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S fly-term -e "/home/$USER/Desktop/linux-amd64_deb/install_gui.sh"
    echo $passwd | sudo -S rm /home/$USER/Desktop/crypto1145.tgz
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/linux-amd64_deb
    echo $passwd | sudo -S apt install pcscd -y 
    wget -O /home/$USER/Загрузки/cades-linux-amd64.tar.gz https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=crypto%2Fcades-linux-amd64.tar.gz
    wget -O /home/$USER/Загрузки/IFCPlugin-x86_64.deb https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=crypto%2FIFCPlugin-x86_64.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Загрузки/IFCPlugin-x86_64.deb
    echo $passwd | sudo -S rm /home/$USER/Загрузки/IFCPlugin-x86_64.deb
    echo $passwd | sudo -S ln -s /etc/opt/chrome/native-messaging-hosts/ru.rtlabs.ifcplugin.json /etc/chromium/native-messaging-hosts
    echo $passwd | sudo -S ln -s /opt/cprocsp/lib/amd64/libcppkcs11.so.4.0.4 /usr/lib/mozilla/plugins/lib/libcppkcs11.so
    wget https://www.cryptopro.ru/sites/default/files/public/faq/ifcx64.cfg -P /home/$USER/Desktop/
    echo $passwd | sudo -S rm /etc/ifc.cfg
    echo $passwd | sudo -S cp /home/$USER/Desktop/ifcx64.cfg /etc/ifc.cfg
    echo $passwd | sudo -S /opt/cprocsp/bin/amd64/csptestf -absorb -certs -autoprov
    echo $passwd | sudo -S rm /home/$USER/Desktop/ifcx64.cfg
    echo $passwd | sudo -S tar xf /home/$USER/Загрузки/cades-linux-amd64.tar.gz -C /home/$USER/Загрузки/
    echo $passwd | sudo -S rm /home/$USER/Загрузки/cades-linux-amd64.tar.gz
    echo $passwd | sudo -S dpkg -i /home/$USER/Загрузки/cades-linux-amd64/*.deb
    echo $passwd | sudo -S rm -r /home/$USER/Загрузки/cades-linux-amd64
    yandex-browser --new-window https://addons.opera.com/ru/extensions/details/cryptopro-extension-for-cades-browser-plug-in/ https://chrome.google.com/webstore/detail/расширение-для-плагина-го/pbefkdcndngodfeigfdgiodgnmbgcfha &
 fi
}

crypto1290(){
    if ! dpkg -s yandex-browser-stable &>/dev/null; then
    $(zenity --info --text="$crypto" --height=300 --width=400)
    else
    passwd=$(zenity --password)
    echo $passwd | sudo -S apt install yandex-browser-stable -y
    wget -O /home/$USER/Desktop/crypto1290.tgz https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=crypto%2Fcrypto1290.tgz
    tar -zxf /home/$USER/Desktop/crypto1290.tgz -C /home/$USER/Desktop/
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S fly-term -e "/home/$USER/Desktop/linux-amd64_deb/install_gui.sh"
    echo $passwd | sudo -S rm /home/$USER/Desktop/crypto1290.tgz
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/linux-amd64_deb
    echo $passwd | sudo -S apt install pcscd -y 
    wget -O /home/$USER/Загрузки/cades-linux-amd64.tar.gz https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=crypto%2Fcades-linux-amd64.tar.gz
    wget -O /home/$USER/Загрузки/IFCPlugin-x86_64.deb https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=crypto%2FIFCPlugin-x86_64.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Загрузки/IFCPlugin-x86_64.deb
    echo $passwd | sudo -S rm /home/$USER/Загрузки/IFCPlugin-x86_64.deb
    echo $passwd | sudo -S ln -s /etc/opt/chrome/native-messaging-hosts/ru.rtlabs.ifcplugin.json /etc/chromium/native-messaging-hosts
    echo $passwd | sudo -S ln -s /opt/cprocsp/lib/amd64/libcppkcs11.so.4.0.4 /usr/lib/mozilla/plugins/lib/libcppkcs11.so
    wget https://www.cryptopro.ru/sites/default/files/public/faq/ifcx64.cfg -P /home/$USER/Desktop/
    echo $passwd | sudo -S rm /etc/ifc.cfg
    echo $passwd | sudo -S cp /home/$USER/Desktop/ifcx64.cfg /etc/ifc.cfg
    echo $passwd | sudo -S /opt/cprocsp/bin/amd64/csptestf -absorb -certs -autoprov
    echo $passwd | sudo -S rm /home/$USER/Desktop/ifcx64.cfg
    echo $passwd | sudo -S tar xf /home/$USER/Загрузки/cades-linux-amd64.tar.gz -C /home/$USER/Загрузки/
    echo $passwd | sudo -S rm /home/$USER/Загрузки/cades-linux-amd64.tar.gz
    echo $passwd | sudo -S dpkg -i /home/$USER/Загрузки/cades-linux-amd64/*.deb
    echo $passwd | sudo -S rm -r /home/$USER/Загрузки/cades-linux-amd64
    yandex-browser --new-window https://addons.opera.com/ru/extensions/details/cryptopro-extension-for-cades-browser-plug-in/ https://chrome.google.com/we$
    fi
}

kaspersky(){
    if dpkg -l | grep kesl-astra  &>/dev/null; then
    $(zenity --info --text="Касперский уже установлен!" --height=300 --width=400)
    else
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S wget -O /home/$USER/Desktop/kesl-astra_11.1.0-3013_amd64.deb https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=kaspersky%2Fkesl-astra_11.1.0-3013_amd64.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/kesl-astra_11.1.0-3013_amd64.deb
    echo $passwd | sudo -S rm /home/$USER/Desktop/kesl-astra_11.1.0-3013_amd64.deb
    echo $passwd | sudo -S wget -O /home/$USER/Desktop/setup.ini
    echo $passwd | sudo -S /opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=/home/$USER/Desktop/setup.ini
    echo $passwd | sudo -S rm /home/$USER/Desktop/setup.ini
    user=$(zenity --entry --text="Введите имя пользователя, чтобы добавить его в группу администраторов Kaspersky:" --height=300 --width=400)
    echo $passwd | sudo -S usermod -a -G kesluser $user
    echo $passwd | sudo -S kesl-control --grant-role admin $user
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate    
   fi
}

fonts(){
    passwd=$(zenity --password)
    echo $passwd | sudo -S wget -O /home/$USER/Desktop/debian.deb https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=repo%2Fdebian.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/debian.deb
    echo $passwd | sudo -S wget -O /etc/apt/sources.list.d/debian.list https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=repo%2Fdebian.list
    echo $passwd | sudo -S rm /home/$USER/Desktop/debian.deb
    echo $passwd | sudo -S apt update -y 
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S apt install ttf-mscorefonts-installer -y -f
    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
    echo $passwd | sudo -S rm /etc/apt/sources.list.d/debian.list
    echo $passwd | sudo -S apt update -y 
}

finereader(){
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S mkdir /opt/finereader/
    echo $passwd | sudo -S wget -O /opt/finereader/ABBYY_Finereader_8_Portable_kmtz.exe https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=FineReader%2FABBYY_Finereader_8_Portable_kmtz.exe
    echo $passwd | sudo -S apt install wine -y
    echo $passwd | sudo -S chmod +x /opt/finereader/ABBYY_Finereader_8_Portable_kmtz.exe
    echo $passwd | sudo -S wget -O /usr/share/applications/flydesktop/finereader.desktop https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Ffinereader.desktop 
    echo $passwd | sudo -S wget -O /usr/share/pixmaps/finereader.png https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Ffinereader.png 
        exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate

    
}

1c_install(){
    passwd=$(zenity --password)
    $(zenity --info --text="Выберите архив с серверной частью Предприятия 1с (примерное имя deb64_8_3_18_1959.tar.gz) " --height=150 --width=300)
    selected_file=$(zenity --file-selection)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    mkdir /home/$USER/Desktop/1c
    echo $passwd | sudo -S tar -xzf $selected_file -C /home/$USER/Desktop/1c
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-*-common*_amd64.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-*-server*_amd64.deb    
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-*-ws*_amd64.deb  
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-*-crs_*_amd64.deb
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Серверная составляющая установлена!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке серверной части."
        fi
    ) | zenity --progress --pulsate
    # Получение кода завершения установки
    $(zenity --info --text="Выберите архив с клиентской частью Предприятия 1с (примерное имя client_8_3_18_1959.deb64.tar.gz) " --height=150 --width=300)
    selected_file_client=$(zenity --file-selection)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S tar -xzf $selected_file_client -C /home/$USER/Desktop/1c
    echo $passwd | sudo -S apt install libfreetype6 libgsf-1-common unixodbc glib2.0 -y 
    echo $passwd | sudo -S apt install libwebkitgtk-3.0-0
    echo $passwd | sudo -S apt --fix-broken install -y
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-*-client_*_amd64.deb   
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/1c
    # тут мы может указать путь откуда будут скачиваться заранее созданый файл с базами 1с ( он есть в репозитори как пример)
    # echo $passwd | sudo -S wget http://ip-address/share/base1c.sh -P /opt/
    # echo $passwd | sudo -S chmod +x /opt/base1c.sh
    # тут мы добавляем скрипт base1c.sh в автозапуск при входе любого пользователя, и если список базу него пуст, то они пропишуться
    # echo $passwd | sudo -S wget http://ip-address/share/base.desktop -P /etc/xdg/autostart/
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Серверная составляющая установлена!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке серверной части."
        fi
    ) | zenity --progress --pulsate
}

dinfo_19(){
    passwd=$(zenity --password)
    (
    echo $passwd | sudo -S mkdir /home/$USER/Desktop/info
    echo $passwd | sudo -S wget -O /home/$USER/Desktop/info/simpledinfo_0-0.5_astra17.deb https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=simpledinfo%2Fsimpledinfo_0-0.5_astra17.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/info/simpledinfo_0-0.5_astra17.deb
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/info
    echo $passwd | sudo -S wget -O /opt/simpledinfo/settings.ini https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=simpledinfo%2Fsettings19.ini
    echo $passwd | sudo -S wget -O /etc/xdg/autostart/simpledinfo.desktop https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=simpledinfo%2Fsimpledinfo.desktop

    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S apt install root-tail   
    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
       
}

dinfo_22(){
    passwd=$(zenity --password)
    (
    echo $passwd | sudo -S mkdir /home/$USER/Desktop/info
    echo $passwd | sudo -S wget -O /home/$USER/Desktop/info/simpledinfo_0-0.5_astra17.deb https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=simpledinfo%2Fsimpledinfo_0-0.5_astra17.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/info/simpledinfo_0-0.5_astra17.deb
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/info
    echo $passwd | sudo -S wget -O /opt/simpledinfo/settings.ini https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=simpledinfo%2Fsettings22.ini
    echo $passwd | sudo -S wget -O /etc/xdg/autostart/simpledinfo.desktop https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=simpledinfo%2Fsimpledinfo.desktop

    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S apt install root-tail   
    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
       
}

consultant(){
      passwd=$(zenity --password)
    (
    echo $passwd | sudo -S apt install wine -y
    echo $passwd | sudo -S mkdir /mnt/cons
    echo $passwd | sudo -S chmod -R 0777 /mnt/cons
    echo $passwd | sudo -S apt install cifs-utils -y
    #необходимо указать сетевую папку где установлен консультант ( ниже пример )
    echo $passwd | sudo -S sh -c 'echo "//10.10.80.43/cp /mnt/cons cifs guest,file_mode=0777,dir_mode=0777,iocharset=utf8 0 0" >> /etc/fstab'
    echo $passwd | sudo -S mount -a  
      тут скачивается бутылка консультанта, которая заранее была установленна на пк, и далее распространяется уже готовым образом без установки
    echo $passwd | sudo -S wget http://ip/share/ConsultantPlus.tar.gz -P /opt/
    echo $passwd | sudo -S tar -xzf /opt/ConsultantPlus.tar.gz -C /opt/
    echo $passwd | sudo -S rm /opt/ConsultantPlus.tar.gz
    echo $passwd | sudo -S chmod -R 0777 /opt/.ConsultantPlus
    echo $passwd | sudo -S wget -O /opt/cons.sh https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Fcons.sh
    echo $passwd | sudo -S chmod +x /opt/cons.sh
    echo $passwd | sudo -S wget -O /etc/xdg/autostart/cons.desktop https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=desktop+and+icons%2Fcons.desktop 
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
}

install_virtualbox(){
    passwd=$(zenity --password)
    (
    echo $passwd | sudo -S wget -O /home/$USER/Desktop/debian.deb https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=repo%2Fdebian.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/debian.deb
    echo $passwd | sudo -S wget -O /etc/apt/sources.list.d/debian.list https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=repo%2Fdebian.list
    echo $passwd | sudo -S apt update -y
    echo $passwd | sudo -S wget https://easyastra.ru/TEST/store/virtualbox.deb -P /home/$USER/Desktop/
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/virtualbox.deb
    echo $passwd | sudo -S rm /etc/apt/sources.list.d/debian.list
    echo $passwd | sudo -S rm /home/$USER/Desktop/debian.deb
    echo $passwd | sudo -S rm /home/$USER/Desktop/virtualbox.deb
    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate  
}

system_update(){
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка обновления" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S bash -c "echo -e 'deb http://dl.astralinux.ru/astra/stable/1.7_x86-64/repository-main/ 1.7_x86-64 main contrib non-free' > /etc/apt/sources.list"
    echo $passwd | sudo -S apt update -y
    echo $passwd | sudo -S apt install ca-certificates -y
    echo $passwd | sudo -S wget -O /etc/apt/sources.list https://gitflic.ru/project/gabidullin-aleks/packets_for_pomogator/blob/raw?file=repo%2Fastra.list
    echo $passwd | sudo -S apt update -y   
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S astra-update -A -r -T
    # установка сразу puppet агента для дальнейшего управления машинами через групповые политики
    # echo $passwd | sudo -S apt install puppet-agent -y
    # echo $passwd | sudo -S sh -c 'echo "[main]" >> /etc/puppetlabs/puppet/puppet.conf'
    # echo $passwd | sudo -S sh -c 'echo "server = puppet.server.domain" >> /etc/puppetlabs/puppet/puppet.conf'
    # echo $passwd | sudo -S sh -c 'echo "show_diff = true" >> /etc/puppetlabs/puppet/puppet.conf'
    # echo $passwd | sudo -S sh -c 'echo "runinterval = 1m" >> /etc/puppetlabs/puppet/puppet.conf'
    # echo $passwd | sudo -S sh -c 'echo "ip-address    puppet.server.domain" >> /etc/hosts'
    # echo $passwd | sudo -S ufw allow 8140
    # echo $passwd | sudo -S systemctl enable puppet
    # echo $passwd | sudo -S systemctl start puppet
    # echo $passwd | sudo -S /opt/puppetlabs/bin/puppet agent --test
    # Получение кода завершения установки
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Система успешно обновлена!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке обновления."
        fi
    ) | zenity --progress --pulsate
}

pomogator_update(){
    passwd=$(zenity --password)
    if dpkg -s git  &>/dev/null; then
        zenity --progress --pulsate --title="Обновление программы" --text="Подождите, идет установка..." --auto-close &
        (
        tmp_folder=$(mktemp -d)
        echo $passwd | sudo -S git clone "https://gitflic.ru/project/gabidullin-aleks/pomogator.git" "$tmp_folder"
        FOLDER_PATH=/opt/helper/
        # Замените файлы в целевой папке
        echo $passwd | sudo -S cp -R "$tmp_folder"/* "$FOLDER_PATH"

        # Удалите временную папку с репозиторием
        echo $passwd | sudo -S rm -rf "$tmp_folder"
        exit_code=$?
        # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Программа успешно обнавлена!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке обнавления."
        fi
        ) | zenity --progress --pulsate
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

}

pomogator_news(){
    news=$(curl "https://gitflic.ru/project/gabidullin-aleks/pomogator/blob/raw?file=news&inline=false")
    $(zenity --info --text="Вышло обновление приложения $news " --height=150 --width=300)

}

pomogator_version(){
    version=$(curl "https://gitflic.ru/project/gabidullin-aleks/pomogator/blob/raw?file=version.sh&inline=false")
    trimmed_version=$(echo "$version" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
    if [[ $version == *html* ]]; then
    $(zenity --info --text=" У вас нет доступа к репозиторию для обновления" --height=150 --width=300)
    else
        if [[ "$trimmed_version" != "$version_now" ]]; then
            $(zenity --info --text="Вышло обновление "$trimmed_version".\nСпасибо что используете наши технологии" --height=150 --width=300)
        else
            $(zenity --info --text="У вас установленно актуальное обновление "$version_now".\nСпасибо что используете наши технологии" --height=150 --width=300)
        fi
    fi
}
#-------------------------------------main function------------------------------------#
check_update(){
    if dpkg -s git  &>/dev/null; then
        if dpkg -s curl  &>/dev/null; then
            passwd=$(zenity --forms --title="Пароль для администратора" \
                    --text="Введите пароль администратора" \
                    --add-password="Пароль")
            echo "$passwd" | sudo -Sv >/dev/null 2>&1
            if [ $? -eq 0 ]; then
            version=$(curl "https://gitflic.ru/project/gabidullin-aleks/pomogator/blob/raw?file=version.sh&inline=false")
            trimmed_version=$(echo "$version" | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+')
                if [[ $version == *html* ]]; then
                $(zenity --info --text=" У вас нет доступа к репозиторию для обновления" --height=150 --width=300)
                else
                    if [[ "$trimmed_version" != "$version_now" ]]; then
                        $(zenity --info --text="Вышло обновление приложения "$trimmed_version".\nСпасибо что используете наши технологии" --height=150 --width=300)
                    else
                        $(zenity --info --text="У вас установленно актуальное обновление "$version_now".\nСпасибо что используете наши технологии" --height=150 --width=300)
                    fi
                fi
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
            zenity --progress --pulsate --title="Обновление программы" --text="Подождите, идет установка..." --auto-close &
            (
            echo $passwd | sudo -S apt install curl -y
            exit_code=$?
            # Проверка кода завершения и отображение соответствующего сообщения
                if [ $exit_code -eq 0 ]; then
                    zenity --info --title="Успех" --text="Программа успешно обнавлена!"
                else
                    zenity --error --title="Ошибка" --text="Ошибка при установке обнавления."
                fi
            ) | zenity --progress --pulsate
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
            zenity --progress --pulsate --title="Обновление программы" --text="Подождите, идет установка..." --auto-close &
            (
            echo $passwd | sudo -S apt install git -y
             exit_code=$?
            # Проверка кода завершения и отображение соответствующего сообщения
            if [ $exit_code -eq 0 ]; then
                zenity --info --title="Успех" --text="Программа успешно обнавлена!"
            else
                zenity --error --title="Ошибка" --text="Ошибка при установке обнавления."
            fi
            ) | zenity --progress --pulsate
            else
            $(zenity --info --text "Неверный пароль администратора! Или у вас не хватает прав!" --height=150 --width=300)
            fi
        else
            exit 0
        fi
    fi
    
}

run_event() {    
    local command_to_run="$1"
    eval "$command_to_run"
}

rend_menu() {
    local choices=("$@")  
    selected_item_menu=$(zenity --list --title="Меню выбора" --column="Выберите" "${choices[@]}"  --height=400 --width=400)
}

run_menu(){
     local menu_items=("$@") 
    
     while true; do
        rend_menu "${menu_items[@]}"
        if [ $? -eq 0 ]; then
            if [ -n "${event_menu["$selected_item_menu"]}" ]; then 
            run_event "${event_menu["$selected_item_menu"]}"
            elif  [ "$selected_item_menu" == "$exit_menu" ]; then
                selected_item_menu=""
                return        
            fi
        else
            exit 1
        fi
     done
}

run_app() {
    $(zenity --info --text="$app_info" --height=300 --width=400)
    check_update
    run_menu "${items_main_menu[@]}"
}

#--------------------Запуск программы---------------------------
run_app
