bye() {
    echo "bye. OwO"
    exit 1
}

# Only support debian based machine now
if ! command -v zsh wget git &> /dev/null; then
    echo "You need to install the packages below to run this script:"
    echo "zsh wget git"
    bye
fi

echo "Wanna install powerlevel10k with zim? [y/n]"
read start_install 
start_install=`echo $start_install | tr '[A-Z]' '[a-z]'`
if  [[ $start_install == 'n' ]] || [[ $start_install == 'no' ]]; then
    bye
fi

mkdir ~/.zim
wget -nv -O ~/.zim/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
chmod +x ~/.zim/zimfw.zsh
cp ./config-files/.* ~/
zsh ~/.zim/zimfw.zsh install
zsh ~/.zim/zimfw.zsh update && zsh ~/.zim/zimfw.zsh upgrade

chsh -s `which zsh`
zsh
bye