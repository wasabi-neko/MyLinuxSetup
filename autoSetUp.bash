#!bin/bash

# help functions
help() {
    echo "usage: 
        -a \"pkg name\": add some other pkg you want"
}

# variables
extendPKG=""
favoratePKG="nyancat zsh docker docker-compose npm htop nmap git wget curl vim"
useYum=false

# main

## change root password
echo "wanna change root password? y/n"
read isChRootpwd
isChRootpwd = `echo $isChRootpwd | tr '[A-Z]' '[a-z]'`
if ["$isChRootpwd"=="y"] | ["$isChRootpwd"=="yes"];
then
    sudo passwd root
fi

## change user
echo "wanna add a new user and login as the new user? y/n"
read isAddUser
isAddUser = `echo $isAddUser | tr '[A-Z]' '[a-z]'`
if ["$isAddUser"=="y"] || ["$isAddUser"=="yes"];
then
    echo "new userName:"
    read newUserName
    
    sudo useradd -m $newUserName
    sudo passwd $newUserName

    echo "new user id:"
    id $newUserName

    echo "switch to $newUserName"
    su $newUserName
fi

## install pkg
whichApt = `which apt`
whichYum = `which yum`

if ["$whichApt"=="/usr/bin/apt"];
then
    sudo apt update &&
    sudo apt-get upgrade ||
    sudo apt install -y $favoratePKG $extendPKG 
elif ["$whichYum"=="/usr/bin/yum"];
then
    sudo yum update && 
    sudo yum install -y $favoratePKG  $extendPKG
else
    echo "both apt and yum not found!!QUITE"
    exit 1
fi

## config zsh
sudo chsh -s $(which zsh)
exec zsh
### oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp ./.zshrc ~   # overwrite zshrc setting file

## NFS
echo "enable NFS? y/n"
read enableNFS
enableNFS = `echo $enableNFS | tr '[A-Z]' '[a-z]'`
if ["$enableNFS"=="y"] | ["$enableNFS"=="yes"];
then
    sudo apt install -r rcpbind nfs-common nfs-kernel-server
    echo "/home/$newUserName 192.168.0.0/24(ew,insecure,syn)" >> /etc/exports
    $ sudo exportfs -ra
    /etc/init.d/nfs start
fi

