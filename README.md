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

<http://localhost:9292/add_server?table_name=aaa&url=server1>
<http://localhost:9292/add_server?table_name=aaa&url=server2>
<http://localhost:9292/add_server?table_name=aaa&url=server3>

これで，テーブルaaaに対して，3つのサーバに分散させた状態になります．さらに，

<http://localhost:9292/add_server?table_name=bbb&url=server2>
<http://localhost:9292/add_server?table_name=aaa&url=server1>

テーブルbbbに対して，2つのサーバに分散させた状態になります．これらの情報は，<http://localhost:9292/list> で確認できます．

各クライアント（データベースに要求を出すソフト側）では，listの状態を持っておき，アクセスするキーの値に応じて，接続先を変えることになります．


