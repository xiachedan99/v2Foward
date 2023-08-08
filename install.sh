#!/bin/bash
#################################################
#                                               # 
#              V2rayForward v1.0                #
#                                               #
#################################################

# ANSI color codes
green='\033[32m'
plain='\033[0m'

# Install required packages
rpm -q curl || yum install -y curl
rpm -q wget || yum install -y wget
apt-get install git -y || yum install git -y

# Install v2fly
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

# Configure info
cd /usr/local/etc/v2ray && rm -rf config.json
wget https://raw.githubusercontent.com/xiachedan99/v2Foward/main/config.json

# Set configuration
read -p "${green}请输入监听端口：${plain}" listen_port
read -p "${green}请输入被转发端口（落地机端口）：${plain}" into_port
read -p "${green}请输入被转发IP（落地机IP）：${plain}" into_address

# Update configuration
file="/usr/local/etc/v2ray/config.json"
sed -i "s|Nat_port|${listen_port}|" $file
sed -i "s|Ld_ipadress|${into_address}|" $file
sed -i "s|Ld_port|${into_port}|" $file

# Enable and start v2ray
systemctl enable v2ray
systemctl start v2ray
service v2ray restart
service v2ray status

# Print completion message
echo -e "${green}安装完成${plain}"
echo -e ""
echo -e "重启v2ray转发： service v2ray restart"
echo -e "查看v2ray转发： service v2ray status"
echo -e "移除v2ray转发请运行： bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) --remove"
echo -e ""
echo -e "配置多用户转发，请至文件目录 /usr/local/etc/v2ray 修改config.json配置文件"
echo -e ""
