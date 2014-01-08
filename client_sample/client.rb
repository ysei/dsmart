require 'net/http'
require 'uri'
require 'json'
require 'openssl'

res = Net::HTTP.start("localhost", 9292) {|http|
  http.get('/list_json')
}

JSON.parse(res.body).each{|var1|
  p var1['table']

  var1['servers'].each{|var2|
    printf("st=%d ", var2['st'])
    printf("ed=%d ", var2['ed'])
    printf("url=%s \n", var2['url'])
  }
}

puts 'type the name'
name = gets
p OpenSSL::Digest::SHA1.hexdigest(name)
num = OpenSSL::Digest::SHA1.hexdigest(name).hex
p num

JSON.parse(res.body).each{|var1|
 printf("table is %s \n", var1['table'])
  var1['servers'].each{|var2|
    if var2['st'] <= num then 
     if num < var2['ed'] then
      puts var2['url']
    end
   end
  }
}


