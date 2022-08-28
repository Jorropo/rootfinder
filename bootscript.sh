#!/bin/sh

apt update && apt upgrade -y && apt install htop jq git gcc libsodium-dev make autoconf netcat -y &

curl https://jorropo.net/ygg/yggdrasil > /usr/local/bin/yggdrasil &
curl https://jorropo.net/ygg/yggdrasilctl > /usr/local/bin/yggdrasilctl &

wait

chmod +x /usr/local/bin/yggdrasil
chmod +x /usr/local/bin/yggdrasilctl

yggdrasil -genconf -json | jq -c '.Peers = ["tls://163.172.31.60:12221?key=060f2d49c6a1a2066357ea06e58f5cff8c76a5c0cc513ceb2dab75c900fe183b"]' | jq '.MulticastInterfaces = []' > ygg.conf

nohup yggdrasil -useconffile ygg.conf &

export CFLAGS="-O3 -march=native -mtune=native"

git clone https://github.com/Jorropo/yggkeygen/ -b florb && cd yggkeygen

./autogen.sh && ./configure --enable-amd64-64-24k && make -j$(nproc) -B

nohup bash -c "nice -n1 ./yggkeygen -s 2>&1 | tee >(nc -v 205:7c34:ad8e:5797:7e67:2a05:7e46:9c28 12222)" &
