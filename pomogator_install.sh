#!/bin/bash
passwd=$(zenity --password)
    echo $passwd | sudo -S apt install curl -y
    echo $passwd | sudo -S git clone https://gitflic.ru/project/gabidullin-aleks/pomogator.git /opt/helper
    echo $passwd | sudo -S chmod +x -R /opt/helper
    echo $passwd | sudo -S cp /opt/helper/pomogator.desktop -P /usr/share/applications/flydesktop/
    echo $passwd | sudo -S cp /opt/helper/pomogator_icon.png -P /usr/share/pixmaps/





