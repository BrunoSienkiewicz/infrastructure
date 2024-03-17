apt-get install iptables
sudo apt-get install -y iptables arptables ebtables
sudo iptables -F
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

