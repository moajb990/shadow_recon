#version
version="1.0.0"

#save user
user=$(whoami)
main_path=$(pwd)

#install python
echo "installing python"
sudo apt-get install python3

#download dirsearch
echo "installing dirsearch from github"
sleep 0.1
pip3 install dirsearch

#setup our dirsearch directory and aother tools
sudo mv dirsearch /home/$user/Desktop
sleep 0.01
sudo apt-get insall curl
sudo apt-get install jq

#make our recon work in /usr/local/bin
echo "moving our recon and lib to /usr/local/bin/ "
cd $main_path
sudo chmod +x *
sudo mv shr.sh /usr/local/bin/shr
sudo mv scan.lib /usr/local/bin/
sudo mb update_repo.sh /usr/local/bin/up-shr
rm -rf $main_path
