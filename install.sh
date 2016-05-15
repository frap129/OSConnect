# Set Current User
export CURRENT_USER=$(whoami)

# Ask for install type
while true; do
  read -p "Do you use this PC locally or through SSH?" ls
  case $ls in
    [Ll]* ) echo "Installing Localized OSConnect..."; export Type=LOCAL; break;;
    [Ss]* ) echo "Installing OSConnect for SSH"; export Type=SSH; break;;
    * ) echo "Please answer local or ssh.";;
  esac
done

echo "Installing OSconnect..."
rm -f ${HOME}/.osconnectrc
cp home/user/OSConnectrc-$Type ${HOME}/.osconnectrc
echo "export OSCONNECT_USER=$CURRENT_USER" >> ~/.bashrc
if [ "$Type" = "SSH" ]; then
  sudo rm -f /root/.profile
  sudo rm -f /root/.osconnectrc
  sudo cp root/.profile /root/.profile
  sudo cp root/OSConnectrc /root/.osconnectrc
  sudo sh -c "echo 'export OSCONNECT_USER=$CURRENT_USER' >> /root/.bashrc"
fi;

echo "Installing default Ubuntu bashrc..."
rm -f ${HOME}/.ubunturc
cp home/user/.ubunturc ${HOME}/.ubunturc

echo "Enabling OSConnect"
echo "source ~/.osconnectrc" >> ~/.bashrc
if [ "$Type" = "SSH" ]; then
  sudo sh -c 'echo "source /root/.osconnectrc" >> /root/.bashrc'
fi;

unset Type
unset CURRENT_USER
