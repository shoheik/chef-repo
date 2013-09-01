#!/bin/bash

#設定開始
# インターフェース名定義
LAN=eth0
# 設定終了
# 内部ネットワークのネットマスク取得
LOCALNET_MASK=`ifconfig $LAN|sed -e 's/^.*Mask:\([^ ]*\)$/\1/p' -e d`
# 内部ネットワークアドレス取得
LOCALNET_ADDR=`netstat -rn|grep $LAN|grep $LOCALNET_MASK|cut -f1 -d' '`
LOCALNET=$LOCALNET_ADDR/$LOCALNET_MASK
# firewall停止
/etc/rc.d/init.d/iptables stop
# デフォルトルール定義
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
# LoopBack許可
iptables -A INPUT -i lo -j ACCEPT
# 内部からのアクセス許可
iptables -A INPUT -s $LOCALNET -j ACCEPT
# 内部から行ったアクセスに対する外部からの返答アクセス許可
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#ココから下はポート開放の設定（自分の環境に合わせてポートを開く）
# TCP20,21番ポート（FTP）許可
#iptables -A INPUT -p tcp --dport 20 -j ACCEPT
#iptables -A INPUT -p tcp --dport 21 -j ACCEPT
# TCP22番ポート（SSH）許可
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
# TCP80番ポート（HTTP）許可
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
# SSL(443) for WEBDAV
#iptables -A INPUT -p tcp --dport 443 -j ACCEPT
# subsonic
#iptables -A INPUT -p tcp --dport 4040 -j ACCEPT
# For mojo test
iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
# For mosh
#iptables -A INPUT -p udp -m udp --dport 60000:61000 -j ACCEPT
#ココから上はポート開放の設定

# 再起動時にもルールを保存
/etc/rc.d/init.d/iptables save
# ファイアウォール起動
/etc/rc.d/init.d/iptables start
