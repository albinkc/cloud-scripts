#Upgrade all packages
sudo apt update && sudo apt -y upgrade

#Remove previous versions if installed
sudo apt remove docker docker-engine docker.io

sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt -y install docker-ce
sudo apt autoremove

#Not necessary; just for testing
sudo docker run hello-world
