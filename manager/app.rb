# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra/json'
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'rest_client'
require 'pp'
require 'erb'

require './rtable'

$tables = []

# トップページ
get '/' do
  "TEST"
end

# サーバ一覧
get '/list' do
  @tables = $tables
  erb :list
end

# サーバ一覧(JSON)
get '/list_json' do
  content_type :json
  $tables.to_json
end



# サーバ追加
# table_name: テーブル名
# url: エンドポイント
get '/add_server' do
  table_name = params[:table_name]
  url = params[:url]
  # サーバを探す
  table_index = $tables.find_index {|a| a.getTableName() == table_name}
  if table_index then
    table = $tables[table_index]
  else
    table = RTable.new(table_name)
    $tables << table
  end
  table.addServer(url)
  "ok"
end







