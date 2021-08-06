#Run As root
#Show commands as they're being executed
set -x

#Set Up DigitalOcean Droplet Monitoring
#For DigitalOcean instances only
#curl -sSL https://agent.digitalocean.com/install.sh | sh

#Add user without password and key based login only
adduser --disabled-password --gecos "" ubuntu

#Copy ssh key from root
##Use the following command to use a custom key
#echo "<key>" > /home/ubuntu/.ssh/authorized_keys
mkdir -p /home/ubuntu/.ssh
cp /root/.ssh/authorized_keys /home/ubuntu/.ssh/authorized_keys

#Change ownership to newly created user
chown -R ubuntu:ubuntu /home/ubuntu/.ssh

#Set permissions. Maybe redundant if key was copied from root
chmod 700 /home/ubuntu/.ssh
chmod 644 /home/ubuntu/.ssh/authorized_keys

#Add to sudo group
usermod -aG sudo ubuntu

#Enable sudo without password for user
##To-do: use visudo
echo "ubuntu ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

#disable password login. If you know of a more elegant way to do this; please send a pull request
grep -q "ChallengeResponseAuthentication" /etc/ssh/sshd_config && sed -i "/^[^#]*ChallengeResponseAuthentication[[:space:]]yes.*/c\ChallengeResponseAuthentication no" /etc/ssh/sshd_config || echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config
grep -q "^[^#]*PasswordAuthentication" /etc/ssh/sshd_config && sed -i "/^[^#]*PasswordAuthentication[[:space:]]yes/c\PasswordAuthentication no" /etc/ssh/sshd_config || echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
systemctl reload sshd
