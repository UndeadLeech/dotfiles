#/bin/bash

exclude="--exclude /programming/rust/**/target \
         --exclude /programming/rust/vtebench \
         --exclude /programming/rust/rust \
         --exclude /programming/c/**/build \
         --exclude /movies \
         --exclude /music \
         --exclude /downloads \
         --exclude /.cache \
         --exclude /.config/nvim/plugins \
         --exclude /.rustup \
         --exclude /.cargo \
         --exclude /Games"

# Setup mount
mkdir -p /mnt/backup
mount -t nfs freenas:/mnt/sas-pool-0/backup /mnt/backup

# Rsync files
sudo -u undeadleech rsync -avhP --delete /home/undeadleech/ /mnt/backup/archhq $exclude

# Destroy mount
umount /mnt/backup
rmdir /mnt/backup