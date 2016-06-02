# Download Ubuntu system
echo "Downloading Ubuntu system..."
sudo debootstrap --arch amd64 vivid /var/chroot/ubuntu http://au.archive.ubuntu.com/ubuntu/

# Install Ubuntu as a chroot
echo "Creating chroot..."
export CURRENT_USER=$(whoami)
sudo sh -c "echo '[ubuntu]
description=Ubuntu 14.04
type=directory
directory=/var/chroot/ubuntu
users=$CURRENT_USER
root-users=$CURRENT_USER
groups=users
aliases=trusty' >> /etc/schroot/schroot.conf"

# Fix networking
echo "Fixing networks..."
sudo sed -i 's/networks/#networks/g' /etc/schroot/default/nssdatabases
echo "Done! Run 'schroot -c ubuntu' to enter Ubuntu"
