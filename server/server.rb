#
# Server
#
require 'net/http'
require 'gserver'

$manager = 'localhost:9292'

$database = {}


# Request GET
# GET KEY=xxx
def get_request(req)
  m = /GET\s+KEY=(?<key>\S+)\s*/i.match(req)
  return $database[ m[:key] ]
end

# Request SET
# SET KEY=xxx VALUE=xxx
def set_request(req)
  m = /SET\s+KEY=(?<key>\S+)\s+VALUE=(?<value>\S+)\s*/i.match(req)
  $database[ m[:key] ] = m[:value]
  return 'ok'
end

# Request STATUS
# STATUS
def status_request(req)
  return $database.size.to_s
end

# Undefined Request
def undef_request(req)
  return '*Unknown'
end




# Database Server
class Dsmart < GServer
  def serve(io)
    begin
      req = io.gets
      
      if req =~ /^GET\s/i then
        ret = get_request(req)
      elsif req =~ /^SET\s/i then
        ret = set_request(req)
      elsif req =~ /^STATUS\s/i then
       ret = status_request(req)
      else
        ret = undef_request(req)
      end
      
    rescue
      io.puts '*Internal Error'
      return
    end
    io.puts ret
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
$db_server.join


