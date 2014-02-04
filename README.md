# manager

## 使い方

managerフォルダで，以下を実行します．

    $ rackup

初回の実行前に，以下が必要かも．

    $ bundle 

## ブラウザでのアクセス

データベースの登録と，状態確認ができます．

<http://localhost:9292/list> でデータベースの状態を確認できます．

<http://localhost:9292/add_server?table_name=aaa&url=server1> でサーバを追加します．
table_nameにテーブル名を，urlにサーバ名を指定します．

例えば，次のようにすると分散されたデータベースサーバを管理する様子が分かります．

1. <http://localhost:9292/add_server?table_name=aaa&url=server1>
2. <http://localhost:9292/add_server?table_name=aaa&url=server2>
3. <http://localhost:9292/add_server?table_name=aaa&url=server3>

これで，テーブルaaaに対して，3つのサーバに分散させた状態になります．さらに，

1. <http://localhost:9292/add_server?table_name=bbb&url=server1>
2. <http://localhost:9292/add_server?table_name=bbb&url=server2>

テーブルbbbに対して，2つのサーバに分散させた状態になります．これらの情報は，<http://localhost:9292/list> で確認できます．

各クライアント（データベースに要求を出すソフト側）では，listの状態を持っておき，アクセスするキーの値に応じて，接続先を変えることになります．

## server.rb について

server.rb は，データベースサーバのプロトタイプです．

パラメータとして，「テーブル名」と「ポート番号」を指定します．ポート番号は適当な整数を入れます（1024以上で）．

テーブルごとにサーバを起動します．ちょうど，/add_server のリクエストそれぞれに対応するようにサーバを起動する必要があります．

*現在，データベースのスケールは行なっていません*ので，最初にすべてのデータベースサーバを起動しておく必要があります．

次のような手順でテストができます．

1. manager.rb を起動する
2. server.eb table1 2100
3. server.eb table1 2101
4. server.eb table1 2102

これで table1 について，3つのサーバに分散されます．

----
これから，クライアントからの要求を受け取る部分を実装します．

