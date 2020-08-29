#!/bin/sh

bye() {
    echo "bye. OwO"
    exit 1
}

OwO() {
    echo "
    *******************************************
    *     ooooo                   oooooo      *         
    *    o     o                 o      o     *          
    *   o       o               o        o    *           
    *    o     o                 o      o     *          
    *     ooooo   w     ww     w  oooooo      *         
    *              w   w   w  w               *
    *                w      w                 *
    *******************************************
    "
}

# variables
extendPKG=""
favoratePKG="nyancat zsh htop nmap git wget curl vim"
user=`whoami`

# main

## install pkg
whichApt=`which apt`
whichYum=`which yum`

if [ $whichApt = '/usr/bin/apt' ];
then
    sudo apt update -y
    sudo apt-get upgrade -y
    echo "installing $favoratePKG"
    sudo apt install -y $favoratePKG $extendPKG 
elif [ $whichYum = '/usr/bin/yum' ];
then
    sudo yum update && 
    sudo yum install -y $favoratePKG  $extendPKG
else
    echo "both apt and yum not found!!QUITE"
    bye
fi

## config zsh
### oh-my-zsh
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --unattended

### zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sudo cp ./.zshrc ./.zshrc_original_cpoy  # make a zshrc copy
sudo sed -i -e "s/{USER_NAME}/$user/g" $PWD/.zshrc_cpoy # replace the {USER_NAME} with $user
sudo mv ./.zshrc_cpoy ~/.zshrc   # overwrite zshrc setting file

### start zsh
sudo chsh -s $(which zsh)
zsh

OwO
echo "finish"
