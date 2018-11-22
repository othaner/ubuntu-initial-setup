
#!/usr/bin/env bash

#RUNNING AS ROOT
#randpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;}
USER="YOURUSERNAME"
#PASSWORD=randpw

apt update && apt upgrade -y

adduser --disabled-password --gecos "" $USER
usermod -aG sudo $USER
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
rsync --archive --chown=$USER:$USER ~/.ssh /home/$USER

# UFW
ufw app list
ufw allow OpenSSH
ufw enable
ufw status

# EasyEngine
wget -qO ee https://rt.cx/ee4 && sudo bash ee
wget -qO ~/.ee-completion.bash https://raw.githubusercontent.com/EasyEngine/easyengine/develop-v4/utils/ee-completion.bash
echo 'source ~/.ee-completion.bash' >> ~/.bashrc
source ~/.ee-completion.bash

# Python3.7
apt install build-essential libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev zlib1g zlib1g-dev -y
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
tar -xzvf Python-3.7.0.tgz
cd Python-3.7.0
./configure --enable-optimizations
make && make install
rm -rfv Python-3.7.0*
cd ~

pip3 install --upgrade pip
pip install pipenv

# USER STUFF
su - $USER
sudo apt update && sudo apt upgrade -y

exit && exit
