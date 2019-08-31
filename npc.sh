#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear
echo -n '请输入KEY：'
read input


if [ ! -d "./nps" ];then
	if [ "$(uname)" == "Darwin" ];then
		wget https://github.com/cnlh/nps/releases/download/v0.23.2/macos_client.tar.gz
		tar -zxvf macos_client.tar.gz
	elif [ -f /etc/redhat-release ];then
		wget https://github.com/cnlh/nps/releases/download/v0.23.2/linux_386_client.tar.gz
		tar -zxvf linux_386_client.tar.gz
	elif [ ! -z "`cat /etc/issue | grep bian`" ];then
		wget https://github.com/cnlh/nps/releases/download/v0.23.2/linux_386_client.tar.gz
		tar -zxvf linux_386_client.tar.gz
	elif [ ! -z "`cat /etc/issue | grep Ubuntu`" ];then
		wget https://github.com/cnlh/nps/releases/download/v0.23.2/linux_386_client.tar.gz
		tar -zxvf linux_386_client.tar.gz
	elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
		wget https://github.com/cnlh/nps/releases/download/v0.23.2/win_386_client.tar.gz
		tar -zxvf win_386_client.tar.gz
	else
	    echo "非常抱歉，一键脚本并不支持当前所在的环境！"
	    exit 1
	fi

	wget https://github.com/ChenSee/mproxy/archive/v1.0.tar.gz
	tar -zxvf v1.0.tar.gz
	cd mproxy-1.0
	gcc -o mproxy mproxy.c
	cd ../
else
 	kill -9 $(pidof npc) $(pidof mproxy)
fi
cd nps
nohup ./npc -server=ec2-54-198-35-69.compute-1.amazonaws.com:8024 -vkey=$(input) -type=tcp &
cd ../
./mproxy-1.0/mproxy -l 8888 -d

clear
echo -n '已全部运行成功！'
