require 'socket'
require 'json'
#you are on step 7
host = 'localhost'
port = 2000
path = "/index.html"

puts "GET or POST?"
type = gets.chomp.downcase

case type
when "get" then request = "GET #{path} HTTP/1.0/\r\n\r\n"
when "post" 
	puts "name and email?"
	ans = gets.chomp.split(" ")
	name = ans[0]
	email = ans[1]
	hash = {:viking => {:name => name, :email => email}}.to_json
	request = "POST #{path} HTTP/1.0/ #{name} #{email}\ncontent-length: #{hash.length}\n#{hash}\r\n\r\n"
else puts "dunno how"
end

socket = TCPSocket.open(host,port)
socket.print(request)

while response = socket.gets
	puts response
end
