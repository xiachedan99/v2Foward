#!/bin/bash
#####################################
#                                   #                 
#         V2rayForward v1.0         #
#                                   #
#####################################

#install base
rpm -q curl || yum install -y curl
rpm -q wget || yum install -y wget
apt-get install git -y || yum install git -y

#install v2fly
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

#Config info
cd /usr/local/etc/v2ray && rm -rf config.json
wget https://raw.githubusercontent.com/xiachedan99/v2Foward/main/v2ray_config.json

#setting config
read -p "请输入监听端口：" listen_port
read -p "请输入被转发端口（落地机端口）：" into_port
read -p "请输入被转发IP（落地机IP）：" into_address

#written config
file="/usr/local/etc/v2ray/config.json"
sed -i "s|Nat_port|${listen_port}|" $file
sed -i "s|Ld_ipadress|${into_address}|" $file
sed -i "s|Ld_port|${into_port}|" $file

#system 
systemctl enable v2ray
systemctl start v2ray
service v2ray restart
service v2ray status
echo -e "\033[32m 安装完成 \033[0m"
