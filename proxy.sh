yum install gcc -y
wget https://github.com/ChenSee/mproxy/archive/v1.0.tar.gz
tar -zxvf v1.0.tar.gz
cd mproxy-1.0
gcc -o mproxy mproxy.c
./mproxy -l 8888 -d