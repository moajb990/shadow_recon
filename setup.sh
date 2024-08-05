#version
version="1.0.0"
#save things
echo "saving user and main path."
user=$(logname)
main_path=$(pwd)
###########
# install python
echo "installing python"
sudo apt-get install python3
#download dirsearch
echo "installing dirsearch from github"
sleep 1.5
sudo git clone https://github.com/maurosoria/dirsearch.git
#move the dirsearch to default path
echo "setup dirsearch and another tools"
sleep 1.5
sudo mv dirsearch /home/$user/Desktop
cd /home/$user/dirsearch && pip install -r requirements.txt
sudo apt-get install curl
sudo apt-get install jq
###########################
# make shadow recon work without bash or ./
echo "move the shadowrecon and lib to /usr/local/bin"
sleep 1
cd $main_path
sudo chmod +x shadow_recon.sh
sudo chmod +x scan_lib
sudo mv shadow_recon.sh /usr/local/bin/shadow_recon
sudo mv scan_lib /usr/local/bin/
sleep 1.5
rm -rf $main_path
