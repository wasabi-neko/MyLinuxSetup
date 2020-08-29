#!/bin/sh

bye() {
    echo "bye. OwO"
    exit 1
}

# main

## change root password
echo "wanna change root password? y/n"
read isChRootpwd
isChRootpwd=`echo $isChRootpwd | tr '[A-Z]' '[a-z]'`
if [ $isChRootpwd == 'y' ] || [ $isChRootpwd == 'yes' ];
then
    sudo passwd root
fi

## change user
echo "wanna add a new user and login as the new user? y/n"
read isAddUser
isAddUser=`echo $isAddUser | tr '[A-Z]' '[a-z]'`
if [ $isAddUser = 'y' ] || [ $isAddUser = 'yes' ];
then
    echo "new userName:"
    read newUserName
    
    sudo useradd -m $newUserName
    sudo passwd $newUserName

    echo "new user id:"
    id $newUserName

    sudo adduser $newUserName sudo
    echo "switch to $newUserName"
    su $newUserName
fi
