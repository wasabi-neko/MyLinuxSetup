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
favoratePKG="nyancat sudo zsh htop nmap git wget curl vim"
user=`whoami`
sudoPrefix=""
installCommand=""

# main

## if logged in as root
if [ $user = "root" ]; then
    echo "your are now logged in as root.Do you want to continue? [Y/N]"
    read continueRoot
    continueRoot=`echo $continueRoot | tr '[A-Z]' '[a-z]'`
    sudoPrefix=""

    if [ $continueRoot = "n" ] || [ $continueRoot = "no" ]; then
        bye
    fi
else
    # get root permission
    sudoPrefix="sudo"
fi

## install pkg
whichApt=`which apt-get`
whichYum=`which yum`

### check installer
if [ $whichApt = "/usr/bin/apt-get" ]; then
    installCommand="apt-get"
elif [ $whichYum = "/usr/bin/yum" ]; then
    installCommand="yum"
else
    echo "both apt and yum not found\nPlease enter the installer you want:"
    read installCommand
    if ! type $installCommand &> /dev/null; then
        # user entered invailed install command
        echo "invailled install command. QUIT!"
        bye
    fi
fi

### install
echo `${sudoPrefix} ${installCommand} update -y`
echo `${sudoPrefix} ${installCommand} upgrade -y`
echo "installing $favoratePKG"
echo `${sudoPrefix} ${installCommand} install -y ${favoratePKG} ${extendPKG}`

## config zsh
### oh-my-zsh
if [ -f "./install.sh" ]; then
    rm ./install.sh
fi
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --unattended
rm install.sh

### zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp ./.zshrc ./.zshrc_copy  # make a zshrc copy

# sed -i -e "s/{USER_HOME}/$home/g" $PWD/.zshrc_copy 
mv -f ./.zshrc_copy ~/.zshrc   # overwrite zshrc setting file
rm ./zshrc_copy
chsh $(whoami) -s $(which zsh)

OwO
echo "finish"

### start zsh
echo "start zsh now? [Y/N]"
read startZSH
startZSH=`echo $startZSH | tr '[A-Z]' '[a-z]'`
if [ $startZSH = "y" ] || [ $startZSH = "yes" ]; then
    zsh
fi
