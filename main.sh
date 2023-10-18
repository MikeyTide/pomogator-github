#!/bin/bash
#---------------init core config-------------------------------------
path=/opt/helper
source $path/version.sh
exit_app="Выход"
exit_menu="Назад"
selected_item_menu=""
app_info="Программа помощник: Помогатор СГЭУ\nВерсия: "$version_now"\nРазработчик: Габидуллин А.\nВкладки установка удаление программ могут быть использованны только под локальным или доменным администратором\n © 2023"
news="В новой версии "$version_now" добавлены: Групповые политики, Finereader, Учебные планы,\n КонсультантПлюс,\n Касперский,\n Криптопро,\n Скрабус,\n КонтурТолк,\n ПДФ-редактор,\n Арт-редактор. \n По запросу студентов и преподавателей добавлены:\n 1.Xampp-аналог OpenServer, \n2. UnityHub,\n 3. Anaconda,\n4.Mysql Workbench"
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

#---------------init event for item_menu_information_update = шрифты menu-------------------------------
event_menu["$item_menu_information_update"]="system_update"

#---------------init menu event for item_menu_information_author="Связь с автором и пожелания" menu------------------
source $path/event_item_menu_information_author.sh



#-------------init functions Функции программы-----------------------
# указана в файле $path/event_item_menu_information_author.sh
# mail_author(){
#     $(zenity --info --text="Для связи с автором приложения напишите на почту gabidullina.a@sseu.ru.\nВ теме письма укажите ПОМОГАТОР СГЭУ.\nХорошего настроения и продуктивной работы!" --height=150 --width=300)
# }

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
    check_head_shared
    local n=1
    while true; do
        number=$(grep "$n" "/home/$USER/.config/rusbitech/fly-fm-vfs.conf")
        if [[ "$number" == "" ]]; then
            break;
        fi
        n=$(($n+1))
    done   
    local check=$(grep "$selected_item_menu" "/home/$USER/.config/rusbitech/fly-fm-vfs.conf")
    echo $check
    if [[ "$check" == "" ]]; then
        echo "[Network Place $n]
        Name=$selected_item_menu
        Url=smb://filecore.sseu.ru/$selected_item_menu" >> /home/$USER/.config/rusbitech/fly-fm-vfs.conf
    fi
    killall fly-vfs-service fly-fops-service fly-open-service fly-fm-service
}

fgroups(){
    check_head_shared
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
        Name=$selected_item_menu
        Url=smb://filecore.sseu.ru/fgroups/$selected_item_menu" >> /home/$USER/.config/rusbitech/fly-fm-vfs.conf
    fi
    killall fly-vfs-service fly-fops-service fly-open-service fly-fm-service
}

share_folder(){
    check_head_shared
    name_folder=$(zenity zenity --entry --text "Введите имя для сетевой папки на английском языке" --height=150 --width=300)
    folder=$(zenity zenity --entry --text "Введите путь до сетевой папки.Без указания сервера filecore, он уже прописан" --height=250 --width=400)
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
        Url=smb://filecore.sseu.ru$folder" >> /home/$USER/.config/rusbitech/fly-fm-vfs.conf
    fi
    killall fly-vfs-service fly-fops-service fly-open-service fly-fm-service   
}

remove_share_folder(){
    remove_name_folder=$(zenity zenity --entry --text "Введите имя для сетевой папки, которую хотите удалить. Имя указано в пункте 'Добавить сетевую папку' " --height=150 --width=300)
    sed "/$remove_name_folder/d" /home/$USER/.config/rusbitech/fly-fm-vfs.conf > /home/$USER/.config/test
    mv /home/$USER/.config/test /home/$USER/.config/rusbitech/fly-fm-vfs.conf
    killall fly-vfs-service fly-fops-service fly-open-service fly-fm-service      
}

fusers(){
    check_head_shared
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
        Name=$selected_item_menu
        Url=smb://filecore.sseu.ru/fusers/$selected_item_menu" >> /home/$USER/.config/rusbitech/fly-fm-vfs.conf
    fi
    killall fly-vfs-service fly-fops-service fly-open-service fly-fm-service   
}

get_drivers() {
    wget http://10.10.80.86/share/printer/"$selected_item_menu".PPD -P /home/$USER/Desktop/
}

