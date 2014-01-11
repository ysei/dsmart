#
# Server
#
require 'net/http'
require 'gserver'

$manager = 'localhost:9292'


# Database Server
class Dsmart < GServer
  def serve(sock)
    sock.puts('ok')
  end
end

if ARGV.size != 2 then
  puts 'server <table_name> <port_number>'
  exit
else
  $table_name = ARGV[0]  
  $port_number = ARGV[1].to_i
end

# make my URL
$db_server = Dsmart.new($port_number)
my_url = "#{$db_server.host}:#{$port_number}"

# Assign to manager
uri = URI.parse("http://#{$manager}/add_server?table_name=#{$table_name}&url=#{my_url}")
response, body = Net::HTTP.get(uri)

$db_server.start
# $db_server.join
