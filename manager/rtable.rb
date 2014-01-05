# -*- coding: utf-8 -*-
#
# キーの範囲を管理するクラス
#

$ratio = 1.68


class RTable
  # テーブル名を引数として，キー管理テーブルを作成する
  def initialize(name = '')
    @name = name
    @servers = []
  end

  def getTableName()
    @name
  end

  def getServers()
    @servers
  end

  # サーバを登録する
  def addServer(url)
    if @servers.size == 0 then
      # 最初のサーバ
      @servers << {:st => 0, :ed => 2**160-1, :url => url}
      # 情報
      puts ">> New Server #{url}"
    else
      # ２つ目以降のサーバ
      @servers.sort_by! {|data| data[:ed]-data[:st]}
      target = @servers[-1]
      @servers.delete_at(-1)
      width = target[:ed] - target[:st]
      mid = target[:st] + (width / (1+$ratio)).to_i
      # 以前のサーバ
      @servers << {:st => target[:st], :ed => mid, :url => target[:url]}
      # 追加されたサーバ
      @servers << {:st => mid+1, :ed => target[:ed], :url => url}
      # 移動の情報
      puts ">> From #{target[:url]}"
      puts ">> Range #{mid+1} - #{target[:ed]}"
      puts ">> To #{url}"      
    end
  end
end
