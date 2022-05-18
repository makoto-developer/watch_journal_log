# watch_journal_log

CentOS7用(Bash) ジャーナルログのsshdプロセスを監視して、不正アクセスしてきたIPを即刻ブロックする(iptables drop)

# 必要条件

- CentOS7で動作します。他のOSは動くかどうかわかりません(iptablesコマンドとjournalctlコマンドが使えればどのOSでも大丈夫そうだと思われる)。
- iptablesを有効にしておいてください。

以下のコマンドで確認できるはずです。

```zsh
systemctl status iptables
```

# 動かし方

↓の2つのスクリプトを起動してください。なお、chmodなどで事前に権限は追加して置いてください。

## 1.ジャーナルログを監視して、必要なログを抽出して書き出す

```zsh
./watch_journal_run.sh
```

## 2.↑の書き込まれたファイルを監視して、書き込まれたIPアドレスはiptables DROPさせる

```zsh
./watch_run.sh
```

# 特定のIPを除外したい場合

以下のファイルにIPアドレスを追加してください。

```zsh
vi ./block_ip_exculede_list.txt
```

# ブロックしたIPを知りたい場合

以下のファイルに書き込まれます。

```zsh
vi ./block_ip_list.txt
```

# 注意

利用される場合は自己責任でお願いします。

修正が必要な箇所、改善プルリク歓迎しています。

