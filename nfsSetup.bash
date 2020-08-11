#!bin/bash

## NFS
echo "enable NFS? y/n"
read enableNFS
enableNFS=`echo $enableNFS | tr '[A-Z]' '[a-z]'`
if [ $enableNFS == 'y' ] || [ $enableNFS == 'yes' ];
then
    sudo apt install -r rcpbind nfs-common nfs-kernel-server
    sudo echo "/home/$newUserName 192.168.0.0/24(ew,insecure,syn)" >> /etc/exports
    sudo exportfs -ra
    sudo /etc/init.d/nfs start
fi
echo "~~finish~~"