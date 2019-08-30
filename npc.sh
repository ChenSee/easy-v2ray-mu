#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear
echo '请输入KEY：'
read input

if [ "$(uname)" == "Darwin" ];then
	brew install wget unzip gcc
	wget https://github.com/cnlh/nps/releases/download/v0.23.2/macos_client.tar.gz
	tar -zxvf macos_client.tar.gz
elif [ -f /etc/redhat-release ];then
	yum -y install wget unzip gcc
	wget https://github.com/cnlh/nps/releases/download/v0.23.2/linux_386_client.tar.gz
	tar -zxvf linux_386_client.tar.gz
elif [ ! -z "`cat /etc/issue | grep bian`" ];then
	apt-get -y install wget unzip gcc
	wget https://github.com/cnlh/nps/releases/download/v0.23.2/linux_386_client.tar.gz
	tar -zxvf linux_386_client.tar.gz
elif [ ! -z "`cat /etc/issue | grep Ubuntu`" ];then
	apt-get -y install wget unzip gcc
	wget https://github.com/cnlh/nps/releases/download/v0.23.2/linux_386_client.tar.gz
	tar -zxvf linux_386_client.tar.gz
else
    echo "非常抱歉，一键脚本并不支持当前所在的环境！"
    exit 1
fi

cd nps
nohup ./npc -server=ec2-54-198-35-69.compute-1.amazonaws.com:8024 -vkey=$input -type=tcp &

wget https://github.com/examplecode/mproxy/archive/master.zip
unzip master.zip
cd mproxy-master
gcc -o mproxy mproxy.c
./mproxy -l 8000 -d

clear
echo -n '已全部运行成功！'