info_install_printer(){
    $(zenity --info --text="Чтобы добавить принтер необходимо перейти от имени пользователя, которому добавляем принтер:\n Пуск -> Панель управления -> Оборудование -> Принтеры -> Нажать правой кнопкой мышки на принтер -> добавить принтер и ищем нужный принтер.\n Скачать необходимые драйвера можно во вкладке 'Драйвера для принтера' в данном приложение." --height=250 --width=350)
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
    echo $passwd | sudo -S wget http://10.10.80.86/share/anaconda3.png -P /usr/share/pixmaps/ 
    echo $passwd | sudo -S wget http://10.10.80.86/share/anaconda3.desktop -P /usr/share/applications/flydesktop/

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

install_apps() {
    wget http://10.10.80.86/share/"$selected_item_menu".deb -P /home/$USER/Desktop/
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

xampp(){
    $(zenity --info --text="ПОСЛЕ УСТАНОВКИ НЕОБХОДИМО ПЕРЕЗАГРУЗИТЬ ПК  --height=300 --width=400")
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S wget https://deac-fra.dl.sourceforge.net/project/xampp/XAMPP%20Linux/8.2.4/xampp-linux-x64-8.2.4-0-installer.run -P /opt/
    echo $passwd | sudo -S chmod 755 /opt/xampp-linux-x64-8.2.4-0-installer.run
    echo $passwd | sudo -S /opt/xampp-linux-x64-8.2.4-0-installer.run
    echo $passwd | sudo -S rm /opt/xampp-linux-x64-8.2.4-0-installer.run
    echo $passwd | sudo -S wget http://10.10.80.86/share/xampp.png -P /usr/share/pixmaps/
    echo $passwd | sudo -S wget http://10.10.80.86/share/xampp.sh -P /opt/
    echo $passwd | sudo -S chmod +x /opt/xampp.sh
    #echo $passwd | sudo -S chmod 777 /opt/xampp.sh
    echo $passwd | sudo -S wget http://10.10.80.86/share/xampp.desktop -P /usr/share/applications/flydesktop/
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
    $(zenity --info --text="ПОСЛЕ УСТАНОВКИ НЕОБХОДИМО ПЕРЕЗАГРУЗИТЬ ПК  --height=300 --width=400")
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S wget http://10.10.80.86/share/debian.deb -P /opt/
    echo $passwd | sudo -S wget http://10.10.80.86/share/debian.list -P /etc/apt/sources.list.d/
    echo $passwd | sudo -S dpkg -i /opt/debian.deb
    echo $passwd | sudo -S rm -r /opt/debian.deb
    echo $passwd | sudo -S apt update
    echo $passwd | sudo -S apt install snapd -y
    echo $passwd | sudo -S apt install snap -y
    echo $passwd | sudo -S snap install core
    echo $passwd | sudo -S snap install mysql-workbench-community --devmode
    
    #echo $passwd | sudo -S chmod 777 /opt/xampp.sh
    echo $passwd | sudo -S wget http://10.10.80.86/share/xampp.desktop -P /usr/share/applications/flydesktop/
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
}

plany() {
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S apt --fix-broken install -y
    echo $passwd | sudo -S apt install wine -y
    echo $passwd | sudo -S apt install winetricks -y
    echo $passwd | sudo -S wget http://10.10.80.86/share/PlanyVS.7z -P /opt/
    echo $passwd | sudo -S apt install ia32-libs -y
    echo $passwd | sudo -S 7z x /opt/PlanyVS.7z -o/opt/
    echo $passwd | sudo -S rm /opt/PlanyVS.7z
    echo $passwd | sudo -S chmod -R 0777 /opt/PlanyVS
    echo $passwd | sudo -S chmod +x /opt/PlanyVS/plany.sh
    echo $passwd | sudo -S chmod 777 /opt/PlanyVS/plany.sh
    echo $passwd | sudo -S wget http://10.10.80.86/share/UpVO.desktop -P /etc/xdg/autostart/
    echo $passwd | sudo -S wget http://10.10.80.86/share/UpVO-yrl.desktop -P /usr/share/applications/flydesktop/
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

freeipa(){
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
    user_freeipa=$(zenity --entry --text="Введите логин администратора домена astra.domain")
    pass_freeipa=$(zenity --forms --title="Пароль для админа домена" \
    --text="Введите пароль админа домена" \
    --add-password="Пароль")
    echo $passwd | sudo -S astra-freeipa-client -d astra.domain -u "$user_freeipa" -p "$pass_freeipa" -y --par "--force --enable-dns-updates"
    echo $passwd | sudo -S sed -i 's/dns_lookup_realm = false/dns_lookup_realm = true/g'  /etc/krb5.conf
    echo $passwd | sudo -S sed -i 's/dns_lookup_kdc = false/dns_lookup_kdc = true/g'  /etc/krb5.conf
    echo $passwd | sudo -S sed -i 's/PreselectUser=None/PreselectUser=Previous/g'  /etc/X11/fly-dm/fly-dmrc
    echo $passwd | sudo -S chmod -x /etc/domains.list.d/astra-freeipa-domains-ctl
}

crypto1145(){
    if ! dpkg -s yandex-browser-stable &>/dev/null; then
    $(zenity --info --text="$crypto" --height=300 --width=400)
    else
    passwd=$(zenity --password)
    wget http://10.10.80.86/share/crypto1145.tgz -P /home/$USER/Desktop/
    tar -zxf /home/$USER/Desktop/crypto1145.tgz -C /home/$USER/Desktop/
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S fly-term -e "/home/$USER/Desktop/linux-amd64_deb/install_gui.sh"
    echo $passwd | sudo -S rm /home/$USER/Desktop/crypto1145.tgz
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/linux-amd64_deb
    echo $passwd | sudo -S apt install pcscd -y 
    wget http://10.10.80.86/share/cades-linux-amd64.tar.gz -P /home/$USER/Загрузки/
    wget http://10.10.80.86/share/IFCPlugin-x86_64.deb -P /home/$USER/Загрузки/
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
    wget http://10.10.80.86/share/crypto1290.tgz -P /home/$USER/Desktop/
    tar -zxf /home/$USER/Desktop/crypto1290.tgz -C /home/$USER/Desktop/
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S fly-term -e "/home/$USER/Desktop/linux-amd64_deb/install_gui.sh"
    echo $passwd | sudo -S rm /home/$USER/Desktop/crypto1145.tgz
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/linux-amd64_deb
    echo $passwd | sudo -S apt install pcscd -y 
    wget http://10.10.80.86/share/cades-linux-amd64.tar.gz -P /home/$USER/Загрузки/
    wget http://10.10.80.86/share/IFCPlugin-x86_64.deb -P /home/$USER/Загрузки/
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
    echo $passwd | sudo -S wget http://10.10.80.86/share/kesl-astra_11.1.0-3013_amd64.deb -P /home/$USER/
    echo $passwd | sudo -S dpkg -i /home/$USER/kesl-astra_11.1.0-3013_amd64.deb
    echo $passwd | sudo -S rm /home/$USER/kesl-astra_11.1.0-3013_amd64.deb
    echo $passwd | sudo -S wget http://10.10.80.86/share/setup.ini -P /home/$USER/
    echo $passwd | sudo -S /opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=/home/$USER/setup.ini
    echo $passwd | sudo -S rm /home/$USER/setup.ini
    echo $passwd | sudo -S usermod -a -G kesluser user
    echo $passwd | sudo -S kesl-control --grant-role admin user
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
    wget http://10.10.80.86/share/debian.deb -P /home/$USER/Desktop/
    passwd=$(zenity --password)
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/debian.deb
    rm /home/$USER/Desktop/debian.deb
    echo $passwd | sudo -S wget http://10.10.80.86/share/debian.list -P /etc/apt/sources.list.d/
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
    echo $passwd | sudo -S wget http://10.10.80.86/share/ABBYY_Finereader_8_Portable_kmtz.exe -P /opt/
    echo $passwd | sudo -S apt install wine -y
    echo $passwd | sudo -S chmod 777 /opt/ABBYY_Finereader_8_Portable_kmtz.exe
    echo $passwd | sudo -S chmod +x /opt/ABBYY_Finereader_8_Portable_kmtz.exe
    echo $passwd | sudo -S wget http://10.10.80.86/share/finereader.desktop -P /usr/share/applications/flydesktop/
    echo $passwd | sudo -S wget http://10.10.80.86/share/finereader.png -P /usr/share/pixmaps/
        exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate

    
}


info_shared_papki() {
    $(zenity --info --text="$papki" --height=200 --width=300)
}

1c_install(){
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    mkdir /home/$USER/Desktop/1c
    echo $passwd | sudo -S wget http://10.10.80.86/share/deb64_8_3_18_1959.tar.gz -P /home/$USER/Desktop/1c
    echo $passwd | sudo -S tar -xzf /home/$USER/Desktop/1c/deb64_8_3_18_1959.tar.gz -C /home/$USER/Desktop/1c
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-8.3.18.1959-common_8.3.18-1959_amd64.deb
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-8.3.18.1959-server_8.3.18-1959_amd64.deb    
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-8.3.18.1959-ws_8.3.18-1959_amd64.deb  
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-8.3.18.1959-crs_8.3.18-1959_amd64.deb
    # Получение кода завершения установки
    echo $passwd | sudo -S wget http://10.10.80.86/share/client_8_3_18_1959.deb64.tar.gz -P /home/$USER/Desktop/1c
    echo $passwd | sudo -S tar -xzf /home/$USER/Desktop/1c/client_8_3_18_1959.deb64.tar.gz -C /home/$USER/Desktop/1c
    echo $passwd | sudo -S apt install libfreetype6 libgsf-1-common unixodbc glib2.0 -y 
    echo $passwd | sudo -S apt install libwebkitgtk-3.0-0
    echo $passwd | sudo -S apt --fix-broken install -y
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/1c/1c-enterprise-8.3.18.1959-client_8.3.18-1959_amd64.deb   
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/1c
    echo $passwd | sudo -S wget http://10.10.80.86/share/1c.desktop -P /usr/share/applications/flydesktop/
    echo $passwd | sudo -S apt --fix-broken install -y
    echo $passwd | sudo -S wget http://10.10.80.86/share/base1c.sh -P /opt/
    echo $passwd | sudo -S chmod +x /opt/base1c.sh
    echo $passwd | sudo -S wget http://10.10.80.86/share/base.desktop -P /etc/xdg/autostart/
    echo $passwd | sudo -S systemctl restart fly-dm
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
}

1c_2208(){
    passwd=$(zenity --password)
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S wget http://10.10.80.86/share/setup-thin-8.3.22.2208-x86_64.run -P /opt/
    echo $passwd | sudo -S chmod +x /opt/setup-thin-8.3.22.2208-x86_64.run
    echo $passwd | sudo -S /opt/setup-thin-8.3.22.2208-x86_64.run --mode unattended
    echo $passwd | sudo -S rm /opt/setup-thin-8.3.22.2208-x86_64.run
    echo $passwd | sudo -S wget http://10.10.80.86/share/1c-enterprise-8.3.22.2208-common_8.3.22-2208_amd64.deb -P /opt/
    echo $passwd | sudo -S wget http://10.10.80.86/share/1c-enterprise-8.3.22.2208-server_8.3.22-2208_amd64.deb -P /opt/
    echo $passwd | sudo -S wget http://10.10.80.86/share/1c-enterprise-8.3.22.2208-client_8.3.22-2208_amd64.deb -P /opt/
    echo $passwd | sudo -S dpkg -i /opt/1c-enterprise-8.3.22.2208-common_8.3.22-2208_amd64.deb
    echo $passwd | sudo -S dpkg -i /opt/1c-enterprise-8.3.22.2208-server_8.3.22-2208_amd64.deb
    echo $passwd | sudo -S dpkg -i /opt/1c-enterprise-8.3.22.2208-client_8.3.22-2208_amd64.deb
    echo $passwd | sudo -S rm /opt/1c-enterprise-8.3.22.2208-common_8.3.22-2208_amd64.deb
    echo $passwd | sudo -S rm /opt/1c-enterprise-8.3.22.2208-server_8.3.22-2208_amd64.deb
    echo $passwd | sudo -S rm /opt/1c-enterprise-8.3.22.2208-client_8.3.22-2208_amd64.deb
    exit_code=$?
    # Проверка кода завершения и отображение соответствующего сообщения
        if [ $exit_code -eq 0 ]; then
            zenity --info --title="Успех" --text="Пакет успешно установлен!"
        else
            zenity --error --title="Ошибка" --text="Ошибка при установке пакета."
        fi
    ) | zenity --progress --pulsate
    
}

dinfo_19(){
    passwd=$(zenity --password)
    (
    echo $passwd | sudo -S mkdir /home/$USER/Desktop/info
    echo $passwd | sudo -S wget http://10.10.80.86/share/simpledinfo_0-0.5_astra17.deb -P /home/$USER/Desktop/info/
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/info/simpledinfo_0-0.5_astra17.deb
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/info
    echo $passwd | sudo -S wget http://10.10.80.86/share/settings19.ini -O /opt/simpledinfo/settings.ini
    echo $passwd | sudo -S wget http://10.10.80.86/share/simpledinfo.desktop -O /etc/xdg/autostart/simpledinfo.desktop

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
    echo $passwd | sudo -S wget http://10.10.80.86/share/simpledinfo_0-0.5_astra17.deb -P /home/$USER/Desktop/info/
    echo $passwd | sudo -S dpkg -i /home/$USER/Desktop/info/simpledinfo_0-0.5_astra17.deb
    echo $passwd | sudo -S rm -r /home/$USER/Desktop/info
    echo $passwd | sudo -S wget http://10.10.80.86/share/settings22.ini -O /opt/simpledinfo/settings.ini
    echo $passwd | sudo -S wget http://10.10.80.86/share/simpledinfo.desktop -O /etc/xdg/autostart/simpledinfo.desktop

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
    echo $passwd | sudo -S sh -c 'echo "//10.10.80.43/cp /mnt/cons cifs guest,file_mode=0777,dir_mode=0777,iocharset=utf8 0 0" >> /etc/fstab'
    echo $passwd | sudo -S mount -a  
    echo $passwd | sudo -S wget http://10.10.80.86/share/ConsultantPlus.tar.gz -P /opt/
    echo $passwd | sudo -S tar -xzf /opt/ConsultantPlus.tar.gz -C /opt/
    echo $passwd | sudo -S rm /opt/ConsultantPlus.tar.gz
    echo $passwd | sudo -S chmod -R 0777 /opt/.ConsultantPlus
    echo $passwd | sudo -S wget http://10.10.80.86/share/cons.sh -P /opt/
    echo $passwd | sudo -S chmod +x /opt/cons.sh
    echo $passwd | sudo -S wget http://10.10.80.86/share/cons.desktop -P /etc/xdg/autostart/
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
    zenity --progress --pulsate --title="Установка пакета" --text="Подождите, идет установка..." --auto-close &
    (
    echo $passwd | sudo -S wget http://10.10.80.86/share/astra.list -P /etc/apt/sources.list.d/
    echo $passwd | sudo -S apt install ca-certificates -y
    echo $passwd | sudo -S rm /etc/apt/sources.list
    echo $passwd | sudo -S apt update -y   
    # Установка пакета с использованием sudo и передачей пароля через stdin
    echo $passwd | sudo -S apt dist-upgrade -y
    echo $passwd | sudo -S apt install puppet-agent -y
    echo $passwd | sudo -S sh -c 'echo "[main]" >> /etc/puppetlabs/puppet/puppet.conf'
    echo $passwd | sudo -S sh -c 'echo "server = puppet.astra.domain" >> /etc/puppetlabs/puppet/puppet.conf'
    echo $passwd | sudo -S sh -c 'echo "show_diff = true" >> /etc/puppetlabs/puppet/puppet.conf'
    echo $passwd | sudo -S sh -c 'echo "runinterval = 1m" >> /etc/puppetlabs/puppet/puppet.conf'
    echo $passwd | sudo -S sh -c 'echo "10.10.80.77     buhsrv2" >> /etc/hosts'
    echo $passwd | sudo -S sh -c 'echo "10.10.80.77     buhsrv2.sseu.ru" >> /etc/hosts'
    echo $passwd | sudo -S sh -c 'echo "10.10.80.88     puppet.astra.domain" >> /etc/hosts'
    echo $passwd | sudo -S ufw allow 8140
    echo $passwd | sudo -S systemctl enable puppet
    echo $passwd | sudo -S systemctl start puppet
    echo $passwd | sudo -S /opt/puppetlabs/bin/puppet agent --test
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
#-------------------------------------main function------------------------------------#
check_update() {
    version=$(curl http://10.10.80.86/version)
        if [[ "$version" != "$version_now" ]]; then
            wget http://10.10.80.86/share/helper/helper.tar.gz -P /opt/helper/
            tar -xvf /opt/helper/helper.tar.gz -C /opt/helper/ --overwrite
            rm /opt/helper/helper.tar.gz
            $(zenity --info --text="Приложение было обновлено с "$version_now" до "$version". Приложение автоматически закроется после того как вы нажмете ОК.\nСпасибо что используете наши технологии " --height=150 --width=300)
            exit 0 
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
    $(zenity --info --text="$news" --height=300 --width=400)
    check_update
    run_menu "${items_main_menu[@]}"
}

#--------------------Запуск программы---------------------------
run_app
