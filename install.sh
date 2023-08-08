#!/bin/bash
##############################################################
#                                                            #
#                                                            # 
#         V2rayForward v1.0                                  #
#                                                            #
##############################################################

#install base
rpm -q curl || yum install -y curl
rpm -q wget || yum install -y wget
apt-get install git -y || yum install git -y

#install v2fly
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

#Config info
cd /usr/local/etc/v2ray && rm -rf config.json
wget https://raw.githubusercontent.com/xiachedan99/v2Foward/main/config.json

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
echo -e "service v2ray restart \033[32m 重启v2ray \033[0m"
echo -e "service v2ray status \033[32m 查看v2ray \033[0m"
echo -e "配置多用户转发，请至/usr/local/etc/v2ray/config.json修改配置文件"
