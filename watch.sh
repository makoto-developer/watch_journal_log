#!/bin/sh
# ログファイル
TARGET_LOG="./journal.log"
# IPブロックリスト
LIST="./block_ip_list.txt"
# IPブロック除外リスト
LIST_EXCLUDED="./block_ip_excluded_list.txt"

# sshに対するエラーワード
conditions_1="Invalid"
conditions_2="Failed"

# ログを監視して、追加されたらIPアドレスをブロック
hit_action() {
  while read i; do
    echo $i | grep -q $conditions_1
    check1=$?
    echo $i | grep -q $conditions_2
    check2=$?
    if [ check1 = "0" ] || [ check2 = "0" ]; then
      ip=$(echo $i | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)

      # 特定のIPは除外
      cat $LIST_EXCLUDED | grep -q $ip
      if [ $? = "0" ]; then
        continue
      fi

      # ブロック済みかチェック。ブロックする。
      cat $LIST | grep -q $ip
      if [ $? != "0" ]; then
        echo $ip >$LIST
        #echo "$ip is blocked"
        iptables -A INPUT -s $ip -j DROP
        service iptables save
        systemctl restart iptables
      fi
    fi
  done
}

# main
if [ ! -f ${TARGET_LOG} ]; then
  touch ${TARGET_LOG}
fi

tail -n 0 --follow=name --retry $TARGET_LOG | hit_action
