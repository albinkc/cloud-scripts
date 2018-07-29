//Enter your ubuntu version codename
$codename=xenial

wget https://nginx.org/keys/nginx_signing.key -O - | sudo apt-key add -

sudo echo -e "\ndeb http://nginx.org/packages/mainline/ubuntu/ $codename nginx" >> /etc/apt/sources.list
sudo echo "deb-src http://nginx.org/packages/mainline/ubuntu/ $codename nginx" >> /etc/apt/sources.list

apt update
apt install nginx
